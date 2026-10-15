Class {
	#name : #GtPharoRenamePP2ProductionRustEditorExamples,
	#superclass : #Object,
	#category : #'GToolkit4PetitParser2-RustEditor-Refactoring - Method New'
}

{ #category : #assertions }
GtPharoRenamePP2ProductionRustEditorExamples >> assert: aScripter editorMode: isEditable [
	aScripter assert
		label: ('Assert variable editor is in {1} mode' format: {isEditable ifTrue: [ 'editable' ] ifFalse: [ 'label' ]});
		satisfies: [ :anEditor | anEditor viewModel mode isEditable = isEditable ];
		// #'variable-editor';
		/ #editorElement;
		play
]

{ #category : #assertions }
GtPharoRenamePP2ProductionRustEditorExamples >> assert: aScripter refactoringsPreviewIsVisible: aBoolean [
	aScripter assert
		label: ('Assert refactorings preview is {1}'
				format: {aBoolean ifTrue: [ 'visible' ] ifFalse: [ 'hidden' ]});
		satisfies: [ :anElement | 
			aBoolean
				ifTrue: [ anElement visibility isVisible ]
				ifFalse: [ anElement visibility isHidden ] ];
		// #'variable-refactorings-preview';
		play
]

{ #category : #utilities }
GtPharoRenamePP2ProductionRustEditorExamples >> createRustEditorWithMethod: aMethod variableNamed: aVariableName [
	"Create a coder element with a Rust text editor. When the editor is styled, the production rename controller is created by `GtPharoRenamePP2ProductionCoderController class>>#renameIn:node:` for the first variable with the given name and installed."

	| aCoderElement aTextEditorElement aDocumentId aController aCoder aCoderViewModel aRecorder |
	aDocumentId := nil.
	aCoder := GtPharoMethodCoder forMethod: aMethod.
	aCoderViewModel := aCoder asCoderViewModel.
	aRecorder := GtTextEditorTimelineRecorder new.
	aRecorder
		addSignalClass: GtTextEditorSignal;
		observeAnnouncer: aCoderViewModel announcer labeled: 'coder view model'.

	aRecorder
		runDuring: [ aCoderElement := GtExpandableSourceCoderElement new
					expandedElementStencil: GtExpandedCoderElementWithRustTextEditorStencil new;
					textualCoderViewModel: aCoderViewModel;
					expand.

			BlTaskAction
				enqueueElement: aCoderElement
				action: [ aTextEditorElement := (aCoderElement query // GtTextEditorElement) anyOne.
					self
						assert: [ aTextEditorElement isNotNil ]
						description: [ 'Text editor element must exist.' ].
					aTextEditorElement privateEditorHandle enableInMemoryCommandsRecorder.
					aTextEditorElement
						when: BrTextEditorModifiedEvent
							do: [ :anEvent | aDocumentId := anEvent documentId ];
						styler: (GtPharoStyler new coderViewModel: aCoderViewModel);
						when: BrTextStyledEvent
							doOnce: [ :anEvent | 
								| anAstFuture |
								anAstFuture := aCoderViewModel coderAstFuture
										map: [ :aCoderAst | 
											BlTaskAction
												enqueueElement: anEvent currentTarget
												action: [ anEvent currentTarget
														assert: [ aDocumentId isNotNil ]
														description: [ 'Document ID must be non-nil.' ].
													aController := GtPharoRenamePP2ProductionCoderController
															renameIn: aCoderViewModel
															node: (self variableNodeNamed: aVariableName in: aCoderAst ast).
													aController
														documentId: aDocumentId;
														editorElement: aTextEditorElement;
														install.
													aController variableModel
														ifNotNil: [ :aVariableModel | 
															aRecorder
																observeAnnouncer: aVariableModel announcer
																labeled: 'rename production model' ] ] ].
								anAstFuture await: aCoderViewModel class commonExecutionConfiguration ].

					aTextEditorElement text: aMethod sourceCode asRopedText.

					aTextEditorElement userData at: #coderViewModel put: aCoderViewModel.
					aTextEditorElement userData at: #timelineRecorder put: aRecorder ] ].

	aCoderElement userData at: #coderViewModel put: aCoderViewModel.
	aCoderElement userData at: #timelineRecorder put: aRecorder.

	^ aCoderElement
]

{ #category : #examples }
GtPharoRenamePP2ProductionRustEditorExamples >> fieldMethod [
	<gtExample>
	<return: #CompiledMethod>
	^ BibtexPParser >> #field
]

{ #category : #utilities }
GtPharoRenamePP2ProductionRustEditorExamples >> numberOfRenameRefactoringElementsIn: anEditorElement [
	^ anEditorElement children
		count: [ :eachChild | 
			eachChild id
				ifNotNil: [ :anId | 
					anId asSymbol
						ifNotNil: [ :aSymbol | aSymbol beginsWith: 'variable-' ]
						ifNil: [ false ] ]
				ifNil: [ false ] ]
]

{ #category : #examples }
GtPharoRenamePP2ProductionRustEditorExamples >> rustEditorWithFieldMethod [
	<gtExample>
	<return: #GtExpandableSourceCoderElement>
	^ self createRustEditorWithMethod: self fieldMethod variableNamed: 'fieldName'
]

{ #category : #examples }
GtPharoRenamePP2ProductionRustEditorExamples >> rustScripterEditorWithFieldMethod [
	<gtExample>
	<return: #BlScripter>
	| aCoderElement aScripter anEditorElement aVariableModel aRecorder |
	aCoderElement := self rustEditorWithFieldMethod.
	aRecorder := aCoderElement userData at: #timelineRecorder.
	aScripter := BlScripter new.
	aScripter userData at: #timelineRecorder put: aRecorder.

	aRecorder
		runDuring: [ aScripter element: aCoderElement.
			anEditorElement := (aScripter element query // GtTextEditorElement) anyOne.
			self
				assert: anEditorElement isNotNil
				description: [ 'Text editor element must exist' ].

			aScripter wait
				forCondition: [ :aSpace :theScripter | 
						anEditorElement userData
							at: #variableModel
							ifPresent: [ :theModel | 
								theModel ifNotNil: [ aVariableModel := theModel ].
								theModel isNotNil ]
							ifAbsent: [ false ] ]
					pulseDuring: 5 seconds;
				play.
			self assert: aVariableModel isNotNil.
			aScripter model: aVariableModel.

			aScripter wait
				waitRustEditorRendered: anEditorElement pulseDuring: 5 seconds;
				play.

			aScripter wait
				label: 'Wait for the editor and the refactorings preview';
				forCondition: [ :aSpace | (self numberOfRenameRefactoringElementsIn: anEditorElement) = 2 ]
					pulseDuring: 5 seconds;
				play ].

	aScripter userData at: #editorElement put: anEditorElement.
	self assert: aScripter editorMode: true.
	self assert: aScripter refactoringsPreviewIsVisible: false.

	^ aScripter
]

{ #category : #examples }
GtPharoRenamePP2ProductionRustEditorExamples >> rustScripterEditorWithFieldMethod_enterShowsPreview [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self rustScripterEditorWithFieldMethod.

	aScripter click
		label: 'Activate the production editor';
		// #'variable-editor';
		play.

	aScripter editor
		label: 'Type character "_"';
		deselectAll;
		typeText: '_';
		// #'variable-editor';
		play.

	aScripter keyPress
		label: 'Press Enter';
		key: BlKeyboardKey return;
		play.

	self assert: aScripter refactoringsPreviewIsVisible: true.
	self
		assert: (self numberOfRenameRefactoringElementsIn: (aScripter userData at: #editorElement))
		equals: 2.

	^ aScripter
]

{ #category : #examples }
GtPharoRenamePP2ProductionRustEditorExamples >> rustScripterEditorWithFieldMethod_escapeUninstalls [
	<gtExample>
	<return: #BlScripter>
	| aScripter anEditorElement |
	aScripter := self rustScripterEditorWithFieldMethod.
	anEditorElement := aScripter userData at: #editorElement.

	aScripter click
		label: 'Activate the production editor';
		// #'variable-editor';
		play.

	aScripter keyPress
		label: 'Press Escape';
		key: BlKeyboardKey escape;
		play.

	aScripter wait
		label: 'Wait until all rename elements are removed';
		forCondition: [ :aSpace | (self numberOfRenameRefactoringElementsIn: anEditorElement) = 0 ]
			pulseDuring: 5 seconds;
		play.

	self assert: (anEditorElement userData includesKey: #variableModel) not.
	self assert: (anEditorElement userData includesKey: #variableController) not.

	^ aScripter
]

{ #category : #examples }
GtPharoRenamePP2ProductionRustEditorExamples >> rustScripterEditorWithFieldMethod_existingProduction [
	"Another production of the parser cannot be used as a new name."

	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self rustScripterEditorWithFieldMethod.

	aScripter click
		label: 'Activate the production editor';
		// #'variable-editor';
		play.

	aScripter editor
		label: 'Replace the name with the existing production "fieldValue"';
		selectAll;
		typeText: 'fieldValue';
		// #'variable-editor';
		play.

	self assert: aScripter refactoringsPreviewIsVisible: false.

	aScripter editor
		label: 'Append character "s", "fieldValues" is a free name';
		typeText: 's';
		// #'variable-editor';
		play.

	self assert: aScripter refactoringsPreviewIsVisible: true.

	^ aScripter
]

{ #category : #examples }
GtPharoRenamePP2ProductionRustEditorExamples >> rustScripterEditorWithFieldMethod_invalidName [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self rustScripterEditorWithFieldMethod.

	aScripter click
		label: 'Activate the production editor';
		// #'variable-editor';
		play.

	aScripter editor
		label: 'Type a space that makes the name invalid';
		deselectAll;
		typeText: ' ';
		// #'variable-editor';
		play.

	self assert: aScripter refactoringsPreviewIsVisible: false.

	^ aScripter
]

{ #category : #examples }
GtPharoRenamePP2ProductionRustEditorExamples >> rustScripterEditorWithFieldMethod_refactoringsPreview [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self rustScripterEditorWithFieldMethod.

	aScripter click
		label: 'Activate the production editor';
		// #'variable-editor';
		play.

	self assert: aScripter refactoringsPreviewIsVisible: false.

	aScripter editor
		label: 'Type character "_"';
		deselectAll;
		typeText: '_';
		// #'variable-editor';
		play.

	self assert: aScripter refactoringsPreviewIsVisible: true.

	aScripter editor
		label: 'Delete previously typed character';
		pressBackspace;
		// #'variable-editor';
		play.

	self assert: aScripter refactoringsPreviewIsVisible: false.

	^ aScripter
]

{ #category : #examples }
GtPharoRenamePP2ProductionRustEditorExamples >> rustScripterEditorWithFieldMethod_typeAThenB [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self rustScripterEditorWithFieldMethod.

	aScripter click
		label: 'Activate the production editor';
		// #'variable-editor';
		play.

	aScripter editor
		label: 'Replace the name with "a"';
		selectAll;
		typeText: 'a';
		assertTextEqualsTo: 'a';
		assertCursorPosition: 1;
		// #'variable-editor';
		play.

	aScripter editor
		typeText: 'b';
		assertTextEqualsTo: 'ab';
		assertCursorPosition: 2;
		// #'variable-editor';
		play.

	^ aScripter
]

{ #category : #utilities }
GtPharoRenamePP2ProductionRustEditorExamples >> variableNodeNamed: aString in: anAst [
	anAst allNodesDo: [ :each | 
		(each isVariable and: [ each source = aString ]) ifTrue: [ ^ each ] ].
	^ self error: 'Variable ' , aString , ' must exist'
]

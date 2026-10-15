"
I contain examples of the rename entry points of {{gtClass:GtPharoSourceCoder}}: {{gtMethod:GtPharoSourceCoder>>#renameNewNode:in:documentId:for:}}, {{gtMethod:GtPharoSourceCoder>>#renamePharoControllerIn:for:}}, {{gtMethod:GtPharoSourceCoder>>#addRenameMethodAst:to:from:}} and {{gtMethod:GtPharoSourceCoder>>#renameAt:in:documentId:for:}}.
"
Class {
	#name : #GtPharoSourceCoderRenameNewNodeExamples,
	#superclass : #Object,
	#category : #'GToolkit4PetitParser2-Refactoring - Method New'
}

{ #category : #utilities }
GtPharoSourceCoderRenameNewNodeExamples >> firstMessageNodeIn: aCoder [
	aCoder astSync allNodesDo: [ :each | each isMessage ifTrue: [ ^ each ] ].
	^ self error: 'The method must contain a message'
]

{ #category : #utilities }
GtPharoSourceCoderRenameNewNodeExamples >> instAPlusOneCoder [
	^ GtPharoMethodCoder forMethod: GtPharoRenameVariableCoderControllerExamples new instAPlusOneMethod
]

{ #category : #utilities }
GtPharoSourceCoderRenameNewNodeExamples >> newEditorElementStub [
	| anEditor |
	anEditor := GtTextEditorElement new.
	anEditor text: GtPharoRenameVariableCoderControllerExamples new instAPlusOneMethod sourceCode asRopedText.
	^ GtPharoRenameEditorElementStub new editorElement: anEditor
]

{ #category : #examples }
GtPharoSourceCoderRenameNewNodeExamples >> renameAtWithNewImplementation [
	<gtExample>
	<return: #GtPharoSourceCoderRenameNewNodeExamples>
	| aCoder aViewModel aNode aStub |
	aCoder := self instAPlusOneCoder.
	aViewModel := aCoder asCoderViewModel.
	aNode := self firstMessageNodeIn: aCoder.
	aStub := self newEditorElementStub.

	self
		withNewRenameImplementation: true
		do: [ aCoder
				renameAt: aNode selectorParts first sourceInterval first
				in: aViewModel
				documentId: nil
				for: aStub ].

	self assert: (aStub editorElement userData includesKey: #selectorModel).
	self
		assert: (aStub editorElement userData at: #selectorController) class
		equals: GtPharoRenameSelectorCoderController.
	^ self
]

{ #category : #examples }
GtPharoSourceCoderRenameNewNodeExamples >> renameAtWithOldImplementation [
	<gtExample>
	<return: #GtPharoSourceCoderRenameNewNodeExamples>
	| aCoder aViewModel aNode aStub |
	aCoder := self instAPlusOneCoder.
	aViewModel := aCoder asCoderViewModel.
	aNode := self firstMessageNodeIn: aCoder.
	aStub := self newEditorElementStub.

	self
		withNewRenameImplementation: false
		do: [ aCoder
				renameAt: aNode selectorParts first sourceInterval first
				in: aViewModel
				documentId: nil
				for: aStub ].

	self assert: (aStub editorElement userData includesKey: #selectorModel) not.
	^ self
]

{ #category : #examples }
GtPharoSourceCoderRenameNewNodeExamples >> renameAtWithoutNode [
	"No node is found, nothing is installed."

	<gtExample>
	<return: #GtPharoSourceCoderRenameNewNodeExamples>
	| aCoder aViewModel aStub |
	aCoder := self instAPlusOneCoder.
	aViewModel := aCoder asCoderViewModel.
	aStub := self newEditorElementStub.

	#(false true)
		do: [ :eachSetting | 
			self
				withNewRenameImplementation: eachSetting
				do: [ aCoder
						renameAt: aCoder currentSourceString size + 100
						in: aViewModel
						documentId: nil
						for: aStub ] ].

	self assert: aStub editorElement userData isEmpty.
	^ self
]

{ #category : #examples }
GtPharoSourceCoderRenameNewNodeExamples >> renameMenuItemIsNotAddedForVariable [
	<gtExample>
	<return: #GtPharoSourceCoderRenameNewNodeExamples>
	| aCoder aViewModel aVariableNode |
	aCoder := self instAPlusOneCoder.
	aViewModel := aCoder asCoderViewModel.
	aVariableNode := GtPharoRenameVariableCoderControllerExamples new instAVariableNode.

	#(false true)
		do: [ :eachSetting | 
			self
				withNewRenameImplementation: eachSetting
				do: [ self
						assert: (self
								renameMessageActionsFor: aCoder
								cursorAt: aVariableNode startPosition
								in: aViewModel) isEmpty ] ].
	^ self
]

{ #category : #examples }
GtPharoSourceCoderRenameNewNodeExamples >> renameMenuItemWithNewImplementation [
	<gtExample>
	<return: #GtPharoSourceCoderRenameNewNodeExamples>
	| aCoder aViewModel aNode someActions aStub |
	aCoder := self instAPlusOneCoder.
	aViewModel := aCoder asCoderViewModel.
	aNode := self firstMessageNodeIn: aCoder.
	aStub := self newEditorElementStub.

	self
		withNewRenameImplementation: true
		do: [ someActions := self
					renameMessageActionsFor: aCoder
					cursorAt: aNode selectorParts first sourceInterval first
					in: aViewModel.
			"a single item, the old and the new implementation are not offered together"
			self assert: someActions size equals: 1.
			self assert: (someActions first title asString beginsWith: 'Rename message (new)').

			someActions first action value: aViewModel value: aStub ].

	self assert: (aStub editorElement userData includesKey: #selectorModel).
	self
		assert: (aStub editorElement userData at: #selectorController) class
		equals: GtPharoRenameSelectorCoderController.
	^ self
]

{ #category : #examples }
GtPharoSourceCoderRenameNewNodeExamples >> renameMenuItemWithOldImplementation [
	<gtExample>
	<return: #GtPharoSourceCoderRenameNewNodeExamples>
	| aCoder aViewModel aNode someActions aStub |
	aCoder := self instAPlusOneCoder.
	aViewModel := aCoder asCoderViewModel.
	aNode := self firstMessageNodeIn: aCoder.
	aStub := self newEditorElementStub.

	self
		withNewRenameImplementation: false
		do: [ someActions := self
					renameMessageActionsFor: aCoder
					cursorAt: aNode selectorParts first sourceInterval first
					in: aViewModel.
			self assert: someActions size equals: 1.
			self assert: (someActions first title asString beginsWith: 'Rename message').
			self assert: (someActions first title asString includesSubstring: '(new)') not.

			someActions first action value: aViewModel value: aStub ].

	self assert: (aStub editorElement userData includesKey: #selectorModel) not.
	^ self
]

{ #category : #utilities }
GtPharoSourceCoderRenameNewNodeExamples >> renameMessageActionsFor: aCoder cursorAt: aTextPosition in: aViewModel [
	"Return the context menu actions that are added for the node at the cursor position."

	| someAddOns |
	someAddOns := aCoder addOns class new.
	aViewModel moveCursorTo: aTextPosition.
	aCoder addRenameMethodAst: aCoder astSync to: someAddOns from: aViewModel.
	^ someAddOns contextMenuActions
		select: [ :each | each id = #'coder--refactoring-rename-message' ]
]

{ #category : #examples }
GtPharoSourceCoderRenameNewNodeExamples >> renameNewNodeInstallsPP2Controller [
	"The production is referenced by a unary message sent to self. The editor shows the source of the node."

	<gtExample>
	<return: #GtTextEditorElement>
	| aSource aMessageNode aCoder aViewModel anEditor aController |
	aSource := 'parse
	^ self fieldName , fieldName'.
	aSource := GtPharoParser parse: aSource.
	aSource allNodesDo: [ :each | 
		(aMessageNode isNil and: [ each isMessage and: [ each isUnary and: [ each selector = #fieldName ] ] ])
			ifTrue: [ aMessageNode := each ] ].
	self assert: aMessageNode isNotNil.

	aCoder := GtPharoMethodCoder forMethod: GtPharoRenamePP2ProductionCoderControllerExamples new fieldMethod.
	aViewModel := aCoder asCoderViewModel.
	anEditor := GtTextEditorElement new.
	anEditor text: aSource topParent source asRopedText.

	aCoder
		renameNewNode: aMessageNode
		in: aViewModel
		documentId: nil
		for: (GtPharoRenameEditorElementStub new editorElement: anEditor).

	aController := anEditor userData at: #variableController.
	self assert: aController class equals: GtPharoRenamePP2ProductionCoderController.
	self assert: aController editorElement equals: anEditor.
	self assert: aController sourceCoderViewModel equals: aViewModel.
	self assert: (anEditor userData at: #variableModel) originalName equals: 'fieldName'.
	self assert: (anEditor userData at: #variableModel) otherIntervals size equals: 1.
	self assert: (anEditor userData includesKey: #selectorModel) not.
	^ anEditor
]

{ #category : #examples }
GtPharoSourceCoderRenameNewNodeExamples >> renameNewNodeKeepsSelectorController [
	"Nodes that are not handled by a controller with the pragma `<gtPharoRenameController>` are renamed as before."

	<gtExample>
	<return: #GtTextEditorElement>
	| anExamples aCoder aViewModel anEditor |
	anExamples := GtPharoRenameVariableCoderControllerExamples new.
	aCoder := GtPharoMethodCoder forMethod: anExamples instAPlusOneMethod.
	aViewModel := aCoder asCoderViewModel.
	anEditor := anExamples editorWithInstAPlusOneMethod.

	aCoder
		renameNewNode: aCoder astSync
		in: aViewModel
		documentId: nil
		for: (GtPharoRenameEditorElementStub new editorElement: anEditor).

	self assert: (anEditor userData includesKey: #selectorModel).
	self assert: (anEditor userData includesKey: #variableModel) not.
	^ anEditor
]

{ #category : #examples }
GtPharoSourceCoderRenameNewNodeExamples >> renamePharoControllerFallsBackToSelectorController [
	"Without a controller that is applicable, the default controller renames the selector."

	<gtExample>
	<return: #GtPharoSourceCoderRenameNewNodeExamples>
	| anExamples aCoder aViewModel aMessageNode aController |
	anExamples := GtPharoRenameVariableCoderControllerExamples new.
	aCoder := GtPharoMethodCoder forMethod: anExamples instAPlusOneMethod.
	aViewModel := aCoder asCoderViewModel.

	aController := aCoder renamePharoControllerIn: aViewModel for: aCoder astSync.
	self assert: aController class equals: GtPharoRenameSelectorCoderController.
	self assert: aController originalNode equals: aCoder astSync.
	self assert: aController sourceCoderViewModel equals: aViewModel.

	aCoder astSync allNodesDo: [ :each | 
		(aMessageNode isNil and: [ each isMessage ]) ifTrue: [ aMessageNode := each ] ].
	aController := aCoder renamePharoControllerIn: aViewModel for: aMessageNode.
	self assert: aController class equals: GtPharoRenameSelectorCoderController.
	self assert: aController originalNode equals: aMessageNode.
	^ self
]

{ #category : #examples }
GtPharoSourceCoderRenameNewNodeExamples >> renamePharoControllerForFieldNameVariable [
	<gtExample>
	<return: #GtPharoRenamePP2ProductionCoderController>
	| anExamples aCoder aController |
	anExamples := GtPharoRenamePP2ProductionCoderControllerExamples new.
	aCoder := GtPharoMethodCoder forMethod: anExamples fieldMethod.
	aController := aCoder
			renamePharoControllerIn: aCoder asCoderViewModel
			for: anExamples fieldNameVariableNode.
	self assert: aController class equals: GtPharoRenamePP2ProductionCoderController.
	self assert: aController variableModel isNil.
	^ aController
]

{ #category : #utilities }
GtPharoSourceCoderRenameNewNodeExamples >> withNewRenameImplementation: aBoolean do: aBlock [
	"Evaluate the block with the given value of the setting and restore the previous value afterwards."

	| aPreviousValue |
	aPreviousValue := GtPharoCoderSettings displayNewRenameImplementationContextMenuItem.
	^ [ GtPharoCoderSettings displayNewRenameImplementationContextMenuItem: aBoolean.
		aBlock value ]
		ensure: [ GtPharoCoderSettings
				displayNewRenameImplementationContextMenuItem: aPreviousValue ]
]

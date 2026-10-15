"
I contain examples of the rename entry points of {{gtClass:GtPharoSourceCoder}}: {{gtMethod:GtPharoSourceCoder>>#renameNewNode:in:documentId:for:}}, {{gtMethod:GtPharoSourceCoder>>#renamePharoControllerIn:for:}}, {{gtMethod:GtPharoSourceCoder>>#addRenameMethodAst:to:from:}} and {{gtMethod:GtPharoSourceCoder>>#renameAt:in:documentId:for:}}. A rename is started with the text editor element, either from a context menu or from a shortcut.
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
GtPharoSourceCoderRenameNewNodeExamples >> newEditorElement [
	"A rename is started with the text editor element, either from a context menu or from a shortcut."

	| anEditor |
	anEditor := GtTextEditorElement new.
	anEditor text: GtPharoRenameVariableCoderControllerExamples new instAPlusOneMethod sourceCode asRopedText.
	^ anEditor
]

{ #category : #examples }
GtPharoSourceCoderRenameNewNodeExamples >> renameAtDoesNotInstallInstanceVariableControllerWithOldImplementation [
	<gtExample>
	<return: #GtTextEditorElement>
	| aCoder aViewModel anEditor aNode |
	aCoder := self instAPlusOneCoder.
	aViewModel := aCoder asCoderViewModel.
	anEditor := self newEditorElement.
	aNode := GtPharoRenameVariableCoderControllerExamples new instAVariableNode.

	self
		withNewRenameImplementation: false
		do: [ aCoder
				renameAt: aNode startPosition + 1
				in: aViewModel
				documentId: nil
				for: anEditor ].

	self assert: (anEditor userData includesKey: #variableController) not.
	^ anEditor
]

{ #category : #examples }
GtPharoSourceCoderRenameNewNodeExamples >> renameAtDoesNotInstallPP2ControllerWithOldImplementation [
	<gtExample>
	<return: #GtTextEditorElement>
	| anExamples aCoder aViewModel anEditor aNode |
	anExamples := GtPharoRenamePP2ProductionCoderControllerExamples new.
	aCoder := GtPharoMethodCoder forMethod: anExamples fieldMethod.
	aViewModel := aCoder asCoderViewModel.
	anEditor := anExamples editorWithFieldMethod.
	aNode := anExamples fieldNameVariableNode.

	self
		withNewRenameImplementation: false
		do: [ aCoder
				renameAt: aNode startPosition + 1
				in: aViewModel
				documentId: nil
				for: anEditor ].

	self assert: (anEditor userData includesKey: #variableController) not.
	^ anEditor
]

{ #category : #examples }
GtPharoSourceCoderRenameNewNodeExamples >> renameAtInstallsInstanceVariableController [
	"An instance variable without a controller with the pragma is renamed by the default controller."

	<gtExample>
	<return: #GtTextEditorElement>
	| aCoder aViewModel anEditor aNode aController |
	aCoder := self instAPlusOneCoder.
	aViewModel := aCoder asCoderViewModel.
	anEditor := self newEditorElement.
	aNode := GtPharoRenameVariableCoderControllerExamples new instAVariableNode.

	self
		withNewRenameImplementation: true
		do: [ aCoder
				renameAt: aNode startPosition + 1
				in: aViewModel
				documentId: nil
				for: anEditor ].

	aController := anEditor userData at: #variableController.
	self assert: aController class equals: GtPharoRenameInstanceVariableCoderController.
	self assert: aController editorElement equals: anEditor.
	self assert: (anEditor userData at: #variableModel) originalName equals: 'instA'.
	self assert: (anEditor userData includesKey: #selectorController) not.
	^ anEditor
]

{ #category : #examples }
GtPharoSourceCoderRenameNewNodeExamples >> renameAtInstallsPP2ControllerForVariable [
	"A shortcut passes the text editor element itself."

	<gtExample>
	<return: #GtTextEditorElement>
	| anExamples aCoder aViewModel anEditor aNode aController |
	anExamples := GtPharoRenamePP2ProductionCoderControllerExamples new.
	aCoder := GtPharoMethodCoder forMethod: anExamples fieldMethod.
	aViewModel := aCoder asCoderViewModel.
	anEditor := anExamples editorWithFieldMethod.
	aNode := anExamples fieldNameVariableNode.

	self
		withNewRenameImplementation: true
		do: [ aCoder
				renameAt: aNode startPosition + 1
				in: aViewModel
				documentId: nil
				for: anEditor ].

	aController := anEditor userData at: #variableController.
	self assert: aController class equals: GtPharoRenamePP2ProductionCoderController.
	self assert: aController editorElement equals: anEditor.
	self assert: (anEditor userData at: #variableModel) originalName equals: 'fieldName'.
	^ anEditor
]

{ #category : #examples }
GtPharoSourceCoderRenameNewNodeExamples >> renameAtWithNewImplementation [
	<gtExample>
	<return: #GtPharoSourceCoderRenameNewNodeExamples>
	| aCoder aViewModel aNode anEditor |
	aCoder := self instAPlusOneCoder.
	aViewModel := aCoder asCoderViewModel.
	aNode := self firstMessageNodeIn: aCoder.
	anEditor := self newEditorElement.

	self
		withNewRenameImplementation: true
		do: [ aCoder
				renameAt: aNode selectorParts first sourceInterval first
				in: aViewModel
				documentId: nil
				for: anEditor ].

	self assert: (anEditor userData includesKey: #selectorModel).
	self
		assert: (anEditor userData at: #selectorController) class
		equals: GtPharoRenameSelectorCoderController.
	^ self
]

{ #category : #examples }
GtPharoSourceCoderRenameNewNodeExamples >> renameAtWithOldImplementation [
	<gtExample>
	<return: #GtPharoSourceCoderRenameNewNodeExamples>
	| aCoder aViewModel aNode anEditor |
	aCoder := self instAPlusOneCoder.
	aViewModel := aCoder asCoderViewModel.
	aNode := self firstMessageNodeIn: aCoder.
	anEditor := self newEditorElement.

	self
		withNewRenameImplementation: false
		do: [ aCoder
				renameAt: aNode selectorParts first sourceInterval first
				in: aViewModel
				documentId: nil
				for: anEditor ].

	self assert: (anEditor userData includesKey: #selectorModel) not.
	^ self
]

{ #category : #examples }
GtPharoSourceCoderRenameNewNodeExamples >> renameAtWithoutNode [
	"No node is found, nothing is installed."

	<gtExample>
	<return: #GtPharoSourceCoderRenameNewNodeExamples>
	| aCoder aViewModel anEditor |
	aCoder := self instAPlusOneCoder.
	aViewModel := aCoder asCoderViewModel.
	anEditor := self newEditorElement.

	#(false true)
		do: [ :eachSetting | 
			self
				withNewRenameImplementation: eachSetting
				do: [ aCoder
						renameAt: aCoder currentSourceString size + 100
						in: aViewModel
						documentId: nil
						for: anEditor ] ].

	self assert: anEditor userData isEmpty.
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
	| aCoder aViewModel aNode someActions anEditor |
	aCoder := self instAPlusOneCoder.
	aViewModel := aCoder asCoderViewModel.
	aNode := self firstMessageNodeIn: aCoder.
	anEditor := self newEditorElement.

	self
		withNewRenameImplementation: true
		do: [ someActions := self
					renameMessageActionsFor: aCoder
					cursorAt: aNode selectorParts first sourceInterval first
					in: aViewModel.
			"a single item, the old and the new implementation are not offered together"
			self assert: someActions size equals: 1.
			self assert: (someActions first title asString beginsWith: 'Rename message (new)').

			someActions first action value: aViewModel value: anEditor ].

	self assert: (anEditor userData includesKey: #selectorModel).
	self
		assert: (anEditor userData at: #selectorController) class
		equals: GtPharoRenameSelectorCoderController.
	^ self
]

{ #category : #examples }
GtPharoSourceCoderRenameNewNodeExamples >> renameMenuItemWithOldImplementation [
	<gtExample>
	<return: #GtPharoSourceCoderRenameNewNodeExamples>
	| aCoder aViewModel aNode someActions anEditor |
	aCoder := self instAPlusOneCoder.
	aViewModel := aCoder asCoderViewModel.
	aNode := self firstMessageNodeIn: aCoder.
	anEditor := self newEditorElement.

	self
		withNewRenameImplementation: false
		do: [ someActions := self
					renameMessageActionsFor: aCoder
					cursorAt: aNode selectorParts first sourceInterval first
					in: aViewModel.
			self assert: someActions size equals: 1.
			self assert: (someActions first title asString beginsWith: 'Rename message').
			self assert: (someActions first title asString includesSubstring: '(new)') not.

			someActions first action value: aViewModel value: anEditor ].

	self assert: (anEditor userData includesKey: #selectorModel) not.
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
	anEditor := GtTextEditorElement new hMatchParent; vFitContentLimited.
	anEditor text: aSource topParent source asRopedText.

	aCoder
		renameNewNode: aMessageNode
		in: aViewModel
		documentId: nil
		for: anEditor.

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
		for: (anEditor).

	self assert: (anEditor userData includesKey: #selectorModel).
	self assert: (anEditor userData includesKey: #variableModel) not.
	^ anEditor
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

{ #category : #examples }
GtPharoSourceCoderRenameNewNodeExamples >> renamePharoControllerWithoutApplicableController [
	"Nodes that are not handled by a controller with the pragma `<gtPharoRenameController>` are renamed by the default implementation."

	<gtExample>
	<return: #GtPharoSourceCoderRenameNewNodeExamples>
	| aCoder aViewModel |
	aCoder := self instAPlusOneCoder.
	aViewModel := aCoder asCoderViewModel.

	self
		assert: (aCoder
				renamePharoControllerIn: aViewModel
				for: GtPharoRenameVariableCoderControllerExamples new instAVariableNode)
		equals: nil.
	self
		assert: (aCoder
				renamePharoControllerIn: aViewModel
				for: (self firstMessageNodeIn: aCoder))
		equals: nil.
	self assert: (aCoder renamePharoControllerIn: aViewModel for: aCoder astSync) equals: nil.
	^ self
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

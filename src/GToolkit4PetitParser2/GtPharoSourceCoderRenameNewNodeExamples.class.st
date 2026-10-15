Class {
	#name : #GtPharoSourceCoderRenameNewNodeExamples,
	#superclass : #Object,
	#category : #'GToolkit4PetitParser2-Refactoring - Method New'
}

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

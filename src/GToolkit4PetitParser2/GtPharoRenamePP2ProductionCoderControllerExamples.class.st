Class {
	#name : #GtPharoRenamePP2ProductionCoderControllerExamples,
	#superclass : #Object,
	#category : #'GToolkit4PetitParser2-Refactoring - Method New'
}

{ #category : #examples }
GtPharoRenamePP2ProductionCoderControllerExamples >> controllerForFieldNameVariable [
	<gtExample>
	<return: #GtPharoRenamePP2ProductionCoderController>
	| aController |
	aController := GtPharoRenamePP2ProductionCoderController
			renameIn: self fieldCoderViewModel
			node: self fieldNameVariableNode.
	self assert: aController isNotNil.
	self assert: aController originalName equals: 'fieldName'.
	self assert: aController refactoringName equals: 'Rename production'.
	self assert: aController variableModel isNil.
	^ aController
]

{ #category : #examples }
GtPharoRenamePP2ProductionCoderControllerExamples >> controllerIsNotApplicable [
	<gtExample>
	<return: #GtPharoRenamePP2ProductionCoderControllerExamples>
	| aViewModel anAst |
	"not a PP2CompositeNode subclass"
	aViewModel := GtPharoRenameVariableCoderControllerExamples new instAPlusOneCoderViewModel.
	self
		assert: (GtPharoRenamePP2ProductionCoderController
				renameIn: aViewModel
				node: GtPharoRenameVariableCoderControllerExamples new instAVariableNode)
		equals: nil.

	"a variable that is not an instance variable"
	aViewModel := (GtPharoMethodCoder forMethod: BibtexPParser >> #fields) asCoderViewModel.
	anAst := (GtPharoMethodCoder forMethod: BibtexPParser >> #fields) astSync.
	anAst allNodesDo: [ :each | 
		(each isVariable and: [ each source = 'node' ])
			ifTrue: [ self
					assert: (GtPharoRenamePP2ProductionCoderController renameIn: aViewModel node: each)
					equals: nil ] ].

	"a unary message that is not sent to self or super"
	anAst allNodesDo: [ :each | 
		(each isMessage and: [ each isUnary and: [ each selector = #star ] ])
			ifTrue: [ self
					assert: (GtPharoRenamePP2ProductionCoderController renameIn: aViewModel node: each)
					equals: nil ] ].
	^ self
]

{ #category : #examples }
GtPharoRenamePP2ProductionCoderControllerExamples >> controllerWithSelfSends [
	"Productions are referenced by instance variables and by unary messages sent to self or super."

	<gtExample>
	<return: #GtPharoRenamePP2ProductionCoderController>
	| aSource anAst aMessageNode aController aViewModel |
	aSource := 'parse
	^ self fieldName , fieldName , super fieldName , other fieldName'.
	anAst := GtPharoParser parse: aSource.
	anAst allNodesDo: [ :each | 
		(aMessageNode isNil and: [ each isMessage and: [ each isUnary and: [ each selector = #fieldName ] ] ])
			ifTrue: [ aMessageNode := each ] ].
	self assert: aMessageNode isNotNil.
	aViewModel := self fieldCoderViewModel.
	aController := GtPharoRenamePP2ProductionCoderController
			renameIn: aViewModel
			node: aMessageNode.
	self assert: aController isNotNil.
	self assert: aController originalName equals: 'fieldName'.

	self assert: aController primaryRenameInterval equals: (aMessageNode selectorParts first sourceInterval).
	self assert: (aSource copyFrom: aController primaryRenameInterval first to: aController primaryRenameInterval last) equals: 'fieldName'.
	"the variable and the super send, but not the send to `other`"
	self assert: aController otherRenameIntervals size equals: 2.
	aController otherRenameIntervals
		do: [ :each | self assert: (aSource copyFrom: each first to: each last) equals: 'fieldName' ].
	^ aController
]

{ #category : #examples }
GtPharoRenamePP2ProductionCoderControllerExamples >> editorWithFieldMethod [
	<gtExample>
	<return: #GtTextEditorElement>
	| anEditor |
	anEditor := GtTextEditorElement new.
	anEditor text: self fieldMethod sourceCode asRopedText.
	^ anEditor
]

{ #category : #examples }
GtPharoRenamePP2ProductionCoderControllerExamples >> fieldCoderViewModel [
	<gtExample>
	<return: #GtPharoMethodCoderViewModel>
	^ (GtPharoMethodCoder forMethod: self fieldMethod) asCoderViewModel
]

{ #category : #examples }
GtPharoRenamePP2ProductionCoderControllerExamples >> fieldMethod [
	<gtExample>
	<return: #CompiledMethod>
	^ BibtexPParser >> #field
]

{ #category : #examples }
GtPharoRenamePP2ProductionCoderControllerExamples >> fieldNameVariableNode [
	<gtExample>
	<return: #GtPharoNamedVariableNode>
	(GtPharoMethodCoder forMethod: self fieldMethod) astSync
		allNodesDo: [ :each | 
			(each isVariable and: [ each source = 'fieldName' ]) ifTrue: [ ^ each ] ].
	^ self error: 'Variable fieldName must exist'
]

{ #category : #examples }
GtPharoRenamePP2ProductionCoderControllerExamples >> installedController [
	<gtExample>
	<return: #GtPharoRenamePP2ProductionCoderController>
	| aController aModel |
	aController := self controllerForFieldNameVariable.
	aController
		editorElement: self editorWithFieldMethod;
		documentId: nil;
		install.
	aModel := aController variableModel.

	self assert: aModel isNotNil.
	self assert: aModel originalName equals: 'fieldName'.
	self assert: aModel otherIntervals isEmpty.
	"editor and refactorings preview, no other occurrence in `field`"
	self assert: aController attributeTags size equals: 2.
	self assert: aController editorElement userData size equals: 2.
	"an instance variable of the class cannot be a new name"
	aModel updateCurrentName: 'fieldValue' source: self.
	self assert: aModel isValid not.
	aModel updateCurrentName: 'fieldTitle' source: self.
	self assert: aModel isValid.
	^ aController
]

{ #category : #examples }
GtPharoRenamePP2ProductionCoderControllerExamples >> installedController_cancel [
	<gtExample>
	<return: #GtPharoRenamePP2ProductionCoderController>
	| aController |
	aController := self installedController.
	aController variableModel requestCancelSource: self.
	self assert: aController attributeTags isNil.
	self assert: aController editorElement userData isEmpty.
	^ aController
]

{ #category : #examples }
GtPharoRenamePP2ProductionCoderControllerExamples >> installedController_refactoring [
	"The refactoring is only created in the refactoring model, the class in the image is not modified."

	<gtExample>
	<return: #GtPharoRenamePP2ProductionCoderController>
	| aController aRefactoring aModelClass |
	aController := self installedController.
	aController variableModel updateCurrentName: 'fieldTitle' source: self.

	aRefactoring := aController computeRefactorings.
	self assert: aRefactoring size equals: 1.
	aRefactoring := aRefactoring first.
	self assert: aRefactoring class equals: GtPP2RenameRefactoring.

	aRefactoring primitiveExecute.
	aModelClass := aRefactoring model classFor: BibtexPParser.
	self assert: (aModelClass directlyDefinesMethod: #fieldTitle).
	self assert: (aModelClass directlyDefinesMethod: #fieldName) not.
	self assert: (aModelClass instanceVariableNames includes: 'fieldTitle').
	self assert: ((aModelClass sourceCodeFor: #field) includesSubstring: 'fieldTitle trim').

	self assert: (BibtexPParser includesSelector: #fieldName).
	self assert: (BibtexPParser instVarNames includes: 'fieldName').
	^ aController
]

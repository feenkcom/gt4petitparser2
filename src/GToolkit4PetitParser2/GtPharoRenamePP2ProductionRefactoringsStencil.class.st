Class {
	#name : #GtPharoRenamePP2ProductionRefactoringsStencil,
	#superclass : #GtPharoRenameVariableRefactoringsStencil,
	#category : #'GToolkit4PetitParser2-Refactoring - Method New'
}

{ #category : #creation }
GtPharoRenamePP2ProductionRefactoringsStencil >> computeRefactoring [
	"Same as `${method:GtPP2RenameController>>#rename:to:}$`."

	| aModel aClass |
	aModel := self createModel.
	aClass := (aModel classFor: sourceCoderViewModel behavior)
			whoDefinesInstanceVariable: variableModel originalName.
	^ GtPP2RenameRefactoring
		model: aModel
		rename: variableModel originalName
		to: variableModel currentName
		in: aClass
]

{ #category : #accessing }
GtPharoRenamePP2ProductionRefactoringsStencil >> refactoringName [
	^ 'Rename production'
]

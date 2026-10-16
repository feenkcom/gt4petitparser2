"
I compute {{gtClass:GtPP2RenameRefactoring}} that renames a PetitParser2 production. See {{gtClass:GtPharoRenamePP2ProductionCoderController}}.

# Example
{{gtExample:GtPharoRenamePP2ProductionCoderControllerExamples>>#installedController_refactoring | codeExpanded=false | previewExpanded | previewHeight=200}}
"
Class {
	#name : #GtPharoRenamePP2ProductionRefactoringsStencil,
	#superclass : #GtPharoRenameVariableRefactoringsStencil,
	#category : #'GToolkit4PetitParser2-Refactoring - Method New'
}

{ #category : #creation }
GtPharoRenamePP2ProductionRefactoringsStencil >> computeRefactoring [
	"Same as {{gtMethod:GtPP2RenameController>>#rename:to:}}."

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

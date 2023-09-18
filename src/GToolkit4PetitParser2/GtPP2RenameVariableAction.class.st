Class {
	#name : #GtPP2RenameVariableAction,
	#superclass : #GtCoderViewModelRenameAction,
	#category : #'GToolkit4PetitParser2-Refactoring '
}

{ #category : #accessing }
GtPP2RenameVariableAction >> initialize [
	super initialize.
	allowAccept := false
]

{ #category : #accessing }
GtPP2RenameVariableAction >> processReturnFor: renameEditor in: anEditorElement [
	| lastWasEditor first |
	lastWasEditor := false.
	anEditorElement
		allChildrenBreadthFirstDo: [ :each | 
			(lastWasEditor and: [ each isKindOf: GtRefactoringsPreviewButton ])
				ifTrue: [ ^ each openPreview ].
			(each isKindOf: GtRenameEditor)
				ifTrue: [ first ifNil: [ first := each ].
					lastWasEditor ifTrue: [ ^ each requestFocus ].
					lastWasEditor := each == renameEditor ] ].
	first ifNotNil: [ ^ first requestFocus ]
]

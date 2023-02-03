Class {
	#name : #PP2ColumnParser,
	#superclass : #PPParser,
	#category : #'GToolkit4PetitParser2-Indent'
}

{ #category : #analysis }
PP2ColumnParser >> acceptsEpsilon [
	^ true
]

{ #category : #parsing }
PP2ColumnParser >> parseOn: context [
	^ context column
]

Class {
	#name : #PP2ColumnNode,
	#superclass : #PP2Node,
	#category : #'GToolkit4PetitParser2-Indent-Nodes'
}

{ #category : #analysis }
PP2ColumnNode >> acceptsEpsilon [
	^ true
]

{ #category : #parsing }
PP2ColumnNode >> parseOn: context [
	^ context column
]

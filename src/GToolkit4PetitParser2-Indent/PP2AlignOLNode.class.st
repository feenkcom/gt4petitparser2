Class {
	#name : #PP2AlignOLNode,
	#superclass : #PP2Node,
	#category : #'GToolkit4PetitParser2-Indent'
}

{ #category : #analysis }
PP2AlignOLNode >> acceptsEpsilon [
	^ true
]

{ #category : #analysis }
PP2AlignOLNode >> firstCharSet [
	^ PPCharSetPredicate on: [:e | true ] 
]

{ #category : #parsing }
PP2AlignOLNode >> parseOn: context [
	"default value for indent stack is 1"
	((context indentStack topIfEmpty: 1) = context column) ifFalse: [  
		^ PPFailure message: 'Not aligned' context: context
	].
	^ #aligned
]

Class {
	#name : #PP2AlignOLParser,
	#superclass : #PPParser,
	#category : #'GToolkit4PetitParser2-Indent'
}

{ #category : #analysis }
PP2AlignOLParser >> acceptsEpsilon [
	^ true
]

{ #category : #analysis }
PP2AlignOLParser >> firstCharSet [
	^ PPCharSetPredicate on: [:e | true ] 
]

{ #category : #parsing }
PP2AlignOLParser >> parseOn: context [
	"default value for indent stack is 1"
	((context indentStack topIfEmpty: 1) = context column) ifFalse: [  
		^ PPFailure message: 'Not aligned' context: context
	].
	^ #aligned
]

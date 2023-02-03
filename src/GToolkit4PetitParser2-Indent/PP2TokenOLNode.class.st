Class {
	#name : #PP2TokenOLNode,
	#superclass : #PP2CreateTokenNode,
	#category : #'GToolkit4PetitParser2-Indent'
}

{ #category : #parsing }
PP2TokenOLNode >> parseOn: context [
	((context indentStack topIfEmpty: 1) <= context column) ifFalse: [  
		^ PPFailure message: 'Not aligned or onside' context: context
	].
	^ super parseOn: context
]

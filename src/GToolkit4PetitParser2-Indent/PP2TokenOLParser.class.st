Class {
	#name : #PP2TokenOLParser,
	#superclass : #PPTokenParser,
	#category : #'GToolkit4PetitParser2-Indent'
}

{ #category : #parsing }
PP2TokenOLParser >> parseOn: context [
	((context indentStack topIfEmpty: 1) <= context column) ifFalse: [  
		^ PPFailure message: 'Not aligned or onside' context: context
	].
	^ super parseOn: context
]

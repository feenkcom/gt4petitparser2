Class {
	#name : #PP2OnsideOLNode,
	#superclass : #PP2Node,
	#category : #'GToolkit4PetitParser2-Indent'
}

{ #category : #analysis }
PP2OnsideOLNode >> acceptsEpsilon [
	^ true
]

{ #category : #analysis }
PP2OnsideOLNode >> firstCharSet [
	^ PPCharSetPredicate on: [:e | true ] 
]

{ #category : #parsing }
PP2OnsideOLNode >> parseOn: context [
	((context indentStack topIfEmpty: 0) < context column) ifFalse: [  
		^ PPFailure message: 'Not in onside' context: context
	].
	^ #onside
]

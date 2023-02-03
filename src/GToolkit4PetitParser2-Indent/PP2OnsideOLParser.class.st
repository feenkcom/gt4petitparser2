Class {
	#name : #PP2OnsideOLParser,
	#superclass : #PPParser,
	#category : #'GToolkit4PetitParser2-Indent'
}

{ #category : #analysis }
PP2OnsideOLParser >> acceptsEpsilon [
	^ true
]

{ #category : #analysis }
PP2OnsideOLParser >> firstCharSet [
	^ PPCharSetPredicate on: [:e | true ] 
]

{ #category : #parsing }
PP2OnsideOLParser >> parseOn: context [
	((context indentStack topIfEmpty: 0) < context column) ifFalse: [  
		^ PPFailure message: 'Not in onside' context: context
	].
	^ #onside
]

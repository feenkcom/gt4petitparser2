Class {
	#name : #PP2OffsideOLParser,
	#superclass : #PPParser,
	#category : #'GToolkit4PetitParser2-Indent'
}

{ #category : #analysis }
PP2OffsideOLParser >> acceptsEpsilon [
	^ true
]

{ #category : #analysis }
PP2OffsideOLParser >> firstCharSet [
	^ PPCharSetPredicate on: [:e | true ] 
]

{ #category : #parsing }
PP2OffsideOLParser >> parseOn: context [
	(context column < (context indentStack topIfEmpty: 1)) ifFalse: [  
		^ PPFailure message: 'Not in offside' context: context
	].
	^ #offside
]

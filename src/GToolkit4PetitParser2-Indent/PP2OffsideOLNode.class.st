Class {
	#name : #PP2OffsideOLNode,
	#superclass : #PP2Node,
	#category : #'GToolkit4PetitParser2-Indent-Nodes'
}

{ #category : #analysis }
PP2OffsideOLNode >> acceptsEpsilon [
	^ true
]

{ #category : #analysis }
PP2OffsideOLNode >> firstCharSet [
	^ PPCharSetPredicate on: [:e | true ] 
]

{ #category : #parsing }
PP2OffsideOLNode >> parseOn: context [
	(context column < (context indentStack topIfEmpty: 1)) ifFalse: [  
		^ PPFailure message: 'Not in offside' context: context
	].
	^ #offside
]

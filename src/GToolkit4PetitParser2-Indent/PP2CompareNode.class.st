Class {
	#name : #PP2CompareNode,
	#superclass : #PP2Node,
	#instVars : [
		'compareBlock',
		'message',
		'column'
	],
	#category : #'GToolkit4PetitParser2-Indent'
}

{ #category : #'as yet unclassified' }
PP2CompareNode class >> on: compareBlock [
	^ self on: compareBlock message: compareBlock asString
]

{ #category : #'as yet unclassified' }
PP2CompareNode class >> on: compareBlock message: message [
	^ (self basicNew
		initialize)
		compareBlock: compareBlock ;
		message: message;
		yourself
]

{ #category : #'as yet unclassified' }
PP2CompareNode class >> on: compareBlock message: message column: column [
	^ (self basicNew
		initialize)
		compareBlock: compareBlock ;
		message: message;
		column: column;
		yourself
]

{ #category : #accessing }
PP2CompareNode >> column [
	^ column
]

{ #category : #accessing }
PP2CompareNode >> column: anInteger [
	column := anInteger
]

{ #category : #accessing }
PP2CompareNode >> compareBlock: aBlock [
	compareBlock := aBlock
]

{ #category : #accessing }
PP2CompareNode >> message: aString [
	message := aString
]

{ #category : #parsing }
PP2CompareNode >> parseOn: context [
	^ (compareBlock value: context) ifTrue: [  
		compareBlock asString
	] ifFalse: [  
		PPFailure message: message context: context
	]
]

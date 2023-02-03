Class {
	#name : #PP2ConditionalNode,
	#superclass : #PP2DelegateNode,
	#instVars : [
		'block'
	],
	#category : #'GToolkit4PetitParser2-Parsers'
}

{ #category : #'instance creation' }
PP2ConditionalNode class >> on: aPPParser block: block [
	^ (self on: aPPParser)
		block: block;
		yourself
]

{ #category : #accessing }
PP2ConditionalNode >> block: aBlock [
	block := aBlock
]

{ #category : #parsing }
PP2ConditionalNode >> parseOn: aPPContext [
	^ (block value: aPPContext) 
		ifTrue: [ child parseOn: aPPContext ]
		ifFalse: [ PP2Failure message: block asString, ' was not evaluated to true.' context: aPPContext ]
]

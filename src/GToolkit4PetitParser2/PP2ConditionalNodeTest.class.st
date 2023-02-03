"
This class contains tests
"
Class {
	#name : #PP2ConditionalNodeTest,
	#superclass : #PP2AbstractParserTest,
	#instVars : [
		'context'
	],
	#category : #'GToolkit4PetitParser2-Tests'
}

{ #category : #'as yet unclassified' }
PP2ConditionalNodeTest >> context [
	^ context
]

{ #category : #accessing }
PP2ConditionalNodeTest >> parse: aStream withParser: aParser withContext: aContext [
	^ aParser parse: aStream withContext: aContext
]

{ #category : #accessing }
PP2ConditionalNodeTest >> setUp [
	super setUp.
	context := PP2Context new
]

{ #category : #accessing }
PP2ConditionalNodeTest >> testConditionCtxAccess [
	| parser |

	parser := ('a' asPParser if: [ :ctx | (ctx propertyAt: #foo) = #bar ]).
	
	context propertyAt: #foo put: #bar.
	self assert: parser parse: 'a' .


	context propertyAt: #foo put: #zorg.
	self assert: parser fail: 'a' .

]

{ #category : #accessing }
PP2ConditionalNodeTest >> testConditionFalse [
	| parser |
	parser := ('a' asPParser if: [ :ctx | false ]).
	
	self assert: parser fail: 'a'.
	self assert: parser fail: 'b'.
]

{ #category : #accessing }
PP2ConditionalNodeTest >> testConditionTrue [
	| parser |
	parser := ('a' asPParser if: [ :ctx | true ]).
	
	self assert: parser parse: 'a'.
	self assert: parser fail: 'b'.
]

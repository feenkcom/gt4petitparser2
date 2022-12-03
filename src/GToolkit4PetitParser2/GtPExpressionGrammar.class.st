Class {
	#name : #GtPExpressionGrammar,
	#superclass : #PP2CompositeNode,
	#instVars : [
		'terms',
		'addition',
		'number',
		'parentheses',
		'multiplication',
		'primary',
		'openBracket',
		'closeBracket',
		'plus',
		'star',
		'subtraction',
		'minus',
		'division',
		'slash'
	],
	#category : #GToolkit4PetitParser2
}

{ #category : #grammar }
GtPExpressionGrammar >> addition [
	^ primary, plus trim, terms
]

{ #category : #tokens }
GtPExpressionGrammar >> closeBracket [
	^ $) asPParser
]

{ #category : #grammar }
GtPExpressionGrammar >> division [
	^ primary, slash trim, terms
]

{ #category : #tokens }
GtPExpressionGrammar >> minus [
	^ $- asPParser
]

{ #category : #grammar }
GtPExpressionGrammar >> multiplication [
	^ primary, star trim, terms
]

{ #category : #tokens }
GtPExpressionGrammar >> number [
	^ ($- asPParser optional , #digit asPParser plus , ($. asPParser, #digit asPParser plus) optional) flatten
]

{ #category : #tokens }
GtPExpressionGrammar >> openBracket [
	^ $( asPParser
]

{ #category : #grammar }
GtPExpressionGrammar >> parentheses [
	^ openBracket trim , terms , closeBracket trim
]

{ #category : #tokens }
GtPExpressionGrammar >> plus [
	^ $+ asPParser
]

{ #category : #grammar }
GtPExpressionGrammar >> primary [
	^ number / parentheses
]

{ #category : #tokens }
GtPExpressionGrammar >> slash [
	^ $/ asPParser
]

{ #category : #tokens }
GtPExpressionGrammar >> star [
	^ $* asPParser
]

{ #category : #accessing }
GtPExpressionGrammar >> start [
	^ terms end
]

{ #category : #grammar }
GtPExpressionGrammar >> subtraction [
	^ primary, minus trim, terms
]

{ #category : #grammar }
GtPExpressionGrammar >> terms [
	^ addition / subtraction / multiplication / division / primary
]

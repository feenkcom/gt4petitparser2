"
I contain a few examples used in the PP2 tutorial in the GT Book.
"
Class {
	#name : #PP2TutorialExamples,
	#superclass : #Object,
	#category : #'GToolkit4PetitParser2-Examples'
}

{ #category : #accessing }
PP2TutorialExamples >> identifier [
	<gtExample>
	| identifier |
	identifier := #letter asPParser , #word asPParser star.
	^ identifier
]

{ #category : #accessing }
PP2TutorialExamples >> identifierFlatten [
	<gtExample>
	| identifier |
	identifier := self identifier.
	^ identifier flatten
]

{ #category : #accessing }
PP2TutorialExamples >> identifierFlattenParseHowdy [
	<gtExample>
	| identifier |
	identifier := self identifierFlatten.
	^ identifier parse: 'howdy'
]

{ #category : #accessing }
PP2TutorialExamples >> identifierMatches123 [
	<gtExample>
	| identifier |
	identifier := self identifier.
	^ identifier matches: '123'
]

{ #category : #accessing }
PP2TutorialExamples >> identifierMatchesFoo [
	<gtExample>
	| identifier |
	identifier := self identifier.
	^ identifier matches: 'foo'
]

{ #category : #accessing }
PP2TutorialExamples >> identifierParse123 [
	<gtExample>
	| identifier |
	identifier := self identifier.
	^ identifier parse: '123'
]

{ #category : #accessing }
PP2TutorialExamples >> identifierParseF12 [
	<gtExample>
	| identifier |
	identifier := self identifier.
	^ identifier parse: 'f12'
]

{ #category : #accessing }
PP2TutorialExamples >> identifierParseYeah [
	<gtExample>
	| identifier |
	identifier := self identifier.
	^ identifier parse: 'yeah'
]

{ #category : #accessing }
PP2TutorialExamples >> number [
	<gtExample>
	| number |
	number := #digit asPParser plus token trim
			==> [ :token | token value asNumber ].
	^ number
]

{ #category : #accessing }
PP2TutorialExamples >> numberParse42 [
	<gtExample>
	| number |
	number := self number.
	^ number parse: '42'
]

{ #category : #accessing }
PP2TutorialExamples >> start [
	<gtExample>
	| start |
	start := self term end.
	^ start
]

{ #category : #accessing }
PP2TutorialExamples >> startParseOnePlusTwoThenTimesThree [
	<gtExample>
	| start result |
	start := self start.
	result := start parse: '(1 + 2) * 3'.
	self assert: result equals: 9.
	^ result
]

{ #category : #accessing }
PP2TutorialExamples >> startParseOnePlusTwoTimesThree [
	<gtExample>
	| start result |
	start := self start.
	result := start parse: '1 + 2 * 3'. 
	self assert: result equals: 7.
	^ result
]

{ #category : #accessing }
PP2TutorialExamples >> term [
	<gtExample>
	| term prod prim number |
	number := self number.
	term := PP2UnresolvedNode new.
	prod := PP2UnresolvedNode new.
	prim := PP2UnresolvedNode new.

	term
		def: ((prod , $+ asPParser trim , term) ==> [ :nodes | nodes first + nodes last ])
				/ prod.
	prod
		def: ((prim , $* asPParser trim , prod) ==> [ :nodes | nodes first * nodes last ])
				/ prim.
	prim
		def: (($( asPParser trim , term , $) asPParser trim) ==> [ :nodes | nodes second ])
				/ number.
	self assert: (term end parse: '42') equals: 42.
	^ term
]

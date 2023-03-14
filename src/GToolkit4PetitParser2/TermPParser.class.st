Class {
	#name : #TermPParser,
	#superclass : #PP2CompositeNode,
	#instVars : [
		'number',
		'term',
		'prod',
		'prim',
		'start'
	],
	#category : #'GToolkit4PetitParser2-Tutorial'
}

{ #category : #grammar }
TermPParser >> number [
	^ #digit asPParser plus token trim ==> [ :token | token value asNumber ]
]

{ #category : #grammar }
TermPParser >> prim [
	^ (($( asPParser trim , term , $) asPParser trim) ==> [ :nodes | nodes second ])
		/ number
]

{ #category : #grammar }
TermPParser >> prod [
	^ ((prim , $* asPParser trim , prod) ==> [ :nodes | nodes first * nodes last ])
		/ prim
]

{ #category : #accessing }
TermPParser >> start [
	^ term end
]

{ #category : #grammar }
TermPParser >> term [
	^ ((prod , $+ asPParser trim , term) ==> [ :nodes | nodes first + nodes last ])
		/ prod
]

Extension { #name : #PP2PossesiveRepeatingNode }

{ #category : #'*GToolkit4PetitParser2' }
PP2PossesiveRepeatingNode >> asElementIn: aParentElement havingVisited: aCollection withExtraElements: anElementsCollection [
	| wrapper content |
	wrapper := BlElement new
			constraintsDo: [ :c | 
				c vertical fitContent.
				c horizontal fitContent ];
			layout: BlLinearLayout new;
			padding: (BlInsets all: 10);
			border: (BlBorder paint: BrGlamorousColors lightBorderColor).
	content := BlElement new
			constraintsDo: [ :c | 
				c vertical fitContent.
				c horizontal fitContent ];
			layout: BlLinearLayout new.
	wrapper addChild: content.
	aParentElement
		addChild: (self
				wrap: wrapper
				withExtraElements: (anElementsCollection copy
						add: (BrLabel new
								text: self rangeString;
								aptitude: (BrGlamorousLabelAptitude new foreground: Color gray));
						yourself)).
	self
		asElementChildrenIn: content
		havingVisited: aCollection
		withExtraElements: OrderedCollection new
]

{ #category : #'*GToolkit4PetitParser2' }
PP2PossesiveRepeatingNode >> rangeString [
	^ self min asString , '..'
		, (self max isInfinite ifTrue: [ 'n' ] ifFalse: [ self max asString ])
]

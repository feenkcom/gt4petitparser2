Extension { #name : 'PP2SequenceNode' }

{ #category : '*GToolkit4PetitParser2' }
PP2SequenceNode >> asElementChildrenIn: aParentElement havingVisited: aCollection withExtraElements: anElementsCollection [
	aParentElement 
		layout: (BlLinearLayout horizontal cellSpacing: 10);
		padding: (BlInsets left: -10).
	self children
		do: [ :aChild | 
			aChild
				asElementIn: aParentElement
				havingVisited: aCollection
				withExtraElements: anElementsCollection ]
]

{ #category : '*GToolkit4PetitParser2' }
PP2SequenceNode >> asElementIn: aParentElement havingVisited: aCollection withExtraElements: anElementsCollection [
"	(aCollection includes: self)
		ifTrue: [ ^ self ].
"
	self
		asElementChildrenIn: aParentElement
		havingVisited: aCollection
		withExtraElements: anElementsCollection
]

{ #category : '*GToolkit4PetitParser2' }
PP2SequenceNode >> gtDisplayOn: aStream [
	aStream nextPut: $,
]

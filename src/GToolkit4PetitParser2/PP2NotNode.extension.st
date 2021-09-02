Extension { #name : 'PP2NotNode' }

{ #category : '*GToolkit4PetitParser2' }
PP2NotNode >> asElementIn: aParentElement havingVisited: aCollection withExtraElements: anElementsCollection [
"	(aCollection includes: self)
		ifTrue: [ ^ self ].
"
	self
		asElementChildrenIn: aParentElement
		havingVisited: aCollection
		withExtraElements: (anElementsCollection copy add: (BrLabel new text: 'not'; aptitude: (BrGlamorousLabelAptitude new foreground: Color gray)); yourself)
]

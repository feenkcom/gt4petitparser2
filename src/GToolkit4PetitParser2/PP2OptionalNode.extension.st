Extension { #name : #PP2OptionalNode }

{ #category : #'*GToolkit4PetitParser2' }
PP2OptionalNode >> asElementIn: aParentElement havingVisited: aCollection withExtraElements: anElementsCollection [
"	(aCollection includes: self)
		ifTrue: [ ^ self ].
"
	self
		asElementChildrenIn: aParentElement
		havingVisited: aCollection
		withExtraElements: (anElementsCollection copy add: (BrLabel new text: 'optional'; aptitude: (BrGlamorousLabelAptitude new foreground: Color gray)); yourself)
]

Extension { #name : #PP2EndNode }

{ #category : #'*GToolkit4PetitParser2' }
PP2EndNode >> asElementIn: aParentElement havingVisited: aCollection withExtraElements: anElementsCollection [
"	(aCollection includes: self)
		ifTrue: [ ^ self ].
"
	self
		asElementChildrenIn: aParentElement
		havingVisited: aCollection
		withExtraElements: (anElementsCollection copy 
			add: (BrLabel new text: 'end'; aptitude: (BrGlamorousLabelAptitude new foreground: Color gray)); 
			yourself)
]

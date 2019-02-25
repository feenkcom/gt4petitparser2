Extension { #name : #PP2FlattenNode }

{ #category : #'*GToolkit4PetitParser2' }
PP2FlattenNode >> asElementIn: aParentElement havingVisited: aCollection withExtraElements: anElementsCollection [
"	(aCollection includes: self)
		ifTrue: [ ^ self ].
"
	self
		asElementChildrenIn: aParentElement
		havingVisited: aCollection
		withExtraElements: (anElementsCollection copy add: (BrLabel new text: 'flatten'; look: (BrGlamorousLabelLook new foreground: Color gray)); yourself)
]

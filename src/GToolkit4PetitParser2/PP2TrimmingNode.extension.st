Extension { #name : #PP2TrimmingNode }

{ #category : #'*GToolkit4PetitParser2' }
PP2TrimmingNode >> asElementIn: aParentElement havingVisited: aCollection withExtraElements: anElementsCollection [
"	(aCollection includes: self)
		ifTrue: [ ^ self ].
"
	self
		asElementChildrenIn: aParentElement
		havingVisited: aCollection
		withExtraElements: (anElementsCollection copy add: (BrLabel new text: 'trim'; look: (BrGlamorousLabelLook new foreground: Color gray)); yourself)
]

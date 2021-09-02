Extension { #name : 'PP2DelegateNode' }

{ #category : '*GToolkit4PetitParser2' }
PP2DelegateNode >> asElementChildrenIn: aParentElement havingVisited: aCollection withExtraElements: anElementsCollection [
	self child
		asElementIn: aParentElement
		havingVisited: aCollection
		withExtraElements: anElementsCollection
]

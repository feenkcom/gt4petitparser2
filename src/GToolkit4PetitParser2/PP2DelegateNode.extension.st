Extension { #name : #PP2DelegateNode }

{ #category : #'*GToolkit4PetitParser2' }
PP2DelegateNode >> asPrivateGraphChildrenIn: aParentElement havingVisited: aCollection [
	self child
		asGraphElementIn: aParentElement
		havingVisited: aCollection
]

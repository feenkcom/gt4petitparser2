Extension { #name : #PP2SequenceNode }

{ #category : #'*GToolkit4PetitParser2' }
PP2SequenceNode >> asGraphElementIn: aParentElement havingVisited: aCollection [
	self
		asGraphChildrenIn: aParentElement
		havingVisited: aCollection.
]

{ #category : #'*GToolkit4PetitParser2' }
PP2SequenceNode >> asPrivateGraphChildrenIn: aParentElement havingVisited: aCollection [
	aParentElement layout: BlLinearLayout horizontal.
	self children
		do: [ :aChild | 
			aChild
				asGraphElementIn: aParentElement
				havingVisited: aCollection ]
]

{ #category : #'*GToolkit4PetitParser2' }
PP2SequenceNode >> gtDisplayOn: aStream [
	aStream nextPut: $,
]

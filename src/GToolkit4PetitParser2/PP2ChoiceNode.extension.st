Extension { #name : #PP2ChoiceNode }

{ #category : #'*GToolkit4PetitParser2' }
PP2ChoiceNode >> asGraphElementIn: aParentElement havingVisited: aCollection [
	self
		asGraphChildrenIn: aParentElement
		havingVisited: aCollection.
]

{ #category : #'*GToolkit4PetitParser2' }
PP2ChoiceNode >> asPrivateGraphChildrenIn: aParentElement havingVisited: aCollection [
	aParentElement layout: BlLinearLayout vertical.
	self children
		do: [ :aChild | 
			aChild
				asGraphElementIn: aParentElement
				havingVisited: aCollection ]
]

{ #category : #'*GToolkit4PetitParser2' }
PP2ChoiceNode >> gtDisplayOn: aStream [
	aStream nextPut: $/
]

Extension { #name : #PP2ChoiceNode }

{ #category : #'*GToolkit4PetitParser2' }
PP2ChoiceNode >> asElementChildrenIn: aParentElement havingVisited: aCollection [
	aParentElement layout: BlLinearLayout vertical.
	self children
		do: [ :aChild | 
			aChild
				asElementIn: aParentElement
				havingVisited: aCollection ]
]

{ #category : #'*GToolkit4PetitParser2' }
PP2ChoiceNode >> asElementIn: aParentElement havingVisited: aCollection [
	self
		asElementChildrenIn: aParentElement
		havingVisited: aCollection.
]

{ #category : #'*GToolkit4PetitParser2' }
PP2ChoiceNode >> gtDisplayOn: aStream [
	aStream nextPut: $/
]

Extension { #name : #PP2SequenceNode }

{ #category : #'*GToolkit4PetitParser2' }
PP2SequenceNode >> asElementChildrenIn: aParentElement havingVisited: aCollection [
	aParentElement layout: BlLinearLayout horizontal.
	self children
		do: [ :aChild | 
			aChild
				asElementIn: aParentElement
				havingVisited: aCollection ]
]

{ #category : #'*GToolkit4PetitParser2' }
PP2SequenceNode >> asElementIn: aParentElement havingVisited: aCollection [
	self
		asElementChildrenIn: aParentElement
		havingVisited: aCollection.
]

{ #category : #'*GToolkit4PetitParser2' }
PP2SequenceNode >> gtDisplayOn: aStream [
	aStream nextPut: $,
]

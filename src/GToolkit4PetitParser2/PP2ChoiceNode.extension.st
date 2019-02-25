Extension { #name : #PP2ChoiceNode }

{ #category : #'*GToolkit4PetitParser2' }
PP2ChoiceNode >> asElementChildrenIn: aParentElement havingVisited: aCollection withExtraElements: anElementsCollection [
	aParentElement 
		layout: (BlLinearLayout vertical cellSpacing: 10);
		padding: (BlInsets top: -10).
	self children
		do: [ :aChild | 
			aChild
				asElementIn: aParentElement
				havingVisited: aCollection
				withExtraElements: anElementsCollection ]
]

{ #category : #'*GToolkit4PetitParser2' }
PP2ChoiceNode >> asElementIn: aParentElement havingVisited: aCollection withExtraElements: anElementsCollection [
"	(aCollection includes: self)
		ifTrue: [ ^ self ].
"
	self
		asElementChildrenIn: aParentElement
		havingVisited: aCollection
		withExtraElements: anElementsCollection
]

{ #category : #'*GToolkit4PetitParser2' }
PP2ChoiceNode >> gtDisplayOn: aStream [
	aStream nextPut: $/
]

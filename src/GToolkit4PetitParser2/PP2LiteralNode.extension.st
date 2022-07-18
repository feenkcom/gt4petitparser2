Extension { #name : #PP2LiteralNode }

{ #category : #'*GToolkit4PetitParser2' }
PP2LiteralNode >> asElementIn: aParentElement havingVisited: aCollection withExtraElements: anElementsCollection [
	| label |
	label := BrLabel new
			background: Color white;
			text: self gtNameOrTypeDisplayString asRopedText;
			geometry: (BlRoundedRectangleGeometry cornerRadius: 3);
			border: (BlBorder paint: BrGlamorousColors lightBorderColor width: 1);
			padding: (BlInsets all: 10).
	aParentElement
		addChild: (self wrap: label withExtraElements: anElementsCollection)
]

{ #category : #'*GToolkit4PetitParser2' }
PP2LiteralNode >> gtDisplayOn: aStream [
	aStream nextPut: $'.
	aStream nextPutAll: literal asString.
	aStream nextPut: $'
]

{ #category : #'*GToolkit4PetitParser2' }
PP2LiteralNode >> gtNameOrTypeDisplayString [ 
	^ self gtDisplayString
]

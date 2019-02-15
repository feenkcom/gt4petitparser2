Extension { #name : #PP2LiteralNode }

{ #category : #'*GToolkit4PetitParser2' }
PP2LiteralNode >> gtDisplayOn: aStream [
	aStream nextPut: $'.
	aStream nextPutAll: literal asString.
	aStream nextPut: $'
]

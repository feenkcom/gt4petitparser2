Extension { #name : #TPP2Context }

{ #category : #'*GToolkit4PetitParser2-Indent' }
TPP2Context >> MPPStack [
	^ self globalAt: #mppstack ifAbsentPut: [ Stack with: 1 ]
]

{ #category : #'*GToolkit4PetitParser2-Indent' }
TPP2Context >> column [
	^ self stream column
]

{ #category : #'*GToolkit4PetitParser2-Indent' }
TPP2Context >> indentStack [
	^ self propertyAt: #indentStack ifAbsentPut: [ IndentStack new ]
]

{ #category : #'*GToolkit4PetitParser2-Indent' }
TPP2Context >> lastIndent [
	^ self indentTraces lastIndent
]

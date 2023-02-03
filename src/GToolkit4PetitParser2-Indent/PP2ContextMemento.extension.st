Extension { #name : #PP2ContextMemento }

{ #category : #'*GToolkit4PetitParser2-Indent' }
PP2ContextMemento >> indentStack [
	^ self propertyAt: #indentStack ifAbsent: [ IndentStack new ]
]

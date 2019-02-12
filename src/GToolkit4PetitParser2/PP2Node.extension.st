Extension { #name : #PP2Node }

{ #category : #'*GToolkit4PetitParser2' }
PP2Node >> gtNamedChildren [
	"Answer the named children of the receiver."

	^ Gt4PPNamedChildrenVisitor new visit: self
]

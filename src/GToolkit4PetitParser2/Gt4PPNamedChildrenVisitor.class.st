Class {
	#name : 'Gt4PPNamedChildrenVisitor',
	#superclass : 'PP2NoopVisitor',
	#category : 'GToolkit4PetitParser2'
}

{ #category : 'visiting' }
Gt4PPNamedChildrenVisitor >> visitPP2Node: node [
	| retval |
	(self isRoot not and: [ node name isNil not ]) ifTrue: [ 
		^ IdentitySet with: node 
	].

	retval := IdentitySet new.
	node children do: [ :child | retval addAll: (self visit: child) ].
	^ retval
]

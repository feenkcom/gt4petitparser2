Class {
	#name : #PP2Push2Node,
	#superclass : #PP2DelegateNode,
	#category : #'GToolkit4PetitParser2-Indent-Nodes'
}

{ #category : #parsing }
PP2Push2Node >> parseOn: context [
	| result |
	
	result := parser parseOn: context.
	result isPetit2Failure ifFalse: [ 
		context indentStack push: result.
	].
	^ result
]

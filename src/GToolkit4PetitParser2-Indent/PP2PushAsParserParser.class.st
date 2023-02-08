Class {
	#name : #PP2PushAsParserParser,
	#superclass : #PP2DelegateNode,
	#category : #'GToolkit4PetitParser2-Indent-Nodes'
}

{ #category : #parsing }
PP2PushAsParserParser >> parseOn: context [
	| result |
	
	result := parser parseOn: context.
	result isPetit2Failure ifFalse: [ 
		context indentStack push: result asPParser.
	].
	^ result
]

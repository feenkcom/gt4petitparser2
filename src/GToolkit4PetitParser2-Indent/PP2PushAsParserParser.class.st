Class {
	#name : #PP2PushAsParserParser,
	#superclass : #PPDelegateParser,
	#category : #'GToolkit4PetitParser2-Indent'
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

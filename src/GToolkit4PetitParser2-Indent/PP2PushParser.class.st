Class {
	#name : #PP2PushParser,
	#superclass : #PPDelegateParser,
	#category : #'GToolkit4PetitParser2-Indent'
}

{ #category : #parsing }
PP2PushParser >> parseOn: context [
	| result |
	
	result := parser parseOn: context.
	result isPetit2Failure ifFalse: [ 
		context indentStack push: result.
	].
	^ result
]

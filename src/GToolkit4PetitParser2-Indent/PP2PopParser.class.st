Class {
	#name : #PP2PopParser,
	#superclass : #PPParser,
	#category : #'GToolkit4PetitParser2-Indent'
}

{ #category : #parsing }
PP2PopParser >> parseOn: context [
	context indentStack isEmpty ifTrue: [ 
		^ PPFailure message: 'cannot pop an empty stack' context: context
	].

	^ context indentStack pop
]

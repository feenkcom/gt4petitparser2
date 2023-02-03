Class {
	#name : #PP2IndentStack,
	#superclass : #Object,
	#instVars : [
		'contents'
	],
	#category : #'GToolkit4PetitParser2-Indent'
}

{ #category : #comparison }
PP2IndentStack >> = anotherStack [
	self == anotherStack ifTrue: [ ^ true ].
	self contents = anotherStack contents ifTrue: [ ^ true ].
	
	^ false
]

{ #category : #accessing }
PP2IndentStack >> contents [
	^ contents
]

{ #category : #comparison }
PP2IndentStack >> hash [
	^ contents hash
]

{ #category : #initialization }
PP2IndentStack >> initialize [
	super initialize.
	contents := OrderedCollection new.
]

{ #category : #testing }
PP2IndentStack >> isEmpty [
	^ self size = 0
]

{ #category : #removing }
PP2IndentStack >> pop [
	contents isEmpty ifTrue: [ ^ PPFailure message: 'cannot pop an empty stack' ].
	^ contents removeLast
]

{ #category : #copy }
PP2IndentStack >> postCopy [
	super postCopy.
	contents := contents copy.
]

{ #category : #adding }
PP2IndentStack >> push: anExpression [
"	self assert: anExpression isPetitParser."
	^ contents addLast: anExpression
]

{ #category : #'as yet unclassified' }
PP2IndentStack >> replay: context [
	| retval result memento |
	memento := context remember.
	
	retval := OrderedCollection new.
	contents do: [ :p |
"		Transcript crShow:  'parsing: ', p asString."
		result := p parseOn: context.
		result isPetit2Failure ifTrue: [
			context restore: memento. 
			^ result
		].
		retval addLast: result.
	].
	^ retval
]

{ #category : #accessing }
PP2IndentStack >> size [
	^ contents size
]

{ #category : #accessing }
PP2IndentStack >> top [
	^ contents last
]

{ #category : #'as yet unclassified' }
PP2IndentStack >> topIfEmpty: block [
	self isEmpty ifTrue: [ ^ block value ].
	^ self top
]

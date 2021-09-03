Extension { #name : 'PP2DebugResult' }

{ #category : '*GToolkit4PetitParser2' }
PP2DebugResult >> gtDisplayWithoutResults [
	^ String streamContents: [:s | self gtDisplayWithoutResultsOn: s ] 
]

{ #category : '*GToolkit4PetitParser2' }
PP2DebugResult >> gtDisplayWithoutResultsOn: aStream [ 
	self parser ifNil: [ ^ self printOn: aStream ].
	aStream 
		nextPutAll: self parser gtDisplayString;
		nextPutAll: '(';
		nextPutAll: self allResults size asString;
		nextPutAll: ')'
]

{ #category : '*GToolkit4PetitParser2' }
PP2DebugResult >> gtFormattedText [
	self result isPetit2Failure ifTrue: [ 
		^ self gtDisplayWithoutResults asRopedText foreground: Color gray 
	].
	^ self gtDisplayWithoutResults asRopedText
]

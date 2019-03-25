Extension { #name : #PP2DebugResult }

{ #category : #'*GToolkit4PetitParser2' }
PP2DebugResult >> gtFormattedText [
	self result isPetit2Failure ifTrue: [ 
		^ self printString asRopedText foreground: Color gray 
	].
	(self isBiggestChild) ifTrue: [  
		^ self printString asRopedText foreground: Color red muchDarker
	].
	^ self printString asRopedText
]

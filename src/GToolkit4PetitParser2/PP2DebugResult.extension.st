Extension { #name : #PP2DebugResult }

{ #category : #'*GToolkit4PetitParser2' }
PP2DebugResult >> gtDisplayWithoutResults [
	^ String streamContents: [:s | self gtDisplayWithoutResultsOn: s ] 
]

{ #category : #'*GToolkit4PetitParser2' }
PP2DebugResult >> gtDisplayWithoutResultsOn: aStream [ 
	self parser ifNil: [ ^ self printOn: aStream ].
	aStream 
		nextPutAll: self parser gtDisplayString;
		nextPutAll: '(';
		nextPutAll: self allResults size asString;
		nextPutAll: ')'
]

{ #category : #'*GToolkit4PetitParser2' }
PP2DebugResult >> gtFormattedText [
	self result isPetit2Failure ifTrue: [ 
		^ self gtDisplayWithoutResults asRopedText foreground: Color gray 
	].
	^ self gtDisplayWithoutResults asRopedText
]

{ #category : #'*GToolkit4PetitParser2' }
PP2DebugResult >> gtStreamStateFor: aView [

	<gtView>
	^ aView explicit
		  title: 'Stream State';
		  priority: 1;
		  stencil: [ 
			  | aText e contents |
			  contents := self contents.
			  aText := contents asRopedText.
			  (self start notNil and: [ self stop notNil ]) ifTrue: [ 
					  (aText from: (self start max: 1) to: (self stop max: 1)) highlight:
							  BrGlamorousColors successBackgroundColor ].
				self stop notNil ifTrue: [ 
					(aText from: (self stop max: 1) to: (self stop max: 1))
						attribute: (GtPlaygroundEvaluatedCodeButtonAttribute new beAppend result: self) ].
			  e := BrEditor new
				       text: aText;
				       aptitude: BrGlamorousCodeEditorAptitude new.
			  self start notNil ifTrue: [ 
				  e scrollToPosition:
					  (contents lineNumberCorrespondingToIndex: self start) ].
			  e ]
]

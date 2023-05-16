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
		  title: 'Stream state';
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

{ #category : #'*GToolkit4PetitParser2' }
PP2DebugResult >> gtTreeFor: aView [
	<gtView>
	self debugResult children isEmpty ifTrue: [ ^ aView empty ].
	^ aView columnedTree
		title: 'Execution traces';
		items: [ {self debugResult children first} ];
		column: 'Parser' text: [ :debuggerResult | debuggerResult gtFormattedText ];
		column: 'Value' text: [ :debuggerResult | 
			debuggerResult result printStringLimitedTo: 50 ];
		children: [ :debuggerResult | debuggerResult children ]
]

{ #category : #'*GToolkit4PetitParser2' }
PP2DebugResult >> topMostParent [
	^ self parent isNil
		ifTrue: [ self ]
		ifFalse: [ self parent ]
]

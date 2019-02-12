Extension { #name : #TPP2Context }

{ #category : #'*GToolkit4PetitParser2' }
TPP2Context >> gtGlobalsFor: aView [
	<gtView>
	
	^ aView columnedList
		title: 'Globals';
		column: 'Key' evaluated: [ :each | each key printString ];
		column: 'Value' evaluated: [ :each | each value printString ];
		items: [ (self globals ifNil: [ Dictionary new ]) associations ]


]

{ #category : #'*GToolkit4PetitParser2' }
TPP2Context >> gtPropertiesFor: aView [
	<gtView>
	
	^ aView columnedList
		title: 'Properties';
		column: 'Key' evaluated: [ :each | each key printString ];
		column: 'Value' evaluated: [ :each | each value printString ];
		items: [ (self properties ifNil: [ Dictionary new ]) associations ]


]

{ #category : #'*GToolkit4PetitParser2' }
TPP2Context >> gtResultFor: aView [
	<gtView>
	^ aView textEditor
		title: 'Return value';
		text: [ self returnValue gtDisplayString ];
		actionButtonIcon: BrGlamorousIcons inspect action: [ : aButton |
			aButton phlow spawnObject: self returnValue]
]

{ #category : #'*GToolkit4PetitParser2' }
TPP2Context >> gtTextFor: aView [
	<gtView>
	
	^ aView textEditor
		title: 'Input text';
		text: [  
			| printStream |
			printStream := WriteStream on: String new.
			self stream asPetit2Stream printOn: printStream position: self position.
			printStream contents
	]

]

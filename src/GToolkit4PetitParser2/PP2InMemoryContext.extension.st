Extension { #name : #PP2InMemoryContext }

{ #category : #'*GToolkit4PetitParser2' }
PP2InMemoryContext >> gtResultFor: aView [
	<gtView>
	^ aView textEditor
		title: 'Return value';
		priority: 10;
		text: [ self returnValue gtDisplayString ];
		actionButtonIcon: BrGlamorousIcons inspect action: [ : aButton |
			aButton phlow spawnObject: self returnValue]
]

{ #category : #'*GToolkit4PetitParser2' }
PP2InMemoryContext >> gtTextFor: aView [
	<gtView>
	^ aView textEditor
		title: 'Input text' translated;
		text: [  
			| string text |
			string := String streamContents: [ :s | 
				| stream |
				stream := self stream asPetit2Stream.
				s nextPutAll: (stream collection copyFrom: 1 to: stream collection size) ].
			text := string asRopedText.
			(text from: self position to: self position) 
				attribute: (GtPlaygroundEvaluatedCodeButtonAttribute new
						beNotOverwritableByStyler;
						beAppend;
						result: self position;
						paint: (Color fromHexString: #'90CAF9')).
			text ]

]
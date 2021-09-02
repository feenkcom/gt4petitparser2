Extension { #name : 'PP2Token' }

{ #category : '*GToolkit4PetitParser2' }
PP2Token >> gtSourceFor: aView [
	<gtView>
	^ aView explicit
		title: 'Source';
		stencil: [ 
			| text e string |
			string := self collection asString.
			text := string asRopedText.
			text
				attributes:
					{(BlTextUnderlineAttribute new
						color: BrGlamorousColors textHighlightColor;
						thickness: 3;
						beNotOverwritableByStyler)}
				from: self start
				to: self stop.
			e := BrEditor new
				text: text;
				aptitude: BrGlamorousCodeEditorAptitude new.
			e
				scrollToPosition: (string lineNumberCorrespondingToIndex: self start).
			e 
		]
]

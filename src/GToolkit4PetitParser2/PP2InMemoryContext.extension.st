Extension { #name : #PP2InMemoryContext }

{ #category : #'*GToolkit4PetitParser2' }
PP2InMemoryContext >> gtTreeFor: aView [
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

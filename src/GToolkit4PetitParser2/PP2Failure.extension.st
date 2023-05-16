Extension { #name : #PP2Failure }

{ #category : #'*GToolkit4PetitParser2' }
PP2Failure >> gtTreeFor: aView [
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

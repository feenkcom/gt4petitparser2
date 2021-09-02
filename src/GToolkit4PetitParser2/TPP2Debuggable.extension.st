Extension { #name : 'TPP2Debuggable' }

{ #category : '*GToolkit4PetitParser2' }
TPP2Debuggable >> gtTreeFor: aView [
	<gtView>
	self debugResult children isEmpty ifTrue: [ ^ aView empty ].
	^ aView columnedTree
		title: 'Execution Traces';
		items: [ {self debugResult children first} ];
		column: 'Parser' text: [ :debuggerResult | debuggerResult gtFormattedText ];
		column: 'Value' text: [ :debuggerResult | 
			debuggerResult result printStringLimitedTo: 50 ];
		children: [ :debuggerResult | debuggerResult children ]
]

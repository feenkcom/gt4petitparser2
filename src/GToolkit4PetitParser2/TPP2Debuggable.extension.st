Extension { #name : #TPP2Debuggable }

{ #category : #'*GToolkit4PetitParser2' }
TPP2Debuggable >> gtTreeFor: aView [
	<gtView>
	self debugResult children isEmpty ifTrue: [ ^ aView empty ].
	^ aView columnedTree
		title: 'Execution Traces';
		items: [ {self debugResult children first} ];
		column: 'Parser' do: [ :column |
			column item: [ :debuggerResult | debuggerResult gtFormattedText ]; matchParent ];
		column: 'Value' do: [ :column |
			column item: [ :debuggerResult | debuggerResult result printStringLimitedTo: 50 ]; matchParent ];
		children: [ :debuggerResult | debuggerResult children ]
]

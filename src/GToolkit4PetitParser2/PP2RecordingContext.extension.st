Extension { #name : #PP2RecordingContext }

{ #category : #'*GToolkit4PetitParser2' }
PP2RecordingContext >> gtCacheReportFor: aView [
	<gtView>
	^ aView columnedList 
		title: 'Caches';
		column: 'Cache' evaluated: [ :each | each first printString ];
		column: 'Hit Rate' evaluated: [ :each | each second printString ];
		column: 'Invocations' evaluated: [ :each | each third printString ];
		items: [ self asCacheReport  ]
]

{ #category : #'*GToolkit4PetitParser2' }
PP2RecordingContext >> gtEventsTableFor: aView [
	<gtView>
	^ aView columnedList 
		title: 'Events Table';
		column: 'Position' evaluated: [ :each | each first printString ];
		column: 'Event' evaluated: [ :each | each second printString ];
		column: 'Strategy' evaluated: [ :each | each third printString ];
		column: 'Node' evaluated: [ :each | each fourth printString ];
		items: [ self eventsTable ].
]

{ #category : #'*GToolkit4PetitParser2' }
PP2RecordingContext >> gtTallyFor: composite [
	<gtView>
	^ composite columnedList 
		title: 'Global Tally';
		column: 'Strategy' evaluated: [ :each | each first gtDisplayString ];
		column: 'Count' evaluated: [ :each | each second printString ];
		column: 'Percentage (%)' evaluated: [ :each | each third printString ];
		items: [ self asFrequencyTable ];
		send: #first
		"selectionAct: [ :list :context | list selection first inspect] on: $i entitled: 'Inspect (i)';
		act: [ :p :ctx | ctx asFrequencyTable inspect ] icon: GLMUIThemeExtraIcons glamorousInspect entitled: 'Inspect';
		showOnly: 50"
]

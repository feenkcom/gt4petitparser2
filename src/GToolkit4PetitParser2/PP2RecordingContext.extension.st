Extension { #name : #PP2RecordingContext }

{ #category : #'*GToolkit4PetitParser2' }
PP2RecordingContext >> gtCacheReportFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Caches';
		column: 'Cache' item: [ :each | each first printString ];
		column: 'Hit Rate' item: [ :each | each second printString ];
		column: 'Invocations' item: [ :each | each third printString ];
		items: [ self asCacheReport ]
]

{ #category : #'*GToolkit4PetitParser2' }
PP2RecordingContext >> gtEventsTableFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Events Table';
		column: 'Position' item: [ :each | each first printString ];
		column: 'Event' item: [ :each | each second printString ];
		column: 'Strategy' item: [ :each | each third printString ];
		column: 'Node' item: [ :each | each fourth printString ];
		items: [ self eventsTable ]
]

{ #category : #'*GToolkit4PetitParser2' }
PP2RecordingContext >> gtTallyFor: composite [
	<gtView>
	^ composite columnedList
		title: 'Global Tally';
		column: 'Strategy' item: [ :each | each first gtDisplayString ];
		column: 'Count' item: [ :each | each second printString ];
		column: 'Percentage (%)' item: [ :each | each third printString ];
		items: [ self asFrequencyTable ];
		send: #first
	"selectionAct: [ :list :context | list selection first inspect] on: $i entitled: 'Inspect (i)';
		act: [ :p :ctx | ctx asFrequencyTable inspect ] icon: GLMUIThemeExtraIcons glamorousInspect entitled: 'Inspect';
		showOnly: 50"
]

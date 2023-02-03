Extension { #name : #TPP2Context }

{ #category : #'*GToolkit4PetitParser2-YAML' }
TPP2Context >> YAMLChomp [
	^ self propertyAt: #YAMLChomp ifAbsent: #'keep'
]

{ #category : #'*GToolkit4PetitParser2-YAML' }
TPP2Context >> YAMLChomp: whatever [
	self propertyAt: #YAMLChomp put: whatever
]

{ #category : #'*GToolkit4PetitParser2-YAML' }
TPP2Context >> YAMLContext [
	^ self propertyAt: #YAMLContext ifAbsent: #'flow-in'
]

{ #category : #'*GToolkit4PetitParser2-YAML' }
TPP2Context >> YAMLContext: whatever [
	self propertyAt: #YAMLContext put: whatever
]

{ #category : #'*GToolkit4PetitParser2-YAML' }
TPP2Context >> YAMLM [
	^ self propertyAt: #YAMLM ifAbsent: [ ^ 1 ]
]

{ #category : #'*GToolkit4PetitParser2-YAML' }
TPP2Context >> YAMLM: whatever [
	self propertyAt: #YAMLM put: whatever
]

{ #category : #'*GToolkit4PetitParser2-YAML' }
TPP2Context >> YAMLN [
	self indentStack isEmpty ifTrue: [ ^ 1 ].
	^ self indentStack top column
]

{ #category : #'*GToolkit4PetitParser2-YAML' }
TPP2Context >> YAMLN: whatever [
	| compare |
	compare := PPCompareParser 
					on: [ :ctx | ctx column = whatever  ] 
					message: 'expected level: ', whatever asString
					column: whatever.

	self indentStack push: compare.
]

{ #category : #'*GToolkit4PetitParser2-YAML' }
TPP2Context >> YAMLRestoreM [
	^ self indentTraces pop: #YAMLM
]

{ #category : #'*GToolkit4PetitParser2-YAML' }
TPP2Context >> YAMLRestoreN [
	^ self indentStack pop
]

{ #category : #'*GToolkit4PetitParser2' }
TPP2Context >> gtGlobalsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Globals';
		column: 'Key' text: [ :each | each key printString ];
		column: 'Value' text: [ :each | each value printString ];
		items: [ (self globals ifNil: [ Dictionary new ]) associations ]
]

{ #category : #'*GToolkit4PetitParser2' }
TPP2Context >> gtPropertiesFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Properties';
		column: 'Key' text: [ :each | each key printString ];
		column: 'Value' text: [ :each | each value printString ];
		items: [ (self properties ifNil: [ Dictionary new ]) associations ]
]

{ #category : #'*GToolkit4PetitParser2' }
TPP2Context >> gtResultFor: aView [
	<gtView>
	^ aView textEditor
		title: 'Return value';
		text: [ self returnValue gtDisplayString ];
		actionButtonIcon: BrGlamorousVectorIcons inspect
			action: [ :aButton | aButton phlow spawnObject: self returnValue ]
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

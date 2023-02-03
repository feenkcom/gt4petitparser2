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
	compare := PP2CompareNode 
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

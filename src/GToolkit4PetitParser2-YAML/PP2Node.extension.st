Extension { #name : #PP2Node }

{ #category : #'*GToolkit4PetitParser2-YAML' }
PP2Node >> YAMLBlockIn [
	^ self >=> [:context :cc |
		| retval aYAMLContext |
		aYAMLContext := context YAMLContext.
		context YAMLContext: #'block-in'.

		retval := cc value.

		context YAMLContext: aYAMLContext.
		retval.
	]
]

{ #category : #'*GToolkit4PetitParser2-YAML' }
PP2Node >> YAMLBlockKey [
	^ self >=> [:context :cc |
		| retval aYAMLContext |
		aYAMLContext := context YAMLContext.
		context YAMLContext: #'block-key'.

		retval := cc value.

		context YAMLContext: aYAMLContext.
		retval.
	]
]

{ #category : #'*GToolkit4PetitParser2-YAML' }
PP2Node >> YAMLBlockOut [
	^ self >=> [:context :cc |
		| retval aYAMLContext |
		aYAMLContext := context YAMLContext.
		context YAMLContext: #'block-out'.

		retval := cc value.

		context YAMLContext: aYAMLContext.
		retval.
	]
]

{ #category : #'*GToolkit4PetitParser2-YAML' }
PP2Node >> YAMLFlowIn [
	^ self >=> [:context :cc |
		| retval aYAMLContext |
		aYAMLContext := context YAMLContext.
		context YAMLContext: #'flow-in'.

		retval := cc value.

		context YAMLContext: aYAMLContext.
		retval.
	]
]

{ #category : #'*GToolkit4PetitParser2-YAML' }
PP2Node >> YAMLFlowKey [
	^ self >=> [:context :cc |
		| retval aYAMLContext |
		aYAMLContext := context YAMLContext.
		context YAMLContext: #'flow-key'.

		retval := cc value.

		context YAMLContext: aYAMLContext.
		retval.
	]
]

{ #category : #'*GToolkit4PetitParser2-YAML' }
PP2Node >> YAMLFlowOut [
	^ self >=> [:context :cc |
		| retval aYAMLContext |
		aYAMLContext := context YAMLContext.
		context YAMLContext: #'flow-out'.

		retval := cc value.

		context YAMLContext: aYAMLContext.
		retval.
	]
]

{ #category : #'*GToolkit4PetitParser2-YAML' }
PP2Node >> YAMLM [
	^ self >=> [:context :cc |
		| retval |
		context YAMLN: (context YAMLM).

		retval := cc value.
	
		context YAMLRestoreN.
		retval.
	]
]

{ #category : #'*GToolkit4PetitParser2-YAML' }
PP2Node >> YAMLNPlus [
	^ self >=> [:context :cc |
		| retval lastIndent |
		lastIndent := context YAMLN.
		context YAMLN: (lastIndent + 1).

		retval := cc value.
	
		context YAMLRestoreN.
		retval.
	]
]

{ #category : #'*GToolkit4PetitParser2-YAML' }
PP2Node >> YAMLPlusM [
	^ self >=> [:context :cc |
		| retval lastIndent |
		lastIndent := context YAMLN.
		context YAMLN: (lastIndent + context YAMLM).

		retval := cc value.
	
		context YAMLRestoreN.
		retval.
	]
]

{ #category : #'*GToolkit4PetitParser2-YAML' }
PP2Node >> YAMLSeqSpaces [
	^ self >=> [:context :cc |
		| retval lastIndent |
		lastIndent := context YAMLN.
		(context YAMLContext = #'block-out') ifTrue: [ 
			context YAMLN: (lastIndent - 1).
		] ifFalse: [ 
			(context YAMLContext = #'block-in') ifFalse: [ self error: 'OOUPSLA' ].
			context YAMLN: lastIndent.
		].

		retval := cc value.
		
		context YAMLRestoreN.
		retval.
	]
]

{ #category : #'*GToolkit4PetitParser2-YAML' }
PP2Node >> YAMLinFlow [
	^ self >=> [:context :cc |
		| retval aYAMLContext |
		aYAMLContext := context YAMLContext.
		(context YAMLContext = #'flow-out')	ifTrue: [ context YAMLContext: #'flow-in' ].
		(context YAMLContext = #'flow-in') 	ifTrue: [ context YAMLContext: #'flow-in' ].
		(context YAMLContext = #'block-key') ifTrue: [ context YAMLContext: #'flow-key' ].
		(context YAMLContext = #'flow-key') 	ifTrue: [ context YAMLContext: #'flow-key' ].
		
		retval := cc value.

		context YAMLContext: aYAMLContext.
		retval.
	]
]

{ #category : #'*GToolkit4PetitParser2-YAML' }
PP2Node >> preceeds [
	^ self >=> [ :context :cc |
		| memento result |
		(context position = 0) ifTrue: [ 
			PPFailure message: 'nothing preceeds start of stream' context: context 
		] ifFalse: [ 
			memento := context remember.
			
			context back	.
			result := cc value.
			
			context restore: memento.
			result
		]
	]
]

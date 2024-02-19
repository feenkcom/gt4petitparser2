Extension { #name : #GtPharoSnippetCoder }

{ #category : #'*GToolkit4PetitParser2' }
GtPharoSnippetCoder >> addCreatePetitParserMenuItem: anAst to: coderAddOns from: aCoderViewModel [
	<gtCoderContextMenuAddOns: 200>
	| nodeVariables |
	nodeVariables := Dictionary new.
	(anAst statements allSatisfy: [ :each | each isAssignment ])
		ifFalse: [ ^ self ].
	anAst
		allNodesOfType: GtPharoVariableNode
		do: [ :var | 
			| assignments |
			var whoDefines isNil
				ifTrue: [ (self class environment bindingOf: var variableName)
						ifNil: [ (aCoderViewModel sharedBindings hasBindingOf: var variableName)
								ifFalse: [ ^ self ].
							((aCoderViewModel sharedBindings bindingValueOf: var variableName)
								isKindOf: PP2Node) ifFalse: [ ^ self ].
							assignments := nodeVariables
									at: var
									ifAbsentPut: [ OrderedCollection new ].
							(var parent notNil
								and: [ var parent isAssignment and: [ var parent variable == var ] ])
								ifTrue: [ assignments add: var parent ] ] ] ].
	nodeVariables isEmpty ifTrue: [ ^ self ].
	(nodeVariables allSatisfy: [ :each | each size = 1 ]) ifFalse: [ ^ self ].
	coderAddOns
		addContextMenuItem: 'Extract PetitParser class'
		action: [ :aTextualViewModel :element | 
			(GtPP2CreateParserRefactoringController new
				sourceCoderViewModel: aTextualViewModel) executeIn: element ]
]

Class {
	#name : 'GtCoderExpandablePetitParserProductionStyler',
	#superclass : 'GtRBASTStyler',
	#category : 'GToolkit4PetitParser2'
}

{ #category : 'visiting' }
GtCoderExpandablePetitParserProductionStyler >> visitInstanceVariableNode: aIVNode [
	super visitInstanceVariableNode: aIVNode.
	(aIVNode methodNode methodClass canPerform: aIVNode name)
		ifFalse: [ ^ self ].
	self
		styleFrom: aIVNode stop
		to: aIVNode stop
		with:
			{(BrGlamorousTrangleExpanderTextAttribute new
				attributesCreatingBlock: [ BrTextAdornmentDynamicAttribute new
						beAppend;
						stencil: [ | editorElement method coder |
							method := aIVNode methodNode methodClass lookupSelector: aIVNode name.
							coder := GtPharoMethodCoder forExample: (method methodClass gtExamplesFactory createExample: method).
							editorElement := (coder asCoderUIModel expanded: true) asElement.
							editorElement border: (BlBorder paint: Color veryLightGray width: 1).
							editorElement
								margin:
									(BlInsets
										top: 0
										right: 10
										bottom: 10
										left: 10) ] ])}
]

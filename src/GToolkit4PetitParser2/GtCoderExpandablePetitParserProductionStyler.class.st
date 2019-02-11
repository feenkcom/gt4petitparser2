Class {
	#name : #GtCoderExpandablePetitParserProductionStyler,
	#superclass : #GtCoderBodyStyler,
	#category : #GToolkit4PetitParser2
}

{ #category : #visiting }
GtCoderExpandablePetitParserProductionStyler >> visitInstanceVariableNode: aIVNode [
	super visitInstanceVariableNode: aIVNode.
	(aIVNode methodNode methodClass canPerform: aIVNode name)
		ifFalse: [ ^ self ].
	self
		styleFrom: aIVNode stop
		to: aIVNode stop
		with:
			{(BrTextExpandButtonAttribute new
				attributesCreatingBlock: [ BrTextAdornmentDynamicAttribute new
						beAppend;
						stencil: [ | editorElement method coder |
							method := aIVNode methodNode methodClass lookupSelector: aIVNode name.
							coder := GtMethodCoder forExample: (method methodClass gtExamplesFactory createExample: method).
							coder expanded: true.
							editorElement := coder asElement.
							editorElement border: (BlBorder paint: Color veryLightGray width: 1).
							editorElement
								margin:
									(BlInsets
										top: 0
										right: 10
										bottom: 10
										left: 10) ] ])}
]

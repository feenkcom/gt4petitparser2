Class {
	#name : #GtCoderExpandablePetitParserProductionStyler,
	#superclass : #GtGenericPharoStyler,
	#category : #GToolkit4PetitParser2
}

{ #category : #accessing }
GtCoderExpandablePetitParserProductionStyler >> visitNamedVariable: aIVNode [
	| selector |
	super visitNamedVariable: aIVNode.
	selector := aIVNode name value asSymbol.
	(self coderViewModel behavior canPerform: selector) ifFalse: [ ^ self ].

	self
		attribute: (BrGlamorousTriangleExpanderTextAttribute new
				attributesCreatingBlock: [ BrTextAdornmentDynamicAttribute new
						beAppend;
						stencil: [ | coderElement method coder |
							method := self coderViewModel behavior lookupSelector: selector.
							coder := GtPharoMethodCoder
									forExample: (method methodClass gtExamplesFactory createExample: method).
							coderElement := coder asElement.
							coderElement border: (BlBorder paint: Color veryLightGray width: 1).
							coderElement
								margin: (BlInsets
										top: 0
										right: 10
										bottom: 10
										left: 10) ] ])
		from: aIVNode stopPosition
		to: aIVNode stopPosition
]

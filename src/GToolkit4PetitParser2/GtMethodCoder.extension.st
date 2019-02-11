Extension { #name : #GtMethodCoder }

{ #category : #'*GToolkit4PetitParser2' }
GtMethodCoder >> petitParserProductionAstFor: anAST [
	<gtAstCoderAddOns: 10>
	(anAST notNil and: [ anAST methodClass inheritsFrom: PP2CompositeNode ])
		ifFalse: [ 
			addOns removeStylerOfType: GtCoderExpandablePetitParserProductionStyler.
			^ self ].
	addOns addStyler: GtCoderExpandablePetitParserProductionStyler new
]

Extension { #name : #GtMethodCoder }

{ #category : #'*GToolkit4PetitParser2' }
GtMethodCoder >> petitParserProductionAstFor: anAST [
	<gtAstCoderAddOns: 10>
	(anAST notNil and: [ anAST isParseError not and: [ anAST methodClass inheritsFrom: PP2CompositeNode ] ])
		ifFalse: [ 
			addOns removeStylerOfType: GtCoderExpandablePetitParserProductionStyler.
			addOns removeContextAction: 'Inspect parser' translated.
			^ self ].
	addOns addStyler: GtCoderExpandablePetitParserProductionStyler new.
	addOns addContextAction: 'Inspect parser' translated icon: BrGlamorousIcons inspect action: [ :button | 
		button phlow spawnObject: (anAST methodClass new perform: anAST selector) ]
]

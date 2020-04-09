Extension { #name : #GtMethodCoder }

{ #category : #'*GToolkit4PetitParser2' }
GtMethodCoder >> petitParserProductionAstFor: anAST into: coderAddOns [
	<gtAstCoderAddOns: 10>
	(anAST notNil
		and: [ anAST isParseError not
				and: [ anAST methodClass inheritsFrom: PP2CompositeNode ] ])
		ifFalse: [ coderAddOns
				removeStylerOfType: GtCoderExpandablePetitParserProductionStyler.
			coderAddOns removeContextAction: 'Inspect parser' translated.
			^ self ].
	coderAddOns
		addStyler: GtCoderExpandablePetitParserProductionStyler new.
	coderAddOns
		addContextAction: 'Inspect parser' translated
		icon: BrGlamorousVectorIcons inspect
		action: [ :button | 
			button phlow
				spawnObject: (anAST methodClass new perform: anAST selector) ]
]

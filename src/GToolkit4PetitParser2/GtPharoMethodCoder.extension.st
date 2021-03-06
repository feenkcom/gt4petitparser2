Extension { #name : #GtPharoMethodCoder }

{ #category : #'*GToolkit4PetitParser2' }
GtPharoMethodCoder >> petitParserProductionAstFor: anAST into: coderAddOns [
	"<gtAstCoderAddOns: 10>"
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
		action: [ :aCoderUIModel :anEvent | self notifyObjectSpawn: (anAST methodClass new perform: anAST selector) ]
]

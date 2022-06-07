Extension { #name : #GtPharoMethodCoder }

{ #category : #'*GToolkit4PetitParser2' }
GtPharoMethodCoder >> petitParserProductionAstFor: anAST into: coderAddOns [
	<gtAstCoderAddOns: 10>
	
	(self behavior inheritsFrom: PP2CompositeNode)
		ifFalse: [ ^ self ].
	coderAddOns addStyler: GtCoderExpandablePetitParserProductionStyler new.
	coderAddOns
		addContextAction: 'Inspect parser' translated
		icon: BrGlamorousVectorIcons inspect
		action: [ :aCoderUIModel :anEvent | self notifyObjectSpawn: (self behavior new perform: anAST selector) ]
]

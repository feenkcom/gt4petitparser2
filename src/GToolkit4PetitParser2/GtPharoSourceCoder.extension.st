Extension { #name : #GtPharoSourceCoder }

{ #category : #'*GToolkit4PetitParser2' }
GtPharoSourceCoder >> extractProduction: anAst to: coderAddOns from: aCoderViewModel [
	<gtCoderContextMenuAddOns: 200>
	(aCoderViewModel behavior includesBehavior: PP2CompositeNode)
		ifFalse: [ ^ self ].
	(self extractableNodesFrom: aCoderViewModel)
		ifNotEmpty: [ :nodes | 
			(nodes size = 1 and: [ nodes first isVariable ]) ifTrue: [ ^ self ].
			(nodes
				anySatisfy: [ :each | each isMethod or: [ (each nodeOfType: GtPharoMethodPatternNode) notNil ] ])
				ifTrue: [ ^ self ].
			coderAddOns
				addContextMenuItem: 'Extract production'
				hover: [ :textualCoderViewModel | 
					textualCoderViewModel
						addTextAttribute: self class nodeHighlight
						from: nodes first startPosition
						to: nodes last stopPosition ]
				leave: self removeHighlightBlock
				action: [ :aTextualViewModel | 
					(GtPP2ExtractProductionRefactoringController new
						sourceCoderViewModel: aTextualViewModel) execute ] ]
]

{ #category : #'*GToolkit4PetitParser2' }
GtPharoSourceCoder >> inlineProduction: anAst to: coderAddOns from: aCoderViewModel [
	<gtCoderContextMenuAddOns: 200>
	(aCoderViewModel behavior includesBehavior: PP2CompositeNode)
		ifFalse: [ ^ self ].
	(self nodeFrom: aCoderViewModel)
		ifNotNil: [ :node | 
			node isVariable ifFalse: [ ^ self ].
			(aCoderViewModel behavior allInstVarNames includes: node source)
				ifFalse: [ ^ self ].
			(aCoderViewModel behavior whichClassIncludesSelector: node source asSymbol)
				ifNil: [ ^ self ].
			coderAddOns
				addContextMenuItem: (self
						createLabel: 'Inline production'
						description: node source)
				hover: [ :textualCoderViewModel | 
					textualCoderViewModel
						addTextAttribute: self class nodeHighlight
						from: node startPosition
						to: node stopPosition ]
				leave: self removeHighlightBlock
				action: [ :aTextualViewModel | 
					(GtPP2InlineProductionRefactoringController new
						sourceCoderViewModel: aTextualViewModel;
						variableNode: node) execute ] ]
]

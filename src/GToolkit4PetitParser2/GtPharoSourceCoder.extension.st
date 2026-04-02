Extension { #name : #GtPharoSourceCoder }

{ #category : #'*GToolkit4PetitParser2' }
GtPharoSourceCoder >> extractProduction: anAst to: coderAddOns from: aCoderViewModel [
	<gtCoderContextMenuAddOns>
	(aCoderViewModel behavior includesBehavior: PP2CompositeNode)
		ifFalse: [ ^ self ].
	(self extractableNodesFrom: aCoderViewModel)
		ifNotEmpty: [ :nodes | 
			(nodes size = 1 and: [ nodes first isVariable ]) ifTrue: [ ^ self ].
			(nodes
				anySatisfy: [ :each | each isMethod or: [ (each nodeOfType: GtPharoMethodPatternNode) notNil ] ])
				ifTrue: [ ^ self ].
			(coderAddOns
				addContextMenuItem: 'Extract production'
				group: BrMenuItemGroupConfiguration refactoring
				hover: [ :textualCoderViewModel | 
					textualCoderViewModel
						addTextAttribute: self class nodeHighlight
						from: nodes first startPosition
						to: nodes last stopPosition
						documentId: aCoderViewModel documentId ]
				leave: self removeHighlightBlock
				action: [ :aTextualViewModel :element | 
					(GtPP2ExtractProductionRefactoringController new
						sourceCoderViewModel: aTextualViewModel) executeIn: element ])
				ifNotNil: [ :anAction | anAction priority: 210 ] ]
]

{ #category : #'*GToolkit4PetitParser2' }
GtPharoSourceCoder >> inlineProduction: anAst to: coderAddOns from: aCoderViewModel [
	<gtCoderContextMenuAddOns>
	(aCoderViewModel behavior includesBehavior: PP2CompositeNode)
		ifFalse: [ ^ self ].
	(self nodeFrom: aCoderViewModel)
		ifNotNil: [ :node | 
			node isVariable ifFalse: [ ^ self ].
			(aCoderViewModel behavior allInstVarNames includes: node source)
				ifFalse: [ ^ self ].
			(aCoderViewModel behavior whichClassIncludesSelector: node source asSymbol)
				ifNil: [ ^ self ].
			(coderAddOns
				addContextMenuItem: (self
						createLabel: 'Inline production'
						description: node source)
				group: BrMenuItemGroupConfiguration refactoring
				hover: [ :textualCoderViewModel | 
					textualCoderViewModel
						addTextAttribute: self class nodeHighlight
						from: node startPosition
						to: node stopPosition
						documentId: aCoderViewModel documentId ]
				leave: self removeHighlightBlock
				action: [ :aTextualViewModel :element | 
					(GtPP2InlineProductionRefactoringController new
						sourceCoderViewModel: aTextualViewModel;
						variableNode: node) executeIn: element ])
				ifNotNil: [ :anAction | anAction priority: 211 ] ]
]

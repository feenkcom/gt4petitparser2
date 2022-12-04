Class {
	#name : #GtPExpressionNode,
	#superclass : #Object,
	#category : #GToolkit4PetitParser2
}

{ #category : #accessing }
GtPExpressionNode >> children [
	^ #()
]

{ #category : #accessing }
GtPExpressionNode >> gtASTFor: aView [
	<gtView>
	^ aView tree
		title: 'AST';
		priority: 10;
		items: [ { self } ];
		children: #children;
		itemText: [:each | each gtLocalDisplayString ];
		expandAll
]

{ #category : #accessing }
GtPExpressionNode >> gtLocalDisplayOn: stream [
	self subclassResponsibility
]

{ #category : #accessing }
GtPExpressionNode >> gtLocalDisplayString [
	^ String streamContents: [ :s | self gtLocalDisplayOn: s ]
]

{ #category : #accessing }
GtPExpressionNode >> gtTreeFor: aView [
	<gtView>
	| all |
	^ aView mondrian
		title: 'Compressed tree';
		priority: 1;
		painting: [ :m | 
			all := self withoutParentheses
					withDeepCollect: [ :each | each children collect: #withoutParentheses ].
			m nodes
				stencil: [ :each | 
					BrLabel new
						background: Color white;
						text: each gtLocalDisplayString;
						padding: (BlInsets all: 5);
						geometry: BlCircleGeometry new;
						aptitude: BrGlamorousLabelAptitude + BrShadowAptitude];
				with: all.
			m edges
				connect: all
				toAll: [ :each | each children collect: #withoutParentheses ].
			m layout custom: (GtGraphTreeLayout new verticallyReverse) ]
]

{ #category : #accessing }
GtPExpressionNode >> withoutParentheses [
	^ self 
]

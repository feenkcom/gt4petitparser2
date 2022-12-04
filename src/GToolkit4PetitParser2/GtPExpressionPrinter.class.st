Class {
	#name : #GtPExpressionPrinter,
	#superclass : #GtPExpressionParser,
	#category : #GToolkit4PetitParser2
}

{ #category : #accessing }
GtPExpressionPrinter >> addition [
	^ super addition ==> [ :t | GtPExpressionAdditionNode new left: t first; right: t last ]
]

{ #category : #accessing }
GtPExpressionPrinter >> division [
	^ super division ==> [ :t | GtPExpressionDivisionNode new left: t first; right: t last ]
]

{ #category : #accessing }
GtPExpressionPrinter >> multiplication [
	^ super multiplication ==> [ :t | GtPExpressionMultiplicationNode new left: t first; right: t last ]
]

{ #category : #accessing }
GtPExpressionPrinter >> number [
	^ super number ==> [:t | GtPExpressionNumber new value: t ]
]

{ #category : #accessing }
GtPExpressionPrinter >> parentheses [
	^ super parentheses ==> [:t | GtPExpressionParenthesesNode new value: t second ]
]

{ #category : #accessing }
GtPExpressionPrinter >> subtraction [
	^ super subtraction ==> [ :t | GtPExpressionSubtractionNode new left: t first; right: t last ]
]

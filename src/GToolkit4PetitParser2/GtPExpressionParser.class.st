Class {
	#name : #GtPExpressionParser,
	#superclass : #GtPExpressionGrammar,
	#category : #GToolkit4PetitParser2
}

{ #category : #accessing }
GtPExpressionParser >> number [
	^ super number ==> #asNumber
]

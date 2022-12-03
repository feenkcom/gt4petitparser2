Class {
	#name : #GtPExpressionParenthesesNode,
	#superclass : #GtPExpressionValueNode,
	#category : #GToolkit4PetitParser2
}

{ #category : #accessing }
GtPExpressionParenthesesNode >> children [ 
	^ { value }
]

{ #category : #accessing }
GtPExpressionParenthesesNode >> gtDisplayOn: stream [
	stream nextPut: $(.
	value gtDisplayOn: stream.
	stream nextPut: $)
]

{ #category : #accessing }
GtPExpressionParenthesesNode >> gtLocalDisplayOn: stream [
	stream nextPutAll: '()'
]

{ #category : #accessing }
GtPExpressionParenthesesNode >> withoutParentheses [
	^ value withoutParentheses
]

Class {
	#name : #GtPExpressionBinaryOperationNode,
	#superclass : #GtPExpressionNode,
	#instVars : [
		'left',
		'right'
	],
	#category : #GToolkit4PetitParser2
}

{ #category : #accessing }
GtPExpressionBinaryOperationNode >> children [ 
	^ { left . right }
]

{ #category : #accessing }
GtPExpressionBinaryOperationNode >> gtDisplayOn: stream [
	left gtDisplayOn: stream.
	stream nextPut: self operationSign.
	right gtDisplayOn: stream.
]

{ #category : #accessing }
GtPExpressionBinaryOperationNode >> gtLocalDisplayOn: stream [
	stream nextPut: self operationSign
]

{ #category : #accessing }
GtPExpressionBinaryOperationNode >> left: anObject [ 
	left := anObject
]

{ #category : #accessing }
GtPExpressionBinaryOperationNode >> operationSign [
	^ self subclassResponsibility
]

{ #category : #accessing }
GtPExpressionBinaryOperationNode >> right: anObject [ 
	right := anObject
]

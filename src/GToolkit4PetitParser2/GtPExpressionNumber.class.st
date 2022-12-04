Class {
	#name : #GtPExpressionNumber,
	#superclass : #GtPExpressionValueNode,
	#category : #GToolkit4PetitParser2
}

{ #category : #accessing }
GtPExpressionNumber >> children [ 
	^ { }
]

{ #category : #accessing }
GtPExpressionNumber >> gtDisplayOn: stream [
	stream nextPutAll: value asString
]

{ #category : #accessing }
GtPExpressionNumber >> gtLocalDisplayOn: stream [
	stream nextPutAll: value asString
]

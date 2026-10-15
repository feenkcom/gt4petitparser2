Class {
	#name : #GtPharoRenamePP2ProductionCoderController,
	#superclass : #GtPharoRenameVariableCoderController,
	#category : #'GToolkit4PetitParser2-Refactoring - Method New'
}

{ #category : #testing }
GtPharoRenamePP2ProductionCoderController class >> isApplicableIn: aSourceCoderViewModel node: aNode [
	| aName aBehavior |
	aBehavior := aSourceCoderViewModel behavior.
	(aBehavior isNotNil and: [ aBehavior includesBehavior: PP2CompositeNode ])
		ifFalse: [ ^ false ].
	aName := self productionNameOf: aNode.
	aName ifNil: [ ^ false ].
	(aBehavior allInstVarNames includes: aName) ifFalse: [ ^ false ].
	^ self isProductionNode: aNode named: aName
]

{ #category : #testing }
GtPharoRenamePP2ProductionCoderController class >> isProductionNode: aNode named: aString [
	"A production is referenced either by an instance variable or by a unary message sent to self or super."

	aNode isVariable ifTrue: [ ^ aNode source = aString ].
	^ aNode isMessage
		and: [ aNode isUnary
				and: [ aNode selector asString = aString and: [ self isSelfOrSuperSend: aNode parent ] ] ]
]

{ #category : #testing }
GtPharoRenamePP2ProductionCoderController class >> isSelfOrSuperSend: aNode [
	^ aNode isMessageSend
		and: [ aNode receiver isVariable
				and: [ #('self' 'super') includes: aNode receiver source ] ]
]

{ #category : #testing }
GtPharoRenamePP2ProductionCoderController class >> productionNameOf: aNode [
	"Return the name of a production that the node references or nil."

	aNode isVariable ifTrue: [ ^ aNode source ].
	(aNode isMessage and: [ aNode isUnary ]) ifTrue: [ ^ aNode selector asString ].
	^ nil
]

{ #category : #'instance creation' }
GtPharoRenamePP2ProductionCoderController class >> renameIn: aSourceCoderViewModel node: aNode [
	"Return a not installed controller that renames the PetitParser2 production referenced by the given node, or nil if the node does not reference a production of a ${class:PP2CompositeNode}$ subclass."

	<gtPharoRenameController>
	(self isApplicableIn: aSourceCoderViewModel node: aNode) ifFalse: [ ^ nil ].
	^ self new
		sourceCoderViewModel: aSourceCoderViewModel;
		originalNode: aNode;
		yourself
]

{ #category : #hooks }
GtPharoRenamePP2ProductionCoderController >> createRefactoringsStencil [
	^ GtPharoRenamePP2ProductionRefactoringsStencil new
]

{ #category : #hooks }
GtPharoRenamePP2ProductionCoderController >> forbiddenNames [
	^ sourceCoderViewModel behavior allInstVarNames
]

{ #category : #private }
GtPharoRenamePP2ProductionCoderController >> intervalOf: aNode [
	"Source interval of the name of the production, i.e., the variable name or the selector."

	aNode isVariable ifTrue: [ ^ aNode name sourceInterval ].
	^ aNode selectorParts first sourceInterval
]

{ #category : #hooks }
GtPharoRenamePP2ProductionCoderController >> originalName [
	^ self class productionNameOf: originalNode
]

{ #category : #hooks }
GtPharoRenamePP2ProductionCoderController >> otherRenameIntervals [
	| someIntervals |
	someIntervals := OrderedCollection new.
	originalNode topParent
		allNodesDo: [ :each | 
			(each ~~ originalNode and: [ self class isProductionNode: each named: self originalName ])
				ifTrue: [ someIntervals add: (self intervalOf: each) ] ].
	^ someIntervals
]

{ #category : #hooks }
GtPharoRenamePP2ProductionCoderController >> primaryRenameInterval [
	^ self intervalOf: originalNode
]

{ #category : #hooks }
GtPharoRenamePP2ProductionCoderController >> refactoringName [
	^ 'Rename production'
]

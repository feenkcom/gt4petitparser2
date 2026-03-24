Class {
	#name : #GtConnectorPetitParser2Styler,
	#superclass : #BrRBTextStyler,
	#instVars : [
		'action',
		'previousLinks'
	],
	#category : #GToolkit4PetitParser2
}

{ #category : #accessing }
GtConnectorPetitParser2Styler >> action [
	^ action
]

{ #category : #accessing }
GtConnectorPetitParser2Styler >> action: anObject [
	action := anObject
]

{ #category : #moldability }
GtConnectorPetitParser2Styler >> extraStyle: aText ast: ast [
	| selfSendsExamples |
	
	selfSendsExamples := self findCachedProductionReferencesIn: ast.
	
	selfSendsExamples do: [ :aVariableNode |
		| buttonAttribute targetProductionMethod aLink |
		
		targetProductionMethod := ast methodNode methodClass lookupSelector: aVariableNode name.
		
		aLink := GtConnectorLink
			source: ast method
			target: targetProductionMethod.

		buttonAttribute := GtConnectorTextButtonAttribute link: aLink.
		buttonAttribute actionBlock: [ :anEvent | action valueWithEnoughArguments: { targetProductionMethod . aVariableNode . anEvent currentTarget } ].
		aText 
			attributes: { buttonAttribute }
			from: aVariableNode stop - 1
			to: aVariableNode stop ].
	
]

{ #category : #moldability }
GtConnectorPetitParser2Styler >> findCachedProductionReferencesIn: anAST [
	^ anAST allChildren asSet asArray select: [ :each | 
		each isVariable and: [ 
			(anAST methodNode methodClass canPerform: each name) ] ]
]

{ #category : #initialization }
GtConnectorPetitParser2Styler >> initialize [
	super initialize.

	previousLinks := OrderedCollection new
]

{ #category : #accessing }
GtConnectorPetitParser2Styler >> links [
	^ self previousLinks
]

{ #category : #accessing }
GtConnectorPetitParser2Styler >> previousLinks [
	^ previousLinks
]

{ #category : #accessing }
GtConnectorPetitParser2Styler >> previousLinks: anObject [
	previousLinks := anObject
]

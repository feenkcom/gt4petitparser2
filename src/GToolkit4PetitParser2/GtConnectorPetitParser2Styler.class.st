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
	
	selfSendsExamples := self findExampleSendsIn: ast.
	
	selfSendsExamples do: [ :each |
		| buttonAttribute targetExampleMethod aLink |
		
		targetExampleMethod := ast methodNode methodClass lookupSelector: each selector.
		
		aLink := GtConnectorLink
			source: ast method
			target: targetExampleMethod.

		buttonAttribute := GtConnectorTextButtonAttribute link: aLink.
		buttonAttribute actionBlock: [ :anEvent | action valueWithEnoughArguments: { targetExampleMethod . each . anEvent currentTarget } ].
		aText 
			attributes: { buttonAttribute }
			from: each stop - 1
			to: each stop ].
	
]

{ #category : #moldability }
GtConnectorPetitParser2Styler >> findExampleSendsIn: anAST [
	^ anAST allChildren asSet asArray select: [ :each | 
		each isMessage and: [ 
			each isSelfSend and: [ 
				each isUnary and: [
					(anAST methodNode methodClass canPerform: each selector) and: [ 
						(anAST methodNode methodClass lookupSelector: each selector) isGTExampleMethod ] ] ] ] ]
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

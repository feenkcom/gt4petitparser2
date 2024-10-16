Class {
	#name : #BaselineOfGToolkit4PetitParser2,
	#superclass : #BaselineOf,
	#category : #BaselineOfGToolkit4PetitParser2
}

{ #category : #baseline }
BaselineOfGToolkit4PetitParser2 >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ spec
				baseline: 'PetitParser2Core'
				with: [ spec
						repository: 'github://feenkcom/petitparser2:main' ].	"spec
				package: 'GToolkit4PetitParser2-Indent'
				with: [ spec requires: #('PetitParser2Core') ]."
			spec package: 'GToolkit4PetitParser2'	
			"with: [ spec requires: #('GToolkit4PetitParser2-Indent') ]"	
			"spec
				package: 'GToolkit4PetitParser2-YAML'
				with: [ spec requires: #('GToolkit4PetitParser2') ] " ]
]

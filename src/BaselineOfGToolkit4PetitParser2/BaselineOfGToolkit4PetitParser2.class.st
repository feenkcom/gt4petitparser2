Class {
	#name : #BaselineOfGToolkit4PetitParser2,
	#superclass : #BaselineOf,
	#category : #BaselineOfGToolkit4PetitParser2
}

{ #category : #baseline }
BaselineOfGToolkit4PetitParser2 >> baselineOf: spec [
	<baseline>
	spec
		for: #common
		do: [
			spec baseline: 'PetitParser2Core' with: [ spec repository: 'github://kursjan/petitparser2' ].
			spec package: 'GToolkit4PetitParser2' with: [ spec requires: #(PetitParser2Core) ] ]
]

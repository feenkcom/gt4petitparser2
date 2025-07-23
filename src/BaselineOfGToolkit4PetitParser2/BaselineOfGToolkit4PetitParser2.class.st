Class {
	#name : #BaselineOfGToolkit4PetitParser2,
	#superclass : #BaselineOf,
	#category : #BaselineOfGToolkit4PetitParser2
}

{ #category : #baseline }
BaselineOfGToolkit4PetitParser2 >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec
			baseline: 'PetitParser2Core' with: [
				spec repository: 'github://feenkcom/petitparser2:2c35cb112d343e8b33e1fa0c6c822cee1940e110' ].

		spec package: 'GToolkit4PetitParser2'.
	]
]

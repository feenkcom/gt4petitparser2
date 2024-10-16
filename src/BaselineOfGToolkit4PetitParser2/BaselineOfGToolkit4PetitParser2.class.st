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
				spec repository: 'github://feenkcom/petitparser2:8b8114fedc5f53040601d5c2ff9ae06df26dd1b2' ].

		spec package: 'GToolkit4PetitParser2'.
	]
]

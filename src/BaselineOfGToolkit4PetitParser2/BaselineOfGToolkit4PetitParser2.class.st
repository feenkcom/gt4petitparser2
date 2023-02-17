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
				spec repository: 'github://kursjan/petitparser2:975fa5b62fbb0c87f89c156b97e9682506cc1e99' ].

		spec package: 'GToolkit4PetitParser2'.
	]
]

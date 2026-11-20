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
				spec repository: 'github://feenkcom/petitparser2:6db23d03ea9e61e2c4f276df73d4859d0ab199b9' ].

		spec package: 'GToolkit4PetitParser2'.
		spec package: 'GToolkit4PetitParser2-RustEditor' with: [
			spec requires: #(#GToolkit4PetitParser2) ].
	]
]

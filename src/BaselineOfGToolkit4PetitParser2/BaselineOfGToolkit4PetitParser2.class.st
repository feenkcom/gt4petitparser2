Class {
	#name : #BaselineOfGToolkit4PetitParser2,
	#superclass : #BaselineOf,
	#category : #BaselineOfGToolkit4PetitParser2
}

{ #category : #baseline }
BaselineOfGToolkit4PetitParser2 >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec baseline: 'PetitParser2Core' with: [
				spec repository: 'github://kursjan/petitparser2:731216a76e0ab7957fc45fa1099ced7f2627e3ab' ].
		spec package: 'GToolkit4PetitParser2' with: [
				spec requires: #(#PetitParser2Core ). ]. ].

]

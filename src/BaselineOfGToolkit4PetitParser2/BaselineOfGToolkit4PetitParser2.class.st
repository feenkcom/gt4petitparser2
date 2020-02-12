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
				spec repository: 'github://kursjan/petitparser2:4c10fb086db477d2067bf1d22f59d647cfe5b344' ].
		spec package: 'GToolkit4PetitParser2' with: [
				spec requires: #(#PetitParser2Core ). ]. ].

]

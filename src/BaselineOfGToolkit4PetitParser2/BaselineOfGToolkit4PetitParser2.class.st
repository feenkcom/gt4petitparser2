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
				spec repository: 'github://kursjan/petitparser2:f1ce7483372941baf888e7dc77cbeffd1c911c06' ].
		spec package: 'GToolkit4PetitParser2' with: [
				spec requires: #('PetitParser2Core' ). ]. ].

]

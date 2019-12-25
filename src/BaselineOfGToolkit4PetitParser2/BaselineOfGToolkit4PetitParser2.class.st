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
				spec repository: 'github://kursjan/petitparser2:8c7438ce8a15ae2dd66f7b2ccc710801de5cacc5' ].
		spec package: 'GToolkit4PetitParser2' with: [
				spec requires: #(#PetitParser2Core ). ]. ].

]

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
				spec repository: 'github://kursjan/petitparser2:9e90d58f71a430f5ed7f2893216990fc5b6a8a43' ].
		spec package: 'GToolkit4PetitParser2' with: [
				spec requires: #(#PetitParser2Core ). ]. ].

]

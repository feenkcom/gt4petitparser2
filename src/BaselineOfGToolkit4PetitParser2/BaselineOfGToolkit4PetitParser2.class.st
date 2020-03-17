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
				spec repository: 'github://kursjan/petitparser2:09f02944f98020302e35c7444d47fcecdcb2e621' ].
		spec package: 'GToolkit4PetitParser2' with: [
				spec requires: #(#PetitParser2Core ). ]. ].

]

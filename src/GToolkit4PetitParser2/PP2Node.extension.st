Extension { #name : #PP2Node }

{ #category : #'*GToolkit4PetitParser2' }
PP2Node >> gtNamedChildren [
	"Answer the named children of the receiver."

	^ Gt4PPNamedChildrenVisitor new visit: self
]

{ #category : #'*GToolkit4PetitParser2' }
PP2Node >> gtSamplerFor: aView [
	<gtView>
	^ aView textEditor
		title: 'Sampler';
		text: [ '' ];
		actionStencil: [ :tab | 
			BrButton new 
				look: BrGlamorousButtonExteriorRectangularLook + BrGlamorousButtonIconLook;
				icon: BrGlamorousIcons playinspect asElement;
				action: [ :aButton |
					| input context | 
					input := tab viewContentElement editor text asString.
					context := PP2RecordingContext new.
					(self 
						deoptimize;
						debug: input withContext: context) value.
				aButton phlow spawnObject: context ] ]
		
]

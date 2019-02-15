Extension { #name : #PP2Node }

{ #category : #'*GToolkit4PetitParser2' }
PP2Node >> gtChildrenFor: aView [
	<gtView>
	^ aView list
		title: 'Children';
		priority: 15;
		items: [ self children ]
]

{ #category : #'*GToolkit4PetitParser2' }
PP2Node >> gtDisplayOn: aStream [

	self name isNil
		ifFalse: [ self name gtDisplayOn: aStream ] 
		ifTrue: [ aStream nextPutAll: ((self class name gtRemovePrefix: 'PP2') gtRemoveSuffix: 'Node') ]
	
]

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
		priority: 10;
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

{ #category : #'*GToolkit4PetitParser2' }
PP2Node >> gtTreeFor: aView [
	<gtView>
	^ aView mondrian 
		title: 'Tree';
		priority: 20;
		painting: [:m | 
		m nodes 
			stencil: [ :each | 
				BrLabel new 
					look: BrGlamorousLabelLook; 
					text: each gtDisplayString asRopedText;
					when: BlClickEvent do: [:event | event target phlow spawnObject: each]
		];
			with: (self withDeepCollect: #children as: Set).
		m edges 
			stencil: [ 
				BlParabollaArcElement new
					zIndex: -1;
					curvatureFraction: 0.2;
					border: (BlBorder paint: (Color gray alpha: 0.5) width: 2);
						toHead:
							(BlArrowheadSimpleArrow new
								arrowLengthFraction: 5;
								arrowNoseAngle: 60;
								border:
									(BlBorder builder
										paint: (Color gray alpha: 0.5);
											width: 2;
											build)) ];
			fromRightCenter;
			toLeftCenter;
			connectToAll: #children.
		m layout custom: (GtGraphHorizontalDominanceTreeLayout new 
				horizontalGap: 50).
		]
]

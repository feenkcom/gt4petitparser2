Extension { #name : #PP2Node }

{ #category : #'*GToolkit4PetitParser2' }
PP2Node >> asElementChildrenIn: aParentElement havingVisited: anObject withExtraElements: anElementsCollection [
	"by default do nothing"
]

{ #category : #'*GToolkit4PetitParser2' }
PP2Node >> asElementContentIn: aParentElement havingVisited: aCollection withExtraElements: anElementsCollection [
	| childrenElement nameLabel |
	aParentElement layout: BlLinearLayout vertical.
	nameLabel := BrLabel new
		look: BrGlamorousLabelLook new;
		text: self gtNameOrTypeDisplayString asRopedText;
		margin: (BlInsets bottom: 10);
		when: BlClickEvent do: [ :event | aParentElement phlow spawnObject: self ].
	aParentElement addChild: nameLabel.
	childrenElement := BlElement new
		constraintsDo: [ :c | 
			c vertical fitContent.
			c horizontal fitContent ];
		layout: BlLinearLayout horizontal alignCenter.
	aParentElement addChild: childrenElement.
	self
		asElementChildrenIn: childrenElement
		havingVisited:
			(aCollection copy
				add: self;
				yourself)
		withExtraElements: anElementsCollection.
	"aParentElement
		addChild:
			(BrLabel new
				look: BrGlamorousLabelLook new;
				text: ' ' asRopedText)"
]

{ #category : #'*GToolkit4PetitParser2' }
PP2Node >> asElementIn: aParentElement havingVisited: aCollection withExtraElements: anElementsCollection [
	| anExpander |
"	(aCollection includes: self)
		ifTrue: [ ^ self ].
"	anExpander := BrExpander new.
	anExpander
		vFitContent;
		hFitContent.
	anExpander look: GtCoderExpanderLook new.
	anExpander
		header: [ BrLabel new
				look: BrGlamorousLabelLook new;
				text: self gtNameOrTypeDisplayString asRopedText ].
	anExpander
		content: [ | content |
			content := BlElement new
				constraintsDo: [ :c | 
					c vertical fitContent.
					c horizontal fitContent ].
			self
				asElementContentIn: content
				havingVisited: aCollection
				withExtraElements: OrderedCollection new.
			content].
	anExpander margin: (BlInsets top: 1 left: 1 bottom: 1 right: 1).
	anElementsCollection isEmpty
		ifTrue: [ aParentElement addChild: anExpander ]
		ifFalse: 	[ aParentElement addChild: (self wrap: anExpander withExtraElements: anElementsCollection) ]
]

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
PP2Node >> gtGraphFor: aView [
	<gtView>
	^ aView explicit
		title: 'Graph';
		actionButtonIcon:  BrGlamorousIcons zoomin asElement 
			action: [ :aButton :aTab | 
				aTab viewContentElement zoomIn];
		actionButtonIcon:  BrGlamorousIcons zoomout asElement 
			action: [ :aButton :aTab | 
				aTab viewContentElement zoomOut];
		actionButtonIcon:  BrGlamorousIcons zoomtofit asElement 
			action: [ :aButton :aTab | 
				aTab viewContentElement zoomToFit];
		actionButtonIcon:  BrGlamorousIcons actualsize asElement 
			action: [ :aButton :aTab | 
				aTab viewContentElement zoomToActualSize];
		stencil: [ | parentElement |
			parentElement := BlElement new
				constraintsDo: [ :c | 
					c vertical fitContent.
					c horizontal fitContent ];
				layout: BlLinearLayout new.
			self
				asElementIn: parentElement
				havingVisited: OrderedCollection new
				withExtraElements: OrderedCollection new.
			parentElement asPannableElement ]
]

{ #category : #'*GToolkit4PetitParser2' }
PP2Node >> gtNameOrTypeDisplayString [
	^ self hasName 
		ifTrue: [ self name ]
		ifFalse: [ (self class name gtRemovePrefix: 'PP2') gtRemoveSuffix: 'Node' ]
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

{ #category : #'*GToolkit4PetitParser2' }
PP2Node >> wrap: content withExtraElements: anElementCollection [
	| extraElement container |
	container := BlElement new
		constraintsDo: [ :c | 
			c vertical fitContent.
			c horizontal fitContent ];
		layout: BlLinearLayout vertical.
	extraElement := BlElement new
		constraintsDo: [ :c | 
			c vertical fitContent.
			c horizontal fitContent ];
		layout: (BlLinearLayout horizontal cellSpacing: 10);
		padding: (BlInsets left: -10).
	anElementCollection do: [ :each | 
		self flag: 'this is a hack'.
		each removeFromParent ].
	extraElement addChildren: anElementCollection reverse.
	container addChild: content.
	container addChild: extraElement.
	^ container
]

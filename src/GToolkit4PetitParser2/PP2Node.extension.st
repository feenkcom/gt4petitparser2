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
		aptitude: BrGlamorousLabelAptitude new;
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
]

{ #category : #'*GToolkit4PetitParser2' }
PP2Node >> asElementIn: aParentElement havingVisited: aCollection withExtraElements: anElementsCollection [
	| anExpander |
	"	(aCollection includes: self)
		ifTrue: [ ^ self ].
"
	anExpander := BrExpander new
			fitContent;
			aptitude: GtCoderExpanderAptitude new;
			margin: (BlInsets all: 1);
			header: [ BrLabel new
					aptitude: BrGlamorousLabelAptitude new;
					text: self gtNameOrTypeDisplayString ];
			content: [ | content |
				content := BlElement new
						constraintsDo: [ :c | 
							c vertical fitContent.
							c horizontal fitContent ].
				self
					asElementContentIn: content
					havingVisited: aCollection
					withExtraElements: OrderedCollection new.
				content ].
	anElementsCollection isEmpty
		ifTrue: [ aParentElement addChild: anExpander ]
		ifFalse: [ aParentElement
				addChild: (self wrap: anExpander withExtraElements: anElementsCollection) ]
]

{ #category : #'*GToolkit4PetitParser2' }
PP2Node >> displayName [
	^ self gtDisplayString
]

{ #category : #'*GToolkit4PetitParser2' }
PP2Node >> gtChildrenFor: aView [
	<gtView>
	^ aView columnedTree
		title: 'Children';
		priority: 15;
		items: [ self children ];
		children: [ :each | each children ];
		column: 'Parser' text: #gtDisplayString;
		column: 'Type'
			text: [ :each | each class name asRopedText foreground: Color gray ]
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
			action: [ :aButton :aTab | 	aTab viewContentElement zoomIn];
		actionButtonIcon:  BrGlamorousIcons zoomout asElement 
			action: [ :aButton :aTab | 	aTab viewContentElement zoomOut];
		actionButtonIcon:  BrGlamorousIcons zoomtofit asElement 
			action: [ :aButton :aTab | aTab viewContentElement zoomToFit];
		actionButtonIcon:  BrGlamorousIcons actualsize asElement 
			action: [ :aButton :aTab | aTab viewContentElement zoomToActualSize];
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
			parentElement asScalableElement maxScale: 1 ]
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
				aptitude: BrGlamorousButtonWithIconAptitude;
				icon: BrGlamorousVectorIcons playinspect;
				action: [ :aButton |
					| input context | 
					input := (tab viewContentElement childWithId: #editor) text asString.
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
		painting: [ :m | 
			m nodes
				stencil: [ :each | 
					BrLabel new
						aptitude: BrGlamorousLabelAptitude new + BrShadowAptitude new;
						text: each gtDisplayString asRopedText;
						background: Color white;
						margin: (BlInsets all: 10);
						padding: (BlInsets all: 5);
						when: BlClickEvent do: [ :event | event target phlow spawnObject: each ] ];
				with: (self withDeepCollect: #children as: Set).
			m edges
				stencil: [ BlParabollaArcElement new
						zIndex: -1;
						curvatureFraction: 0.2;
						border: (Color lightGray alpha: 0.5);
						toHead: (BlArrowheadSimpleArrow new
								arrowLengthFraction: 5;
								arrowNoseAngle: 60;
								border: (Color lightGray alpha: 0.5)) ];
				fromRightCenter;
				toLeftCenter;
				connectToAll: #children.
			m layout horizontalDominanceTree levelDistance: 30; nodeDistance: 5 ]
]

{ #category : #'*GToolkit4PetitParser2' }
PP2Node >> if: aBlock [
	^ PP2ConditionalNode on: self block: aBlock
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

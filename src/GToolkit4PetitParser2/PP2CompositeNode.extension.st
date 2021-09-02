Extension { #name : 'PP2CompositeNode' }

{ #category : '*GToolkit4PetitParser2' }
PP2CompositeNode >> buildBlankContainer: method [
	| container |
	container := BlElement new.
	container connector 
		model: method;
		beLayoutSource; 
		beLayoutTarget;
		beVisualTarget.

	container
		size: 300@100; 
		background: Color white;
		aptitude: BrShadowAptitude new;
		layout: BlLinearLayout new.
	^ container
]

{ #category : '*GToolkit4PetitParser2' }
PP2CompositeNode >> buildBottomResizerFor: blankContainer [
	^  BlElement new
			aptitude: BrGlamorousResizerBottomBarAptitude new;
			background: BrGlamorousColors editorBorderColor;
			constraintsDo: [ :c | c vertical exact: 5. c grid horizontal span: 2];
			addEventHandler: (BlResizerBottomListener new resizeTarget: blankContainer; minimumExtent: 0@75).

]

{ #category : '*GToolkit4PetitParser2' }
PP2CompositeNode >> buildCloseButton: gtconnector [. 
	^ GtInspectorRoundButtonStencil new asElement
		icon: (GtInspectorPlusIconStencil close asElement);
		constraintsDo: [ :c |
			c ignoreByLayout.
			c margin: (BlInsets top: -10 left: 0 bottom: 0 right: -10).
			c ignored horizontal alignRight.
			c ignored vertical alignTop ];
		action: [ :e | gtconnector removeChild: e parent ]
]

{ #category : '*GToolkit4PetitParser2' }
PP2CompositeNode >> buildEditor: aMethod for: gtconnector [
	| styler editorElement text |
				
	styler := GtConnectorPetitParser2Styler new.
	styler action: [ :anExampleMethod | gtconnector addEntity: anExampleMethod ].
	styler classOrMetaClass: aMethod methodClass.
				
	editorElement := BrEditor new aptitude: BrGlamorousCodeEditorAptitude new.
	editorElement
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent. ].
	editorElement styler: styler.
	text := aMethod sourceCode asRopedText.

	"because we connect editors with lines based on styler we must change text
	only after editor is added to the scene, otherwise events will be ignored"
	editorElement text: text.	
	^ editorElement
]

{ #category : '*GToolkit4PetitParser2' }
PP2CompositeNode >> buildRightResizerFor: blankContainer [
	^  BlElement new
			aptitude: BrGlamorousResizerRightBarAptitude new;
			background: BrGlamorousColors editorBorderColor;
			constraintsDo: [ :c | c margin: (BlInsets right: 0). c horizontal exact: 5.];
			addEventHandler: (BlResizerRightListener new resizeTarget: blankContainer; minimumExtent: 75@0).

]

{ #category : '*GToolkit4PetitParser2' }
PP2CompositeNode >> editorContainer [
	^ BlElement new
		constraintsDo: [ :c | 
			c vertical matchParent. 
			c horizontal matchParent ];
		layout: BlLinearLayout new
]

{ #category : '*GToolkit4PetitParser2' }
PP2CompositeNode >> gtConnectionsFor: aView [
	<gtView>
	^ aView explicit
		title: 'Connections';
		stencil: [	
			| gtconnector method |
			gtconnector := GtConnector new.
			method := self class>>#start.
			gtconnector stencil: [ :startMethod |
				| blankContainer editorContainer editorElement aBottomResizer aRightResizer aCloseButton |
				"The blankContainer is there as a placeholder for toggling between the source and the output of the example."
								
				blankContainer := self buildBlankContainer: startMethod.
				blankContainer clipChildren: false.
				aRightResizer := self buildRightResizerFor: blankContainer.
				aBottomResizer := self buildBottomResizerFor: blankContainer.
				
				editorContainer := self editorContainer.
				editorElement := self buildEditor: startMethod for: gtconnector.
				editorContainer addChild: editorElement.
				aCloseButton := self buildCloseButton: gtconnector. 
				
				blankContainer addChild: editorContainer.
				blankContainer addChild: aRightResizer.
				blankContainer addChild: aBottomResizer.
				blankContainer addChild: aCloseButton.
				
				blankContainer
			].
		
			gtconnector addEntity: method.
			gtconnector asPannableElement ]
]

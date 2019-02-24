Extension { #name : #PP2CompositeNode }

{ #category : #'*GToolkit4PetitParser2' }
PP2CompositeNode >> buildBlankContainer: method [
	|container|
	container := VocalBlElement new.
	container 
		connector 
			beLayoutSource; 
			beLayoutTarget;
			beVisualTarget;
			model: method.

	container 
		size: 300@100; 
		"border: (BlBorder paint: (BrGlamorousColors editorBorderColor) width: 1);"
		background: Color white;
		look: BrShadowLook new;
		layout: BlLinearLayout new.
	^ container
]

{ #category : #'*GToolkit4PetitParser2' }
PP2CompositeNode >> buildBottomResizerFor: blankContainer [
	^  BlElement new
			look: BrGlamorousResizerBottomBarLook new;
			background: BrGlamorousColors editorBorderColor;
			constraintsDo: [ :c | c vertical exact: 5. c grid horizontal span: 2];
			addEventHandler: (BlResizerBottomListener new resizeTarget: blankContainer; minimumExtent: 0@75).

]

{ #category : #'*GToolkit4PetitParser2' }
PP2CompositeNode >> buildCloseButton: gtconnector. [ 
	^ GtInspectorRoundButtonStencil new asElement
		icon: (GtInspectorPlusIconStencil close asElement);
		constraintsDo: [ :c |
			c ignoreByLayout.
			c margin: (BlInsets top: -10 left: 0 bottom: 0 right: -10).
			c ignored horizontal alignRight.
			c ignored vertical alignTop ];
		action: [ :e | gtconnector removeChild: e parent ]
]

{ #category : #'*GToolkit4PetitParser2' }
PP2CompositeNode >> buildEditor: aMethod for: gtconnector [
	| vocalVisualTarget styler editorElement text |
	vocalVisualTarget:= VocalBlElement new.
	vocalVisualTarget
		constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
				
	styler := GtConnectorPetitParser2Styler new.
	styler action: [ :anExampleMethod | gtconnector addEntity: anExampleMethod ].
	styler classOrMetaClass: aMethod methodClass.
				
	editorElement := BrEditor new look: BrGlamorousCodeEditorLook new.
	editorElement
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent. ].
	editorElement styler: styler.
	text := aMethod sourceCode asRopedText.

	"because we connect editors with lines based on styler we must change text
	only after editor is added to the scene, otherwise events will be ignored"
	editorElement text: text.	
	vocalVisualTarget addChild: editorElement.

	^ vocalVisualTarget.
					
]

{ #category : #'*GToolkit4PetitParser2' }
PP2CompositeNode >> buildRightResizerFor: blankContainer [
	^  BlElement new
			look: BrGlamorousResizerRightBarLook new;
			background: BrGlamorousColors editorBorderColor;
			constraintsDo: [ :c | c margin: (BlInsets right: 0). c horizontal exact: 5.];
			addEventHandler: (BlResizerRightListener new resizeTarget: blankContainer; minimumExtent: 75@0).

]

{ #category : #'*GToolkit4PetitParser2' }
PP2CompositeNode >> gtConnectionsFor: aView [
	^ aView explicit
		title: 'Connections';
		stencil: [	
			| gtconnector method |
			gtconnector := GtConnector new.
			method := self class>>#start.
			gtconnector stencil: [ :startMethod |
				| blankContainer vocalEditorContainer vocalVisualTarget aBottomResizer aRightResizer aCloseButton |
				"The blankContainer is there as a placeholder for toggling between the source and the output of the example."
								
				blankContainer := self buildBlankContainer: startMethod.
				blankContainer clipChildren: false.
				vocalEditorContainer := self vocalEditorContainer.
				vocalVisualTarget := self buildEditor: startMethod for: gtconnector.
				vocalEditorContainer addChild: vocalVisualTarget.
				aRightResizer := self buildRightResizerFor: blankContainer.
				aBottomResizer := self buildBottomResizerFor: blankContainer.
				aCloseButton := self buildCloseButton: gtconnector. 
				
				blankContainer addChild: vocalEditorContainer.
				blankContainer addChild: aRightResizer.
				blankContainer addChild: aBottomResizer.
				blankContainer addChild: aCloseButton.
				
				blankContainer
			].
		
			gtconnector addEntity: method.
			gtconnector asPannableElement ]
]

{ #category : #'*GToolkit4PetitParser2' }
PP2CompositeNode >> vocalEditorContainer [
	|vocalEditorContainer|
	vocalEditorContainer := VocalBlElement new.
	vocalEditorContainer constraintsDo: [ :c | c vertical matchParent. c horizontal matchParent. ].
	vocalEditorContainer layout: BlLinearLayout new.
	^ vocalEditorContainer
]

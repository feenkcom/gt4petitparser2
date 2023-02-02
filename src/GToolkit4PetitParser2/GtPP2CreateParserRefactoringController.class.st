Class {
	#name : #GtPP2CreateParserRefactoringController,
	#superclass : #GtPharoSourceCoderRefactoringController,
	#instVars : [
		'className',
		'renameAction',
		'category',
		'source',
		'classAttribute',
		'package',
		'tag'
	],
	#category : #'GToolkit4PetitParser2-Refactoring '
}

{ #category : #executing }
GtPP2CreateParserRefactoringController >> addClassPackageAttribute [
	| expander |
	classAttribute
		ifNotNil: [ sourceCoderViewModel removeCoderTextAttributes: classAttribute ].
	expander := GtCreateClassExpanderAttribute new
			action: self;
			setPackage: package andTag: tag;
			hideSuperclass;
			yourself.
	classAttribute := sourceCoderViewModel
			addTextAttribute: expander
			from: className size
			to: className size
]

{ #category : #accessing }
GtPP2CreateParserRefactoringController >> cancelRefactoring [
	renameAction ifNotNil: [ renameAction uninstall ].
	super cancelRefactoring
]

{ #category : #accessing }
GtPP2CreateParserRefactoringController >> category [
	^ (package trim , (tag isEmptyOrNil ifTrue: [ '' ] ifFalse: [ '-' , tag trim ]))
		asSymbol
]

{ #category : #accessing }
GtPP2CreateParserRefactoringController >> cleanUp [
	super cleanUp.
	classAttribute
		ifNotNil: [ sourceCoderViewModel removeCoderTextAttributes: classAttribute ]
]

{ #category : #accessing }
GtPP2CreateParserRefactoringController >> finishRefactoring: refactoring [
	super finishRefactoring: refactoring.
	renameAction
		ifNotNil: [ renameAction
				updateSource;
				uninstall ].
]

{ #category : #initialization }
GtPP2CreateParserRefactoringController >> initialize [
	super initialize.
	className := #NewParser.
	package := RPackage defaultPackageName.
	tag := ''
]

{ #category : #executing }
GtPP2CreateParserRefactoringController >> installRenamer [
	self addRefactoringPreview.

	sourceCoderViewModel moveCursorTo: 0.

	renameAction := GtPP2RenameVariableAction
			locations: {1 to: className size}
			textualCoderViewModel: sourceCoderViewModel.
	renameAction selectAll: true.
	renameAction forVariableOrUnaryMessage.
	renameAction
		when: GtRenameActionAnnouncement
		do: [ :ann | 
			ann eventType = #textUpdated
				ifTrue: [ renameAction isValid ifTrue: [ self updateClassName: renameAction newName ] ].
			ann eventType = #cancel ifTrue: [ self cancelRefactoring ] ].
	renameAction install.
	
	self addClassPackageAttribute
]

{ #category : #accessing }
GtPP2CreateParserRefactoringController >> previewPosition [
	^ self sourceText characters size
]

{ #category : #accessing }
GtPP2CreateParserRefactoringController >> refactoring [
	^ GtPP2CreateParserRefactoring
		model: self createModel
		className: className
		category: self category
		source: source
]

{ #category : #accessing }
GtPP2CreateParserRefactoringController >> refactoringName [
	^ 'Create PetitParser'
]

{ #category : #executing }
GtPP2CreateParserRefactoringController >> safelyExecute [
	| refactoring |
	refactoring := self refactoring.
	refactoring primitiveExecute.
	self sourceCoderViewModel selectNone.
	self updateSource.
	self installRenamer
]

{ #category : #accessing }
GtPP2CreateParserRefactoringController >> sourceCoderViewModel: aSourceCoderViewModel [
	super sourceCoderViewModel: aSourceCoderViewModel.
	source := self sourceText characters asString
]

{ #category : #executing }
GtPP2CreateParserRefactoringController >> updateClassName: aString [
	className := aString asSymbol.
	self addRefactoringPreview
]

{ #category : #accessing }
GtPP2CreateParserRefactoringController >> updatePackage: aSymbol [
	package := aSymbol.
	self addRefactoringPreview
]

{ #category : #accessing }
GtPP2CreateParserRefactoringController >> updatePackageTag: aSymbol [
	tag := aSymbol.
	self addRefactoringPreview
]

{ #category : #executing }
GtPP2CreateParserRefactoringController >> updateSource [
	| newText |
	newText := (className , ' new') asRopedText glamorousCodeFontAndSize.
	self setText: newText
]

{ #category : #executing }
GtPP2CreateParserRefactoringController >> updateSuperclass: aString [
]

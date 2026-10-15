"
I am a test stub for the element that {{gtMethod:GtPharoSourceCoder>>#renameNewNode:in:documentId:for:}} receives as its last argument. That method sends `#editorElement` to the element to find the text editor, and {{gtClass:GtTextEditorElement}} does not understand it. I wrap a text editor so that examples can call {{gtMethod:GtPharoSourceCoder>>#renameNewNode:in:documentId:for:}} without creating a coder element attached to a space. See {{gtClass:GtPharoSourceCoderRenameNewNodeExamples}}.

The real argument is not verified yet: it is most likely a coder-level element such as {{gtClass:GtTextualCoderElement}}, not the text editor itself.
"
Class {
	#name : #GtPharoRenameEditorElementStub,
	#superclass : #Object,
	#instVars : [
		'editorElement'
	],
	#category : #'GToolkit4PetitParser2-Refactoring - Method New'
}

{ #category : #accessing }
GtPharoRenameEditorElementStub >> editorElement [
	"The coder element that is passed to {{gtMethod:GtPharoSourceCoder>>#renameNewNode:in:documentId:for:}} understands `#editorElement`."

	^ editorElement
]

{ #category : #accessing }
GtPharoRenameEditorElementStub >> editorElement: anObject [
	editorElement := anObject
]

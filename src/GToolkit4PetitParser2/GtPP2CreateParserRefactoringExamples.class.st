Class {
	#name : #GtPP2CreateParserRefactoringExamples,
	#superclass : #Object,
	#category : #'GToolkit4PetitParser2-Examples'
}

{ #category : #'as yet unclassified' }
GtPP2CreateParserRefactoringExamples >> failInvalidClassName [
	<gtExample>
	| refactoring |
	refactoring := GtPP2CreateParserRefactoring
			model: GtRBNamespace new
			className: #'New ParserClass'
			category: self class category
			source: 'number := #digit asPParser plus.
expr := (number , ''+'' asPParser , number) / number'.
	[ refactoring primitiveExecute ]
		on: RBRefactoringError
		do: [ :ex | ^ ex copy freeze ].
	self error: 'Refactoring did not throw an error'
]

{ #category : #'as yet unclassified' }
GtPP2CreateParserRefactoringExamples >> failNotAParser [
	<gtExample>
	| refactoring |
	refactoring := GtPP2CreateParserRefactoring
			model: GtRBNamespace new
			className: #NewParserClass
			category: self class category
			source: 'parser parse: ''3 + 4'''.
	[ refactoring primitiveExecute ]
		on: RBRefactoringError
		do: [ :ex | ^ ex copy freeze ].
	self error: 'Refactoring did not throw an error'
]

{ #category : #'as yet unclassified' }
GtPP2CreateParserRefactoringExamples >> simpleParser [
	<gtExample>
	| refactoring model cls |
	model := GtRBNamespace new.
	refactoring := GtPP2CreateParserRefactoring
			model: model
			className: #NewParserClass
			category: self class category
			source: 'number := #digit asPParser plus.
expr := (number , ''+'' asPParser , number) / number'.
	refactoring primitiveExecute.
	cls := model classNamed: #NewParserClass.
	self
		assert: (cls sourceCodeFor: #number)
		equals: 'number
	^ #digit asPParser plus'.
	self
		assert: (cls sourceCodeFor: #expr)
		equals: 'expr
	^ (number , ''+'' asPParser , number) / number'.
	^ model
]

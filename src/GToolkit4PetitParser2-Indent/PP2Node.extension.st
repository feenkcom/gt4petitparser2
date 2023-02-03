Extension { #name : #PP2Node }

{ #category : #'*GToolkit4PetitParser2-Indent' }
PP2Node >> olToken [
	^ PP2TokenOLParser on: self
]

{ #category : #'*GToolkit4PetitParser2-Indent' }
PP2Node >> pop [
	"pop myself from the indent stack, fail if I am not on top of the stack"
	^ [:context | 
			| retval |
			retval := context indentStack pop.
			(retval = self) ifFalse: [ 
				PP2Failure message: self asString, 'is not on top of the stack, cannot pop!'
			] ifTrue: [  
				retval
			] 
	] asPParser
]

{ #category : #'*GToolkit4PetitParser2-Indent' }
PP2Node >> push [
	"evaluate myself and if I dont' fail, push the result on the indent stack"
	^ PP2PushParser on: self
]

{ #category : #'*GToolkit4PetitParser2-Indent' }
PP2Node >> pushAsParser [
	"evaluate myself and if I dont' fail, push the parser made from result on the indent stack"
	^ PP2PushAsParserParser on: self
]

{ #category : #'*GToolkit4PetitParser2-Indent' }
PP2Node >> trimAlign [
	"
		trim blanks and check if I am aligned
	"
	^ (#align asPParser, #blank asPParser not, self ==> #last)

	
]

{ #category : #'*GToolkit4PetitParser2-Indent' }
PP2Node >> trimOffside [
	"
		trim blanks and check if I am in offside position
	"
	^ 
	(#offside asPParser, self ==> #last)" /
	(#startOfLine asParser not, #blank asParser star, self ==> #last)"

	
]

{ #category : #'*GToolkit4PetitParser2-Indent' }
PP2Node >> trimOnside [
	"
		trim blanks and check if I am in onside position
	"
	^
	(#onside asPParser, self ==> #last)" /
	(#startOfLine asParser not, #blank asParser star, self ==> #last)"

	
]

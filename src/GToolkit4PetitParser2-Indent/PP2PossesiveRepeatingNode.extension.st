Extension { #name : #PP2PossesiveRepeatingNode }

{ #category : #'*GToolkit4PetitParser2-Indent' }
PP2PossesiveRepeatingNode >> aligned [
	"
		self indentationLevel push,
			parser aligned,
			(#space star, parser aligned) star
		self indentationLevel pop	
	"
	
	^ (self indentationLevel push, 
		((((min == 0) ifTrue: [ parser aligned optional ] ifFalse: [ parser aligned ]),
		 ((#space asPParser star, parser aligned) and,  
		  (#space asPParser star, parser aligned) ==> [:nodes | nodes second second ]) star) 
		 ==> [:nodes | 
				nodes first ifNil: [ #() ] ifNotNil: [ 
				((OrderedCollection with: nodes first) addAll: nodes second; yourself) asArray ] ]),
	   self indentationLevel pop) ==> #second name: 'aligned'; yourself

]

Class {
	#name : #PP2YAMLGrammar,
	#superclass : #PP2CompositeNode,
	#instVars : [
		's_indent',
		's_block_line_prefix',
		's_flow_line_prefix',
		's_line_prefix',
		'b_as_line_feed',
		's_space',
		's_tab',
		'e_scalar',
		'nb_double_char',
		'nb_json',
		's_white',
		'nb_double_text',
		'b_break',
		'nb_double_multi_line',
		'nb_double_one_line',
		'c_double_quoted',
		'nb_char',
		'b_char',
		'c_printable',
		'ns_char',
		'c_flow_indicator',
		'ns_plain_safe',
		'ns_plain_first',
		'nb_ns_plain_in_line',
		'ns_plain_char',
		'ns_plain_multi_line',
		'ns_plain_one_line',
		'ns_plain_safe_out',
		'ns_plain_safe_in',
		'c_indicator',
		's_flow_folded',
		's_separate_in_line',
		'b_l_folded',
		'b_l_trimmed',
		'b_as_space',
		'b_non_content',
		'l_empty',
		's_indent_smaller',
		's_ns_plain_next_line',
		's_separate',
		'ns_s_flow_seq_entries',
		'ns_flow_seq_entry',
		'ns_flow_pair',
		'ns_flow_node',
		'ns_flow_content',
		'ns_flow_yaml_content',
		'c_flow_json_content',
		'ns_plain',
		'c_flow_sequence',
		'c_flow_mapping',
		'ns_s_flow_map_entries',
		'ns_flow_map_entry',
		'ns_flow_map_explicit_entry',
		'ns_flow_map_implicit_entry',
		'e_node',
		'ns_flow_map_yaml_key_entry',
		'c_ns_flow_map_empty_key_entry',
		'c_ns_flow_map_json_key_entry',
		'ns_flow_yaml_node',
		'c_ns_flow_map_separate_value',
		's_separate_lines',
		's_l_comments',
		'ns_flow_pair_entry',
		'ns_flow_pair_yaml_key_entry',
		'c_ns_flow_pair_json_key_entry',
		'ns_s_implicit_yaml_key',
		'c_flow_json_node',
		'c_ns_flow_map_adjacent_value',
		'c_s_implicit_json_key',
		'c_ns_properties',
		'ns_double_char',
		's_double_break',
		'nb_ns_double_in_line',
		's_double_next_line',
		's_double_escaped',
		's_b_comment',
		'l_comment',
		'b_comment',
		'c_nb_comment_text',
		'c_indentation_indicator',
		'c_chomping_indicator',
		'l_strip_empty',
		'l_keep_empty',
		'l_trail_comments',
		'c_b_block_header',
		'l_literal_content',
		'l_nb_literal_text',
		'b_nb_literal_next',
		'b_chomped_last',
		'l_chomped_empty',
		'c_l_literal',
		'l_folded_content',
		's_nb_folded_text',
		's_nb_spaced_text',
		'b_l_spaced',
		'l_nb_spaced_lines',
		'l_nb_folded_lines',
		'l_nb_same_lines',
		'l_nb_diff_lines',
		'c_l_folded',
		'c_l_block_seq_entry',
		's_l_block_indented',
		'ns_l_compact_sequence',
		'ns_l_compact_mapping',
		's_l_block_node',
		'ns_l_block_map_entry',
		'c_l_block_map_explicit_entry',
		'ns_l_block_map_implicit_entry',
		'c_l_block_map_explicit_key',
		'l_block_map_explicit_value',
		'ns_s_block_map_implicit_key',
		'c_l_block_map_implicit_value',
		's_l_block_in_block',
		's_l_flow_in_block',
		's_l_block_scalar',
		's_l_block_collection',
		'l_block_sequence',
		'l_block_mapping',
		'l_bare_document',
		'aligns'
	],
	#category : #'GToolkit4PetitParser2-YAML'
}

{ #category : #spec }
PP2YAMLGrammar >> aligns [
	^ [ :context | 
		context indentStack isEmpty ifFalse: [ 
			context indentStack top parseOn: context ] 
	] asPParser
]

{ #category : #spec }
PP2YAMLGrammar >> autoDetect: context [
	^ self autoDetect: context blockHeader: false
]

{ #category : #spec }
PP2YAMLGrammar >> autoDetect: context blockHeader: blockHeader [
	| retval position |
	position := context position.
	
	retval := nil.
	blockHeader ifTrue: [ 
		(context peek = $- or: [ context peek = $+ ]) ifTrue: [context next].
	].

	[context atEnd not and: [retval = nil]] whileTrue: [ 
		context peek isSeparator 
			ifTrue: [ context next ]
			ifFalse: [ retval := (context stream column - context YAMLN) ].		
	].

	retval ifNil: [  retval := (context stream column - context YAMLN) ].
	
	context position: position.
	
	"
		auto detect always returns m > 0, so if 0 is detected, 
		return something strange :)
	"
	(retval = 0) ifTrue: [ retval := -1 ].
	"Transcript crShow: 'autodetected: ', retval asString."
	^ retval
]

{ #category : #spec }
PP2YAMLGrammar >> b_as_line_feed [
	^ b_break ==> [ :e | String cr ]
]

{ #category : #spec }
PP2YAMLGrammar >> b_as_space [ 	
	^ b_break ==> [ :e | String space ]
]

{ #category : #spec }
PP2YAMLGrammar >> b_break [
	^ #newline asPParser
]

{ #category : #spec }
PP2YAMLGrammar >> b_char [
	^ Character cr asPParser / Character lf asPParser
]

{ #category : #spec }
PP2YAMLGrammar >> b_chomped_last [
	^ (b_non_content / #endOfLine asPParser
		if: [ :context | context YAMLChomp = #strip ])
		/ (b_as_line_feed / #endOfLine asPParser
				if: [ :context | context YAMLChomp = #clip ])
		/ (b_as_line_feed / #endOfLine asPParser
				if: [ :context | context YAMLChomp = #keep ])
]

{ #category : #spec }
PP2YAMLGrammar >> b_comment [
	^ b_non_content / #endOfLine asPParser
]

{ #category : #spec }
PP2YAMLGrammar >> b_l_folded [
	^ b_l_trimmed / b_as_space
]

{ #category : #spec }
PP2YAMLGrammar >> b_l_spaced [ 
	^ b_as_line_feed, l_empty YAMLBlockIn star 
	
	map: [ :lf :empty |
		| retval |
		
		retval := lf asString.
		empty do: [ :line | retval := retval, line asString ].
		retval
	]
]

{ #category : #spec }
PP2YAMLGrammar >> b_l_trimmed [
	^ (b_non_content, l_empty plus) 
	
	
	map: [ :break :lines | 
		lines inject: '' into: [ :res :line | res, line asString ] 
	]
]

{ #category : #spec }
PP2YAMLGrammar >> b_nb_literal_next [ 
	^ b_as_line_feed, l_nb_literal_text
	map: [ :lf :text |
		lf asString, text
	]
]

{ #category : #spec }
PP2YAMLGrammar >> b_non_content [
	^ b_break ==> [ :e | '' ].
]

{ #category : #spec }
PP2YAMLGrammar >> c_b_block_header [ 	
	^ ((c_indentation_indicator, c_chomping_indicator)	/ 
		(c_chomping_indicator, c_indentation_indicator)), 
	s_b_comment
]

{ #category : #spec }
PP2YAMLGrammar >> c_chomping_indicator [
	^ 	($- asPParser, [ :context | context YAMLChomp: #strip. #strip ] asPParser) / 
		($+ asPParser, [ :context | context YAMLChomp: #keep. #keep ] asPParser) / 
		(nil asPParser, [ :context | context YAMLChomp: #clip. #clip ] asPParser)
]

{ #category : #spec }
PP2YAMLGrammar >> c_double_quoted [
	^ ($" asPParser, nb_double_text, $" asPParser) map: [ :first :text :second |
		"first asString, text, second asString"
		text
	] 
]

{ #category : #spec }
PP2YAMLGrammar >> c_flow_indicator [
	^ 	$, asPParser / 
		$[ asPParser / 
		$] asPParser / 
		${ asPParser / 
		$} asPParser
]

{ #category : #spec }
PP2YAMLGrammar >> c_flow_json_content [
	^ 	c_flow_sequence / 
		c_flow_mapping / 
		"c_single_quoted /"
		c_double_quoted
]

{ #category : #spec }
PP2YAMLGrammar >> c_flow_json_node [
	^ ( c_ns_properties, s_separate optional) optional, c_flow_json_content ==> #second
]

{ #category : #spec }
PP2YAMLGrammar >> c_flow_mapping [
	^  	${ asPParser, s_separate optional, ns_s_flow_map_entries YAMLinFlow optional, $} asPParser
	
	map: [ :open :sep :entries :close |
		entries 	ifNil: [ #() ]
				   ifNotNil: [ 
						entries 	inject: Dictionary new 
									into: [ :dict :assoc | dict at: assoc key put: assoc value; yourself ] ]
	]
]

{ #category : #spec }
PP2YAMLGrammar >> c_flow_sequence [
	^  	$[ asPParser, s_separate optional, ns_s_flow_seq_entries YAMLinFlow optional, $] asPParser
	
	map: [ :open :separate :entries : close |
		entries ifNil: [ #() ]
	]
]

{ #category : #spec }
PP2YAMLGrammar >> c_indentation_indicator [ 
	^ #digit asPParser >=> [ :context :cc |
		| digit |
		digit := cc value.
		digit isPetitFailure ifTrue: [ 
			digit := self autoDetect: context blockHeader: true.
		] ifFalse: [
			digit := digit asString asInteger.
		].
		context YAMLM: digit.
		digit
	]
]

{ #category : #spec }
PP2YAMLGrammar >> c_indicator [
 	^	$- asPParser / 
		$? asPParser /
		$: asPParser / 
		$, asPParser /
		$[ asPParser /
		$] asPParser /
		${ asPParser / 
		$} asPParser /
		$# asPParser / 
		$& asPParser / 
		$* asPParser / 
		$! asPParser / 
		$| asPParser / 
		$> asPParser / 
		$' asPParser / 
		$" asPParser / 
		$% asPParser / 
		$@ asPParser / 
		$` asPParser
]

{ #category : #spec }
PP2YAMLGrammar >> c_l_block_map_explicit_entry [
	^ c_l_block_map_explicit_key, (l_block_map_explicit_value / e_node) 
	
	map: [ :key :value |
		key ->value
	]
]

{ #category : #spec }
PP2YAMLGrammar >> c_l_block_map_explicit_key [ 	
	^ $? asPParser, s_l_block_indented YAMLBlockOut

	==> #second
]

{ #category : #spec }
PP2YAMLGrammar >> c_l_block_map_implicit_value [ 
	^ $: asPParser, (s_l_block_node YAMLBlockOut / ((e_node, s_l_comments) ==> #first)) ==> #second
]

{ #category : #spec }
PP2YAMLGrammar >> c_l_block_seq_entry [
	^ ($- asPParser, ns_char not), s_l_block_indented YAMLBlockIn"(n,block_in)" ==> #last
]

{ #category : #spec }
PP2YAMLGrammar >> c_l_folded [ 	
	^ $> asPParser, c_b_block_header, (l_folded_content >=> [ :context :cc |
		| retval |
		context YAMLN: (context YAMLN + context YAMLM).
		retval := cc value.
		context YAMLRestoreN.
		retval
	]) ==> #third
]

{ #category : #spec }
PP2YAMLGrammar >> c_l_literal [ 
	^ ($| asPParser, c_b_block_header, (l_literal_content >=> [ :context :cc |
		| retval |
		context YAMLN: (context YAMLN + context YAMLM).
			
		retval := cc value.
		context YAMLRestoreN.
		context YAMLM: 1.
		retval
	])) ==> #third
]

{ #category : #spec }
PP2YAMLGrammar >> c_nb_comment_text [ 
	^ $# asPParser, nb_char star 
]

{ #category : #spec }
PP2YAMLGrammar >> c_ns_flow_map_adjacent_value [
	^ $: asPParser, ( ( s_separate optional,  ns_flow_node ==> #second) / e_node ) "Value"  ==> #second
]

{ #category : #spec }
PP2YAMLGrammar >> c_ns_flow_map_empty_key_entry [ 	
	^ 	e_node "Key", c_ns_flow_map_separate_value
	map: [ :key :sep |
		key -> sep
	]
]

{ #category : #spec }
PP2YAMLGrammar >> c_ns_flow_map_json_key_entry [
	^ c_flow_json_node, ( (s_separate optional, c_ns_flow_map_adjacent_value) ==> #second / e_node)
	
	map: [ :key :value |
		key -> value
	]
]

{ #category : #spec }
PP2YAMLGrammar >> c_ns_flow_map_separate_value [ 	
	^	$: asPParser, ns_plain_safe not, 
		(( s_separate, ns_flow_node ==> #second ) / e_node "Value" ) ==> #third 
]

{ #category : #spec }
PP2YAMLGrammar >> c_ns_flow_pair_json_key_entry [ 
	^ 	c_s_implicit_json_key YAMLFlowKey,
	  	c_ns_flow_map_adjacent_value
]

{ #category : #spec }
PP2YAMLGrammar >> c_ns_properties [
	^ PP2FailingNode message: 'Properties not YET supported'
]

{ #category : #spec }
PP2YAMLGrammar >> c_printable [
	^ PP2PredicateObjectNode on: (PP2CharSetPredicate on: 
			[ :e | e asInteger >= 32 or: [ e isSeparator ] ]) message: 'c_printable expected' 
]

{ #category : #spec }
PP2YAMLGrammar >> c_s_implicit_json_key [
	^	c_flow_json_node, s_separate_in_line optional ==> #first
]

{ #category : #spec }
PP2YAMLGrammar >> e_node [
	^ e_scalar
]

{ #category : #spec }
PP2YAMLGrammar >> e_scalar [
	^ nil asPParser
]

{ #category : #spec }
PP2YAMLGrammar >> l_bare_document [ 	
	^ s_l_block_node "(-1,block_in)" >=>
	[ :context :cc |
		| retval aYAMLContext |

	
		aYAMLContext := context YAMLContext.
		context YAMLContext: #'block-in'.
		context YAMLN: -1.

		retval := cc value.
		retval.
	]
]

{ #category : #spec }
PP2YAMLGrammar >> l_block_map_explicit_value [
	^ s_indent, $: asPParser, s_l_block_indented YAMLBlockOut ==> #third
]

{ #category : #spec }
PP2YAMLGrammar >> l_block_mapping [
	^ (( s_indent"(n+m)", ns_l_block_map_entry"(n+m) ") plus
	"/* For some fixed auto_detected m > 0 */ "
	
	>=> [ :context :cc |
		| retval size |
		size := context indentStack size.
		context YAMLN: (context YAMLN + (self autoDetect: context)).
		self assert: (size + 1) = (context indentStack size).
		retval := cc value.
		
		context YAMLRestoreN.
		retval
	])	map: [ :results |
		| retval |
		retval := Dictionary new.
		(results collect: [ :e | e second ]) do: [:r | retval at: r key put: r value ].
		retval
	]

]

{ #category : #spec }
PP2YAMLGrammar >> l_block_sequence [
	^ ( s_indent "(n+m)", c_l_block_seq_entry"(n+m)" ==> #second) plus
		"/* For some fixed auto_detected m > 0 */ "
	
	>=> [ :context :cc |
		| retval |
		context YAMLN: (context YAMLN + (self autoDetect: context)).
			
		retval := cc value.
		
		context YAMLRestoreN.
		retval
	]		
]

{ #category : #spec }
PP2YAMLGrammar >> l_chomped_empty [ 	
	^ 
	(l_strip_empty if: [ :context | context YAMLChomp = #strip ]) /
	(l_strip_empty if: [ :context | context YAMLChomp = #clip ]) /
	(l_keep_empty if: [ :context | context YAMLChomp = #keep ])
]

{ #category : #spec }
PP2YAMLGrammar >> l_comment [
	^ (#startOfLine asPParser , #endOfLine asPParser) not , s_separate_in_line
		, c_nb_comment_text optional , b_comment	"if the line is last and empty, do not consume it"
]

{ #category : #spec }
PP2YAMLGrammar >> l_empty [
	^	(	s_line_prefix /
			s_indent_smaller),
			b_as_line_feed 
	map: [ :prefix :lf |
		prefix asString, lf asString
	]
]

{ #category : #spec }
PP2YAMLGrammar >> l_folded_content [
	^ (l_nb_diff_lines, b_chomped_last) optional, l_chomped_empty
	
	map: [ :lines :empty |
		| start end |
		lines 	ifNotNil: [ 
					start := lines first.
					end := ((lines second = #'end-of-input') 
						ifTrue: [ '' ] 
						ifFalse: [ lines second asString ]).
				] ifNil: [ 
					start := ''. 
					end := ''.
				].

		start, end.
	]
]

{ #category : #spec }
PP2YAMLGrammar >> l_keep_empty [	
	^ l_empty YAMLBlockIn star, l_trail_comments optional
	
	map: [ :lines :comments | 
		lines inject: '' into: [ :concat :line | concat, line ]
	]
]

{ #category : #spec }
PP2YAMLGrammar >> l_literal_content [ 
	^ (l_nb_literal_text, b_nb_literal_next star, b_chomped_last) optional, l_chomped_empty
	
	map: [ :start :empty |
		start ifNotNil: [  
			| retval text next last |
			text := start first.
			next := start second.
			last := start third.
			
			retval := text.
			next do: [ :nextText | retval := retval, nextText ].
			retval := retval, last asString.
			retval, empty
		] ifNil: [ 
	 		empty
		]
	]
]

{ #category : #spec }
PP2YAMLGrammar >> l_nb_diff_lines [
	^ l_nb_same_lines, (b_as_line_feed, l_nb_same_lines) star 
	
	map: [ :lines :rest | 
		| retval |
		retval := lines.
		rest do: [ :e |
			retval := retval, e first asString.
			retval := retval, e second.
		].
		retval
	]
]

{ #category : #spec }
PP2YAMLGrammar >> l_nb_folded_lines [ 	
	^ s_nb_folded_text, (b_l_folded YAMLBlockIn, s_nb_folded_text) star 
	
	map: [ :text :rest |
		|retval|
		
		retval := text.
		rest do: [ :e |  
			retval := retval, e first.
			retval := retval, e second.
		].
		retval
	]
]

{ #category : #spec }
PP2YAMLGrammar >> l_nb_literal_text [
	^ ((l_empty YAMLBlockIn) star, s_indent, nb_char plus flatten)
	
	map: [ :empty :indent :text |
		| retval |
		retval := ''.
		empty do: [ :e |
			retval := retval, e asString.
		].
		retval := retval, text.
		retval
	]
]

{ #category : #spec }
PP2YAMLGrammar >> l_nb_same_lines [ 
	^ l_empty YAMLBlockIn star, (l_nb_folded_lines / l_nb_spaced_lines)  
	
	map: [ :empty :lines |
		|retval|
		retval := ''.
		empty do: [ :e | retval := retval, e asString ].
		retval := retval, lines.
		retval
	]
]

{ #category : #spec }
PP2YAMLGrammar >> l_nb_spaced_lines [
	^ s_nb_spaced_text, (b_l_spaced, s_nb_spaced_text) star

	
	map: [ :text :rest |
		|retval|
		
		retval := text.
		rest do: [ :e |  
			retval := retval, e first.
			retval := retval, e second.
		].
		retval
	]
]

{ #category : #spec }
PP2YAMLGrammar >> l_strip_empty [ 
	^ (s_indent / s_indent_smaller, b_non_content ) star, l_trail_comments optional
	map: [:nonContent :comments |  '' ]
]

{ #category : #spec }
PP2YAMLGrammar >> l_trail_comments [	
	^ s_indent_smaller, c_nb_comment_text, b_comment, l_comment star
]

{ #category : #spec }
PP2YAMLGrammar >> nb_char [
	^ b_char not, c_printable ==> #second
]

{ #category : #spec }
PP2YAMLGrammar >> nb_double_char [
	^ ($/ asPParser not,  $" asPParser not), nb_json ==> #third
]

{ #category : #spec }
PP2YAMLGrammar >> nb_double_multi_line [ 	
 	^ nb_ns_double_in_line, (s_double_next_line / (s_white star flatten)) 
	
	map: [ :first :rest | 
		first, rest
	]
]

{ #category : #spec }
PP2YAMLGrammar >> nb_double_one_line [ 	
	^ nb_double_char star flatten
]

{ #category : #spec }
PP2YAMLGrammar >> nb_double_text [
	^ 
	(nb_double_multi_line if: [:context | context YAMLContext = #'flow-out' ]) /
	(nb_double_multi_line if: [:context | context YAMLContext = #'flow-in' ]) /
	(nb_double_one_line if: [:context | context YAMLContext = #'block-key' ]) /
	(nb_double_one_line if: [:context | context YAMLContext = #'flow-key' ])
]

{ #category : #spec }
PP2YAMLGrammar >> nb_json [
	^ PP2PredicateObjectNode on: (PP2CharSetPredicate on: 
			[ :e | e asInteger >= 32 or: [ e = Character tab ] ]) message: 'nb_json expected' 
]

{ #category : #spec }
PP2YAMLGrammar >> nb_ns_double_in_line [ 	
	^ ( s_white star, ns_double_char) star flatten 
]

{ #category : #spec }
PP2YAMLGrammar >> nb_ns_plain_in_line [
	^  (s_white star, ns_plain_char) star flatten
]

{ #category : #spec }
PP2YAMLGrammar >> ns_char [
	^  	s_white not, nb_char ==> #second
]

{ #category : #spec }
PP2YAMLGrammar >> ns_double_char [ 
	^ s_white not, nb_double_char  ==> #second
]

{ #category : #spec }
PP2YAMLGrammar >> ns_flow_content [
	^ ns_flow_yaml_content / c_flow_json_content
]

{ #category : #spec }
PP2YAMLGrammar >> ns_flow_map_entry [
	"
		TODO JK: s_separate is optional, even though doc say, it is not.
		Yet, how else to parse: { ? } into nil -> nil ??
	"
	^ 	($? asPParser, s_separate optional, ns_flow_map_explicit_entry ==> #third) /
		ns_flow_map_implicit_entry
]

{ #category : #spec }
PP2YAMLGrammar >> ns_flow_map_explicit_entry [
	^ ns_flow_map_implicit_entry /
		(( e_node, e_node ) map: [ :key :value | key -> value ])
	
]

{ #category : #spec }
PP2YAMLGrammar >> ns_flow_map_implicit_entry [ 
	^ 	ns_flow_map_yaml_key_entry /
		c_ns_flow_map_empty_key_entry /
		c_ns_flow_map_json_key_entry
]

{ #category : #spec }
PP2YAMLGrammar >> ns_flow_map_yaml_key_entry [
	^	ns_flow_yaml_node, ((s_separate optional, c_ns_flow_map_separate_value) ==> #second / e_node)
	map: [ :key :value |
		key -> value
	]
]

{ #category : #spec }
PP2YAMLGrammar >> ns_flow_node [
	^ "c_ns_alias_node /"
		ns_flow_content "/
		 ( c_ns_properties(n,c) ,( ( s_separate(n,c), ns_flow_content(n,c) ) / e_scalar ) ) "
]

{ #category : #spec }
PP2YAMLGrammar >> ns_flow_pair [
	^ 	($? asPParser, s_separate, ns_flow_map_explicit_entry ==> #third) / 
		ns_flow_pair_entry
	
	map: [ :assoc |
		Dictionary new at: (assoc key) put: (assoc value); yourself
	]
]

{ #category : #spec }
PP2YAMLGrammar >> ns_flow_pair_entry [
	^	ns_flow_pair_yaml_key_entry /
 		c_ns_flow_map_empty_key_entry /
 		c_ns_flow_pair_json_key_entry 

]

{ #category : #spec }
PP2YAMLGrammar >> ns_flow_pair_yaml_key_entry [
	^ 	ns_s_implicit_yaml_key YAMLFlowKey,
		c_ns_flow_map_separate_value
	
	map: [ :first :second |
		first -> second
	]
]

{ #category : #spec }
PP2YAMLGrammar >> ns_flow_seq_entry [
	^	ns_flow_pair / ns_flow_node
]

{ #category : #spec }
PP2YAMLGrammar >> ns_flow_yaml_content [
	^ ns_plain
]

{ #category : #spec }
PP2YAMLGrammar >> ns_flow_yaml_node [ 
	^ "c_ns_alias_node /"
 	  	ns_flow_yaml_content "/
 		(c_ns_properties, ( ( s_separate(n,c), ns_flow_yaml_content(n,c) ) / e_scalar ) ) "
]

{ #category : #spec }
PP2YAMLGrammar >> ns_l_block_map_entry [
	^ 	c_l_block_map_explicit_entry /
		ns_l_block_map_implicit_entry
]

{ #category : #spec }
PP2YAMLGrammar >> ns_l_block_map_implicit_entry [
	^ ( ns_s_block_map_implicit_key / e_node ), c_l_block_map_implicit_value
	map: [ :key :value |
		key -> value
	]
]

{ #category : #spec }
PP2YAMLGrammar >> ns_l_compact_mapping [
	^ ns_l_block_map_entry, (s_indent, ns_l_block_map_entry ==> #second) star 
	map: [ :entry :rest |
		| retval |
		retval := Dictionary new.
		retval at: entry key put: entry value.
		rest do: [ :e | retval at: e key put: e value].
		retval
	]
]

{ #category : #spec }
PP2YAMLGrammar >> ns_l_compact_sequence [
	^ c_l_block_seq_entry, (s_indent, c_l_block_seq_entry ==> #second) star
	map: [ :first :rest |
		rest asOrderedCollection addFirst: first; yourself
	] 
]

{ #category : #spec }
PP2YAMLGrammar >> ns_plain [
	^ 
	(ns_plain_multi_line if: [: context | context YAMLContext = #'flow-out'  ]) /
	(ns_plain_multi_line if: [: context | context YAMLContext = #'flow-in'  ]) /
	(ns_plain_one_line if: [: context | context YAMLContext = #'block-key'  ]) /
	(ns_plain_one_line if: [: context | context YAMLContext = #'flow-key'  ])
]

{ #category : #spec }
PP2YAMLGrammar >> ns_plain_char [
	^ 	(($: asPParser not, $# asPParser not, ns_plain_safe) ==> #third) / 
		( ns_char preceeds, $# asPParser) / 
		(( $: asPParser, ns_plain_safe and) ==> #first)
]

{ #category : #spec }
PP2YAMLGrammar >> ns_plain_first [
	^ 	(c_indicator not, ns_char) /
		(($? asPParser / $: asPParser / $- asPParser), ns_plain_safe and )
]

{ #category : #spec }
PP2YAMLGrammar >> ns_plain_multi_line [
	^ ns_plain_one_line, s_ns_plain_next_line star 
	
	
	map: [ :first :rest |
		| retval |
		retval := first.
		rest do: [ :e | retval := retval, e ].
		retval
	]
]

{ #category : #spec }
PP2YAMLGrammar >> ns_plain_one_line [
	^  	(ns_plain_first, nb_ns_plain_in_line) flatten
]

{ #category : #spec }
PP2YAMLGrammar >> ns_plain_safe [
	^ 
	(ns_plain_safe_out if: [ :context | context YAMLContext = #'flow-out' ]) /
	(ns_plain_safe_in  if: [ :context | context YAMLContext = #'flow-in' ]) /
	(ns_plain_safe_out if: [ :context | context YAMLContext = #'block-key' ]) /
	(ns_plain_safe_in  if: [ :context | context YAMLContext = #'flow-key' ]) 
]

{ #category : #spec }
PP2YAMLGrammar >> ns_plain_safe_in [
	^ c_flow_indicator not, ns_char ==> #second
]

{ #category : #spec }
PP2YAMLGrammar >> ns_plain_safe_out [
	^ ns_char
]

{ #category : #spec }
PP2YAMLGrammar >> ns_s_block_map_implicit_key [  
	^ 	c_s_implicit_json_key YAMLBlockKey /
		ns_s_implicit_yaml_key YAMLBlockKey
]

{ #category : #spec }
PP2YAMLGrammar >> ns_s_flow_map_entries [ 
	^ ns_flow_map_entry, s_separate optional, 
		($, asPParser, s_separate optional, ns_s_flow_map_entries optional) optional 

	map: [ :entry :sep :rest |
		rest ifNotNil: [ 
			rest third ifNotNil: [ 
				rest third addFirst: entry.
				rest third
			] ifNil: [ 
				OrderedCollection with: entry.
			]
		] ifNil: [  
			OrderedCollection with: entry
		].
	]
]

{ #category : #spec }
PP2YAMLGrammar >> ns_s_flow_seq_entries [
	^ ns_flow_seq_entry, s_separate optional, 
		( $, asPParser, s_separate optional, ns_s_flow_seq_entries optional ) optional 
	
	map: [ :entry :sep :rest |
		rest ifNotNil: [ 
			rest third ifNotNil: [ 
				rest third addFirst: entry.
				rest third
			] ifNil: [ 
				OrderedCollection with: entry.
			]
		] ifNil: [  
			OrderedCollection with: entry
		].
	]
]

{ #category : #spec }
PP2YAMLGrammar >> ns_s_implicit_yaml_key [
	^ ns_flow_yaml_node, s_separate_in_line optional ==> #first
]

{ #category : #spec }
PP2YAMLGrammar >> s_b_comment [ 	
	^ ( s_separate_in_line, c_nb_comment_text optional ) optional, b_comment
]

{ #category : #spec }
PP2YAMLGrammar >> s_block_line_prefix [
	^ s_indent
]

{ #category : #spec }
PP2YAMLGrammar >> s_double_break [
	^ s_flow_folded / s_double_escaped
]

{ #category : #spec }
PP2YAMLGrammar >> s_double_escaped [
	^ PP2FailingNode message: 's_double_escaped not yet implemented'
]

{ #category : #spec }
PP2YAMLGrammar >> s_double_next_line [
	^ s_double_break, ( ns_double_char, nb_ns_double_in_line, 
		(s_double_next_line / (s_white star flatten))) optional 
		
	map: [ :break :rest |
		| retval |
		retval := break.
		rest ifNotNil: [ 
			retval := retval, rest first asString.
			retval := retval, rest second.
			rest third ifNotNil: [ 
				retval := retval, rest third.
			].
			retval
		]
	].
]

{ #category : #spec }
PP2YAMLGrammar >> s_flow_folded [
 	^ s_separate_in_line optional, 
		b_l_folded YAMLFlowIn "(n,flow-in)",
		s_flow_line_prefix "(n)" ==> #second
]

{ #category : #spec }
PP2YAMLGrammar >> s_flow_line_prefix [
	^ s_indent, s_separate_in_line optional
	map: [ :indent :separate |
		"separate ifNil: [ '' ] "
		"
			From SPEC: Separation spaces are a presentation detail 
			and must not be used to convey content information. 
		"
		''
	]
]

{ #category : #spec }
PP2YAMLGrammar >> s_indent [
	^ (aligns not, s_space) star, aligns
	==> [ :e | '' ]

"	^ ((nil asParser offsideTo: #YAMLN), s_space ==> #second) star, (nil asParser alignedTo: #YAMLN) 
	
	==> [ :e | '' ]"
]

{ #category : #spec }
PP2YAMLGrammar >> s_indent_smaller [
	^ (aligns not, s_space) star
	==> [ :e | '' ]

"	^ (s_space, nil asParser offsideTo: #YAMLN) star
	
	==> [ :e | '' ]"
]

{ #category : #spec }
PP2YAMLGrammar >> s_l_block_collection [ 	
	^ 	( s_separate YAMLNPlus, c_ns_properties YAMLNPlus ) optional, s_l_comments,
		( l_block_sequence YAMLSeqSpaces / l_block_mapping ) 
	
	map: [ :props :comments :sequenceOrMapping |
		sequenceOrMapping 
	]
]

{ #category : #spec }
PP2YAMLGrammar >> s_l_block_in_block [ 
	^ s_l_block_scalar / s_l_block_collection
]

{ #category : #spec }
PP2YAMLGrammar >> s_l_block_indented [ 	
	"I did the hack here, because yaml's indent is n*space, 
		mine is connected to the column"
	^ 	(( s_indent YAMLNPlus YAMLPlusM "n+1+m" "YAMLM" "(m)",  
										(	ns_l_compact_sequence YAMLNPlus YAMLPlusM "(n+1+m)" / 											ns_l_compact_mapping YAMLNPlus YAMLPlusM "(n+1+m)" ) ) 
														
		) ==> #second	/
		s_l_block_node /
		(( e_node, s_l_comments ) ==> #first) 
]

{ #category : #spec }
PP2YAMLGrammar >> s_l_block_node [
	^ s_l_block_in_block / s_l_flow_in_block
]

{ #category : #spec }
PP2YAMLGrammar >> s_l_block_scalar [
	^ s_separate YAMLNPlus"(n+1,c)", (c_ns_properties YAMLNPlus "(n+1,c)", 
												s_separate YAMLNPlus "(n+1,c)" ) optional,
		( c_l_literal / c_l_folded) 
	map: [ :separate :props :rest |
		rest
	]
]

{ #category : #spec }
PP2YAMLGrammar >> s_l_comments [
	^ s_b_comment / #startOfLine asPParser , l_comment star
]

{ #category : #spec }
PP2YAMLGrammar >> s_l_flow_in_block [ 	
	^ 	s_separate YAMLNPlus YAMLFlowOut "(n+1,flow_out)", 
		ns_flow_node YAMLNPlus YAMLFlowOut "(n+1,flow_out)", 
		s_l_comments
	
	map: [ :separate :flow_node :comment |
		flow_node
	]
]

{ #category : #spec }
PP2YAMLGrammar >> s_line_prefix [
	^ 
	(s_block_line_prefix if: [ :context | context YAMLContext = #'block-out' ]) /
	(s_block_line_prefix if: [ :context |  context YAMLContext = #'block-in' ]) /
	(s_flow_line_prefix if: [ :context |  context YAMLContext = #'flow-out' ]) /
	(s_flow_line_prefix if: [ :context |  context YAMLContext = #'flow-in' ])
]

{ #category : #spec }
PP2YAMLGrammar >> s_nb_folded_text [
	^ s_indent, ns_char, nb_char star flatten
	
	map: [ :indent :ns :nb |
		ns asString, nb
	]
]

{ #category : #spec }
PP2YAMLGrammar >> s_nb_spaced_text [ 	
	^ s_indent, s_white, nb_char star flatten
	
	map: [ :indent :white :chars |
		white asString, chars
	]
]

{ #category : #spec }
PP2YAMLGrammar >> s_ns_plain_next_line [
	^ s_flow_folded, ns_plain_char, nb_ns_plain_in_line
		
	map: [ :folding :char :line |
		folding asString, char asString, line
	]
]

{ #category : #spec }
PP2YAMLGrammar >> s_separate [
	^ 
	(s_separate_lines if: [ :context | context YAMLContext = #'block-out' ]) / 
	(s_separate_lines if: [ :context | context YAMLContext = #'block-in' ]) /
	(s_separate_lines if: [ :context | context YAMLContext = #'flow-out' ]) /
	(s_separate_lines if: [ :context | context YAMLContext = #'flow-in' ]) /
	(s_separate_in_line if: [ :context | context YAMLContext = #'block-key' ]) /
	(s_separate_in_line if: [ :context | context YAMLContext = #'flow-key' ])

]

{ #category : #spec }
PP2YAMLGrammar >> s_separate_in_line [
	^ #blank asPParser plus flatten / (#startOfLine asPParser ==> [ :e | '' ])
]

{ #category : #spec }
PP2YAMLGrammar >> s_separate_lines [ 
	^ 	( s_l_comments, s_flow_line_prefix) / 
		s_separate_in_line
]

{ #category : #spec }
PP2YAMLGrammar >> s_space [
	^ Character space asPParser
]

{ #category : #spec }
PP2YAMLGrammar >> s_tab [
	^ Character tab asPParser
]

{ #category : #spec }
PP2YAMLGrammar >> s_white [
	^ s_space / s_tab
]

{ #category : #accessing }
PP2YAMLGrammar >> start [
	^ l_bare_document
]

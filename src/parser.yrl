Nonterminals statement select_stmt columns column_list column table_name where_clause condition.
Terminals select from where and_op or_op star comma semicolon eq identifier integer string.
Rootsymbol statement.

statement -> select_stmt semicolon : '$1'.

select_stmt -> select columns from table_name : {select, '$2', '$4'}.
select_stmt -> select columns from table_name where_clause : {select, '$2', '$4', '$5'}.

columns -> star : all.
columns -> column_list : '$1'.

column_list -> column : ['$1'].
column_list -> column comma column_list : ['$1' | '$3'].

column -> identifier : extract_value('$1').

table_name -> identifier : extract_value('$1').

where_clause -> where condition : {where, '$2'}.

condition -> identifier eq identifier : {eq, extract_value('$1'), extract_value('$3')}.
condition -> identifier eq integer : {eq, extract_value('$1'), extract_value('$3')}.
condition -> identifier eq string : {eq, extract_value('$1'), extract_value('$3')}.
condition -> condition and_op condition : {and_op, '$1', '$3'}.
condition -> condition or_op condition : {or_op, '$1', '$3'}.

Erlang code.

extract_value({_, _, Value}) -> Value.

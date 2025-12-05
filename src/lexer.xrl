Definitions.

DIGIT = [0-9]
LETTER = [a-zA-Z_]
WS = [\s\t\n\r]

Rules.

[sS][eE][lL][eE][cC][tT] : {token, {select, TokenLine}}.
[fF][rR][oO][mM] : {token, {from, TokenLine}}.
[wW][hH][eE][rR][eE] : {token, {where, TokenLine}}.
[aA][nN][dD] : {token, {and_op, TokenLine}}.
[oO][rR] : {token, {or_op, TokenLine}}.
\* : {token, {star, TokenLine}}.
, : {token, {comma, TokenLine}}.
; : {token, {semicolon, TokenLine}}.
= : {token, {eq, TokenLine}}.
{DIGIT}+ : {token, {integer, TokenLine, list_to_integer(TokenChars)}}.
{LETTER}({LETTER}|{DIGIT})* : {token, {identifier, TokenLine, list_to_atom(TokenChars)}}.
'[^']*' : {token, {string, TokenLine, lists:sublist(TokenChars, 2, length(TokenChars) - 2)}}.
{WS}+ : skip_token.

Erlang code.

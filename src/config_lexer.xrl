Definitions.

NUMBER            = [0-9]
LETTER            = [a-zA-Z_]
BASE64            = [+=]
ATTR_START        = @
NEGATIVE_SIGN     = \!
WHITESPACE        = [\s\t\n\r]+
COMMA_SPLIT       = \,
SLASH_SPLIT       = \/
SIGIL             = \~
LEFT_PARENTHESES  = \(
RIGHT_PARENTHESES = \)
BRACKET           = [\[\]]
OTHER_SIGNS       = [\:\.\-\?]
CODE_SIGN         = ```
TEXT_SIGN         = `
CHINESE           = [^\x00-\xff]
COMMENT           = #.*


KEY                  = ([^\(\)\s\t\n\r])
CHAR                 = {LETTER}|{NUMBER}|{COMMA_SPLIT}|{SLASH_SPLIT}|{BRACKET}|{BASE64}|{SIGIL}|{OTHER_SIGNS}|{CHINESE}
STRING               = ({CHAR}+)+
TEXT_CHAR            = ([^`])
POS_ATTR_DEFINATION  = {ATTR_START}{KEY}+
NEG_ATTR_DEFINATION  = {NEGATIVE_SIGN}{ATTR_START}{KEY}+
ADD_ATTR_DEFINATION  = \+{KEY}+
ATTR_DEFINATION      = {POS_ATTR_DEFINATION}|{NEG_ATTR_DEFINATION}
TEXT_DEFINITION      = {TEXT_SIGN}({TEXT_CHAR}+)+{TEXT_SIGN}
CODE_DEFINITION      = {CODE_SIGN}([^`])*{CODE_SIGN}
SECTION_WORKER       = worker
SECTION_SETTING      = setting
SECTION_OBJECT       = object
SECTION_FIELD        = field
SECTION_SCHEMA       = schema
SECTION_VALIDATION   = validation
SECTION_PERMISSION   = permission
SECTION_SEED         = seed
SECTION_WECHAT       = wechat
SECTION_CALLBACK     = callback
SECTION_EXTENSION    = extension
SECTION_GLOBAL       = global
BLOCK_START          = do
BLOCK_END            = end

Rules.

{NEW_LINE}              : skip_token.
{COMMENT}               : skip_token.
{WHITESPACE}            : skip_token.
{CODE_SIGN}             : skip_token.
{POS_ATTR_DEFINATION}   : {token, {'pos_attr', TokenLine, pos_attr_atom(TokenChars)}}.
{NEG_ATTR_DEFINATION}   : {token, {'neg_attr', TokenLine, neg_attr_atom(TokenChars)}}.
{ADD_ATTR_DEFINATION}   : {token, {'add_attr', TokenLine, plus_attr_atom(TokenChars)}}.
{SECTION_OBJECT}        : {token, {'section_object', TokenLine}}.
{SECTION_FIELD}         : {token, {'section_field', TokenLine}}.
{SECTION_SCHEMA}        : {token, {'section_schema', TokenLine}}.
{SECTION_VALIDATION}    : {token, {'section_validation', TokenLine}}.
{SECTION_PERMISSION}    : {token, {'section_permission', TokenLine}}.
{SECTION_SEED}          : {token, {'section_seed', TokenLine}}.
{SECTION_WECHAT}        : {token, {'section_wechat', TokenLine}}.
{SECTION_CALLBACK}      : {token, {'section_callback', TokenLine}}.
{SECTION_EXTENSION}     : {token, {'section_extension', TokenLine}}.
{SECTION_WORKER}        : {token, {'section_worker', TokenLine}}.
{SECTION_SETTING}       : {token, {'section_setting', TokenLine}}.
{SECTION_GLOBAL}        : {token, {'section_global', TokenLine}}.
{BLOCK_START}           : {token, {'do_exp', TokenLine}}.
{BLOCK_END}             : {token, {'end_exp', TokenLine}}.
{LEFT_PARENTHESES}      : {token, {'(', TokenLine}}.
{RIGHT_PARENTHESES}     : {token, {')', TokenLine}}.
{TEXT_DEFINITION}       : {token, {'text', TokenLine, text_attr_string(TokenChars)}}.
{CODE_DEFINITION}       : {token, {'code', TokenLine, code_attr_string(TokenChars)}}.
{STRING}                : {token, {'string', TokenLine, unicode:characters_to_binary(TokenChars)}}.

Erlang code.

pos_attr_atom([$@|Chars]) -> list_to_atom(Chars).
neg_attr_atom([$!|[$@|Chars]]) -> list_to_atom(Chars).
plus_attr_atom([$+|Chars]) -> list_to_binary(Chars).

text_attr_string(Chars) ->
  [$`|Chars1] = Chars,
  [$`|Chars2] = lists:reverse(Chars1),
  Chars3 = lists:reverse(Chars2),
  unicode:characters_to_binary(Chars3).

code_attr_string(Chars) ->
  [$`|[$`|[$`|Chars1]]] = Chars,
  [$`|[$`|[$`|Chars2]]] = lists:reverse(Chars1),
  Chars3 = lists:reverse(Chars2),
  unicode:characters_to_binary(Chars3).

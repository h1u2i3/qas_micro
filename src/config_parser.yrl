Nonterminals
  grammer
  object_blocks object_block object_items object_item
  field_block schema_block validation_block permission_block worker_block setting_block global_block
  wechat_block seed_blocks seed_block callback_block text_content
  extension_block plus_attrs plus_attr attrs attr content code_content.

Terminals
  '(' ')' do_exp end_exp
  section_object section_schema section_field section_validation section_permission
  section_wechat section_seed section_callback section_extension section_worker section_setting section_global
  pos_attr neg_attr add_attr string text code.

Rootsymbol grammer.

grammer -> attrs                  : '$1'.
grammer -> wechat_block           : [{'wechat', '$1'}].
grammer -> grammer wechat_block   : [{'wechat', '$2'}|'$1'].
grammer -> grammer worker_block   : [{'worker', '$2'}|'$1'].
grammer -> grammer setting_block  : [{'setting', '$2'}|'$1'].
grammer -> grammer callback_block : [{'callback', '$2'}|'$1'].
grammer -> grammer object_blocks  : [{'object', '$2'}|'$1'].
grammer -> grammer global_block   : [{'global', '$2'}|'$1'].

wechat_block  -> section_wechat do_exp attrs end_exp      : '$3'.

object_blocks -> object_block               : ['$1'].
object_blocks -> object_block object_blocks : concat_results('$1', '$2').
object_block  -> section_object do_exp object_items end_exp : '$3'.

object_items  -> object_item              : '$1'.
object_items  -> object_item object_items : concat_results('$1', '$2').
object_item   -> attr                     : '$1'.
object_item   -> field_block              : '$1'.
object_item   -> schema_block             : '$1'.
object_item   -> validation_block         : '$1'.
object_item   -> permission_block         : '$1'.
object_item   -> extension_block          : '$1'.
object_item   -> seed_blocks              : {'seed', '$1'}.

field_block       -> section_field do_exp plus_attrs end_exp        : {'field', '$3'}.
schema_block      -> section_schema do_exp plus_attrs end_exp       : {'schema', '$3'}.
validation_block  -> section_validation do_exp plus_attrs end_exp   : {'validation', '$3'}.
permission_block  -> section_permission do_exp attrs end_exp        : {'permission', '$3'}.
extension_block   -> section_extension do_exp attrs end_exp         : {'extension', '$3'}.
worker_block      -> section_worker do_exp attrs end_exp            : '$3'.
setting_block     -> section_setting do_exp attrs end_exp           : '$3'.
callback_block    -> section_callback do_exp code_content end_exp   : '$3'.
global_block      -> section_global do_exp code_content end_exp     : '$3'.

seed_blocks       -> seed_block                           : ['$1'].
seed_blocks       -> seed_block seed_blocks               : concat_results('$1', '$2').
seed_block        -> section_seed do_exp attrs end_exp    : '$3'.

plus_attrs   -> plus_attr                      : ['$1'].
plus_attrs   -> plus_attr plus_attrs           : concat_results('$1', '$2').
plus_attr    -> add_attr '(' content ')'       : extract_add_attr('$1', '$3').
plus_attr    -> add_attr '(' content attrs ')' : extract_add_attr('$1', '$3', '$4').

attrs -> attr                           : ['$1'].
attrs -> attr attrs                     : concat_results('$1', '$2').
attr  -> pos_attr                       : extract_pos_attr('$1').
attr  -> neg_attr                       : extract_neg_attr('$1').
attr  -> pos_attr '(' content ')'       : extract_pos_attr('$1', '$3').
attr  -> pos_attr '(' text_content ')'  : extract_pos_attr('$1', '$3').
attr  -> pos_attr '(' attrs ')'         : concat_attr_results('$1', '$3').
attr  -> pos_attr '(' code_content ')'  : extract_code_attr('$1', '$3').

content         -> string  : extract_string('$1').
code_content    -> code    : extract_string('$1').
text_content    -> text    : extract_string('$1').


Erlang code.

extract_pos_attr({_Token, _Line, Value})                -> {Value, true}.
extract_pos_attr({_Token, _Line, Value}, String)        -> {Value, String}.
concat_attr_results({_Token, _Line, Value}, Value2)     -> {Value, Value2}.
extract_code_attr({_Token, _Line, Value}, Value2)       -> {Value, Value2}.

extract_neg_attr({_Token, _Line, Value})                -> {Value, false}.

extract_add_attr({_Token, _Line, Value}, String)        -> [{'type', Value}, {'name', String}].

extract_add_attr({_Token, _Line, Value}, String, List) when is_list(List) ->
  [{'type', Value}, {'name', String}] ++ List;
extract_add_attr({_Token, _Line, Value}, String, List) ->
  [{'type', Value}, {'name', String}] ++ [List].

extract_string({_Token, _Line, Value})                  -> Value.

concat_results({Key, Value1} = Item1, Item2) when is_list(Item2) ->
  case lists:keyfind(Key, 1, Item2) of
    {Key, [{_Key, _Value}|_Tail] = Value2} ->
      Item3 = Item2 -- [{Key, Value2}],
      Item3 ++ [{Key, concat_results(Value1, [Value2])}];
    {Key, Value2} ->
      Item3 = Item2 -- [{Key, Value2}],
      Item3 ++ [{Key, concat_results(Value1, Value2)}];
    _ ->
      [Item1|Item2]
  end;
concat_results(Item1, Item2) when is_list(Item2) ->
  [Item1|Item2];
concat_results(Item1, Item2) ->
  concat_results(Item1, [Item2]).

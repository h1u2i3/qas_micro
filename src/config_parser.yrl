Nonterminals
  grammer
  object_blocks object_block object_items object_item global_block field_block text_content
  query_blocks query_block mutation_blocks mutation_block type_blocks type_block input_type_blocks input_type_block
  validation_block type_attrs plus_attrs plus_attr attrs attr content code_content.
  % schema_block permission_block seed_blocks seed_block
  % wechat_block callback_block setting_block worker_block extension_block type_attr

Terminals
  '(' ')' do_exp end_exp
  section_object section_field
  section_query section_mutation section_type section_input_type
  section_global section_service
  section_validation pos_attr neg_attr add_attr string text code.
  % section_wechat section_callback section_worker section_setting
  % section_permission section_schema section_extension section_extension  section_seed

Rootsymbol grammer.

grammer -> attrs                  : '$1'.
grammer -> grammer global_block   : [{'global', '$2'}|'$1'].
grammer -> grammer object_blocks  : [{'object', '$2'}|'$1'].

% grammer -> grammer wechat_block                           : [{'wechat', '$2'}|'$1'].
% grammer -> grammer worker_block                           : [{'worker', '$2'}|'$1'].
% grammer -> grammer setting_block                          : [{'setting', '$2'}|'$1'].
% grammer -> grammer callback_block                         : [{'callback', '$2'}|'$1'].
% grammer -> grammer object_blocks                          : [{'object', '$2'}|'$1'].
% wechat_block  -> section_wechat do_exp attrs end_exp      : '$3'.

object_blocks -> object_block                               : ['$1'].
object_blocks -> object_block object_blocks                 : concat_results('$1', '$2').
object_block  -> section_object do_exp object_items end_exp : '$3'.

object_items  -> object_item              : '$1'.
object_items  -> object_item object_items : concat_results('$1', '$2').
object_item   -> attr                     : '$1'.
object_item   -> field_block              : '$1'.
object_item   -> query_blocks             : {'query', '$1'}.
object_item   -> mutation_blocks          : {'mutation', '$1'}.
object_item   -> type_blocks              : {'type', '$1'}.
object_item   -> input_type_blocks        : {'input_type', '$1'}.
% object_item   -> schema_block             : '$1'.
object_item   -> validation_block         : '$1'.
% object_item   -> permission_block         : '$1'.
% object_item   -> extension_block          : '$1'.
% object_item   -> seed_blocks              : {'seed', '$1'}.

field_block       -> section_field do_exp plus_attrs end_exp          : {'field', '$3'}.
% schema_block      -> section_schema do_exp plus_attrs end_exp         : {'schema', '$3'}.
validation_block  -> section_validation do_exp plus_attrs end_exp     : {'validation', '$3'}.
% permission_block  -> section_permission do_exp attrs end_exp          : {'permission', '$3'}.
% extension_block   -> section_extension do_exp attrs end_exp           : {'extension', '$3'}.
global_block      -> section_global do_exp code_content end_exp       : '$3'.
% worker_block      -> section_worker do_exp attrs end_exp            : '$3'.
% setting_block     -> section_setting do_exp attrs end_exp           : '$3'.
% callback_block    -> section_callback do_exp code_content end_exp   : '$3'.

% seed_blocks       -> seed_block                           : ['$1'].
% seed_blocks       -> seed_block seed_blocks               : concat_results('$1', '$2').
% seed_block        -> section_seed do_exp attrs end_exp    : '$3'.

query_blocks       -> query_block                                   : ['$1'].
query_blocks       -> query_block query_blocks                      : concat_results('$1', '$2').
query_block        -> section_query do_exp attrs end_exp            : '$3'.

mutation_blocks    -> mutation_block                                : ['$1'].
mutation_blocks    -> mutation_block mutation_blocks                : concat_results('$1', '$2').
mutation_block     -> section_mutation do_exp attrs end_exp         : '$3'.

type_blocks        -> type_block                                    : ['$1'].
type_blocks        -> type_block type_blocks                        : concat_results('$1', '$2').
type_block         -> section_type do_exp type_attrs end_exp        : '$3'.

input_type_blocks  -> input_type_block                              : ['$1'].
input_type_blocks  -> input_type_block input_type_blocks            : concat_results('$1', '$2').
input_type_block   -> section_input_type do_exp type_attrs end_exp  : '$3'.

type_attrs   -> attrs                          : '$1'.
type_attrs   -> type_attrs plus_attrs          : [{'field', '$2'} | '$1'].

plus_attrs   -> plus_attr                      : ['$1'].
plus_attrs   -> plus_attr plus_attrs           : concat_results('$1', '$2').
plus_attr    -> add_attr '(' content ')'       : extract_add_attr('$1', '$3').
plus_attr    -> add_attr '(' content attrs ')' : extract_add_attr('$1', '$3', '$4').

attrs -> attr                           : check_if_list('$1').
attrs -> attr attrs                     : concat_results('$1', '$2').
attr  -> pos_attr                       : extract_pos_attr('$1').
attr  -> neg_attr                       : extract_neg_attr('$1').
attr  -> pos_attr '(' content ')'       : extract_pos_attr('$1', '$3').
attr  -> pos_attr '(' content attrs ')' : extract_pos_attr('$1', '$3', '$4').
attr  -> pos_attr '(' text_content ')'  : extract_pos_attr('$1', '$3').
attr  -> pos_attr '(' attrs ')'         : concat_attr_results('$1', '$3').
attr  -> pos_attr '(' code_content ')'  : extract_code_attr('$1', '$3').

content         -> string  : extract_string('$1').
code_content    -> code    : extract_string('$1').
text_content    -> text    : extract_string('$1').


Erlang code.

check_if_list(List) when is_list(List) -> List;
check_if_list(List)                    -> [List].

extract_pos_attr({_Token, _Line, Value})                                   -> {Value, true}.
extract_pos_attr({_Token, _Line, Value}, String)                           -> {Value, String}.
extract_pos_attr({_Token, _Line, Value}, String, List)  when is_list(List) ->
  {Value, [{'name', String}] ++ List};
extract_pos_attr({_Token, _Line, Value}, String, List)                     ->
  {Value, [{'name', String}] ++ [List]}.

concat_attr_results({_Token, _Line, Value}, Value2)     -> {Value, Value2}.

extract_code_attr({_Token, _Line, Value}, Value2)       -> {Value, Value2}.

extract_neg_attr({_Token, _Line, Value})                -> {Value, false}.

extract_add_attr({_Token, _Line, Value}, String)                          -> [{'type', Value}, {'name', String}].
extract_add_attr({_Token, _Line, Value}, String, List) when is_list(List) ->
  [{'type', Value}, {'name', String}] ++ List;
extract_add_attr({_Token, _Line, Value}, String, List)                    ->
  [{'type', Value}, {'name', String}] ++ [List].

extract_string({_Token, _Line, Value})                  -> Value.

concat_results({Key, Value1} = Item1, Item2) when is_list(Item2) ->
  case lists:keyfind(Key, 1, Item2) of
    {Key, [{_Key, _Value}|_Tail] = Value2} ->
      Item3 = Item2 -- [{Key, Value2}],
      Item3 ++ [{Key, concat_results(Value1, Value2)}];
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

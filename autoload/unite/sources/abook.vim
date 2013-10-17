let s:save_cpo = &cpo
set cpo&vim

let s:unite_source = {
      \ 'name': 'abook',
      \ 'default_action': 'insert',
      \ 'is_volatile': 1,
      \ 'required_pattern_length': 3,
      \ 'action_table':{},
      \ }

let s:abook_command = 'abook --mutt-query %s'

function! s:address(string)
  let s:s = split(string)
  return s:s[0]
endfunction

function! s:unite_source.gather_candidates(args, context)
  return map(
        \ split(
        \   unite#util#system(printf(
        \     s:abook_command,
        \     a:context.input)),
        \   "\n"),
        \ '{
        \ "word": join(split(v:val)[1:])." <".split(v:val)[0].">",
        \ "kind": "word",
        \ }')
endfunction

function! unite#sources#abook#define()
  return exists('s:abook_command') ? s:unite_source : []
endfunction


let &cpo = s:save_cpo
unlet s:save_cpo

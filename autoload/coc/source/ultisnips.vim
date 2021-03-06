function! coc#source#ultisnips#init() abort
  return {'isSnippet': 1}
endfunction

function! coc#source#ultisnips#should_complete(opt) abort
  if get(g:, 'did_plugin_ultisnips', 0) | return 1 | endif
  return 0
endfunction

function! coc#source#ultisnips#complete(opt, cb) abort
  if len(get(a:opt, 'input', '')) == 0
    call a:cb([])
    return
  endif
  let snips = UltiSnips#SnippetsInCurrentScope()
  if type(snips) == 3
    let items = map(snips, {idx, val -> {'word': val['key'], 'dup': 1, 'menu': val['description']}})
  else
    let items = []
    call map(snips, {key, val -> add(items, {'word': key, 'dup': 1, 'menu': val})})
  endif
  call a:cb(items)
endfunction

function! coc#source#ultisnips#on_complete(item) abort
  call UltiSnips#ExpandSnippet()
endfunction

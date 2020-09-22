if exists('g:loaded_keep_indent_cont') | finish | endif
let g:loaded_keep_indent_cont = 1

" Ref: $VIMRUNTIME/indent/vim.vim @63
let s:default_indent_cont = get(g:, 'vim_indent_cont', shiftwidth() * 3)

augroup keepIndentContWidth
  au!
  au BufEnter *.vim let g:vim_indent_cont = s:keepIndentContWidth()
augroup END

function! s:keepIndentContWidth() abort
  " Ref: $VIMRUNTIME/indent/vim.vim @34
  let pat_line_cont = '^\s*\%(\\\|"\\ \)'
  let pat_start_line = '^\s*\%('. pat_line_cont .'\)\@<![^\\]*\n'
  let pat_continued_lines = pat_start_line . pat_line_cont
  let lnum_lines_cont_start = search(pat_continued_lines, 'nw')

  if lnum_lines_cont_start == 0
    return s:default_indent_cont
  endif

  let [ind_start, ind_cont] = [
        \ indent(lnum_lines_cont_start),
        \ indent(lnum_lines_cont_start + 1)
        \ ]

  let ind_diff = ind_cont - ind_start
  return ind_diff
endfunction


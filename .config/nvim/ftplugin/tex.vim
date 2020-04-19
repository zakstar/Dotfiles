" ==================== SETTINGS ==================== {{{1
" Basic tex {{{2
let maplocalleader = ","
let g:tex_indent_items = 1
let g:tex_indent_and = 1
let g:tex_indent_brace = 1
let g:tex_flavor = 'latex'

" ==================== MAPS AND COMMANDS ==================== {{{1
" Vimtex map {{{2
map <Leader>t :VimtexTocToggle<CR>
map <Leader>c :VimtexCompile<CR>
map <leader>w :VimtexCountWords<CR>

" Templates commands {{{2
command! -bang Templates call fzf#vim#files('~/Documents/Document-Templates/LaTeX', <bang>0)
map <F2> :Templates<CR>

" Code snippets {{{2
inoremap ,dc \documentclass[]{<++>}<CR>\usepackege[utf8]{inputenc}<CR>\usepackage[english]{babel}<Esc>2k$T[i
inoremap ,tad \title{}<CR>\author{Ang Li (Frank)}<CR>\date{\today}<Esc>2k$i
inoremap ,em \emph{}<++><Esc>T{i
inoremap ,bf \textbf{}<++><Esc>T{i
inoremap ,it \textit{}<++><Esc>T{i
inoremap ,un \underline{}<++><Esc>T{i
inoremap ,ol \begin{enumerate}\itemsep0em<CR>\item<Space><CR><Backspace><Backspace>\end{enumerate}<CR><++><Esc>2kA
inoremap ,ul \begin{itemize}\itemsep0em<CR>\item<Space><CR><Backspace><Backspace>\end{itemize}<CR><++><Esc>2kA
inoremap ,li <CR><Backspace>\item<Space>
inoremap ,up <Esc>/usepackage<CR>o\usepackage{}<Esc>i
inoremap ,beg \begin{}<CR><++><CR>\end{<++>}<Esc>2k$i
inoremap ,ft \footnote{}<Esc>T{i
inoremap ,col \begin{multicols}{}<CR><++><CR>\end{multicols}<Esc>2k$i
inoremap ,m $$<++><Esc>2T$i
inoremap ,M \begin{equation}<CR><CR>\end{equation}<CR><++><Esc>2kA<Tab>
inoremap ,ce \ce{}<++><Esc>T{i
inoremap () \left(\right)<Esc>T(i
inoremap ,sec \section{}<Esc>i
inoremap ,subsec \subsection{}<Esc>i
inoremap ,subsubsec \subsubsection{}<Esc>i
inoremap ,img \includegraphics[]{}T[i
inoremap ,fig \begin{figure}[h!]<CR><CR>\caption{<++>}<CR>\label{fig:<++>}<CR>\end{figure}<Esc>3k$i<Tab>
inoremap ,rap \begin{wrapfigure}{}{<++>}<CR><++><CR>\end{wrapfigure}<Esc>2k$i
inoremap ,tab \begin{tabular}{}<CR><++><CR>\end{tabular}<Esc>2k$i
inoremap ,ci \cite{}<Esc>i
inoremap ,pci \parencite{}<Esc>i
inoremap ,gl \Gls{}<Esc>i
inoremap ,kni <<echo=TRUE, cache=TRUE>>=<CR><CR>@<Esc>ki
inoremap "" ``''<Esc>T`i
inoremap ,ax \begin{axis}[<CR>xlabel=$x$,<CR>ylabel={$y$},<CR>width=\linewidth,<CR>height=5cm,<CR>xtick={},<CR>ytick={}<CR>]<CR>\addplot[samples=200]{<++>};<CR>\addlegendentry{$<++>$}<CR>\end{axis}<Esc>2k$F]i
inoremap ,apl <CR>\addplot[samples=200]{<++>};<CR>\addlegendentry{$<++>$}<Esc>k$F]i
inoremap ,che \ce{}<Esc>i
inoremap ,si \si{}<++><Esc>F}i
inoremap ,SI \SI{}{<++>}<++><Esc>2F}i

" HTML Snippets

" Writing the <html> skeleton
nnoremap <leader>html 	:-1read $HOME/.config/nvim/snippet/html/html-skeleton.html<CR>5jf>a
nnoremap <leader>div	i<div><CR><CR></div><ESC>ki
nnoremap <leader>span	i<span></span><ESC>F>a
nnoremap <leader>cl		a class=""<Left>
nnoremap <leader>a		a<a href="#"></a><Esc>F>a
nnoremap <leader>img	a<img src=""><Left><Left>


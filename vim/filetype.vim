if exists("did_load_filetypes")
    finish
endif
augroup filetypedetect
    autocmd!
    autocmd! BufRead,BufNewFile *.md setfiletype markdown
augroup END

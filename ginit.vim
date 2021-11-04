if has('gui_vimr')
    set guifont=FiraCode\ Nerd\ Font\ Mono:h13
" else
    " set guifont=FiraCode\ Nerd\ Font\ Mono:h10
endif


if exists(':GuiFont')
    " Use GuiFont! to ignore font errors
    GuiFont FiraCode\ Nerd\ Font\ Mono:h10
endif

" Disable GUI Tabline
if exists(':GuiTabline')
    GuiTabline 0
endif

" Disable GUI Popupmenu
if exists(':GuiPopupmenu')
    GuiPopupmenu 0
endif

" Enable GUI ScrollBar
if exists(':GuiScrollBar')
    GuiScrollBar 0
endif

augroup vimtrans
    autocmd!
    autocmd User PackerComplete ++once TransparentDisable
augroup end


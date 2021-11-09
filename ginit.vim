if has('gui_vimr')
    set guifont=FiraCode\ Nerd\ Font\ Mono:h13
endif


if exists(':GuiFont')
    " Use GuiFont! to ignore font errors
    if has('win32')
        GuiFont! BlexMono\ NF:h10
    else
        GuiFont! FiraMono\ Nerd\ Font\ Mono:h10
        " GuiLinespace 1
    end
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

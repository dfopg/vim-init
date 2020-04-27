"" 清除所有目录项目
"call quickui#menu#reset()
"
"" 安装一个 File 目录，使用 [名称，命令] 的格式表示各个选项。
"call quickui#menu#install('&File', [
"            \ [ "&New File\tCtrl+n", 'echo 0' ],
"            \ [ "&Open File\t(F3)", 'echo 1' ],
"            \ [ "&Close", 'echo 2' ],
"            \ [ "--", '' ],
"            \ [ "&Save\tCtrl+s", 'echo 3'],
"            \ [ "Save &As", 'echo 4' ],
"            \ [ "Save All", 'echo 5' ],
"            \ [ "--", '' ],
"            \ [ "E&xit\tAlt+x", 'echo 6' ],
"            \ ])
"
"" 每个项目还可以多包含一个字段，表示它的帮助文档，光标过去时会被显示到最下方的命令行
"call quickui#menu#install('&Edit', [
"            \ [ '&Copy', 'echo 1', 'help 1' ],
"            \ [ '&Paste', 'echo 2', 'help 2' ],
"            \ [ '&Find', 'echo 3', 'help 3' ],
"            \ ])
"
"" 在 %{...} 内的脚本会被求值并展开成字符串
"call quickui#menu#install("&Option", [
"			\ ['Set &Spell %{&spell? "Off":"On"}', 'set spell!'],
"			\ ['Set &Cursor Line %{&cursorline? "Off":"On"}', 'set cursorline!'],
"			\ ['Set &Paste %{&paste? "Off":"On"}', 'set paste!'],
"			\ ])
"
"" install 命令最后可以加一个 “权重”系数，用于决定目录位置，权重越大越靠右，越小越靠左
"call quickui#menu#install('H&elp', [
"			\ ["&Cheatsheet", 'help index', ''],
"			\ ['T&ips', 'help tips', ''],
"			\ ['--',''],
"			\ ["&Tutorial", 'help tutor', ''],
"			\ ['&Quick Reference', 'help quickref', ''],
"			\ ['&Summary', 'help summary', ''],
"			\ ], 10000)
"" 
"call quickui#menu#install('&C/C++', [
"            \ [ '&Compile', 'echo 1' ],
"            \ [ '&Run', 'echo 2' ],
"            \ ], '<auto>', 'c,cpp')
"
"" 打开下面选项，允许在 vim 的下面命令行部分显示帮助信息
"let g:quickui_show_tip = 1
"
"" 定义按两次空格就打开上面的目录
"noremap <space><space> :call quickui#menu#open()<cr>


"======================================================================
"
" menu_init.vim -
"
" Created by skywind on 2019/12/26
" Last Modified: 2019/12/26 16:23:48
"
"======================================================================

if has('patch-8.1.2292') == 0 && exists('*nvim_open_win') == 0
	finish
endif

call quickui#menu#reset()

call quickui#menu#install("&File", [
			\ [ "&Open\t(:o ..)", 'call feedkeys(":open ")'],
			\ [ "&Save", 'write'],
			\ [ "--", ],
			\ [ "LeaderF &File\t(A+p)", 'Leaderf file', 'Open file with leaderf'],
			\ [ "LeaderF &Mru", 'Leaderf mru --regexMode', 'Open recently accessed files'],
			\ [ "LeaderF &Buffer", 'Leaderf buffer', 'List current buffers in leaderf'],
			\ [ "--", ],
			\ [ "NERD&Tree\t(S-nt)", 'NERDTree', ''],
			\ ])

call quickui#menu#install("&File", [
			\ [ "--", ],
			\ [ "E&xit\t(:qa)", 'qa' ],
			\ ])

call quickui#menu#install("&Edit", [
			\ ["Tag&Bar\t(l-tb)", 'TagbarToggle'],
			\ ['--', ''],
			\ [ "Goto D&efinition\t(YCM)", 'YcmCompleter GoToDefinitionElseDeclaration'],
			\ [ "Goto &References\t(YCM)", 'YcmCompleter GoToReferences'],
			\ [ "Get D&oc\t(YCM)", 'YcmCompleter GetDoc'],
			\ [ "Get &Type\t(YCM)", 'YcmCompleter GetTypeImprecise'],
			\ ])

call quickui#menu#install("&Pages",[
			\ ["TabN&ew\t(l-tc)",':tabnew'],
			\ ["Tab&Next\t(l-tn)", ':tabnext'],
			\ ["Tab&Prev\t(l-tp)", ':tabprev'],
			\ ["Tab&Close\t(l-tq)",':tabclose'],
			\ ["Tab&Only\t(l-to)", ':tabonly'],
			\ ["--", ''],
			\ ["BufferP&rev\t(l-bp)", ':bp'],
			\ ["BufferNe&xt\t(l-bn)", ':bn'],
			\ ["Buffe&Del\t(l-bd)", ':bd'],
			\ ["--",''],
			\ ["Choose&Win\t(m-e)", 'ChooseWin'],
			\ ])

call quickui#menu#install('&Move', [
			\ ["Quickfix &First\t:cfirst", 'cfirst', 'quickfix cursor rewind'],
			\ ["Quickfix L&ast\t:clast", 'clast', 'quickfix cursor to the end'],
			\ ["Quickfix &Next\t:cnext", 'cnext', 'cursor next'],
			\ ["Quickfix &Previous\t:cprev", 'cprev', 'quickfix cursor previous'],
			\ ["--",''],
			\ ["&CtrlSF *this\tl-f", ':CtrlSF'],
			\ ["CtrlSF &grep\tll-c", 'AsyncTask CtrlSF-grep'],
			\ ])

call quickui#menu#install("&Build", [
			\ ["File &Run\tF4", 'AsyncTask file-build'],
			\ ["File &Build\tF5", 'AsyncTask file-run'],
			\ ['--', ''],
			\ ["Proj&ect build\tF6", 'AsyncTask project-build'],
			\ ["Pro&ject Run\tF7", 'AsyncTask project-run'],
			\ ['--', ''],
			\ ['E&dit Task', 'AsyncTask -e'],
			\ ['Edit &Global Task', 'AsyncTask -E'],
			\ ['&Stop Building', 'AsyncStop'],
			\ ])

call quickui#menu#install('&Debug',[
			\ ["&Begin/Continue\tC-F5", 'call vimspector#Launch()'],
			\ ["Break&Point\tC-F9", 'call vimspector#ToggleBreakpoint()'],
			\ ["&Step\tC-F2", 'call vimspector#StepInto()'],
			\ ["&Close", 'call vimspector#Reset()'],
			\ ])

call quickui#menu#install("&Git", [
			\ ['Show &Log', 'G log'],
			\ ['View &Status', 'Gstatus'],
			\ ['&View Diff', 'Git diff'],
			\ ['File &Add', 'Gwrite'],
			\ ['&Commit', 'Gcommit'],
			\ ['&Push', 'G push'],
			\ ])

call quickui#menu#install('&Tools', [
			\ ['List &Buffer', 'call quickui#tools#list_buffer("FileSwitch tabe")', ],
			\ ['List &Function', 'call quickui#tools#list_function()', ],
			\ ['Display &Messages', 'call quickui#tools#display_messages()', ],
			\ ['--',''],
			\ ["&DelimitMate %{get(b:, 'delimitMate_enabled', 0)? 'Disable':'Enable'}", 'DelimitMateSwitch'],
			\ ['Read &URL', 'call menu#ReadUrl()', 'load content from url into current buffer'],
			\ ['&Spell %{&spell? "Disable":"Enable"}', 'set spell!', 'Toggle spell check %{&spell? "off" : "on"}'],
			\ ['&Profile Start', 'call MonitorInit()', ''],
			\ ['Profile S&top', 'call MonitorExit()', ''],
			\ ["Relati&ve number %{&relativenumber? 'OFF':'ON'}", 'set relativenumber!'],
			\ ["Proxy &Enable", 'call MenuHelp_Proxy(1)', 'setup http_proxy/https_proxy/all_proxy'],
			\ ["Proxy D&isable", 'call MenuHelp_Proxy(0)', 'clear http_proxy/https_proxy/all_proxy'],
			\ ])

call quickui#menu#install('P&lugin', [
			\ ["&Browse in github\trhubarb", "Gbrowse", "using tpope's rhubarb to open browse and view the file"],
			\ ["&Startify", "Startify", "using tpope's rhubarb to open browse and view the file"],
			\ ["&Gist", "Gist", "open gist with mattn/gist-vim"],
			\ ["&Edit Note", "Note", "edit note with vim-notes"],
			\ ["&Display Calendar", "Calendar", "display a calender"],
			\ ['Toggle &Vista', 'Vista!!', ''],
			\ ["-"],
			\ ["Plugin &List", "PlugList", "Update list"],
			\ ["Plugin &Update", "PlugUpdate", "Update plugin"],
			\ ])

call quickui#menu#install('Help (&?)', [
			\ ["&Index", 'tab help index', ''],
			\ ['Ti&ps', 'tab help tips', ''],
			\ ['--',''],
			\ ["&Tutorial", 'tab help tutor', ''],
			\ ['&Quick Reference', 'tab help quickref', ''],
			\ ['&Summary', 'tab help summary', ''],
			\ ['--',''],
			\ ['&Vim Script', 'tab help eval', ''],
			\ ['&Function List', 'tab help function-list', ''],
			\ ['&Dash Help', 'call asclib#utils#dash_ft(&ft, expand("<cword>"))'],
			\ ], 10000)

" let g:quickui_show_tip = 1


"----------------------------------------------------------------------
" context menu
"----------------------------------------------------------------------
let g:context_menu_k = [
			\ ['Cpp&man', 'exec "Cppman " . expand("<cword>")', '', 'c,cpp'],
			\ ["S&earch in Project\t\\cx", 'exec "silent! GrepCode! " . expand("<cword>")'],
			\ [ "--", ],
			\ [ "Find &Definition\t\\cg", 'call MenuHelp_Fscope("g")', 'GNU Global search g'],
			\ [ "Find &Symbol\t\\cs", 'call MenuHelp_Fscope("s")', 'GNU Gloal search s'],
			\ [ "Find &Called by\t\\cd", 'call MenuHelp_Fscope("d")', 'GNU Global search d'],
			\ [ "Find C&alling\t\\cc", 'call MenuHelp_Fscope("c")', 'GNU Global search c'],
			\ [ "Find &From Ctags\t\\cz", 'call MenuHelp_Fscope("z")', 'GNU Global search c'],
			\ [ "--", ],
			\ [ "Goto D&efinition\t(YCM)", 'YcmCompleter GoToDefinitionElseDeclaration'],
			\ [ "Goto &References\t(YCM)", 'YcmCompleter GoToReferences'],
			\ [ "Get D&oc\t(YCM)", 'YcmCompleter GetDoc'],
			\ [ "Get &Type\t(YCM)", 'YcmCompleter GetTypeImprecise'],
			\ ]


"----------------------------------------------------------------------
" hotkey
"----------------------------------------------------------------------
nnoremap <silent><space><space> :call quickui#menu#open()<cr>

nnoremap <silent>K :call quickui#tools#clever_context('k', g:context_menu_k, {})<cr>

if has('gui_running') || has('nvim')
	noremap <c-f10> :call MenuHelp_TaskList()<cr>
endif

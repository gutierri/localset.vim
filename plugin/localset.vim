function! localset#CallSettingsLocal()
python3 << EOF
import vim
import os
import pathlib

PROJECT = os.environ.get('VIM_PROJECT')
if PROJECT:
    VIM_FILE = vim.eval("expand('%:p')")
    CWD = pathlib.Path(VIM_FILE).parent.absolute().resolve()
    dirs = str(CWD).split('/')
    if PROJECT in dirs:
        root_dir = '/'.join(dirs[:dirs.index(PROJECT) + 1])
        local_settings_file = pathlib.Path(root_dir).joinpath('vim.local')
        if local_settings_file.exists():
            vim.command('source {vim_local}'.format(vim_local=local_settings_file.absolute()))
EOF
endfunction

autocmd! BufReadPost,BufNewFile * call localset#CallSettingsLocal()

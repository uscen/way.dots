# =============================================================================== #
# Elvish Modules:                                                                 #
# =============================================================================== #
use platform
use readline-binding

# =============================================================================== #
# General Env:                                                                    #
# =============================================================================== #
set E:CC = "gcc"
set E:LANG = "en_US.UTF-8"
set E:LC_ALL = "C.UTF-8"
set E:EDITOR = "nvim"
set E:VISUAL = "nvim"
set E:PAGER = "less"
set E:LESS = "-i -R"
set E:LESSHISTFILE = -
set E:TERMINAL = "alacritty"
set E:BROWSER = "firefox"
set E:FZF_DEFAULT_OPTS = "
    --prompt='󱓇  ' --layout=reverse
    --preview-window=right,30%
    --style=minimal --height=100% --border --preview-window right,40%
    --color fg:#DBD2C7,bg:#172526
    --color bg+:#233935,fg+:#DBD2C7
    --color hl:#88B497,hl+:#88B497,gutter:#172526
    --color pointer:#233935,info:#233935
    --color prompt:#88B497,
    --color border:#233935
    --bind 'tab:accept'
"
set E:_ZO_FZF_OPTS = $E:FZF_DEFAULT_OPTS

# =============================================================================== #
# Plathform Env:                                                                  #
# =============================================================================== #
if (eq $platform:os windows) {
  set-env HOME $E:USERPROFILE
  set-env USER $E:USERNAME
} else {
  set-env TMPDIR '/tmp'
}

# =============================================================================== #
# Elvish clean ~:									                                                #
# =============================================================================== #
set E:INPUTRC = $E:HOME"/.bash/inputrc"
set E:HISTFILE = $E:HOME"/.bash/history"
set E:GIT_CONFIG_GLOBAL = $E:HOME"/.others/gitconfig"
set E:WGETRC = $E:HOME"/.others/wgetrc"
set E:CARGO_HOME = $E:HOME"/.local/share/cargo"
set E:GOPATH = $E:HOME"/.local/share/go"
set E:GOMODCACHE = $E:HOME"/.cache/go/mod"
set E:PYTHONSTARTUP = $E:HOME"/.config/python/pythonrc"
set E:SQLITE_HISTORY = $E:HOME"/.local/share/sqlite_history"
set E:MYVIMRC = $E:HOME"/.config/nvim/init.lua"
set E:RIPGREP_CONFIG_PATH  = $E:HOME"/.config/ripgrep/rc"

# =============================================================================== #
# Helpers:                                                                        #
# =============================================================================== #
fn match {|seed|
    var inputs = [(all)]
    var results = []
    for matcher [$edit:match-prefix~ $edit:match-substr~ $edit:match-subseq~] {
        set results = [(put $@inputs | $matcher &smart-case $seed)]
        if (or $@results) {
            put $@results
            return
        }
    }
    put $@results
}
fn fzf_history {
  use str
  tmp E:SHELL = 'elvish'
  var key line @ignored = (str:split "\x00" (
    edit:command-history &dedup &newest-first |
    each {|cmd| printf "%s %s\x00" $cmd[id] $cmd[cmd] } |
    try {
      fzf --no-multi --no-sort --read0 --print0 --info-command="print History" ^
      --scheme=history --expect=tab,ctrl-d --exact ^
      --bind 'down:transform:if (<= $E:FZF_POS 1) { print abort } else { print down }' ^
      --query=$edit:current-command | slurp
    } catch {
      edit:redraw &full=$true
      return
    }
  ))
  edit:redraw &full=$true
  var id command = (str:split &max=2 ' ' $line)
  if (eq $key 'ctrl-d') {
    store:del-cmd $id
    edit:notify 'Deleted '$id
  } else {
    edit:replace-input $command

    if (not-eq $key 'tab') {
      edit:return-line
    }
  }
}
fn fzf_cd {
  try {
    cd (fd --type d --strip-cwd-prefix  --max-depth 9  --no-ignore -0 | fzf --read0)
  } catch {
    edit:redraw &full=$true
    return
  }
}

# =============================================================================== #
# Insert:                                                                         #
# =============================================================================== #
set edit:insert:binding[Ctrl-b] = { edit:move-dot-left-word }
set edit:insert:binding[Ctrl-w] = { edit:move-dot-right-word }
set edit:insert:binding[Ctrl-d] = { edit:kill-small-word-left }
set edit:insert:binding[Ctrl-n] = { edit:navigation:start; edit:navigation:trigger-filter }
set edit:insert:binding[Ctrl-y] = { edit:-instant:start; edit:close-mode }
set edit:insert:binding[Ctrl-x] = { edit:-instant:start }
set edit:insert:binding[Ctrl-t] = { edit:history:start }
set edit:insert:binding[Ctrl-v] = { edit:command:start }
set edit:insert:binding[Ctrl-Enter] = { edit:insert-at-dot "\n" }
set edit:insert:binding[Ctrl-Delete] = { edit:move-dot-right-word; edit:kill-word-left }

# =============================================================================== #
# Fzf:                                                                            #
# =============================================================================== #
set edit:insert:binding[Alt-c] = { fzf_cd }
set edit:insert:binding[Ctrl-r] = { fzf_history }

# =============================================================================== #
# Completion:                                                                     #
# =============================================================================== #
set edit:completion:binding[Ctrl-u] = { edit:close-mode }
set edit:completion:binding[Ctrl-y] = { edit:completion:accept }
set edit:completion:binding[Ctrl-v] = { edit:close-mode; edit:command:start }
set edit:completion:binding[Enter] = { edit:completion:accept; edit:return-line }

# =============================================================================== #
# Command:                                                                        #
# =============================================================================== #
set edit:command:binding[Ctrl-u] = { edit:close-mode; edit:kill-line-left; edit:command:start }
set edit:command:binding[d] = { edit:close-mode; edit:kill-line-left; edit:command:start }
set edit:command:binding[A] = { edit:move-dot-eol; edit:close-mode }
set edit:command:binding[I] = { edit:move-dot-sol; edit:close-mode }
set edit:command:binding[u] = { edit:close-mode; edit:kill-line-left }
set edit:command:binding[e] = { edit:move-dot-right-small-word }
set edit:command:binding[k] = { edit:history:start; edit:history:up }
set edit:command:binding[j] = { edit:history:start; edit:history:down }

# =============================================================================== #
# history:                                                                        #
# =============================================================================== #
set edit:history:binding[Ctrl-y] = { edit:history:accept }
set edit:history:binding[k] = { edit:history:up }
set edit:history:binding[j] = { edit:history:down }

# =============================================================================== #
# Location:                                                                       #
# =============================================================================== #
set edit:location:binding[Ctrl-u] = { edit:close-mode }

# =============================================================================== #
# Others:                                                                         #
# =============================================================================== #
set edit:max-height = 25
set notify-bg-job-success = $false
set edit:completion:matcher[''] = $match~

# =============================================================================== #
# Paths:                                                                          #
# =============================================================================== #
if (eq $platform:os windows) {
  set paths = [
    'C:\Program Files\Git\bin'
    C:\Windows\System32
    C:\Windows\System32\OpenSSH
    C:\Windows\System32\WindowsPowerShell\v1.0
    C:$E:HOMEPATH\scoop\apps\mingw\current\bin
    C:$E:HOMEPATH\scoop\apps\nodejs-lts\current\bin
    C:$E:HOMEPATH\scoop\apps\nodejs-lts\current\bin
    C:$E:HOMEPATH\scoop\shims
    C:$E:HOMEPATH\config\bin
    C:$E:HOMEPATH\bin
    $@paths
  ]
} else {
  set paths = [
    /bin
    /usr/bin
    $E:HOME/bin
    $E:HOME/.config/bin
    $@paths
  ]
}

# =============================================================================== #
# Extrnal:                                                                        #
# =============================================================================== #
eval (zoxide init elvish | slurp)
eval (carapace _carapace | slurp)

# =============================================================================== #
# Prompt:                                                                         #
# =============================================================================== #
set edit:prompt = { styled (tilde-abbr $pwd) bright-blue bold; styled ' λ ' bright-cyan dim }
set edit:rprompt = { nop }

# =============================================================================== #
# Abbreviations:                                                                  #
# =============================================================================== #
set edit:abbr['||'] = '| less'
set edit:abbr['>dn'] = '2>/dev/null'
set edit:abbr['>eo'] = '2>&1'
set edit:command-abbr['cd'] = 'z'
set edit:command-abbr['lz'] = 'lazygit'
set edit:command-abbr['curld'] = 'curl --retry 5 -L -C -'
set edit:command-abbr['edit'] = 'nvim'

# =============================================================================== #
# Elvish Aliases:                                                                 #
# =============================================================================== #
# =============================================================================== #
# Reset:                                                                          #
# =============================================================================== #
fn cls { edit:clear }
fn clear { print "\e[H\e[2J\e[3J" }
fn reset { print "\033c" }

# =============================================================================== #
# Fetch:                                                                          #
# =============================================================================== #
fn fetch { fastfetch }
fn neofetch { fastfetch }

# =============================================================================== #
# Zoxide:                                                                         #
# =============================================================================== #
fn ... { z ~ }
fn .. { z .. }
fn ../ { z .. }
fn ../../ { z ../.. }

# =============================================================================== #
# Configs:                                                                        #
# =============================================================================== #
fn dots { cd $E:HOME/.local/way.dots }
fn bashc { nvim $E:HOME/.local/way.dots/void-dotfiles/home/.bash/bashrc }
fn wmc { nvim $E:HOME/.local/way.dots/void-dotfiles/cfg/niri/config.kdl }
fn elvc { nvim $E:HOME/.local/way.dots/void-dotfiles/cfg/elvish/rc.elv }

# =============================================================================== #
# Eza:                                                                            #
# =============================================================================== #
fn ls {|@a| e:eza --long --group --icons=auto --git --sort=name --group-directories-first $@a }
fn ll {|@a| e:eza --long --group --icons=auto --git --sort=name --group-directories-first $@a }
fn lt {|@a| e:eza --long --group --icons=auto --git --only-dirs --tree --level=3 --sort=modified $@a }

# =============================================================================== #
# Bat:                                                                            #
# =============================================================================== #
fn b {|@a| e:bat $@a }
fn bn {|@a| e:bat --number $@a }
fn bnl {|@a| e:bat --number --line-range $@a }
fn bp {|@a| e:bat --plain $@a }
fn bpl {|@a| e:bat --plain --line-range $@a }
fn bl {|@a| e:bat --line-range $@a }

# =============================================================================== #
# Editor:                                                                         #
# =============================================================================== #
fn v {|@a| e:nvim $@a }
fn vi {|@a| e:nvim $@a }
fn nv {|@a| e:nvim $@a }
fn vn {|@a| e:nvim $@a }
fn vm {|@a| e:nvim $@a }
fn vim {|@a| e:nvim $@a }
fn vd {|@a| e:neovide & }
fn nd {|@a| e:neovide & }

# =============================================================================== #
# Services:                                                                       #
# =============================================================================== #
fn svenable {|@a| e:doas ln -sfv /etc/sv/$a[0] /var/service/ }
fn svdisable {|@a| e:doas unlink /var/service/$a[0] }
fn svstatus {|@a| e:doas sv status /var/service/* }

# =============================================================================== #
# Packages:                                                                       #
# =============================================================================== #
fn pu {|@a| e:doas xbps-install -Syu xbps; doas xbps-install -Su $@a }
fn pi {|@a| e:doas xbps-install -S $@a }
fn pr {|@a| e:doas xbps-remove -Rcon $@a }
fn pq {|@a| e:xbps-query -Rs $@a }
fn pl {|@a| e:xbps-query -l $@a }
fn pc {|@a| e:doas xbps-remove -Oo $@a }
fn pclean {|@a| e:doas rm -rf /var/cache/xbps/* $@a }

# =============================================================================== #
# Bun:                                                                            #
# =============================================================================== #
fn buna {|@a| e:bun add $@a }
fn bunr {|@a| e:bun remove $@a }
fn bunu {|@a| e:bun update $@a }
fn buni {|@a| e:bun install $@a }
fn bun-run {|@a| e:bun run $@a }
fn bun-dev {|@a| e:bun --bun run dev $@a }

# =============================================================================== #
# Pnpm:                                                                           #
# =============================================================================== #
fn p {|@a| e:pnpm $@a }
fn px {|@a| e:pnpm dlx $@a }

# =============================================================================== #
# Git:                                                                            #
# =============================================================================== #
fn g {|@a| e:git $@a }
fn gi {|@a| e:git init $@a }
fn gs {|@a| e:git status $@a }
fn ga {|@a| e:git add --all $@a }
fn ge {|@a| e:git clone $@a }
fn gc {|@a| e:git commit -m $@a }
fn gd {|@a| e:git diff $@a }
fn gl {|@a| e:git log --oneline --graph --all -10  $@a }
fn gb {|@a| e:git branch $@a }
fn gp {|@a| e:git push -uf origin main $@a }
fn gf {|@a| e:git fetch $@a }
fn gg {|@a| e:git pull $@a }
fn gr {|@a| e:git switch $@a }
fn lg {|@a| e:lazygit $@a }

# =============================================================================== #
# Others:                                                                         #
# =============================================================================== #
fn yt-concats {|@a| e:yt-dlp --ignore-config --config-locations ~/.config/yt-dlp/playlist $@a }
fn yt-music {|@a| e:yt-dlp --ignore-config --config-locations ~/.config/yt-dlp/music $@a }
fn dev {|@a| browser-sync start --no-notify --server --files "**/*.html, **/*.css", "**/*.js" $@a }
fn msg { |@a| echo (styled "👉🏼 "$@a bold italic yellow) }
fn rm {|@a| e:trash-put $@a }
fn man {|@a| e:tldr $@a }
fn cat {|@a| e:bat $@a }

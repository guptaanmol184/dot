try{if(Get-Command scoop){}} catch {iex (new-object net.webclient).downloadstring('https://get.scoop.sh')}
scoop install git
scoop bucket add extras
scoop bucket add knox-scoop https://git.irs.sh/KNOXDEV/knox-scoop
scoop bucket add main
scoop bucket add nerd-fonts
scoop install 7zip
scoop install archwsl
scoop install aria2
scoop install bugn
scoop install cacert
scoop install conemu
scoop install coreutils
scoop install curl
scoop install eartrumpet
scoop install everything-lite
scoop install far
scoop install firacode-nf
scoop install freecommander
scoop install grep
scoop install hack-nf
scoop install ilspy
scoop install keypirinha
scoop install less
scoop install lessmsi
scoop install licecap
scoop install meslo-nf
scoop install neovim
scoop install notepadplusplus
scoop install paint.net
scoop install posh-git
scoop install quicklook
scoop install qutebrowser
scoop install scoop-backup
scoop install sed
scoop install sharex
scoop install sourcecodepro-nf
scoop install speedcrunch
scoop install sysinternals
scoop install vlc
scoop install vscode
scoop install wget
scoop install sudo
sudo powershell -Command "scoop install --global hack-nf;scoop install --global sudo;scoop install --global Ubuntu-NF"


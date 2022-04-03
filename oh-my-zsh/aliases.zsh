# compilers, repl, etc.
# alias python="python3"

# networking
alias get-ports="netstat -tulnp | grep LISTEN"
alias get-router="ip route | grep default"
alias get-ip="hostname -I"

# directories
# alias goto-dev="cd ~/dev/"

# zsh
alias zsh-edit="$EDITOR $HOME/.zshrc"
alias refreshenv="source $HOME/.zshrc"

# git aliases in ~/.gitconfig

# misc
alias export-env="export \$(cat .env)"

mkdircd() {
  mkdir $1
  cd $1
}

# backup file
bak() {
  cp $1{,.bak}
}

# add to path
path-add() {
  export PATH=$PATH:$1
}

# add all permissions
perm-all() {
  chmod -R 777 $1
}

# change owner to me
claim() {
  sudo chown -R $USER $1
}

# file size
file-size() {
  du -h $1
}

# directory size
dir-size() {
  du -hs $1
}

# tar
compress() {
  tar -czvf archive.tar.gz $1
}
decompress() {
  tar -zxv -f $1
}

# search and use bat as a previewer
if [[ -x "$(command -v fzf)" ]] && [[ -x "$(command -v bat)" ]]; then
  alias fp="fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}'"
  alias supersearch=fp
fi

# base64 -> jwt (requires jq: sudo apt-get install jq)
if [ -x "$(command -v jq)" ]; then
  decode_base64_url() {
    local len=$((${#1} % 4))
    local result="$1"
    if [ $len -eq 2 ]; then result="$1"'=='
    elif [ $len -eq 3 ]; then result="$1"'=' 
    fi
    echo "$result" | tr '_-' '/+' | openssl enc -d -base64
  }
  decode_jwt(){
    decode_base64_url $(echo -n $2 | cut -d "." -f $1) | jq .
  }
  # Decode JWT header
  alias jwth="decode_jwt 1"
  # Decode JWT Payload
  alias jwtp="decode_jwt 2"
fi

# colorls: https://github.com/athityakumar/colorls#installation
if [ -x "$(command -v colorls)" ]; then
    alias ls="colorls"
    alias la="colorls -al"
fi

# diff-so-fancy: https://github.com/so-fancy/diff-so-fancy#install
if [ -x "$(command -v diff-so-fancy)" ]; then
  diffs() {
    diff -u $1 $2 | diff-so-fancy
  }
fi

# docker
if [ -x "$(command -v docker)" ]; then
    alias dw="watch \"docker ps --format \\\"table {{.Names}}\t{{.Status}}\\\" -a\""
fi

# ! WSL2 only, set username
# alias cd-windows="cd \"/mnt/c/Users/twj/Documents/\""

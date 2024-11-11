# export GOPATH=$HOME/sdk/go1.21.10
# export GOPATH=/usr/local/go
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
export PATH=$HOME/stripe/bin:$PATH
export PATH=$GOBIN:$PATH

export SC_SECRETS_TEAM=1
alias pandorabuild='cd ~/stripe/minitrue; go install ./cmd/pandora; cd -'
alias pandoractlbuild='cd ~/stripe/minitrue; go build -o pandoractl cmd/pandoractl/main.go; cd -'
alias pandoracli='/usr/local/bin/pandora'
alias pandora-migrate="cd ~/stripe/gocode && time bazel run //security/confidant/migrate-v2 --"
export PANDORA_FLAGS='-Mq --host-type pandoracanarybox --user-acls secret-acl-secrets-infra-testing'

alias terraform=$HOME/stripe/gocode/bazel-bin/external/terraform_0_13_7/terraform_0.13.7

export MINITRUE=$HOME/stripe/minitrue
export GOCODE=$HOME/stripe/gocode
export PAYSERVER=$HOME/stripe/pay-server
export ZOOLANDER=$HOME/stripe/zoolander
export PUPPETCONFIG=$GOCODE/puppet-config

export PATH=$MINITRUE/bin:$PATH

function b() {
  lgi --no-detect-repo 'path:/(prod|qa|preprod).yaml'
}

function refresh() {
	str="$(git -C $1 branch 2>/dev/null | grep '^*' | sed s/..//)"
  if [ $str == "master" ]
  then
    git -C $1 pull
  else
    git -C $1 fetch origin master:master
  fi
}

function dualsign() {
  set +x
  if [[ -z "$1" ]]; then
    echo "domain required as first arg"
    return
  fi
  if [[ -z "$2" ]]; then
    echo "user required as second arg"
    return
  fi
  ROLE=$3
  if [[ -z "$3" ]]; then
    ROLE=deploy
  fi

  cd $GOCODE
  sc-env -r $ROLE $1
  eval $(sc-aws-environment)
  go run ./dual-access/cmd/multisign grant --action assume-$ROLE-role --user $2 | pbcopy
  sc-env --deactivate
  cd -
}

function dualsign_minitrue() {
  dualsign stripe-ca.com $1 $2
}

function dualsign_pandora() {
  dualsign secrets.stripe.net $1 $2
}

function daily_script() {
  echo "Running daily script"
  sc-2fa get --if-needed --reason="Daily bashrc setup"
  echo "git pull -C $PAYSERVER"
  refresh $PAYSERVER
  echo "git pull -C $ZOOLANDER"
  refresh $ZOOLANDER
  echo "git pull -C $GOCODE"
  refresh $GOCODE
  echo "pandorabuild"
  refresh $MINITRUE
  pandorabuild
  echo "Done running daily script"
}

if [[ ! -e /tmp/$(date +%m-%d).sem ]]
then
    touch /tmp/$(date +%m-%d).sem
    daily_script
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

source sc-aliases

#!/bin/sh -l

git_setup() {
  cat <<- EOF > $HOME/.netrc
		machine github.com
		login $GITHUB_ACTOR
		password $GITHUB_TOKEN
		machine api.github.com
		login $GITHUB_ACTOR
		password $GITHUB_TOKEN
EOF
  chmod 600 $HOME/.netrc

  git config --global user.email "$GITHUB_ACTOR@users.noreply.github.com"
  git config --global user.name "$GITHUB_ACTOR"

  : ${INPUT_PUSH_BRANCH:=`echo "$GITHUB_REF" | awk -F / '{ print $3 }' `}
}

git_setup

# debug
#echo username — $GITHUB_ACTOR, branch — $INPUT_BRANCH, commit message — $INPUT_COMMIT_MESSAGE
#echo $(cat $HOME/.netrc)

git remote update
git fetch --all

# Will create branch if it does not exist
if [[ $( git branch -r | grep "$INPUT_BRANCH" ) ]]; then
   git checkout "${INPUT_BRANCH}"
else
   git checkout -b "${INPUT_BRANCH}"
fi

git add .
git commit -m "${INPUT_COMMIT_MESSAGE}"
git push --set-upstream origin "${INPUT_BRANCH}"

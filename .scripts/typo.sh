#!/bin/zsh

echo '################################################################\n'
figlet 'TYPO   m9(^Д^)'
echo '################################################################\n'

chara=`shuf -n 1 -e /usr/local/Cellar/cowsay/3.04_1/share/cows/*.cow | xargs basename`

msg="
Holy sit, you ruined everything. Like everything you do.
This typo is like your life.
Beginning a lot of things, left undone.
And nobody loves you.
"

cowsay -f $chara "$msg"

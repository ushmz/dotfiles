#!/bin/zsh

echo '################################################################' | lolcat -p 0.5 -t -F 0.1 -s 42
toilet "  TYPO      m9(^Д^) " | lolcat -p 0.5 -t -F 0.1 -s 42 -a
echo '################################################################\n' | lolcat -p 0.5 -t -F 0.1 -s 42

# chara=`shuf -n 1 -e /usr/local/Cellar/cowsay/3.04_1/share/cows/*.cow | xargs basename`

msg="
Holy sit, you ruined everything. Like everything you do.
This typo is like your life.
Beginning a lot of things, left undone.
And nobody loves you.
"

# cowsay -f $chara "$msg" | lolcat -p 0.5 -t -s 42
cowsay "$msg"

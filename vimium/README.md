# vimium

[philc/vimium: The hacker's browser.](https://github.com/philc/vimium)


## install

- [Chrome Extension](https://chrome.google.com/webstore/detail/vimium/dbepggeogbaibhgnhhndojpepiihcmeb)
- [Firefox Add-on](https://addons.mozilla.org/en-GB/firefox/addon/vimium-ff/)


## Tips

### ページがもともと持っているショートカットと競合する

- `i` で vimium を黙らせる．
- `Esc` でもとに戻す．


### iframe にフォーカスした

- `gf` でフォーカスするフレームを切り替える
- `gF` でルートのフレームに戻れる


### アドレスバーにフォーカスした

ブラウザの Search Engine の設定で以下を追加
|Key|Value|
|:-:|:-:|
|Search engine|(任意)|
|Keyword|j|
|URL|`javascript:`|

`j` -> `Enter` で戻ってこれる


### ちょっとURLいじりたい

`ge` を使う


### 1階層上に上がる

`gu`, `gU` とかを使う


### 見た目

CSS をいい感じにいじる．
あるいは[Wiki](https://github.com/philc/vimium/wiki/Theme) からお好みのテーマを使う．
おすすめは [ysjn/vimium-simply-dark: Dark theme for vimium chrome extension.](https://github.com/ysjn/vimium-simply-dark)

サブフレーム内ではテーマ聞かなかったりするらしいです．

# vimium

[philc/vimium: The hacker's browser.](https://github.com/philc/vimium)

## install

- [Chrome Extension](https://chrome.google.com/webstore/detail/vimium/dbepggeogbaibhgnhhndojpepiihcmeb)
- [Firefox Add-on](https://addons.mozilla.org/en-GB/firefox/addon/vimium-ff/)

## Tips

### Avoid conflicting with webpage's own shortcut keys

- Press `i` to disable vimium key-binds temporary.
- Press `Esc` to anable vimium again.

### Escape from iframe

- Press `gf` to switch frames to focus.
- Press `gF` to go back to root frame.

### Escape from address bar

Add following as a custom search engine.

|Key|Value|
|:-:|:-:|
|Search engine|(any)|
|Keyword|j|
|URL|`javascript:`|

Press `j` -> `Enter` to go back to browser's contents area.

### Edit URL directly

Press `ge` to edit.

### Go to parent URL

Press `gu`, ( `gU` to root)

e.g.
`gu` : https://github.com/ushmz/dotfiles -> https://github.com/ushmz
`gU` : https://github.com/ushmz/dotfiles -> https://github.com

### Appearance

Edit CSS option to apply.
You can find themes from [Wiki](https://github.com/philc/vimium/wiki/Theme)
([ysjn/vimium-simply-dark](https://github.com/ysjn/vimium-simply-dark) looks good for me.)

CSS option doesn't take effect in sub-flame.

# Utility Scripts

Trivial scripts that keeps me refrain from little things.

## scripts

### tmux status line

- battery
- load_ave
- ssid

### cmdnotif

Notify you in slack when finish commands execution that takes long time.
Rust version is [here](https://github.com/ushmz/hicaq).

#### Setup

```shell
echo 'export CMD_NOTIFY_SLACK_WEBHOOK_URL="{workspace webhook URL}"' >> ~/.zshenv
echo 'export CMD_NOTIFY_SLACK_USER_NAME="{slackID to notify(mention)}"' >> ~/.zshenv
echo 'source /path/to/cmdnotif' >> ~/.zshec
```

#### References

- [時間がかかるコマンドの実行結果をSlackに通知する](https://qiita.com/izumin5210/items/c683cb6addc58cae59b6)
- [時間がかかるコマンドを実行した後に通知する - handlename's blog](http://handlename.hatenablog.jp/entry/2013/02/02/190720)
- [時間がかかるコマンドが終了したときに Beep! - f99aq8oveのブログ](http://f99aq.hateblo.jp/entry/20080101/1199196416)
- [Message Attachments | Slack](https://api.slack.com/docs/attachments)

### mux.sh

Script for make tmux session and split pane.

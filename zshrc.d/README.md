# zshrc

## slack notify

Notify you in slack on finish commands that takes long time.

### Setup

```shell
echo 'export CMD_NOTIFY_SLACK_WEBHOOK_URL="{workspace webhook URL}"' >> ~/.zshenv
echo 'export CMD_NOTIFY_SLACK_USER_NAME="{slackID to notify(mention)}"' >> ~/.zshenv
```

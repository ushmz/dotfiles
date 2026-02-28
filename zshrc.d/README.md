# zshrc

## slack notify

Notify you in slack on finish commands that takes long time.

### Setup

```shell
echo 'export SLACK_NOTIFY_WEBHOOK_URL="{workspace webhook URL}"' >> ~/.zshenv
echo 'export SLACK_NOTIFY_USER_NAME="{slackID to notify(mention)}"' >> ~/.zshenv
```

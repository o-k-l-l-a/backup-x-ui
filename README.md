
 simple script to back up the x-ui database and send it to Telegram via a SOCKS5 proxy.

 Features

- Automatically sends `/etc/x-ui/x-ui.db` file to your Telegram chat
- Uses SOCKS5 proxy for the Telegram API requests
- Includes server IPv4 in the backup caption
- Runs every 2 hours using a cron job

 Usage

 Clone the repository and run setup

```bash
git clone https://github.com/o-k-l-l-a/backup-x-ui.git
cd backup-x-ui
bash setup.sh
````

 Or download and run setup directly

```bash
bash <(curl -Ls https://raw.githubusercontent.com/o-k-l-l-a/backup-x-ui/main/setup.sh | tr -d '\r')
```

You will be prompted to enter:

* Telegram Bot Token (e.g. `123456:ABC-DEF`)
* Telegram Chat ID (number, can be negative)
* SOCKS5 Proxy IP (e.g. `127.0.0.1`)
* SOCKS5 Proxy Port (e.g. `3434`)

This will create the `backup.sh` script and schedule it via cron to run every 2 hours.

 Files

* `setup.sh`: Setup script that creates the backup script and cron job
* `backup.sh`: Backup script sending the x-ui database to Telegram (auto-generated)

 Notes

* Default backup file path is `/etc/x-ui/x-ui.db`. If yours is different, edit `backup.sh` accordingly.
* Ensure `curl` is installed on your server.

---

Feel free to open issues or contribute!


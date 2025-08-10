#!/bin/bash
set -e

echo "Setup Telegram backup script with SOCKS5 proxy"
read -p "Telegram bot token (e.g. 123456:ABC-DEF): " TOKEN
read -p "Telegram chat_id (number, can be negative): " CHAT_ID
read -p "SOCKS5 proxy IP (e.g. 127.0.0.1): " PROXY_HOST
read -p "SOCKS5 proxy port (e.g. 3434): " PROXY_PORT

FILE_PATH="/etc/x-ui/x-ui.db"
SCRIPT_PATH="/root/backup.sh"

cat > "$SCRIPT_PATH" <<EOF
#!/bin/bash
DATE=\$(date '+%Y-%m-%d %H:%M:%S')
IPV4=\$(curl -4 -s https://ipv4.icanhazip.com)
CAPTION="📦 x-ui backup
📅 \${DATE}
📂 ${FILE_PATH}
🌐 IPv4: \${IPV4}
💻 Server: Iran"

curl --socks5-hostname ${PROXY_HOST}:${PROXY_PORT} \\
     -F chat_id="${CHAT_ID}" \\
     -F document=@"${FILE_PATH}" \\
     -F caption="\${CAPTION}" \\
     https://api.telegram.org/bot${TOKEN}/sendDocument
EOF

chmod +x "$SCRIPT_PATH"

# Add cron job if not present
(crontab -l 2>/dev/null | grep -F "$SCRIPT_PATH" >/dev/null) || \
(crontab -l 2>/dev/null; echo "0 */2 * * * bash $SCRIPT_PATH") | crontab -

echo "✅ Setup complete. Script created at $SCRIPT_PATH and scheduled to run every 2 hours."

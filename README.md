# 🩺 System Health Monitoring Tool (Bash + Docker + Slack)

A simple yet powerful Bash script that monitors:

- 🧠 Memory usage
- 💽 Disk usage
- 🔥 CPU Load
- 🔐 Logged-in Users
- ⏱️ System Uptime
- 📢 Slack Alerts (Optional)
- 🐳 Dockerized

## 📁 Folder Structure

```
.
├── system_health_check.sh        # Main script
├── slack_alert.sh                # Slack integration
├── Dockerfile                    # Docker container setup
└── README.md
```

## ⚙️ Prerequisites

- Ubuntu or Linux system
- Bash
- `bc`, `curl`, `df`, `free`, `uptime`, `who`
- Docker (optional)

Install missing tools:

```bash
sudo apt update
sudo apt install bc curl
```

## 🚀 How to Run

### Locally

```bash
chmod +x system_health_check.sh
./system_health_check.sh
```

### Via Docker

```bash
docker build -t sys-health-check .
docker run --rm sys-health-check
```

## 🔔 Slack Integration (Optional)

1. Create an [Incoming Webhook in Slack](https://api.slack.com/messaging/webhooks)
2. Replace your Webhook URL inside `slack_alert.sh`
3. Make it executable:

```bash
chmod +x slack_alert.sh
```

## ⏱️ Cron Scheduling

```bash
crontab -e
```

Run every day at 9AM:

```
0 9 * * * /path/to/system_health_check.sh >> /path/to/system_health.log
```

## 📌 Author

Koushik

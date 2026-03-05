#!/bin/bash

# 1. Setup Git configuration
git config --global user.email "cutestar.panda@gmail.com"
git config --global user.name "Nirupam Gayen"

# 2. Clone your private memory repository
git clone https://${GITHUB_TOKEN}@github.com/nirupamdev/openclaw-memory ~/.openclaw/workspace

# 3. Bypass security for cloud deployment
openclaw config set gateway.controlUi.dangerouslyAllowHostHeaderOriginFallback true --strict-json

# 4. START THE GATEWAY IN THE BACKGROUND
openclaw gateway --bind lan --port 8080 --allow-unconfigured --auth token --token "${GITHUB_TOKEN}" &

# 5. WAIT 15 SECONDS FOR IT TO START, THEN AUTO-APPROVE TELEGRAM
# Replace [YOUR_CODE] with the code from your Telegram screenshot (starts with V)
sleep 15
openclaw pairing approve telegram [W4N4MQAC]

# 6. Keep the script alive and auto-sync memory
while true; do
  sleep 300
  cd ~/.openclaw/workspace
  git add .
  git commit -m "Auto-saving agent memory"
  git push
done

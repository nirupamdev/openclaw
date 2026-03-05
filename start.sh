#!/bin/bash

# 1. Setup Git configuration
git config --global user.email "cutestarpanda@gmail.com"
git config --global user.name "Nirupam Gayen"

# 2. Clone your private memory repository into the OpenClaw workspace
git clone https://${GITHUB_TOKEN}@github.com/nirupamdev/openclaw-memory.git ~/.openclaw/workspace

# 3. Bypass the strict Control UI origin check for cloud deployments
openclaw config set gateway.controlUi.dangerouslyAllowHostHeaderOriginFallback true --strict-json

# 4. Start the OpenClaw Gateway with LAN bind + explicit Auth Token
openclaw gateway --bind lan --port 8080 --allow-unconfigured --auth token --token "${GITHUB_TOKEN}" &

# 5. Auto-sync memory every 5 minutes to prevent data loss
while true; do
  sleep 300
  cd ~/.openclaw/workspace
  git add .
  git commit -m "Auto-saving agent memory"
  git push
done

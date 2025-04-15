sudo apt update
sudo apt install nodejs npm -y
sudo npm install -g green-tunnel
green-tunnel
nano ~/.config/green-tunnel/config.json
{
"whitelist": ["discord.com", "example.com"]
}
green-tunnel --whitelist

sudo apt-get update && sudo apt-get upgrade -y

# Install basic packages 
sudo apt install ufw git mosh speedtest-cli  -y 

# Allow password login
# Enter new password manually
sudo passwd
sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
sudo systemctl restart sshd

# Setup firewall
sudo ufw enable
sudo ufw allow ssh
sudo ufw allow 60000:61000/udp
sudo ufw allow 5000/tcp

# Install python dependencies
sudo apt install python3-flask
sudo apt install python3-pygame

# Clone this repo
git clone https://github.com/aivantg/scavenger-hunt-audio-server.git
cd scavenger-hunt-audio-server

# Copy music server to home directory
cp -R music_server ..

# Set and save volume settings
amixer -c 2 set PCM 100%
sudo alsactl store

# Set up system services
sudo cp setup/alsa_restore.service /etc/systemd/system/alsa_restore.service
sudo cp setup/music_server.service /etc/systemd/system/music_server.service
sudo systemctl daemon-reload
sudo systemctl enable alsa_restore
sudo systemctl enable music_server

# Copy over wifi settings 
# Add wifi credentials
sudo cp setup/wpa_supplicant.conf /etc/wpa_supplicant/wpa_supplicant.conf
sudo systemctl restart networking

# Reboot
sudo systemctl reboot








## Assumes you've just run the following: 
# git clone https://github.com/aivantg/scavenger-hunt-audio-server.git
# cd scavenger-hunt-audio-server
# source setup_pi.sh

sudo apt-get update && sudo apt-get upgrade -y

# Install basic packages 
sudo apt install ufw git mosh python3-flask python3-pygame -y 

# Allow password login
# Enter new password manually
sudo passwd
# Uncomment line "PasswordAuthentication yes" in /etc/ssh/sshd_config automatically
sudo sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/g' /etc/ssh/sshd_config

# Setup firewall
sudo ufw enable
sudo ufw allow ssh
sudo ufw allow 60000:61000/udp
sudo ufw allow 5000/tcp

# Copy music server to home directory
cp -R music_server ..

# Set and save volume settings
# may need to adjust to ensure correct sound card is being used
# `sudo aplay -l` shows sound card options, replace '2' with correct card number
# `sudo alsamixer` shows UI for adjusting volume. Match `PCM` with the name of the volume control. 
# Either 'PCM' or 'Master' are common.
amixer -c 2 set PCM 100% 
sudo alsactl store

# Set up music server to start on boot
sudo cp setup/alsa_restore.service /etc/systemd/system/alsa_restore.service
sudo cp setup/music_server.service /etc/systemd/system/music_server.service
sudo systemctl daemon-reload
sudo systemctl enable alsa_restore
sudo systemctl enable music_server

# Copy over wifi settings 
sudo cp setup/wpa_supplicant.conf /etc/wpa_supplicant/wpa_supplicant.conf

# Reboot
sudo systemctl reboot








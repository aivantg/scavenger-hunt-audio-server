### Raspberry Pi setup steps
1. Flash a new SD Card with the latest Debian version using tool like [Raspberry Pi Imager](https://www.raspberrypi.com/software/)
- Make sure to include your wifi in the advanced settings ([details here](https://raspberrypi.stackexchange.com/questions/10251/prepare-sd-card-for-wifi-on-headless-pi))
- Make sure to create a blank file in root of card titled `/boot/ssh` to enable ssh
2. Insert card into Pi and let it boot up
3. SSH from a computer on the same network `ssh pi@raspberrypi.local` default password is `raspberry`
4. Run the following commands. You'll be prompted to select a password, but everything else should work automatically. at the end, the raspberry pi will reboot
- `git clone https://github.com/aivantg/scavenger-hunt-audio-server.git`
- `cd scavenger-hunt-audio-server`
- `source setup_pi.sh`
5. The music server should now start up on boot! You can control it by visiting `raspberrypi.local:5000` on the same network and visiting the routes:
- `/currentSong`
- `/allSongs`
- `/playSong?song=[index]`
- `/stop`

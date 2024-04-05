from flask import Flask, request
import pygame
import os 

app = Flask(__name__)

# List of available songs
SONGS = ['a.mp3', 'b.mp3']
current_song_index = 0  # Start with the first song
pygame.mixer.init()
pygame.mixer.music.load(SONGS[current_song_index])
pygame.mixer.music.play(-1)  # -1 to loop indefinitely

@app.route('/stop')
def stop_song_route(): 
    pygame.mixer.music.stop()
    return "Stopped music"

@app.route('/currentSong')
def current_song_route():
    return SONGS[current_song_index]

@app.route('/playSong')
def switch_song():
    global current_song_index
    new_song_index = int(request.args.get('song'))
    if new_song_index < 0 or new_song_index >= len(SONGS):
        return 'Invalid song index'
    current_song_index = new_song_index
    pygame.mixer.music.load(SONGS[current_song_index])
    pygame.mixer.music.play(-1)
    return f'Switched to {SONGS[current_song_index]}'

@app.route('/allSongs')
def all_songs():
    return '\n'.join(SONGS)

PORT = os.environ.get('PORT', 5000)
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=PORT)

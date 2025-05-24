# Generate a random number within a specific range
random_x=$((1 + RANDOM % 100))
random_y=$((1 + RANDOM % 100))
# Setup the bc calculation
xPos="scale=3; $random_x / 100"
yPos="scale=3; $random_y / 100"
# calculate and return the value
xPos=$(echo "$xPos" | bc)
yPos=$(echo "$yPos" | bc)

# update global color pallete and wallpaper
wal -i /home/myles/Pictures/Wallpapers/
swww img --transition-type grow --transition-pos "$xPos,$yPos" --transition-fps 120 --transition-step 1 --transition-duration 1 "$(< "${HOME}/.cache/wal/wal")"

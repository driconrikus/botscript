# Botscript.sh
A little bash script for finding bots in a huge log file.

# What does it do?
It reads a whole .log file scanning for multiple log in, changed password and log off lines
that have happened within the same second and marks them as bots.

# Try it youself!
- git clone
- cd to the botscript directory
- run the script along with the supplied sample .log file. -> ./botscript.sh net.log

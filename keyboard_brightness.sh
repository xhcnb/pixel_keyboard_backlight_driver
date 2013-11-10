#!/bin/bash

DIRECTION=$1
INCREMENT=10

DEVFILE=/sys/class/leds/chromeos\:\:kbd_backlight/brightness
DEFAULT_LEVEL=60

CURR=`cat $DEVFILE`
NEW=$CURR

if [ "$DIRECTION"x == "up"x ]; then
    NEW=$(( $CURR + $INCREMENT ))
fi

if [ "$DIRECTION"x == "down"x ]; then
    NEW=$(( $CURR - $INCREMENT ))
fi

if [ "$DIRECTION"x == "on"x ]; then
    NEW=$DEFAULT_LEVEL
fi

if [ "$DIRECTION"x == "off"x ]; then
    NEW=0
fi

if [ "$NEW" -gt "100" ]; then
    NEW=100
fi

if [ "$NEW" -lt "0" ]; then
    NEW=0
fi

echo $NEW > $DEVFILE

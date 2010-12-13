#!/bin/bash

if ps -e | grep mythfrontend > /dev/null
then
   killall mythfrontend
else
   ( mythfrontend >> /home/mythtv/mythfrontend.log & )
fi

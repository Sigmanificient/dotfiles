Xephyr -br -ac -noreset -screen 1280x720 :1 &

DISPLAY=:1 qtile start

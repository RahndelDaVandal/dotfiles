#!/usr/bin/env bash

# if [[ -v TMUX ]]
if tmux ls &> /dev/null; then tmux attach; else tmux; fi

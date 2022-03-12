#!/bin/bash

USER_ID=$(id -u)
if [ "$USER_ID" -ne 0 ]; then
    echo run the script with root access
    exit 1
fi

check() {
  if [ $1 -eq 0 ]; then
    echo "\e[32mSUCCESS\e[0m"
  else
    echo "\e[31mFAILURE\e[0m"
    exit 2
  fi
}
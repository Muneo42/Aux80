#!/bin/bash

echo "Enter your message"
read message
git add *
git commit -m"${message}"
git push

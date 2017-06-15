#!/bin/bash
source envs/debug
bundle exec middleman serve &
trap "kill -SIGQUIT $!" INT
wait


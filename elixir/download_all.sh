#!/bin/bash

curl -LSs https://exercism.io/tracks/elixir/exercises | grep "/tracks/elixir/exercises/" | awk '{print $3}' | cut -d/ -f5 | cut -d\" -f1 > exercises.txt

while read in; do
  exercism download --exercise="$in" --track=elixir
done < exercises.txt

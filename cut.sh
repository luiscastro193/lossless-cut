#!/bin/bash
set -e
extension=${1##*.}
points=($(<"$2"))

mkdir -p fragments

for (( i=0; i<${#points[@]}; i+=2 )) ; do
	index=$(printf '%03d' $((i/2)))
	[[ ${points[$i]} != 0 ]] && start="-ss ${points[$i]}" || start=''
	[[ ${points[$i+1]} ]] && end="-to ${points[$i+1]}" || end=''
	ffmpeg $start -i "$1" $end -copyts -c copy -avoid_negative_ts make_zero fragments/$index.$extension
done

for f in fragments/*.$extension; do
	echo "file '$f'" >> fragments.txt
done

if [[ ${#points[@]} -le 2 ]] ; then
	mv fragments/000.$extension output.$extension
else
	ffmpeg -f concat -safe 0 -i fragments.txt -c copy output.$extension
fi

rm -f fragments.txt
rm -fr fragments

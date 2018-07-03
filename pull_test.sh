#!/usr/bin/env bash
#
# Description: This script measures docker pull performance
# WARNING: This will prune ALL of your image cache.

log="results.log"
image="mjeromin/maxlayers"

ATTEMPT=0
SUCCESS=0
FAILURE=0
AVG_SUCCESS_RATE=0
while /bin/true; do
	echo "WARNING: clearing docker image cache in 10s...(CNTL-C to cancel)"
	for i in {10..1}; do
		echo -n $i...
		sleep 1
	done
	echo
	docker image rm $image
	docker image prune --all --force
	date_stamp=`date +%Y%M%d-%H%M`
	(( ATTEMPT = ATTEMPT + 1 ))
	echo "Starting attempt #${ATTEMPT} [$date_stamp]..."
	docker pull $image
	RESULT=$?
	if [[ $RESULT == 0 ]]; then
		(( SUCCESS = SUCCESS + 1 ))
	else
		(( FAILURE = FAIULURE + 1 ))
	fi
	(( AVG_SUCCESS_RATE = 100 * SUCCESS / ATTEMPT ))
	echo "Result[${date_stamp}]: $RESULT (${ATTEMPT} attempts, ${AVG_SUCCESS_RATE}% success rate)" | tee -a $log
done

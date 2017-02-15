#!/bin/bash

# Collection of utility methods
VERSION=5.3

# Check if the specified value is a number
is_number() {
	re='^[0-9]+([.][0-9]+)?$'
	value=$1
	if [ $value == "latest" ]; then
		#latest release version
		value=$VERSION
	fi
	if [[ $value =~ $re ]]; then
		return 0
	else
		return 1
	fi
}

# Check if the specified value is a number less than
# the specified limit.
is_less_than() {
	value=$(get_version $1)
	limit=$2
	if (($(echo "$value < $limit" |bc -l))); then
		return 0
	else
		return 1
	fi
}

# Return the latest version if not specified
get_version() {
	value=$1
	if [ $value == "latest" ]; then
		#latest release version
		value=$VERSION
	fi
	if $(is_number $value); then
		echo $value
	else
		echo $VERSION
	fi
}

is_latest_version() {
	value=$(get_version $1)
	limit=$(get_latest_version)
	if (($(echo "$value <= $limit" |bc -l))) && (($(echo "$value >= $limit" |bc -l))); then
		return 0
	else
		return 1
	fi
}

get_latest_version() {
	echo $VERSION
}
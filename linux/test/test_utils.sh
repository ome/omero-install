#!/bin/bash
# unit tests for ../utils.sh
# You will first need to install shunit2
# e.g. brew install shunit2

# make the script executable
set +x

source `pwd`/../utils.sh

testNotANumber() {
	is_number OMERO-DEV
	assertEquals "This is not a number" "$?" "1"
}

testLatestAsaNumber() {
	is_number latest
	assertEquals "This is a number" "$?" "0"
}

testIsaNumber() {
	is_number 5.2
	assertEquals "This is a number" "$?" "0"
}

testGetVersionDEV() {
	n=$(get_version OMERO-DEV)
	assertEquals "This should be the latest version" "$n" "$(get_latest_version)"
}

testGetVersionLatest() {
	n=$(get_version latest)
	assertEquals "This should be the latest version" "$n" "$(get_latest_version)"
}

testGetVersionMerge() {
	n=$(get_version latest)
	assertEquals "This should be the latest version" "$n" "$(get_latest_version)"
}

testGetVersion() {
	v=5.1
	n=$(get_version $v)
	assertEquals "This should be the latest version" "$n" "$v"
}

testIsLessThanLatest() {
	limit=5.1
	is_less_than latest $limit
	assertEquals "The value should be greater than $limit" "$?" "1"
}

testIsLessThanNumber() {
	limit=5.1
	is_less_than 5.0 $limit
	assertEquals "The value should be less than $limit" "$?" "0"
}
testIsLessThanNumber2() {
	limit=5.1
	is_less_than 5.2 $limit
	assertEquals "The value should be greater than $limit" "$?" "1"
}

. shunit2
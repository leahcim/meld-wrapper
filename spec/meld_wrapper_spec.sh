#!/bin/bash
SPECDIR=$(dirname "$0")
TOPDIR=$SPECDIR/..
. "$SPECDIR/spec_helper.sh"

export MELD="$SPECDIR/mock_meld.sh"
MELDWRAP="$TOPDIR/meld"

conflict_markers="
<<<<<<< HEAD
=======
>>>>>>> develop"

desc "Meld wrapper"
	function setup () {
		mkdir output_files;
		echo -e $conflict_markers >> output_files/merged.txt;
	}

	function teardown () {
		rm -fr output_files;
	}

	it "should recognise a successful merge"
		"$MELDWRAP" -o output_files/merged.txt

		reject_success $? "Merge was not successful!"
	ti
csed
#!/usr/bin/env perl

#######################    Simplified BSD License    ########################
# Copyright (c) 2010, 2011, 2012
# Stephan Laukien (All rights reserved)
#
# Redistribution and use in source and binary forms, with or without 
# modification, are permitted provided that the following conditions are met:
#    * Redistributions of source code must retain the above copyright 
#      notice, this list of conditions and the following disclaimer.
#    * Redistributions in binary form must reproduce the above copyright 
#      notice, this list of conditions and the following disclaimer in the
#      documentation and/or other materials provided with the 
#      distribution.
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS 
# IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
# TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
# PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
# HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, 
# SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED 
# TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR 
# PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF 
# LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING 
# NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS 
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
# http://opensource.org/licenses/bsd-license.php

#===============================================================================
#
#         FILE:  OS.pm
#
#        USAGE:  use Laukien::OS;
#
#  DESCRIPTION:  basic methods which are in contact with the operating system
#
#      OPTIONS:  ---
# REQUIREMENTS:  ---
#         BUGS:  ---
#        NOTES:  ---
#       AUTHOR:  Stephan Laukien
#      COMPANY:  
#      VERSION:  1.0
#      CREATED:  01.01.2011 01:20:11
#     REVISION:  0.4
#===============================================================================

package Laukien::OS;

use strict;
use warnings;


#===  FUNCTION  ================================================================
#         NAME:  isWindows
#      PURPOSE:  checks if the operating system is 'MS Windows'
#   PARAMETERS:  none
#      RETURNS:  'true' if the operating system is 'MS Windows'; otherwise false
#  DESCRIPTION:  ????
#       THROWS:  no exceptions
#     COMMENTS:  none
#     SEE ALSO:  n/a
#===============================================================================
sub isWindows {
	if ( defined($ENV{'comspec'}) ) {
		return 1;
	} else {
		return 0;
	}
}	# ----------  end of subroutine isWindows  ----------


#===  FUNCTION  ================================================================
#         NAME:  isUnix
#      PURPOSE:  checks if the operating system is '*nix'
#   PARAMETERS:  ????
#      RETURNS:  'true' if the operating system is '*nix'; otherwise false
#  DESCRIPTION:  ????
#       THROWS:  no exceptions
#     COMMENTS:  none
#     SEE ALSO:  n/a
#===============================================================================
sub isUnix {
	if ( defined($ENV{'comspec'}) ) {
		return 0;
	} else {
		return 1;
	}
}	# ----------  end of subroutine isUnix  ----------

#===  FUNCTION  ================================================================
#         NAME:  correctPath
#      PURPOSE:  
#   PARAMETERS:  ????
#      RETURNS:  ????
#  DESCRIPTION:  ????
#       THROWS:  no exceptions
#     COMMENTS:  none
#     SEE ALSO:  n/a
#===============================================================================
sub correctPath {
# set parameter
	my $param=shift;

# check parameter
	unless(defined($param)) {
		die "OS.correctPath: Wrong parameter-set.";
	}

# translate
	$_ = $param;                                # set variable
    if (isWindows()) {                          # check os
		$_ =~ tr!/!\\!;	
	} else {
		$_ =~ tr!\\!/!;
	}

# result
	return $_;
}	# ----------  end of subroutine correctPath  ----------


#===  FUNCTION  ================================================================
#         NAME:  getSeparator
#      PURPOSE:  returns the specific separator for the operating-system
#   PARAMETERS:  ????
#      RETURNS:  ????
#  DESCRIPTION:  ????
#       THROWS:  no exceptions
#     COMMENTS:  none
#     SEE ALSO:  n/a
#===============================================================================
sub getSeparator {
	if (isWindows()) {
		return "\\";
	} else {
		return "/";
	}
}	# ----------  end of subroutine getSeparator  ----------



#===  FUNCTION  ================================================================
#         NAME:  getDirectory
#      PURPOSE:  list a directory and its subdirectories
#   PARAMETERS:  directory, filter, recursive
#      RETURNS:  a sorted array
#  DESCRIPTION:  ????
#       THROWS:  no exceptions
#     COMMENTS:  none
#     SEE ALSO:  n/a
#===============================================================================
sub getDirectory {
	my $directory = shift;
	my $filter = shift;
	my $recursive = shift;
	my $deep = shift;

# check directory
	unless (defined($directory)) {
		die "OS.getDirectory: Directory not defined.";
	}

# check recursive
	unless (defined($recursive)) {
		$recursive = 0;
	}

# check deep
	unless (defined($deep)) {
		$deep=0;
	}

# read directory
	opendir(DIR, $directory) || die "OS.getDirectory: Unable to read directory (" . $directory . ").";
	my @items=readdir(DIR);
	closedir(DIR);

# init file-array
	my @dirList=();

# check directory and its items
	foreach my $file (@items) {

# check directory
		my $current = $directory;
		$current .= getSeparator();
		$current .= $file;

		if ( -d $current ) {
# no dot-directories
			if ($file =~ m/^(\.|\.\.)/) {
				next;
			}

			if ($recursive) {
				my @subdirectory;
				eval {
					@subdirectory = getDirectory($current, $filter, 1, ($deep + 1));
				};
				next if ($@);

				@dirList=(@dirList, @subdirectory);
			}
			
			next;
		}

# filter
#		if (defined($filter)) {
#			if ($file !~ m/$filter/) {
#				next;
#			}
#		}

# add to array
		push(@dirList, $current);
	}

# delete initial $directory plus the following path ( $deep == 0)
	if ($deep == 0) {
        my $dirLength=length($directory) + 1;   # dir-length plus separator
		for (my $i=0; $i <= $#dirList; $i++) {
			$dirList[$i] = substr($dirList[$i], $dirLength); # remove starting-path
		}

# filter
		if (defined($filter)) {
			my @tmpList = ();
			foreach (@dirList) {
				push(@tmpList, $_) if (m/$filter/);
			}

			@dirList = @tmpList;
		}
	}

# return list of file
	return @dirList;
}	# ----------  end of subroutine listConfigUser ----------


#===  FUNCTION  ================================================================
#         NAME:  slashToDot
#      PURPOSE:  converts all slashes and backslashes to dots
#   PARAMETERS:  ????
#      RETURNS:  ????
#  DESCRIPTION:  ????
#       THROWS:  no exceptions
#     COMMENTS:  none
#     SEE ALSO:  n/a
#===============================================================================
sub slashToDot {
	my $string = shift;

	unless (defined($string)) {
		die "OS.slashToDot: Wrong parameter-set.";
	}

	$string =~ tr/\//./;
	$string =~ tr/\\/./;

	return $string;
}	# ----------  end of subroutine slashToDot  ----------


#===  FUNCTION  ================================================================
#         NAME:  dotToSlash
#      PURPOSE:  converts all dots to paths
#   PARAMETERS:  ????
#      RETURNS:  ????
#  DESCRIPTION:  ????
#       THROWS:  no exceptions
#     COMMENTS:  none
#     SEE ALSO:  n/a
#===============================================================================
sub dotToSlash {
	my $string = shift;

	unless (defined($string)) {
		die "OS.dotToSlash: Wrong parameter-set.";
	}

	if (isWindows()) {
		$string =~ tr/./\\/;
	} else {
		$string =~ tr/./\//;
	}

	return $string;
}	# ----------  end of subroutine dotToSlash  ----------



#===  FUNCTION  ================================================================
#         NAME:  getExtension
#      PURPOSE:  extracts the file-extension
#   PARAMETERS:  common filename
#      RETURNS:  the extension if the file has an extension; otherwise 'unfed'
#  DESCRIPTION:  ????
#       THROWS:  no exceptions
#     COMMENTS:  none
#     SEE ALSO:  n/a
#===============================================================================
sub getExtension {
	my $file =shift;

	unless (defined($file)) {
		die "OS.getExtension: Wrong parameter-set.";
	}

# get the position of the last dot-separator
	my $idx = rindex($file, '.');
	
	if (($idx > 0) && (($idx + 1) < length($file))) { # . exists and is not the fist or the last
		return substr($file, $idx + 1);
	} else {
		return undef;
	}
}	# ----------  end of subroutine getExtension  ----------



#===  FUNCTION  ================================================================
#         NAME:  getUser
#      PURPOSE:  gets the current user of the operating-system
#   PARAMETERS:  ????
#      RETURNS:  ????
#  DESCRIPTION:  ????
#       THROWS:  no exceptions
#     COMMENTS:  none
#     SEE ALSO:  n/a
#===============================================================================
sub getUser {
	if (isWindows()) {
		return $ENV{'USERNAME'};
	} elsif (isUnix()) {
		return $ENV{'USER'};
	} else {
		die('Unknown OS-environment.');
	}
}	# ----------  end of subroutine getUser  ----------

1;


#!/usr/bin/env perl

#######################    Simplified BSD License    ########################
# Copyright (c) 2010, 2011, 2012, 2013, 2014, 2015
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
#         FILE:  String.pm
#
#        USAGE:  use Laukien::String
#
#  DESCRIPTION:  basic string-functions
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

package Laukien::String;

use strict;
use warnings;


#===  FUNCTION  ================================================================
#         NAME:  trim
#      PURPOSE:  
#   PARAMETERS:  ????
#      RETURNS:  ????
#  DESCRIPTION:  ????
#       THROWS:  no exceptions
#     COMMENTS:  none
#     SEE ALSO:  n/a
#===============================================================================
sub trim {
	my $string=shift;

# check parameter
	unless( defined($string) ) {
		die("String.trim: String is not defined.");
	}

	$string=ltrim($string);
	$string=rtrim($string);

	return $string;
}	# ----------  end of subroutine trim  ----------



#===  FUNCTION  ================================================================
#         NAME:  ltrim
#      PURPOSE:  
#   PARAMETERS:  ????
#      RETURNS:  ????
#  DESCRIPTION:  ????
#       THROWS:  no exceptions
#     COMMENTS:  none
#     SEE ALSO:  n/a
#===============================================================================
sub ltrim {
	my $string=shift;

# check parameter
	unless( defined($string) ) {
		die("String.ltrim: String is not defined.");
	}

	$string =~ s/^\s+//;

	return $string;
}	# ----------  end of subroutine ltrim  ----------



#===  FUNCTION  ================================================================
#         NAME:  rtrim
#      PURPOSE:  
#   PARAMETERS:  ????
#      RETURNS:  ????
#  DESCRIPTION:  ????
#       THROWS:  no exceptions
#     COMMENTS:  none
#     SEE ALSO:  n/a
#===============================================================================
sub rtrim {
	my $string=shift;

# check parameter
	unless( defined($string) ) {
		die("String.rtrim: String is not defined.");
	}

	$string =~ s/\s+$//;

	return $string;
}	# ----------  end of subroutine rtrim  ----------


#===  FUNCTION  ================================================================
#         NAME:  listToArray
#      PURPOSE:  converts a whitespace-separated list of strings to an array
#   PARAMETERS:  ????
#      RETURNS:  an array with items which are the words of the list
#  DESCRIPTION:  ????
#       THROWS:  no exceptions
#     COMMENTS:  none
#     SEE ALSO:  n/a
#===============================================================================
sub listToArray {
# set parameter
	my $string=shift;
	my @array;

# check parameter
	unless ( defined ($string) ) {
		die("String.listToArray: Invalid parameter-set.");
	}
	
# split list
	@array=split(/ +/, $string);

# return array
#	return @array;
}	# ----------  end of subroutine listToArray  ----------


#===  FUNCTION  ================================================================
#         NAME:  uppercase
#      PURPOSE:  uppercases the string
#   PARAMETERS:  ????
#      RETURNS:  ????
#  DESCRIPTION:  ????
#       THROWS:  no exceptions
#     COMMENTS:  none
#     SEE ALSO:  n/a
#===============================================================================
sub uppercase {
	my $string = shift;

	unless (defined($string)) {
		die("String.uppercase: Wrong parameter-set.");
	}

	$string =~ tr/a-z/A-Z/;

	return $string;
}	# ----------  end of subroutine uppercase  ----------


#===  FUNCTION  ================================================================
#         NAME:  lowercase
#      PURPOSE:  lowercases the string
#   PARAMETERS:  ????
#      RETURNS:  ????
#  DESCRIPTION:  ????
#       THROWS:  no exceptions
#     COMMENTS:  none
#     SEE ALSO:  n/a
#===============================================================================
sub lowercase {
	my $string = shift;

	unless (defined($string)) {
		die("String.lowercase: Wrong parameter-set.");
	}

	$string =~ tr/A-Z/a-z/;

	return $string;
}	# ----------  end of subroutine lowercase  ----------


#===  FUNCTION  ================================================================
#         NAME:  isNumber
#      PURPOSE:  checks if the given string is a vlaid number
#   PARAMETERS:  string which could be a number
#      RETURNS:  'true' if string ist a valid decimal number; otherwise 'false'
#  DESCRIPTION:  ????
#       THROWS:  no exceptions
#     COMMENTS:  none
#     SEE ALSO:  n/a
#===============================================================================
sub isNumber {
	my $string = shift;
	
	unless (defined($string)) {
		die("String.isNumber: Wrong parameter-set.");
	}

	if ($string =~ m/^\d+$/) {
		return 1;
	} else {
		return 0;
	}
}



#===  FUNCTION  ================================================================
#         NAME:  replace
#      PURPOSE:  replaces the given 'old' with 'new'
#   PARAMETERS:  string, old, new
#      RETURNS:  ????
#  DESCRIPTION:  ????
#       THROWS:  no exceptions
#     COMMENTS:  none
#     SEE ALSO:  n/a
#===============================================================================
sub replace {
	my $str = shift;
	my $old = shift;
	my $new = shift;

# check parameter
	unless (defined($str)) {
		die("String.replace: String-value is not defined.");
	}

	unless (defined($old)) {
		die("String.replace: Old-value is not defined.");
	}

	unless (defined($new)) {
		die("String.replace: New-value is not defined.");
	}

# translate
	$str =~ s/$old/$new/g;

	return $str;
}	# ----------  end of subroutine replace  ----------


#===  FUNCTION  ================================================================
#         NAME:  random
#      PURPOSE:  creates a string of random alphanumeric characters
#   PARAMETERS:  length of the string
#      RETURNS:  ????
#  DESCRIPTION:  ????
#       THROWS:  no exceptions
#     COMMENTS:  none
#     SEE ALSO:  n/a
#===============================================================================
sub random(*) {
	my $length = shift;

	my @symbols = ("0".."9", "A".."Z", "a".."z");
	my $string = "";

	for (my $i=0; $i<$length; $i++) {
			$string .= $symbols[(rand() * 100) % $#symbols];
	}

	return $string;
}	# ----------  end of subroutine random  ----------



1;

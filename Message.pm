#!/usr/bin/env perl

#---------------------------------------------------------------------------
#  Copyright (c) 2010, 2011
#  Stephan Laukien (All rights reserved)
#
#  This program is free software; you can redistribute it and/or
#  modify it under the terms of version 3 of the GNU General Public
#  License published by the Free Software Foundation.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program; If not, see <http://www.gnu.org/licenses/>.
#---------------------------------------------------------------------------

#===============================================================================
#
#         FILE:  Message.pm
#
#        USAGE:  use Laukien::Message;
#
#  DESCRIPTION:  message to the console
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

package Laukien::Message;

use strict;
use warnings;
use Laukien::String;


#---------------------------------------------------------------------------
#  global variables
#---------------------------------------------------------------------------
my $isDebug;


#===  FUNCTION  ================================================================
#         NAME:  isDebug
#      PURPOSE:  checks if there where a debug-environment has been set
#   PARAMETERS:  Environment-variable 'DEBUG', 'debug', 'LAUKIEN_DEBUG', 'ADMEN_DEBUG'
#      RETURNS:  debug-status
#  DESCRIPTION:  ????
#       THROWS:  no exceptions
#     COMMENTS:  none
#     SEE ALSO:  n/a
#===============================================================================
sub isDebug {
	my $debug;

# return if "debug" is it has been checked already
	return $isDebug if (defined($isDebug));

# check OS-environment
	if (defined($ENV{'DEBUG'})) {
		$debug = $ENV{'DEBUG'};
	} elsif (defined($ENV{'debug'})) {
		$debug = $ENV{'debug'};
	} elsif (defined($ENV{'LAUKIEN_DEBUG'})) {
		$debug = $ENV{'LAUKIEN_DEBUG'};
	} elsif (defined($ENV{'ADMEN_DEBUG'})) {
		$debug = $ENV{'ADMEN_DEBUG'};
	} else {
		$debug = 'f';
	}

# return value
	return setDebug($debug);

}	# ----------  end of subroutine isDebug  ----------


#===  FUNCTION  ================================================================
#         NAME:  setDebug
#      PURPOSE:  set the global variable via an internal call
#   PARAMETERS:  status (t,y,1 or UNDEF for 'true'; otherwise false)
#      RETURNS:  debug-status
#  DESCRIPTION:  set the global debug-variable and returns the value
#       THROWS:  no exceptions
#     COMMENTS:  none
#     SEE ALSO:  n/a
#===============================================================================
sub setDebug {
	my $debug = shift;

# set "debug" to TRUE if it is not defined
	$debug = 't' unless (defined($debug));

# check length
	if (length($debug) < 1) {
		$isDebug = 0;
		return 0;
	}

# short value to one
	$debug = substr($debug, 0, 1);

# to lower case
	$debug =~ tr/A-Z/a-z/;

# check value
	$isDebug = ($debug eq 't' || $debug eq 'y' || $debug eq '1');

# return debug-value
	return $isDebug;
}	# ----------  end of subroutine setDebug  ----------


#===  FUNCTION  ================================================================
#         NAME:  debug
#      PURPOSE:  writes out debug-messages if Admen is in debug-mode
#   PARAMETERS:  the 'key' and (optional) it's 'value'
#      RETURNS:  none
#  DESCRIPTION:  ????
#       THROWS:  no exceptions
#     COMMENTS:  none
#     SEE ALSO:  n/a
#===============================================================================
sub debug {
	my $key = shift;
	my $value = shift;

# break if is no debug-mode
	return unless (isDebug());

	unless (defined($key)) {
		die "Message.debug: Wrong parameter-set (key).";
	}

	if (defined($value)) {                      # key-value-pair
		$key = Laukien::String::uppercase($key); # convert key
		print $key . ": " . $value . "\n";      # print out key-value-pair
	} else {                                    # message only
		print $key . "\n";                      # print out message
	}
}	# ----------  end of subroutine debug  ----------


#===  FUNCTION  ================================================================
#         NAME:  info
#      PURPOSE:  prints out the given message.
#   PARAMETERS:  the 'key' and (optional) it's 'value'
#      RETURNS:  ????
#  DESCRIPTION:  ????
#       THROWS:  no exceptions
#     COMMENTS:  none
#     SEE ALSO:  n/a
#===============================================================================
sub info {
	my $key = shift;
	my $value = shift;

	unless (defined($key)) {
		die "Message.info: Wrong parameter-set (key).";
	}

	if (defined($value)) {                      # key-value-pair
		$key = Laukien::String::uppercase($key); # convert key
		print $key . ": " . $value . "\n";      # print out key-value-pair
	} else {                                    # message only
		print $key . "\n";                      # print out message
	}
}	# ----------  end of subroutine info  ----------


#===  FUNCTION  ================================================================
#         NAME:  error
#      PURPOSE:  prints out the given error-message and exits the program
#   PARAMETERS:  the 'key' and it's 'value'; the 'code' is the OS-exit-code
#      RETURNS:  ????
#  DESCRIPTION:  ????
#       THROWS:  no exceptions
#     COMMENTS:  none
#     SEE ALSO:  n/a
#===============================================================================
sub error {
	my $key = shift;
	my $value = shift;
	my $code =shift;

	unless (defined($key)) {
		die "Message.error: Wrong parameter-set (key).";
	}

# check if 'value' is a number (exit code)
	if (Laukien::String::isNumber($value)) {
		$code = $value;
		$value = undef;
	} else {
		unless (defined($code)) {
			$code = 1;
		}
	}

	if (defined($value)) {                      # key-value-pair
		$key = Laukien::String::uppercase($key); # convert key
		print $key . ": " . $value . "\n";      # print out key-value-pair
	} else {                                    # message only
		print $key . "\n";                      # print out message
	}

 	exit $code                                  # exit the program
}	# ----------  end of subroutine error  ----------


1;


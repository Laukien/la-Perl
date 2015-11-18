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
	my $code = shift;

	unless (defined($key)) {
		die "Message.error: Wrong parameter-set (key).";
	}

# check if 'value' is a number (exit code)
	if (defined($value) && Laukien::String::isNumber($value)) {
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


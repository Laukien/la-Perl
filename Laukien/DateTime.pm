#!/usr/bin/env perl

#######################    Simplified BSD License    ########################
# Copyright (c) 2010-2018
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
#         FILE:  DataTime.pm
#
#        USAGE:  use Laukien::DateTime;
#
#  DESCRIPTION:  simple methods which access date und time
#
#      OPTIONS:  ---
# REQUIREMENTS:  ---
#         BUGS:  ---
#        NOTES:  ---
#       AUTHOR:  Stephan Laukien
#      COMPANY:  
#      VERSION:  1.1
#      CREATED:  14.04.2011 12:23:26
#     REVISION:  0.1
#===============================================================================

package Laukien::DateTime;

use strict;
use warnings;
use Laukien::String;


#===  FUNCTION  ================================================================
#         NAME:  getTimestamp
#      PURPOSE:  generates a timestamp which looks like 'yyyymmddhhmmss'
#   PARAMETERS:  ????
#      RETURNS:  ????
#  DESCRIPTION:  ????
#       THROWS:  no exceptions
#     COMMENTS:  none
#     SEE ALSO:  n/a
#===============================================================================
sub getTimestamp {
	my $year;
	my $month;
	my $day;
	my $hour;
	my $minute;
	my $second;

# set variables
	($second, $minute, $hour, $day, $month, $year) = localtime();

# correct
	$year += 1900;
	$month++;
	$month = '0' . $month if ($month < 10);
	$day = '0' . $day if ($day < 10);
	$hour = '0' . $hour if ($hour < 10);
	$minute = '0' . $minute if ($minute < 10);
	$second = '0' . $second if ($second < 10);

	return $year . $month . $day . $hour . $minute . $second;
}	# ----------  end of subroutine getTimestamp  ----------


#===  FUNCTION  ================================================================
#         NAME:  getDate
#      PURPOSE:  generates a timestamp which looks like 'yymmdd'
#   PARAMETERS:  ????
#      RETURNS:  ????
#  DESCRIPTION:  ????
#       THROWS:  no exceptions
#     COMMENTS:  none
#     SEE ALSO:  n/a
#===============================================================================
sub getDate {
	my $year;
	my $month;
	my $day;
	my $hour;
	my $minute;
	my $second;

# set variables
	($second, $minute, $hour, $day, $month, $year) = localtime();

# correct
	$year = '0' . $year if ($year < 10);
	$month++;
	$month = '0' . $month if ($month < 10);
	$day = '0' . $day if ($day < 10);

	return $year . $month . $day;
}	# ----------  end of subroutine getDate  ----------


#===  FUNCTION  ================================================================
#         NAME:  getTime
#      PURPOSE:  generates a timestamp which looks like 'hhmmss'
#   PARAMETERS:  ????
#      RETURNS:  ????
#  DESCRIPTION:  ????
#       THROWS:  no exceptions
#     COMMENTS:  none
#     SEE ALSO:  n/a
#===============================================================================
sub getTime {
	my $year;
	my $month;
	my $day;
	my $hour;
	my $minute;
	my $second;

# set variables
	($second, $minute, $hour, $day, $month, $year) = localtime();

# correct
	$hour = '0' . $hour if ($hour < 10);
	$minute = '0' . $minute if ($minute < 10);
	$second = '0' . $second if ($second < 10);

	return $hour . $minute . $second;
}	# ----------  end of subroutine getTime  ----------


=pod

=head1 NAME

Laukien::DateTime

=head1 VERSION

version 1.1

=head1 SYNOPSIS

simple methods which access date und time

=head1 AUTHOR

Stephan Laukien <software@laukien.com>

Please report bugs L<here|https://github.com/Laukien/la-Perl/>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011-2017 by Stephan Laukien.

=cut

1;


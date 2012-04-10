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
#      VERSION:  1.0
#      CREATED:  14.04.2011 12:23:26
#     REVISION:  0.2
#===============================================================================

package Laukien::DateTime;

use strict;
use warnings;
use Laukien::String;


#===  FUNCTION  ================================================================
#         NAME:  getTimestamp
#      PURPOSE:  generates a timestamp which has looks like 'yyyymmddhhmmss'
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




1;


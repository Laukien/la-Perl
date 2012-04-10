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
#         FILE:  Common.pm
#
#        USAGE:  use Laukien::Database::Oracle;
#
#  DESCRIPTION:  Abstract class which is a helper for other database-classes
#
#      OPTIONS:  ---
# REQUIREMENTS:  ---
#         BUGS:  ---
#        NOTES:  ---
#       AUTHOR:  Stephan Laukien
#      COMPANY:  
#      VERSION:  1.0
#      CREATED:  03.05.2011 15:55:00
#     REVISION:  0.1
#
package Laukien::Database::Common;

use strict;
use warnings;

use Laukien::DateTime;


#===  FUNCTION  ================================================================
#         NAME:  new
#      PURPOSE:  constructor
#   PARAMETERS:  ????
#      RETURNS:  ????
#  DESCRIPTION:  ????
#       THROWS:  no exceptions
#     COMMENTS:  none
#     SEE ALSO:  n/a
#===============================================================================
sub new {
	my $class = shift;
	my $self = {};

# init timestamp
	$self->{timestamp} = Laukien::DateTime::getTimestamp();

	return bless($self, $class);
}	# ----------  end of subroutine new  ----------


#===  FUNCTION  ================================================================
#         NAME:  getTimestamp
#      PURPOSE:  returns the current 'unique' timestamp (once calculated)
#   PARAMETERS:  ????
#      RETURNS:  ????
#  DESCRIPTION:  ????
#       THROWS:  no exceptions
#     COMMENTS:  none
#     SEE ALSO:  n/a
#===============================================================================
sub getTimestamp(*) {
	my $self = shift;

	return $self->{timestamp};
}	# ----------  end of subroutine getTimestamp  ----------

1;

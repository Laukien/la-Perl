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

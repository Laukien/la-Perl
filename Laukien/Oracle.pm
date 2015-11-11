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
#         FILE:  Oracle.pm
#
#        USAGE:  use Laukien::Oracle;
#
#  DESCRIPTION:  common operations at and for the Oracle-Database
#
#      OPTIONS:  ---
# REQUIREMENTS:  ---
#         BUGS:  ---
#        NOTES:  ---
#       AUTHOR:  Stephan Laukien
#      COMPANY:  
#      VERSION:  1.0
#      CREATED:  03.05.2011 15:55:56
#     REVISION:  0.1
#===============================================================================

package Laukien::Oracle;

use strict;
use warnings;
#no warnings 'redefine';

use Laukien::DateTime;

#
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


#===  FUNCTION  ================================================================
#         NAME:  setHome
#      PURPOSE:  sets the ORACLE_HOME
#   PARAMETERS:  ????
#      RETURNS:  ????
#  DESCRIPTION:  ????
#       THROWS:  no exceptions
#     COMMENTS:  none
#     SEE ALSO:  n/a
#===============================================================================
sub setHome(**) {
	my $self = shift;
	my $param = shift;

	$self->{home} = $param;
}	# ----------  end of subroutine setHome  ----------


#===  FUNCTION  ================================================================
#         NAME:  setUser
#      PURPOSE:  sets the Oracle-user
#   PARAMETERS:  ????
#      RETURNS:  ????
#  DESCRIPTION:  ????
#       THROWS:  no exceptions
#     COMMENTS:  none
#     SEE ALSO:  n/a
#===============================================================================
sub setUser(**) {
	my $self = shift;
	my $param = shift;

	$param =~ tr/A-Z/a-z/;                      # lowercase

	$self->{user} = $param;
}	# ----------  end of subroutine setUser  ----------


#===  FUNCTION  ================================================================
#         NAME:  setPassword
#      PURPOSE:  sets the ORACLE_HOME
#   PARAMETERS:  ????
#      RETURNS:  ????
#  DESCRIPTION:  ????
#       THROWS:  no exceptions
#     COMMENTS:  none
#     SEE ALSO:  n/a
#===============================================================================
sub setPassword(**) {
	my $self = shift;
	my $param = shift;

	$self->{password} = $param;
}	# ----------  end of subroutine setPassword  ----------


#===  FUNCTION  ================================================================
#         NAME:  setSID
#      PURPOSE:  sets the ORACLE_HOME
#   PARAMETERS:  ????
#      RETURNS:  ????
#  DESCRIPTION:  ????
#       THROWS:  no exceptions
#     COMMENTS:  none
#     SEE ALSO:  n/a
#===============================================================================
sub setSID(**) {
	my $self = shift;
	my $param = shift;

	$self->{sid} = $param;
}	# ----------  end of subroutine setSID  ----------


#===  FUNCTION  ================================================================
#         NAME:  checkParameter
#      PURPOSE:  checks if all parameters are set correctly
#   PARAMETERS:  ????
#      RETURNS:  'true' if there is an error; otherwise false
#  DESCRIPTION:  ????
#       THROWS:  no exceptions
#     COMMENTS:  none
#     SEE ALSO:  n/a
#===============================================================================
sub checkParameter(*) {
	my $self = shift;

		if (
				defined($self->{home})
				&&
				defined($self->{sid})
				&&
				defined($self->{user})
				&&
				defined($self->{password})
		 ) {
			return 0;
		} else {
			return 1;
		}
}	# ----------  end of subroutine checkParameter  ----------


#===  FUNCTION  ================================================================
#         NAME:  runScript
#      PURPOSE:  runs the given script
#   PARAMETERS:  script as file
#      RETURNS:  error-code
#  DESCRIPTION:  ????
#       THROWS:  no exceptions
#     COMMENTS:  none
#     SEE ALSO:  n/a
#===============================================================================
sub runScript(**) {
	my $self = shift;
	my $script = shift;

# check parameters
	return 1 if ($self->checkParameter());

# build sqlplus-command (ORACLE_HOME/bin/sqlplus[.exe])
	my $cmd = $self->{home};
	$cmd .= Laukien::File::getSeparator();
	$cmd .= 'bin';
	$cmd .= Laukien::File::getSeparator();
	$cmd .= 'sqlplus';
	$cmd .= '.exe' if (Laukien::OS::isWindows());

# user
	$cmd .= ' ';
	$cmd .= $self->{user} . '/' . $self->{password} . '@' . $self->{sid};
	$cmd .= ' AS SYSDBA' if ($self->{user} eq 'sys');

# script
	$cmd .= ' @' . $script;
	
# execute
#	print "CMD: $cmd\n";
	my $status = system($cmd);

	return $status ? 1 : 0;
}	# ----------  end of subroutine runScript  ----------


#===  FUNCTION  ================================================================
#         NAME:  runCommand
#      PURPOSE:  runs the given command
#   PARAMETERS:  command as string
#      RETURNS:  ????
#  DESCRIPTION:  ????
#       THROWS:  no exceptions
#     COMMENTS:  none
#     SEE ALSO:  n/a
#===============================================================================
sub runCommand(**) {
	my $self = shift;
	my $command = shift;

	my $file = Laukien::File::getTempFile();    # make temp-file
	
# write temp-file
	open(FH, '>', $file) || return 1;
    print FH $command . "\n";                   # command
    print FH "exit;\n";                         # exit script
	close(FH);

    my $status = $self->runScript($file);       # run script

	unlink($file);                              # delete temp-file

	return $status;
}	# ----------  end of subroutine runCommand  ----------


#===  FUNCTION  ================================================================
#         NAME:  addDirectory
#      PURPOSE:  adds a DBA-directory
#   PARAMETERS:  name, directory
#      RETURNS:  error-code
#  DESCRIPTION:  ????
#       THROWS:  no exceptions
#     COMMENTS:  none
#     SEE ALSO:  n/a
#===============================================================================
sub addDirectory(***) {
	my $self = shift;
	my $name = shift;
	my $directory = shift;

	my $cmd = "CREATE OR REPLACE DIRECTORY $name AS '$directory';";

	return $self->runCommand($cmd);
}	# ----------  end of subroutine addDirectory  ----------


#===  FUNCTION  ================================================================
#         NAME:  dropDirectory
#      PURPOSE:  drops a DBA-directory
#   PARAMETERS:  name
#      RETURNS:  error-code
#  DESCRIPTION:  ????
#       THROWS:  no exceptions
#     COMMENTS:  none
#     SEE ALSO:  n/a
#===============================================================================
sub dropDirectory(**) {
	my $self = shift;
	my $name = shift;

	my $cmd = "DROP DIRECTORY $name;";

	return $self->runCommand($cmd);
}	# ----------  end of subroutine addDirectory  ----------

1;

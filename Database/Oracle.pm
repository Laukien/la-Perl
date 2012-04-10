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
#         FILE:  Oracle.pm
#
#        USAGE:  use Laukien::Database::Oracle;
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

package Laukien::Database::Oracle;
@ISA = qw(Laukien::Database::Common);

use strict;
use warnings;
#no warnings 'redefine';

use Laukien::Database::Common;

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


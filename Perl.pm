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
#         FILE:  Perl.pm
#
#        USAGE:  use Laukien::Perl;
#
#  DESCRIPTION:  methods which gets Perl internals
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

package Laukien::Perl;

use strict;
use warnings;

#use ExtUtils::Installed;
#use Module::CoreList;

use Laukien::OS;
use Laukien::String;


#===  FUNCTION  ================================================================
#         NAME:  getVersion
#      PURPOSE:  gets the Perl-version as String
#   PARAMETERS:  ????
#      RETURNS:  ????
#  DESCRIPTION:  ????
#       THROWS:  no exceptions
#     COMMENTS:  none
#     SEE ALSO:  n/a
#===============================================================================
sub getVersion {
	return $];
}	# ----------  end of subroutine getVersion  ----------



#===  FUNCTION  ================================================================
#         NAME:  getVersionMain
#      PURPOSE:  gets the main-Perl-version
#   PARAMETERS:  ????
#      RETURNS:  ????
#  DESCRIPTION:  ????
#       THROWS:  no exceptions
#     COMMENTS:  none
#     SEE ALSO:  n/a
#===============================================================================
sub getVersionMain {
	my $version = getVersion();

	return substr($version, 0, index($version, '.'));
}	# ----------  end of subroutine getVersionMain  ----------



#===  FUNCTION  ================================================================
#         NAME:  getVersionSub
#      PURPOSE:  gets the sub-Perl-version
#   PARAMETERS:  ????
#      RETURNS:  ????
#  DESCRIPTION:  ????
#       THROWS:  no exceptions
#     COMMENTS:  none
#     SEE ALSO:  n/a
#===============================================================================
sub getVersionSub {
	my $version = getVersion();

	return substr($version, index($version, '.') + 1, 3);
}	# ----------  end of subroutine getVersionSub  ----------



#===  FUNCTION  ================================================================
#         NAME:  getModuleListExtra
#      PURPOSE:  gets a list of all additionally installed modules
#   PARAMETERS:  ????
#      RETURNS:  ????
#  DESCRIPTION:  ????
#       THROWS:  no exceptions
#     COMMENTS:  deprecated
#     SEE ALSO:  n/a
#===============================================================================
#sub getModuleListExtra {
#	my $inst = ExtUtils::Installed->new();
#	my @modules = $inst->modules();
#
#	return @modules;
#}	# ----------  end of subroutine getModuleListExtra  ----------



#===  FUNCTION  ================================================================
#         NAME:  getModuleListAll
#      PURPOSE:  gets a list of all modules
#   PARAMETERS:  ????
#      RETURNS:  ????
#  DESCRIPTION:  ????
#       THROWS:  no exceptions
#     COMMENTS:  deprecated
#     SEE ALSO:  n/a
#===============================================================================
sub getModuleListAll {
	use File::Find;
	my @files;

	find(
		sub {
			push @files, $File::Find::name
				if -f $File::Find::name && /\.pm$/
		},
		@INC
	);
	
	return @files;
}	# ----------  end of subroutine getModuleListAll  ----------


#===  FUNCTION  ================================================================
#         NAME:  getModuleList
#      PURPOSE:  returns a list of all usable Perl-modules
#   PARAMETERS:  ????
#      RETURNS:  ????
#  DESCRIPTION:  ????
#       THROWS:  no exceptions
#     COMMENTS:  none
#     SEE ALSO:  n/a
#===============================================================================
sub getModuleList {
	my @list=();
	foreach my $dir (@INC) {
		next unless (-e $dir);                  # only if the directory exists
		@list=(@list, Laukien::OS::getDirectory($dir, '.pm$', 1));
	}
	return @list;
}	# ----------  end of subroutine getModuleList  ----------


#===  FUNCTION  ================================================================
#         NAME:  checkModule
#      PURPOSE:  checks if the given module exists
#   PARAMETERS:  ????
#      RETURNS:  ????
#  DESCRIPTION:  ????
#       THROWS:  no exceptions
#     COMMENTS:  none
#     SEE ALSO:  n/a
#===============================================================================
sub checkModule {
	my $name = shift;

# check if the parameter is set
	unless (defined($name)) {
		die("Perl.checkModule: Parameter not set.");
	}

# convert name to path
	$name = Laukien::String::replace($name, '::', Laukien::OS::getSeparator());
	$name .= '.pm';

# get list of all modules
	my @modules = getModuleList();

	foreach my $item (@modules) {
#		if ($item =~ m/$name/) {
		if (index($item, $name)>-1) {
			return 1;
		}
	}

	return 0;
}	# ----------  end of subroutine checkModule  ----------


1;


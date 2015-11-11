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


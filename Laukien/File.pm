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
#         FILE:  File.pm
#
#        USAGE:  use Laukien::File;
#
#  DESCRIPTION:  methods for file-management
#
#      OPTIONS:  ---
# REQUIREMENTS:  ---
#         BUGS:  ---
#        NOTES:  ---
#       AUTHOR:  Stephan Laukien
#      COMPANY:  
#      VERSION:  1.0
#      CREATED:  14.04.2011 09:33:56
#     REVISION:  0.2
#===============================================================================

package Laukien::File;

use strict;
use warnings;

use File::Spec;

use Laukien::DateTime;
use Laukien::OS;
use Laukien::String;

#===  FUNCTION  ================================================================
#         NAME:  getSeparator
#      PURPOSE:  returns the specific separator for the operating-system
#   PARAMETERS:  ????
#      RETURNS:  ????
#  DESCRIPTION:  ????
#       THROWS:  no exceptions
#     COMMENTS:  none
#     SEE ALSO:  n/a
#===============================================================================
sub getSeparator {
	if (Laukien::OS::isWindows()) {
		return "\\";
	} else {
		return "/";
	}
}	# ----------  end of subroutine getSeparator  ----------


#===  FUNCTION  ================================================================
#         NAME:  getPathSeparator
#      PURPOSE:  returns the specific separator for the operating-system
#   PARAMETERS:  ????
#      RETURNS:  ????
#  DESCRIPTION:  ????
#       THROWS:  no exceptions
#     COMMENTS:  none
#     SEE ALSO:  n/a
#===============================================================================
sub getPathSeparator {
	if (Laukien::OS::isWindows()) {
		return ";";
	} else {
		return ":";
	}
}	# ----------  end of subroutine getPathSeparator  ----------


#===  FUNCTION  ================================================================
#         NAME:  readString
#      PURPOSE:  reads the file into a string
#   PARAMETERS:  filename
#      RETURNS:  data
#  DESCRIPTION:  ????
#       THROWS:  no exceptions
#     COMMENTS:  none
#     SEE ALSO:  n/a
#===============================================================================
sub readString(*) {
	my $file = shift;
	my $data = '';

	open(FH, "<$file") || die("Unable to read file ($file).");
	while(<FH>) {
		$data .= $_;
	}
	close(FH);

	return $data
}	# ----------  end of subroutine readString  ----------


#===  FUNCTION  ================================================================
#         NAME:  readArray
#      PURPOSE:  reads a file into an array
#   PARAMETERS:  filename
#      RETURNS:  ????
#  DESCRIPTION:  ????
#       THROWS:  no exceptions
#     COMMENTS:  none
#     SEE ALSO:  n/a
#===============================================================================
sub readArray(*) {
	my $file = shift;
	my @data =();
	open(FH, '<', $file) || die('Can\'t read file (' . $! . ').');
	@data = <FH>;
	close(FH);

	return @data;
}	# ----------  end of subroutine read(*)  ----------


#===  FUNCTION  ================================================================
#         NAME:  writeString
#      PURPOSE:  writes the string into a file
#   PARAMETERS:  filename, data
#      RETURNS:  ????
#  DESCRIPTION:  ????
#       THROWS:  no exceptions
#     COMMENTS:  none
#     SEE ALSO:  n/a
#===============================================================================
sub writeString(**) {
	my $file = shift;
	my $data = shift;

	open(FH, ">$file") || die("Unable to write file ($file).\n$!");
	print FH $data;
	close(FH);
}	# ----------  end of subroutine writeString  ----------


#===  FUNCTION  ================================================================
#         NAME:  writeArray
#      PURPOSE:  writes an array into a file
#   PARAMETERS:  ????
#      RETURNS:  ????
#  DESCRIPTION:  ????
#       THROWS:  no exceptions
#     COMMENTS:  none
#     SEE ALSO:  n/a
#===============================================================================
sub writeArray {
	my $file = shift;
	my @data = @_;

	unless (defined($file)) {
		die("Parameter 'file' not defined.");
	}

	open(FH, '>', $file) || die("Unable to write file ($file).\n$!");
	foreach my $line (@data) {
		print(FH $line);
	}
	close(FH);
}	# ----------  end of subroutine writeArray  ----------


#===  FUNCTION  ================================================================
#         NAME:  getTempDirectory
#      PURPOSE:  returns to OS-temp-diretory
#   PARAMETERS:  ????
#      RETURNS:  ????
#  DESCRIPTION:  ????
#       THROWS:  no exceptions
#     COMMENTS:  none
#     SEE ALSO:  n/a
#===============================================================================
sub getTempDirectory {
	return File::Spec->tmpdir();
}	# ----------  end of subroutine getTempDirectory  ----------


#===  FUNCTION  ================================================================
#         NAME:  getTempFile
#      PURPOSE:  returns a random-file-name in the temp-path
#   PARAMETERS:  ????
#      RETURNS:  ????
#  DESCRIPTION:  ????
#       THROWS:  no exceptions
#     COMMENTS:  none
#     SEE ALSO:  n/a
#===============================================================================
sub getTempFile {
	my $file = getTempDirectory();
	$file .= getSeparator();
	$file .= Laukien::DateTime::getTimestamp();
	$file .= '_';
	$file .= Laukien::String::random(10);
	$file .= '.tmp';
}	# ----------  end of subroutine getTempFile  ----------


1;


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


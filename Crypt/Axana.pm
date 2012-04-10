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
#         FILE:  Axana.pm
#
#        USAGE:  use Laukien::Crypt::Axana;
#
#  DESCRIPTION:  en- and de-crypt plain text
#
#      OPTIONS:  ---
# REQUIREMENTS:  ---
#         BUGS:  ---
#        NOTES:  ---
#       AUTHOR:  Axana Freser, Stephan Laukien
#      COMPANY:  
#      VERSION:  3.0
#      CREATED:  14.04.2011 10:20:00
#     REVISION:  0.1
#===============================================================================

package Laukien::Crypt::Axana;

use strict;
use warnings;


my @symbols = ();
my @keys = ();
my @chars = ();
my %index = ();
my $size = 10 * 1024;
my $length = 8;
my $debug = 0;

#===  FUNCTION  ================================================================
#         NAME:  setKeySize
#      PURPOSE:  sets the size of the key
#   PARAMETERS:  ????
#      RETURNS:  ????
#  DESCRIPTION:  ????
#       THROWS:  no exceptions
#     COMMENTS:  none
#     SEE ALSO:  n/a
#===============================================================================
sub setKeySize(*) {
	$length = shift;
}	# ----------  end of subroutine setKeySize  ----------


#===  FUNCTION  ================================================================
#         NAME:  setKeyCount
#      PURPOSE:  sets how many keys are in the list
#   PARAMETERS:  ????
#      RETURNS:  ????
#  DESCRIPTION:  ????
#       THROWS:  no exceptions
#     COMMENTS:  none
#     SEE ALSO:  n/a
#===============================================================================
sub setKeyCount(*) {
	$size = shift;
}	# ----------  end of subroutine setKeyCount  ----------


#===  FUNCTION  ================================================================
#         NAME:  setDebug
#      PURPOSE:  allows to look how Axana-Crypt works
#   PARAMETERS:  ????
#      RETURNS:  ????
#  DESCRIPTION:  ????
#       THROWS:  no exceptions
#     COMMENTS:  none
#     SEE ALSO:  n/a
#===============================================================================
sub setDebug(*) {
	$debug = shift;
}	# ----------  end of subroutine setDebug  ----------


#===  FUNCTION  ================================================================
#         NAME:  addSymbol
#      PURPOSE:  adds the given symbol if it doesn't exists
#   PARAMETERS:  ????
#      RETURNS:  ????
#  DESCRIPTION:  ????
#       THROWS:  no exceptions
#     COMMENTS:  none
#     SEE ALSO:  n/a
#===============================================================================
sub addSymbol(*) {
	my $lchr = shift;

	foreach my $achr (@symbols) {
		if ($achr eq $lchr) {
			return 0;                           # symbol already exists
		}
	}

	push(@symbols, $lchr);                      # add symbol
	return 1;
}	# ----------  end of subroutine addSymbol  ----------


#===  FUNCTION  ================================================================
#         NAME:  addSymbolsFormString
#      PURPOSE:  converts the plain text to the symbol-array
#   PARAMETERS:  plain text
#      RETURNS:  ????
#  DESCRIPTION:  ????
#       THROWS:  no exceptions
#     COMMENTS:  none
#     SEE ALSO:  n/a
#===============================================================================
sub addSymbolsFormString(*) {
	my $data = shift;

	for (my $i = 0; $i < length($data); $i++) {
		addSymbol(substr($data, $i, 1));
	}
}	# ----------  end of subroutine addSymbolsFormString  ----------


#===  FUNCTION  ================================================================
#         NAME:  getKey
#      PURPOSE:  generates a key
#   PARAMETERS:  ????
#      RETURNS:  ????
#  DESCRIPTION:  ????
#       THROWS:  no exceptions
#     COMMENTS:  none
#     SEE ALSO:  n/a
#===============================================================================
sub getKey {
	my $string = '';
	for (my $count = 0; $count < $length; $count++) {
		my $i = rand($#symbols + 1);
		$string .= $symbols[$i];
	}
	return $string;
}	# ----------  end of subroutine getKey  ----------


#===  FUNCTION  ================================================================
#         NAME:  checkKey
#      PURPOSE:  checks if the key already exists
#   PARAMETERS:  key
#      RETURNS:  ????
#  DESCRIPTION:  ????
#       THROWS:  no exceptions
#     COMMENTS:  none
#     SEE ALSO:  n/a
#===============================================================================
sub checkKey(*) {
	my $key = shift;

	foreach (@keys) {
		return 1 if ($_ eq $key);
	}
	return 0;
}	# ----------  end of subroutine checkKey  ----------


#===  FUNCTION  ================================================================
#         NAME:  buildKeyList
#      PURPOSE:  fills the table with keys based on the symbol-list
#   PARAMETERS:  ????
#      RETURNS:  ????
#  DESCRIPTION:  ????
#       THROWS:  no exceptions
#     COMMENTS:  none
#     SEE ALSO:  n/a
#===============================================================================
sub buildKeyList {
	my $count = 0;
	while ($count < $size) {
		my $key = getKey();
		unless (checkKey($key)) {
			$count++;
			push(@keys, $key);
			if ($debug) {
				print $count . ": " . $key . "\n";
			}
		}
	}
}	# ----------  end of subroutine buildKeyList  ----------


#===  FUNCTION  ================================================================
#         NAME:  buildCharList
#      PURPOSE:  place the symbols to the keys
#   PARAMETERS:  ????
#      RETURNS:  ????
#  DESCRIPTION:  ????
#       THROWS:  no exceptions
#     COMMENTS:  none
#     SEE ALSO:  n/a
#===============================================================================
sub buildCharList {
	foreach (@keys) {
		my $idx = rand($#symbols +1);
		push(@chars, $symbols[$idx]);
	}
}	# ----------  end of subroutine buildCharList  ----------


#===  FUNCTION  ================================================================
#         NAME:  saveList
#      PURPOSE:  writes the list of translations
#   PARAMETERS:  filename
#      RETURNS:  ????
#  DESCRIPTION:  ????
#       THROWS:  no exceptions
#     COMMENTS:  none
#     SEE ALSO:  n/a
#===============================================================================
sub saveList(*) {
	my $file = shift;

	open(FH, ">$file") || die ("Unable to write list-file ($file).");
	for (my $i = 0; $i <= $#keys; $i++) {
		print FH $chars[$i] . $keys[$i];
	}
	close(FH);
}	# ----------  end of subroutine saveList  ----------


#===  FUNCTION  ================================================================
#         NAME:  loadList
#      PURPOSE:  reads the key-list into the system
#   PARAMETERS:  filename
#      RETURNS:  list as 
#  DESCRIPTION:  ????
#       THROWS:  no exceptions
#     COMMENTS:  none
#     SEE ALSO:  n/a
#===============================================================================
sub loadList(*) {
	my $file = shift;

	@chars = ();
	@keys = ();

	my $string = '';

	open(FH, "<$file") || die("Unable to read list-file ($file).");
	while(<FH>) {
		$string .= $_;
	}
	close(FH);

	my $count = length($string);
	$count /= ($length +1);

	for (my $i = 0; $i < $count; $i++) {
		if ($debug) {
			print ($i + 1);
			print ": ";
			print substr($string, ($i * $length) + $i, 1);
			print "::";
			print substr($string, ($i * $length) + $i + 1, $length);
			print "\n";
		}

		push(@chars, substr($string, ($i * $length) + $i, 1));
		push(@keys, substr($string, ($i * $length) + $i + 1, $length));
	}
}	# ----------  end of subroutine loadList  ----------


#===  FUNCTION  ================================================================
#         NAME:  buildCharIndex
#      PURPOSE:  builds an index of chars and its key-positions
#   PARAMETERS:  ????
#      RETURNS:  ????
#  DESCRIPTION:  ????
#       THROWS:  no exceptions
#     COMMENTS:  none
#     SEE ALSO:  n/a
#===============================================================================
sub buildCharIndex {
	foreach my $symbol (@symbols) {
		$index{$symbol}=();
	}

	for (my $i = 0; $i < $#chars; $i++) {
		my $char = $chars[$i];
		push(@{$index{$char}}, $i);             # add an entry into the array in the hash
	}
}	# ----------  end of subroutine buildCharIndex  ----------


#===  FUNCTION  ================================================================
#         NAME:  encryptString
#      PURPOSE:  encrypts the plain-text
#   PARAMETERS:  data
#      RETURNS:  encrypted text
#  DESCRIPTION:  ????
#       THROWS:  no exceptions
#     COMMENTS:  none
#     SEE ALSO:  n/a
#===============================================================================
sub encryptString(*) {
	my $data = shift;
	my $string = '';

	for (my $i = 0; $i < length($data); $i++) {
		my $char = encryptChar(substr($data, $i, 1));
		$string .= $char;
	}

	return $string;
}	# ----------  end of subroutine encryptString  ----------


#===  FUNCTION  ================================================================
#         NAME:  encryptChar
#      PURPOSE:  encrypts one character
#   PARAMETERS:  ????
#      RETURNS:  ????
#  DESCRIPTION:  ????
#       THROWS:  no exceptions
#     COMMENTS:  none
#     SEE ALSO:  n/a
#===============================================================================
sub encryptChar(*) {
	my $char = shift;
	my @idx = @{$index{$char}};
	my $size = $#idx +1;
	my $ptr = $idx[rand($size)];

	return $keys[$ptr];
}	# ----------  end of subroutine encryptChar  ----------


#===  FUNCTION  ================================================================
#         NAME:  decryptString
#      PURPOSE:  decrypts an encrypted text
#   PARAMETERS:  plain text
#      RETURNS:  ????
#  DESCRIPTION:  ????
#       THROWS:  no exceptions
#     COMMENTS:  none
#     SEE ALSO:  n/a
#===============================================================================
sub decryptString(*) {
	my $data = shift;
	my $count = length($data);
	$count /= $length;
	my $string = '';
	my $key;
	my $char;

	for (my $i = 0; $i < $count; $i++) {
		$key = substr($data, ($i * $length), $length);
		$char = decryptChar($key);
		unless (defined($char)) {
			die("Unable to decrypt text. Invalid key ($key).");
		}

		$string .= $char;

		if ($debug) {
			print ($i + 1);
			print ": ";
			print $key . " => " . $char;
			print "\n";
		}
	}

	return $string;
}	# ----------  end of subroutine decryptString  ----------


#===  FUNCTION  ================================================================
#         NAME:  decryptChar
#      PURPOSE:  decrypts one character
#   PARAMETERS:  encrypted key
#      RETURNS:  decrypted character
#  DESCRIPTION:  ????
#       THROWS:  no exceptions
#     COMMENTS:  none
#     SEE ALSO:  n/a
#===============================================================================
sub decryptChar(*) {
	my $key = shift;

	for (my $i = 0; $i <= $#keys; $i++) {
		if ($keys[$i] eq $key) {
			return $chars[$i];
		}
	}
	return undef;
}	# ----------  end of subroutine decryptChar  ----------



1;

#!/usr/bin/perl
#-*-perl-*-

use FindBin qw( $Bin );

use Test::More;
use File::Compare;

my $PDF2XML = $Bin.'/../pdf2xml';

system("$Bin/../pdf2xml $Bin/french.pdf > output.xml 2>/dev/null");
is( compare( "output.xml", "$Bin/french.xml" ),0, "pdf2xml (standard)" );

system("$Bin/../pdf2xml -l $Bin/word-list.txt $Bin/french.pdf > output.xml 2>/dev/null");
is( compare( "output.xml", "$Bin/french.voc.xml" ),0, "pdf2xml (with word list)" );

# cleanup ....

unlink('output.xml');
done_testing;


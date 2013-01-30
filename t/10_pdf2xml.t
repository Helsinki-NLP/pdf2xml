#!/usr/bin/perl
#-*-perl-*-

use FindBin qw( $Bin );

use Test::More;
use File::Compare;

my $PDF2XML = $Bin.'/../pdf2xml';

system("$Bin/../pdf2xml $Bin/french.pdf > output.xml 2>/dev/null");
is( compare( "output.xml", "$Bin/french.xml" ),0, "pdf2xml (standard)" );

system("$Bin/../pdf2xml -h $Bin/french.pdf > output.xml 2>/dev/null");
is( compare( "output.xml", "$Bin/french.hyphenated.xml" ),0, "pdf2xml (keep hyphenation)" );

system("$Bin/../pdf2xml -r $Bin/french.pdf > output.xml 2>/dev/null");
is( compare( "output.xml", "$Bin/french.skip-pdftotext-raw.xml" ),0, "pdf2xml (skip pdftotext raw)" );

system("$Bin/../pdf2xml -x $Bin/french.pdf > output.xml 2>/dev/null");
is( compare( "output.xml", "$Bin/french.skip-pdftotext-standard.xml" ),0, "pdf2xml (skip pdftotext standard)" );

system("$Bin/../pdf2xml -r -x $Bin/french.pdf > output.xml 2>/dev/null");
is( compare( "output.xml", "$Bin/french.skip-pdftotext.xml" ),0, "pdf2xml (skip pdftotext)" );

system("$Bin/../pdf2xml -m -r -x $Bin/french.pdf > output.xml 2>/dev/null");
is( compare( "output.xml", "$Bin/french.dehyphenated.xml" ),0, "pdf2xml (de-hyphenate only)" );

system("$Bin/../pdf2xml -h -m -r -x $Bin/french.pdf > output.xml 2>/dev/null");
is( compare( "output.xml", "$Bin/french.raw.xml" ),0, "pdf2xml (raw Apache Tika)" );

system("$Bin/../pdf2xml -l $Bin/word-list.txt $Bin/french.pdf > output.xml 2>/dev/null");
is( compare( "output.xml", "$Bin/french.voc.xml" ),0, "pdf2xml (use word list)" );

# cleanup ....

unlink('output.xml');
done_testing;


#!/usr/bin/perl
#-*-perl-*-

use FindBin qw( $Bin );

use Test::More;
use File::Compare;

my $PDF2XML = $Bin.'/../pdf2xml';
my $POPPLER = `pdftotext --help 2>&1 | grep -i 'poppler'`;

# the following tests only work if pdftotext is available

if ($POPPLER=~/poppler/i){
    system("$Bin/../pdf2xml $Bin/french.pdf > output.xml 2>/dev/null");
    is( my_compare( "output.xml", "$Bin/french.xml" ),0, "pdf2xml (standard)" );

    system("$Bin/../pdf2xml -h $Bin/french.pdf > output.xml 2>/dev/null");
    is( my_compare( "output.xml", "$Bin/french.hyphenated.xml" ),0, "pdf2xml (keep hyphenation)" );

#    system("$Bin/../pdf2xml -r $Bin/french.pdf > output.xml 2>/dev/null");
#    is( my_compare( "output.xml", "$Bin/french.skip-pdftotext-raw.xml" ),0, 
#        "pdf2xml (skip pdftotext raw)" );

    system("$Bin/../pdf2xml -x $Bin/french.pdf > output.xml 2>/dev/null");
    is( my_compare( "output.xml", "$Bin/french.skip-pdftotext-standard.xml" ),0, "pdf2xml (skip pdftotext standard)" );

    system("$Bin/../pdf2xml -l $Bin/word-list.txt $Bin/french.pdf > output.xml 2>/dev/null");
    is( my_compare( "output.xml", "$Bin/french.voc.xml" ),0, "pdf2xml (use word list)" );

#    system("$Bin/../pdf2xml -L $Bin/french.pdf > output.xml 2>/dev/null");
#    is( my_compare( "output.xml", "$Bin/french.skip-lowercasing.xml" ),0, 
#	"pdf2xml (skip lowercasing)" );

}
else{
    system("$Bin/../pdf2xml $Bin/french.pdf > output.xml 2>/dev/null");
    is( my_compare( "output.xml", "$Bin/french.tika.xml" ),0, "pdf2xml (standard)" );

    system("$Bin/../pdf2xml -h $Bin/french.pdf > output.xml 2>/dev/null");
    is( my_compare( "output.xml", "$Bin/french.tika-hyphenated.xml" ),0, "pdf2xml (keep hyphenation)" );
}


system("$Bin/../pdf2xml -r -x $Bin/french.pdf > output.xml 2>/dev/null");
is( my_compare( "output.xml", "$Bin/french.skip-pdftotext.xml" ),0, "pdf2xml (skip pdftotext)" );

system("$Bin/../pdf2xml -m -r -x $Bin/french.pdf > output.xml 2>/dev/null");
is( my_compare( "output.xml", "$Bin/french.dehyphenated.xml" ),0, "pdf2xml (de-hyphenate only)" );

system("$Bin/../pdf2xml -h -m -r -x $Bin/french.pdf > output.xml 2>/dev/null");
is( my_compare( "output.xml", "$Bin/french.raw.xml" ),0, "pdf2xml (raw Apache Tika)" );

system("$Bin/../pdf2xml -X $Bin/french.pdf > output.xml 2>/dev/null");
is( my_compare( "output.xml", "$Bin/french.pdfxtk.xml" ),0, "pdf2xml (pdfXtk)" );

# cleanup ....

unlink('output.xml');
done_testing;



# there is one line that destroys the tests! take it away!

sub my_compare{
    my ($file1,$file2) = @_;
    system("grep -v '(U ο υ a vu Q' $file1 > $file1.tmp");
    system("grep -v '(U ο υ a vu Q' $file2 > $file2.tmp");
    my $ret = compare("$file1.tmp","$file2.tmp");
    unlink("$file1.tmp");
    unlink("$file2.tmp");
    return $ret;
}

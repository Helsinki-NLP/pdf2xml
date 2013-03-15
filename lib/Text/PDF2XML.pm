#-*-perl-*-

=encoding utf-8

=head1 NAME

pdf2xml - extract text from PDF files and wraps it in XML

=head1 SYNOPSIS

 pdf2xml [OPTIONS] pdf-file > output.xml

=head1 OPTIONS

 -h ............. skip de-hypenation (keep hyphenated words)
 -l lexicon ..... provide a list of words or a text in the target language
 -L ............. skip lowercasing (which is switched in by default)
 -m ............. skip merging character sequences (not recommended)
 -r ............. skip 'pdftotext -raw' (not recommended)
 -x ............. skip standard 'pdftotext'
 -X ............. use pdfXtk to convert to XHTML
 -v ............. verbose output

=head1 DESCRIPTION

pdf2xml calls pdftotext and Apache Tika to extract text from PDf files and to convert them to XML (actually XHTML). It also uses some heuristics to find words that should not be split into character sequences (which often happens with pdf-text extraction tools) and it also tries to put hyphenated words together.

Example: raw is without cleanup heuristics

  raw:    <p>PRESENTATION ET R A P P E L DES PRINCIPAUX RESULTATS 9</p>
  clean:  <p>PRESENTATION ET RAPPEL DES PRINCIPAUX RESULTATS 9</p>

  raw:    <p>2. Les c r i t è r e s de choix : la c o n s o m m a t i o n 
             de c o m b u s - t ib les et l e u r moda l i t é 
             d ' u t i l i s a t i on d 'une p a r t , 
             la concen t r a t ion d ' a u t r e p a r t 16</p>

  clean:  <p>2. Les critères de choix : la consommation 
             de combustibles et leur modalité 
             d'utilisation d'une part, 
             la concentration d'autre part 16</p>

=head1 TODO

This is quite slow and loading Apache Tika for each conversion is not very efficient. Using the server mode of Apache Tika would be a solution.

Character merging heuristics are very simple. Using the longest string forming a valid word from the vocabulary may lead to many incorrect words in context for some languages. Also, the implementation of the merging procedure is probably not the most efficient one.

De-hyphenation heuristics could also be improved. The problem is to keep it as language-independent as possible.

=head1 SEE ALSO

Apache Tika: L<http://tika.apache.org>

The Poppler Developers - L<http://poppler.freedesktop.org>

pdfXtk L<http://sourceforge.net/projects/pdfxtk/>


=head1 COPYRIGHT AND LICENSE

Copyright (C) 2013 by Joerg Tiedemann

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.8 or,
at your option, any later version of Perl 5 you may have available.

=cut

package Text::PDF2XML;

1;

__END__

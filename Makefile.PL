use inc::Module::Install;

name        'Text-PDF2XML';
abstract    'Convert PDF to XML';
author      'Joerg Tiedemann';
license     'gpl';
version     '0.2.9';

include     'Module::AutoInstall';

requires 'Encode'         => 0;
requires 'FindBin'        => 0;
requires 'Getopt::Std'    => 0;
requires 'IO::File'       => 0;
requires 'IPC::Open3'     => 0;
requires 'LWP::UserAgent' => 0;
requires 'XML::Parser'    => 0;
requires 'XML::Writer'    => 0;

recommends 'File::ShareDir' => 0;
recommends 'Lingua::Identify::Blacklists' => '0.04';

requires_external_bin 'java';
# pdftotext is not required anymore but recommended ....
# requires_external_bin 'pdftotext';

auto_install;

install_script 'pdf2xml';
install_share;

WriteAll;

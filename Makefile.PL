use inc::Module::Install;

name        'PDF2XML';
abstract    'Converting PDF to XML';
author      'Joerg Tiedemann';
license     'gpl';
version     '0.1';

include     'Module::AutoInstall';

requires 'IPC::Open2'  => 0;
requires 'XML::Parser' => 0;
requires 'XML::Writer' => 0;
requires 'Getopt::Std' => 0;
requires 'FindBin'     => 0;

recommends 'File::ShareDir' => 0;

requires_external_bin 'pdftotext';
requires_external_bin 'java';

auto_install;

install_script 'pdf2xml';
install_share;

WriteAll;

use inc::Module::Install;

name          'PDF2XML';
license       'gpl';
author        'Joerg Tiedemann';
version       '0.1';

abstract    'Converting PDF to XML';
author      'Joerg Tiedemann';

requires 'IPC::Open2'  => 0;
requires 'XML::Parser' => 0;
requires 'XML::Writer' => 0;
requires 'Getopt::Std' => 0;
requires 'FindBin'     => 0;

recommends 'File::ShareDir' => 0;

requires_external_bin 'pdf2text';
requires_external_bin 'java';

install_script 'pdf2xml';
install_share;

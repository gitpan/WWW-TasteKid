use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'WWW::TasteKid',
    AUTHOR              => 'David Wright <david_v_wright@yahoo.com>',
    VERSION_FROM        => 'lib/WWW/TasteKid.pm',
    ABSTRACT_FROM       => 'lib/WWW/TasteKid.pm',
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More'       => 0,
        'Readonly'         => 0,
        'XML::LibXML'      => 0,
        'Carp'             => 0,
        'Encode'           => 0,
        'LWP::Simple'      => 0,
        'Data::Dumper'     => 0,
        'Scalar::Util'     => 0,
        'URI::Escape'      => 0,
        'HTML::Entities'   => 0,
        'Class::InsideOut' => 0,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'WWW-TasteKid*' },
);
use version; our $VERSION = qv('1.0.0');
 

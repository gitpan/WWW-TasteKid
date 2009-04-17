use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'WWW::TasteKid',
    AUTHOR              => 'David Wright <david_v_wright@yahoo.com>',
    VERSION_FROM        => 'lib/WWW/TasteKid.pm',
    ABSTRACT_FROM       => 'lib/WWW/TasteKid.pm',
    PREREQ_PM => {
        'Test::More'       => 0.8,
        'Readonly'         => 1.03,
        'XML::LibXML'      => 1.66,
        'Encode'           => 2.23,
        'LWP::Simple'      => 5.810,
        'Data::Dumper'     => 2.121,
        'Scalar::Util'     => 1.19,
        'URI::Escape'      => 3.28,
        'HTML::Entities'   => 1.35,
        'Class::InsideOut' => 1.09,
        'Carp'             => 1.08,
        'File::Slurp'      => 9999.12
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'WWW-TasteKid*' },
);
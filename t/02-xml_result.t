#!perl -T
# /* vim:et: set ts=4 sw=4 sts=4 tw=78: */
#$Id: 02-xml_result.t,v 1.3 2009/09/22 08:10:10 dinosau2 Exp $

use strict;
use warnings;

use Test::More tests => 5;

use WWW::TasteKid;
use File::Basename qw/dirname/;
use Data::Dumper;
use XML::Simple;

my $tc = WWW::TasteKid->new;
$tc->query({ type => 'music', name => 'bach' });
$tc->ask;

my $res =  XMLin($tc->get_xml_result);

is $res->{info}->{resource}->{name}, 'Johann Sebastian Bach';

my @should_exist  = (
                      'George Frideric Handel',
                      'Gustav Mahler',
                      'Maurice Ravel',
                      'Wolfgang Amadeus Mozart'
                    );

foreach my $c (@should_exist){
    ok grep {/$c/} %{$res->{results}->{resource}};
}


#!/usr/bin/perl
use strict;
use warnings;

my $prefix = "/usr/local/bin";

if(`whoami` ne "root\n"){
  die "must be run as root; look at what i do first\n";
}

my @setuids = qw();
my %isSetuid = map {$_ => 1} @setuids;

sub run(@){
  print "exec: " . join(' ', @_) . "\n";
  system @_;
}

for my $x(`ls src`){
  chomp $x;
  run "rm $prefix/$x";
  run "cp src/$x $prefix";
  if($isSetuid{$x}){
    run "chmod +s $prefix/$x";
  }
}

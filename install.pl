#!/usr/bin/perl
use strict;
use warnings;

my $prefix = "/usr/local/bin";
my $bcDir = "/etc/bash_completion.d";

if(`whoami` ne "root\n"){
  die "must be run as root; look at what i do first\n";
}

sub run(@){
  print "exec: " . join(' ', @_) . "\n";
  system @_;
}

for my $x(`ls src`){
  chomp $x;
  run "rm $prefix/$x";
  run "cp src/$x $prefix";
}

run "cp src/bash_completion $bcDir/net-ssids";
run "chown root.root $bcDir/net-ssids";
run "chmod 644 $bcDir/net-ssids";


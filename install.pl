#!/usr/bin/perl
use strict;
use warnings;

my $prefix = "/usr/local/bin";
my $bcDir = "/etc/bash_completion.d";

sub runOrDie(@){
  print "@_\n";
  system @_;
  die "FAILED: @_\n" if $? != 0;
}

sub main(@){
  die "Usage: $0\n" if @_ > 0;

  if(`whoami` ne "root\n"){
    print "rerunning as root\n";
    exec "sudo", $0, @ARGV;
  }

  my $dir = `dirname $0`;
  chomp $dir;
  chdir $dir;

  for my $f(`ls src`){
    chomp $f;
    next if $f eq "bash_completion";
    runOrDie "cp", "src/$f", "$prefix";
  }

  runOrDie "cp", "src/bash_completion", "$bcDir/net-ssids";
  runOrDie "chown", "root.root", "$bcDir/net-ssids";
  runOrDie "chmod", "644", "$bcDir/net-ssids";
}

&main(@ARGV);

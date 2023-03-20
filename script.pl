#!/usr/bin/perl
use strict;
use warnings;

my $htmlpage = "lyrics.html";
my $script = "dl.sh";

open(my $in, "<", $htmlpage) || die "Can't open $htmlpage $!";
open(my $out, ">", $script) || die "Can't open $script $!";

print $out "#!/bin/sh\n\n\n";

my $version = "";
my $title = "";
my $file = "";
my $url = "";

while (<$in>)
{
	if (/(\d\.\d)<\/a>: "(.*)"/)
	{
		$version = $1;
		$title = $2;
	}
	if (/(https:\/\/ftp.openbsd.org\/pub\/OpenBSD\/songs\/song.*.mp3)/)
	{
		$url = $1;
		$_ = $url;
		if (/https:\/\/ftp.openbsd.org\/pub\/OpenBSD\/songs\/(song.*.mp3)/)
		{
			$file = $1;
		}

		print $out "curl -O $url\n";
		print $out "id3tag --artist \"openBSD\" --album \"$version\" --song \"$title\" \"$file\"\n";
	}
}

close $in;
close $out;

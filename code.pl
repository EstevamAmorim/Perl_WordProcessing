#!usr/bin/perl
use warnings;
use strict;

my $filename = '2020.2-poesias_machado_de_assis.txt';

open(FILE, '<', $filename) or die $!;

my $text;
my $matches;
my $characters_result;
my $words_result;
my $verse_result;
my $stanza_result;
my $title_characters;
my $title_words;

while(<FILE>)
{	
	$text .= $_; 
}

close(FILE);

#Text treatment, converting windows formatting to linux formatting, adjusting the amount of line breaks between stanzas and removing   #dates from below the titles is performed.

$text =~ s,\r\n,\n,g;
$text =~ s,(.\n.+\n\n)\n.,$1,g;
$text =~ s,\(\d\d.+\d\d\d\d\)\n\n\n,\n,g;

#------------------------------------------------------------------------------------------------

my $character_count = () = $text =~ /\S/g;
my $word_count = () = $text =~ /\S+/g;

my $poem_count = () = $text =~ /.\n{3}./g;
print "Total number of poems: $poem_count\n";

my $verse_count = () = $text =~ /.\n.|.\n{2}.|.\n{3}./g;
print "Total number of verses: $verse_count\n";

my $stanza_count = () = $text =~ /.\n{2}.|.\n{3}./g;
print "Total number of stanzas: $stanza_count\n";

$matches = () = $text =~ /\n{2}\N+\n\N+\n\N+\n\N+\n\N+\n\N+((?=\n{2})|$)/g;
print "Total number of stanzas sextiles: $matches\n";

$matches = () = $text =~ /\n{3}\N+\n\N+\n\N+\n\N+\n{2}\N+\n\N+\n\N+\n\N+\n{2}\N+\n\N+\n\N+\n{2}\N+\n\N+\n\N+(\n{5}|$)/g;
print "Number of sonnets: $matches\n";

$title_characters = () = (join(' ', $text =~ /.+(?=\n\n\n.)/g) =~ /\S/g);
$title_words = () = (join(' ', $text =~ /.+(?=\n\n\n.)/g) =~ /\S+/g);

$words_result = sprintf('%.1f', ($word_count - $title_words) / $verse_count);
$characters_result = sprintf('%.1f', ($character_count - $title_characters) / $verse_count);

print "Average length of verses: $characters_result characters and $words_result words. \n";

$characters_result = sprintf('%.1f', ($character_count - $title_characters) / $stanza_count);
$words_result = sprintf('%.1f', ($word_count - $title_words) / $stanza_count);
$verse_result = sprintf('%.1f', $verse_count / $stanza_count);

print "Average length of stanzas: $characters_result characters, $words_result words and $verse_result verses. \n";

$characters_result = sprintf('%.1f', ($character_count / $poem_count));
$words_result = sprintf('%.1f', ($word_count / $poem_count));
$verse_result = sprintf('%.1f', $verse_count / $poem_count);
$stanza_result = sprintf('%.1f', $stanza_count / $poem_count);

print "Average size of poems (counting titles): $characters_result characteres, $words_result words, $verse_result verses and $stanza_result stanzas. \n";

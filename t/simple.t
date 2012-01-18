#!/usr/bin/perl

use strict;
use warnings;

use Test::More tests => 16;
use_ok('HTML::Fraction');

# these are adapted forms of leon's tests

my $f = HTML::Fraction->new;
isa_ok($f, 'HTML::Fraction');

is($f->tweak("Hi there"), "Hi there");
is($f->tweak("Half is 1/2"), "Half is &frac12;");
is($f->tweak("1/2 of 1/2 is 1/4"),  "&frac12; of &frac12; is &frac14;");
is($f->tweak("1/5 of 1/5 is 1/25"), "&#8533; of &#8533; is 1/25");

# my own tests

is($f->tweak("Half is 0.5 or .5 or 000.5 or 0.5000"),
   "Half is &frac12; or &frac12; or &frac12; or &frac12;");

is($f->tweak("Third is .33 or 0.33 or 0.333 or 0.3333 but not 0.3"),
             "Third is &#8531; or &#8531; or &#8531; or &#8531; but not 0.3");
   
is($f->tweak("Two Thirds is .667 or 0.67 or 0.667 or 0.6667"),
             "Two Thirds is &#8532; or &#8532; or &#8532; or &#8532;");

is($f->tweak("One sixth is .167 or 0.17 or 0.1667 or 0.16667"),
             "One sixth is &#8537; or &#8537; or &#8537; or &#8537;");


is($f->tweak("Five sixth is .83 or 0.833 or 0.8333 or 0.8333"),
             "Five sixth is &#8538; or &#8538; or &#8538; or &#8538;");


isnt($f->tweak("Two Thirds is 0.6"),  # this will be encoded as 3/5
               "Two Thirds is &#8532;");

isnt($f->tweak("Two Thirds is 0.66"),  # this will be left alone
               "Two Thirds is &#8532;");

isnt($f->tweak("Two Thirds is 0.7"),  # this is just wrong
               "Two Thirds is &#8532;");


# right, make sure we're not eating things we shouldn't
is($f->tweak("ten and a half is 10.5"),
             "ten and a half is 10&frac12;");

is($f->tweak("hundred and a half is 100.5"),
             "hundred and a half is 100&frac12;")
     or Dump($f->tweak("hunderd and a half is 100.5"));
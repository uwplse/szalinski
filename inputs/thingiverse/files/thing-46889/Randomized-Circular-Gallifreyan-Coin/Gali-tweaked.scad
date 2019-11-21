$fn=64;

// Word to display (must be all lower case, no punctuation)
word = "thingiverse";

// Radius of coin
outer_radius = 42;

// Thickness of coin
coin_thickness = 2;

// Radius of writing
pendant_radius = 30;

// Radius of the large circles in a letter
letter_radius = 10;

// Thickness of writing
line_thickness = 1;

// Height of writing
line_height = 1;

// seed for random numbers
seed=70;

random_vect=rands(-30,30,20,seed);
echo(random_vect);

/////////////////////////////////////////
//CUSTOMIZER VARIABLES END
/////////////////////////////////////////

large_circle_radius = letter_radius;
small_circle_radius = letter_radius/4;

large_dot_radius = letter_radius/7;
small_dot_radius = letter_radius/8;

dot_offset = large_circle_radius/4*3;

chars_in_word = lenWord(word, 0, len(word));
spacing_angle = 360 / chars_in_word;

// draw the coin if it's valid
if (len(word) > 0 && isValidWord(word))
{
  difference()
  {
    linear_extrude(height=coin_thickness)
      circle(outer_radius);

    translate([0,0,coin_thickness-line_height])
      linear_extrude(height=line_height+0.1)
      rotate([0,0,-90])
      write_circle();
  }
}
else
{
  echo("invalid input");
}

/////////////////////////////////////////
// TEXT HELPER ROUTINES

function isVowel(t,p,l) = (l - p > 0)
                       && (t[p] == "a" || t[p] == "e" || t[p] == "i" || t[p] == "o" || t[p] == "u");
function isConsWithH(t,p,l) = (l - p > 1)
                           && (t[p+1] == "h")
                           && (t[p] == "t" || t[p] == "s" || t[p] == "c");
function isConsNG(t,p,l) = (l - p > 1)
                        && t[p] == "n"
                        && t[p+1] == "g";
function isConsQU(t,p,l) = (l - p > 1)
                        && t[p] == "q"
                        && t[p+1] == "u";
function isCons2(t,p,l) = isConsWithH(t,p,l) || isConsNG(t,p,l) || isConsQU(t,p,l);
function isCons1(t,p,l) = (l - p > 0)
                       && (t[p] == "b" || t[p] == "d" || t[p] == "f" || t[p] == "g" || t[p] == "h" ||
                           t[p] == "j" || t[p] == "k" || t[p] == "l" || t[p] == "m" || t[p] == "n" ||
                           t[p] == "p" || t[p] == "t" || t[p] == "r" || t[p] == "s" || t[p] == "v" ||
                           t[p] == "w" || t[p] == "y" || t[p] == "z" || t[p] == "x");
function isCons2WithVowel(t,p,l) = isVowel(t,p+2,l) && isCons2(t,p,l);
function isCons1WithVowel(t,p,l) = isVowel(t,p+1,l) && isCons1(t,p,l);

function isValid(t,p,l) = l == p ? true
                        : isVowel(t,p,l) ? isValid(t,p+1,l)
                        : isCons2(t,p,l) ? isValid(t,p+2,l)
                        : isCons1(t,p,l) ? isValid(t,p+1,l) : false;

function lenWord(t,p,l) = isVowel(t,p,l) ? 1 + lenWord(t,p+1,l)
                        : isCons2WithVowel(t,p,l) ? 1 + lenWord(t,p+3,l)
                        : isCons1WithVowel(t,p,l) ? 1 + lenWord(t,p+2,l)
                        : isCons2(t,p,l) ? 1 + lenWord(t,p+2,l)
                        : isCons1(t,p,l) ? 1 + lenWord(t,p+1,l)
                        : 0;

function isValidWord(txt) = isValid(txt,0,len(txt));

function isLetterStart(s,t,p,l) = s == p ? true
                                : s < p ? false
                                : isVowel(t,p,l) ? isLetterStart(s,t,p+1,l)
                                : isCons2WithVowel(t,p,l) ? isLetterStart(s,t,p+3,l)
                                : isCons1WithVowel(t,p,l) ? isLetterStart(s,t,p+2,l)
                                : isCons2(t,p,l) ? isLetterStart(s,t,p+2,l)
                                : isCons1(t,p,l) ? isLetterStart(s,t,p+1,l)
                                : false;
function whichLetter(s,t,p,l) = s <= p ? 0
                                : isVowel(t,p,l) ? 1 + whichLetter(s,t,p+1,l)
                                : isCons2WithVowel(t,p,l) ? 1 + whichLetter(s,t,p+3,l)
                                : isCons1WithVowel(t,p,l) ? 1 + whichLetter(s,t,p+2,l)
                                : isCons2(t,p,l) ? 1 + whichLetter(s,t,p+2,l)
                                : isCons1(t,p,l) ? 1 + whichLetter(s,t,p+1,l)
                                : 0;

/////////////////////////////////////////
// GENERATE THE WRITING

module write_circle()
{
  for (letter = [0 : len(word)-1])
  {
    if (isLetterStart(letter, word, 0, len(word)))
    {
      rotate([0, 0, spacing_angle * whichLetter(letter, word, 0, len(word))])
        translate([pendant_radius, 0, 0])
        write_circle_letter(word, letter, len(word));
    }
  }
}

module write_circle_letter(t,p,l)
{
  // centered around positive x-axis

  if (p < l)
  {
    if (isVowel(t,p,l))
    {
      translate([-pendant_radius, 0, 0])
        arc_segment(spacing_angle, pendant_radius);

      write_vowel(t[p]);
    }
    else if (isCons2(t,p,l))
    {
      write_consonant(str(t[p],t[p+1]), isCons2WithVowel(t,p,l) ? t[p+2] : undef);
    }
    else if (isCons1(t,p,l))
    {
      write_consonant(t[p], isCons1WithVowel(t,p,l) ? t[p+1] : undef);
    }
    else
    {
      echo("wha? invalid character");
    }
  }
}

module write_vowel(c)
{
  if (c == "a")
  {
    translate([letter_radius/2,0,0])
      circle_line(small_circle_radius);
  }
  else if (c == "e")
  {
    circle_line(small_circle_radius);
  }
  else if (c == "i")
  {
    circle_line(small_circle_radius);
    rotate([0,0,180])
      rotate([0,0,random_vect[0]]) translate([small_circle_radius,0,0])
        line(letter_radius - small_circle_radius+2*outer_radius);
  }
  else if (c == "o")
  {
    translate([-letter_radius/2,0,0])
    circle_line(small_circle_radius);
  }
  else if (c == "u")
  {
    circle_line(small_circle_radius);
    rotate([0,0,random_vect[7]]) translate([small_circle_radius,0,0])
      line(letter_radius - small_circle_radius+2*outer_radius);
  }
  else
  {
    echo("wha? invalid vowel");
  }
}

module write_consonant(c,v)
{
  // SET 1
  if (c == "b" || c == "ch" || c == "d" || c == "f" || c == "g" || c == "h")
  {
    difference()
    {
      union()
      {
        translate([-pendant_radius, 0, 0])
          arc_segment(spacing_angle, pendant_radius);
        translate([-large_circle_radius,0,0])
          circle_line(large_circle_radius);
      }
      square(small_circle_radius*2, center=true);
    }

    translate([-large_circle_radius,0,0])
    {
      if (c == "ch")     write_circle_modifier(1);
      else if (c == "d") write_circle_modifier(2);
      else if (c == "f") write_circle_modifier(3);
      else if (c == "g") write_circle_modifier(4);
      else if (c == "h") write_circle_modifier(5);

      if (v) write_vowel(v);
    }
  }
  // SET 2
  else if (c == "j" || c == "k" || c == "l" || c == "m" || c == "n" || c == "p")
  {
    translate([-pendant_radius, 0, 0])
      arc_segment(spacing_angle, pendant_radius);

    translate([-large_circle_radius-large_dot_radius,0,0])
    {
      circle_line(large_circle_radius);

      if (c == "k")      write_circle_modifier(1);
      else if (c == "l") write_circle_modifier(2);
      else if (c == "m") write_circle_modifier(3);
      else if (c == "n") write_circle_modifier(4);
      else if (c == "p") write_circle_modifier(5);

      if (v) write_vowel(v);
    }
  }
  // SET 3
  else if (c == "t" || c == "sh" || c == "r" || c == "s" || c == "v" || c == "w")
  {
    difference()
    {
      translate([-pendant_radius, 0, 0])
        arc_segment(spacing_angle, pendant_radius);
      circle(large_circle_radius - line_thickness/2);
    }
    difference()
    {
      rotate(180) arc_segment(180, large_circle_radius);
      difference()
      {
        translate([-pendant_radius,0,0]) circle(pendant_radius+large_circle_radius);
        translate([-pendant_radius,0,0]) circle(pendant_radius);
      }
    }

    if (c == "sh")     write_circle_modifier(1);
    else if (c == "r") write_circle_modifier(2);
    else if (c == "s") write_circle_modifier(3);
    else if (c == "v") write_circle_modifier(4);
    else if (c == "w") write_circle_modifier(5);

    if (v) write_vowel(v);
  }
  // SET 4
  else if (c == "th" || c == "y" || c == "z" || c == "ng" || c == "qu" || c == "x")
  {
    translate([-pendant_radius, 0, 0])
      arc_segment(spacing_angle, pendant_radius);

    circle_line(large_circle_radius);

    if (c == "y")       write_circle_modifier(1);
    else if (c == "z")  write_circle_modifier(2);
    else if (c == "ng") write_circle_modifier(3);
    else if (c == "qu") write_circle_modifier(4);
    else if (c == "x")  write_circle_modifier(5);

    if (v) write_vowel(v);
  }
  else
  {
    echo("wha? invalid consonant");
  }
}

module write_circle_modifier(y)
{
  if (y == 1)
  {
    rotate(-45) translate([-dot_offset,0,0]) circle(large_dot_radius);
    rotate(-70) translate([-dot_offset,0,0]) circle(small_dot_radius);
  }
  else if (y == 2)
  {
    rotate(-40) translate([-dot_offset,0,0]) circle(small_dot_radius);
    rotate(-65) translate([-dot_offset,0,0]) circle(large_dot_radius);
    rotate(-90) translate([-dot_offset,0,0]) circle(small_dot_radius);
  }
  else if (y == 3)
  {
    rotate(180+15+random_vect[1]) translate([large_circle_radius,0,0]) line(letter_radius+2*outer_radius);
    rotate(180+random_vect[2]   ) translate([large_circle_radius,0,0]) line(letter_radius+2*outer_radius);
    rotate(180-random_vect[3]) translate([large_circle_radius,0,0]) line(letter_radius+2*outer_radius);
  }
  else if (y == 4)
  {
    rotate(180   ) translate([large_circle_radius,0,0]) line(letter_radius+2*outer_radius);
  }
  else if (y == 5)
  {
    rotate(180+15+random_vect[4]) translate([large_circle_radius,0,0]) line(letter_radius+2*outer_radius);
    rotate(180-15+random_vect[5]) translate([large_circle_radius,0,0]) line(letter_radius+2*outer_radius);
  }
}

/////////////////////////////////////////
// WRITING HELPERS

module arc_segment(angle, radius, thick)
{
  // centered around positive x-axis

  pos_x = cos(angle/2) * radius * 1.5;
  pos_y = sin(angle/2) * radius * 1.5;

  intersection()
  {
    if (angle < 360)
      polygon([ [0,0], [pos_x,-pos_y], [radius * 1.5,0], [pos_x,+pos_y] ]);

    circle_line(radius);
  }
}

module circle_line(radius)
{
  difference()
  {
    circle(radius + line_thickness/2);
    circle(radius - line_thickness/2);
  }
}

module line(length)
{
  translate([0,-line_thickness/2,0])
    square([length, line_thickness]);
}

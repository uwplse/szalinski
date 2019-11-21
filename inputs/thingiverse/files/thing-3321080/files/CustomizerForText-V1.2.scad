/*
46 Room Signs Like "The Office" Logo by Lyl3
Licensed under the Creative Commons - Attribution - Share Alike license
https://www.thingiverse.com/thing:3321080

Creates the parts, other than the pictogram, for a room sign
   like the logo for the TV show "The Office"
   
V1.1 Fixed the automatic scaling to an algorithm that doesn't degenerate
     into 0 and negative numbers when the number of characters is 25 or more
V1.2 Output options changed to just "Everything" and "Text Only", removing "Base only" and "Square only" choices since they're now in the ZIP file if needed
*/

$fn=50+0;
fudge = 0.01 + 0.01;

/* [Parameters] */

// Word(s) on first line
string_1 = "The"; 

// Word(s) on second line
string_2 = "??Mystery Room??"; 

// The size of the text is scaled down for room names longer than 8 characters. Some letters take more space than others, so the scaling is just an estimate and may need to be adjusted here. 
text_scaling_ratio = 1; // [0.5:0.01:3]

/* [Advanced Parameters] */

// Which model would you like to see in the preview? (When "Create Thing" is clicked, both STL files will be created)
part = 4; // [1:Text only, 4:Everything]
//part = 4; // [1:Text only, 2:Square only, 3:Base only, 4:Everything]

// If you need to access glyphs for other languages, you can override the default font. You can specify any font from the Google fonts repository. Enter the font name and style with a colon character in between as in "Sawarabi Gothic:regular"
select_font = "Arial:bold";
//select_font = "Noto Serif CJK JP:regular";

/* [Hidden] */
auto_scale = (len(string_2) > 8) ?  14 / ( len(string_2) + 6 ) : 1;
scaling = auto_scale * text_scaling_ratio;

/* Create the text part */
if (part == 1 || part == 4) {
  color ("white") translate ([-84,-2-(9*(1-scaling)),2])
    linear_extrude(1) text (string_1, size=10.8*scaling, font=select_font);
  color ("white") translate ([-83.35,-21.55+(9*(1-scaling)),2])
    linear_extrude(1) text (string_2, size=15*scaling, font=select_font);
}

/* Create the square outline part */
if (part == 2 || part == 4) {
  color ("white") translate ([58.275,0,2])
  difference () {
    linear_extrude (1) minkowski()
    {
      square ([53.9,50.4],center=true);
      circle (3.5);
    }

    translate([0,0,-fudge/2]) linear_extrude (1+fudge) minkowski()
    {
      square ([53.9,50.4],center=true);
      circle (2.7);
    }
  }
}

/* Create the base part */
if (part == 3 || part == 4) {
  color ("black") 
  linear_extrude (2) minkowski()
  {
    square ([173,49.56],center=true);
    circle (6);
  }
}


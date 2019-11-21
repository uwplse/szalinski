// quick tips:
// 1. stick to capital letters
// 2. ? and ! and anything else with a dot is right out
// 3. you can always change the font if you find a better one

// Increase when using openSCAD; decrease if customizer starts timing out.
rounding=32; // [5:256]

font_size = 32;

// first word
word1 = "WORD";

// second word
word2 = "PLAY";

// how much extra spacing is between letters. may have to adjust depending on font size
extra_word_spacing = -5;

// how offset the second word is from the first
rotation=90; // [45:135]

// how much further the letters extrude before they are intersected. you will need to lengthen this if you change the rotation
extra_extrusion_length = 0; // [100]

// how much the base curves. set to 0 for no curve
curvature_factor = 0.5; // [0:0.05:3]

// how thick the base under the words is
base_thickness = 5;

font="DejaVu Sans Mono:style=Bold";

// the words need to be equal in length to work
/* assert(len(word1) == len(word2)); */

// derived variables
length = max(len(word1), len(word2));
word_spacing = font_size + extra_word_spacing;
extrusion_length = font_size + extra_extrusion_length;

half_spacing = word_spacing*(length-1)/2;

// you can change the empty string to a UTF8 full block, but Thingiverse Customizer can't handle it
function letterText(word, index) = (index >=len(word) || word[index] == " ") ? "" : word[index];

// finds the position of the letter based off the index
module letter_position(i, cf = curvature_factor) {
  current_letter_delta = word_spacing * i;

  function curvature(i, length, factor) = pow((i-(length-1)/2),2) * factor;

  translate([current_letter_delta,base_thickness,-current_letter_delta]){
    translate([curvature(i, length, cf), 0, curvature(i, length, cf)]) {
      children();
    }
  }
}

module words() {
  for (i = [0:length-1]) {
    // the whole thing is done on its side, so this rotates it to a normal position
    rotate([90,0,0]) {
      letter_position(i) {
        letter1 = letterText(word1, i);
        letter2 = letterText(word2, i);
        // for debugging you can change this to union()
        intersection() {
          if (letter1 != ""){
            linear_extrude(extrusion_length, center=true) {
              text(letter1, font=font, halign="center", size=font_size, $fn=rounding);
            }
          }

          // rotates one word to oppose the other
          if(letter2 != ""){
            rotate([0,rotation,0]) {
              linear_extrude(extrusion_length, center=true) {
                text(letter2, font=font, halign="center", size=font_size, $fn=rounding);
              }
            }
          }
        }
      }
    }
  }
}

// straight bar, doesn't work with curvature, doesn't scale currently
module base1() {
  rotate(-45) linear_extrude(height=2) offset(r=2, $fn=24) square([7.5,10*(length)], center=true);
}

// hull of the projections of the letters.
module base2() {
  linear_extrude(2) offset(2, $fn=24) hull() projection() words();
}

// successive hull (in slices of 2) of cylinders underneath the letters
module base3() {
  rotate([90,0,0]) {
    for (i = [0:length-2]) {
      hull() {
        // no idea why 1.75
        letter_position(i) rotate([90,0,0]) cylinder(r=extrusion_length/1.75, h=base_thickness, $fn=rounding);
        letter_position(i+1) rotate([90,0,0]) cylinder(r=extrusion_length/1.75, h=base_thickness, $fn=rounding);
      }
    }
  }
}

rotate(-45) translate([-half_spacing,-half_spacing,0]) {
  words();
  base3();
}

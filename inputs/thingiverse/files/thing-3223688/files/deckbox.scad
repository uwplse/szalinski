
//For a normal deck [37]; for 2 decks [37, 37], etc
compartiments = [37];

//Thickness of the walls
wall = 2.5; // Between 2 and 4

// The kind of window you want (0 for none, 1 for three small, 2 for one big)
window = 1; // [0, 1, 2]

// First line of text (I recommend putting your deck name).
// Escape double quotes if necessary, example: "Sir \"Green\" Svenson"
text1 = "Call of the Archons";
// Second line of text (optional)
text2 = "";
// The size of this text (adjust according to the deck name length)
textsize = 4.5;
// Check if you double sleeve the cards
doubleSleeved = false;

cardW = 67.5;
cardH = 93.4;
// Card thickness. (standard dragon shield MTG sleeve with card)
cardT = doubleSleeved ? 0.71 : 0.61;

// Adjust the window showing the house logos
windowPosition = 18;
flexibleClips = true;

tolerance = 1 + 0; // '+ 0' to ensure it's excluded from Customizer
nComps = len(compartiments);
sizes = compartiments * cardT;
totalDepth = sum(sizes) + wall * nComps + wall + tolerance * nComps;
innerDepth = totalDepth - wall * 2;

// MAIN

deckbox();
lid();

// MODULES

module window() {
  if (window == 1) { // 3 round holes
    // left house
    translate([(cardW + wall * 2) / 2 - 20, -1, windowPosition + 5])
    rotate([-90, 0, 0])
    cylinder(h = wall * 2, d1 = 20, d2 = 16);

    // middle house
    translate([(cardW + wall * 2) / 2, -1, windowPosition]) rotate([-90, 0, 0])
    cylinder(h = wall * 2, d1 = 20, d2 = 16);

    // right house
    translate([(cardW + wall * 2) / 2 + 20, -1, windowPosition + 5]) rotate([-90, 0, 0])
    cylinder(h = wall * 2, d1 = 20, d2 = 16);
  } else if (window == 2) {
    hull() { // 1 big hole
      // left house
      translate([(cardW + wall * 2) / 2 - 20, -1, windowPosition + 5])
      rotate([-90, 0, 0])
      cylinder(h = wall * 2, d1 = 20, d2 = 16);

      // middle house
      translate([(cardW + wall * 2) / 2, -1, windowPosition])
      rotate([-90, 0, 0])
      cylinder(h = wall * 2, d1 = 20, d2 = 16);

      // right house
      translate([(cardW + wall * 2) / 2 + 20, -1, windowPosition + 5])
      rotate([-90, 0, 0])
      cylinder(h = wall * 2, d1 = 20, d2 = 16);
    }
  }
}

module logo() {
  // Keyforge logo
  translate([(cardW + wall * 2) / 2 - 25, 1, 55])
  resize([50, 2, 25])
  rotate([90, 0, 0])
  linear_extrude(height = 2)
  import (file = "keyforge.dxf");
}

module lid() {
  margin = 0.2;
  translate([cardW + wall * 2 + 5, 0, 0])
  difference(){
    translate([wall / 2, wall, 0])
    minkowski(){
      cube([cardW - margin, innerDepth, wall - 1 - margin]);
      cylinder(r = wall, h = 1);
    }

    cube([wall / 2, wall, wall]);

    translate([wall * 0.5, wall / 2, wall / 2])
    sphere(r = wall / 3);

    translate([-wall - 0.4, 0, 0])
    rotate([0, 27, 0])
    cube([wall, totalDepth, wall * 2]);

    translate([cardW + wall / 2 - margin, 0, 0])
    cube([wall / 2, wall, wall]);

    translate([cardW + wall * 0.5 - margin, wall / 2, wall / 2])
    sphere(r = wall / 3);

    translate([cardW + wall * 2 + 0.4 - margin, totalDepth, 0])
    rotate([0, 27, 180])
    cube([wall, totalDepth, wall * 2]);

    if (text2 == "") {
      // Deck name is 1 line
      translate([(cardW + wall - margin) / 2, (totalDepth) / 2, wall - 1])
      linear_extrude(height = 1.3){
        text(text1, halign = "center", valign = "center", size = textsize, font="Arial:style=Bold");
      }

    } else {
      // Deck name is 2 lines
      translate([(cardW + wall - margin) / 2, (totalDepth) / 2+5, wall - 1])
      linear_extrude(height = 1.3){
        text(text1, halign = "center", valign = "center", size = textsize, font="Arial:style=Bold");
      }

      translate([(cardW + wall - margin) / 2, (totalDepth) / 2 - textsize, wall - 1])
      linear_extrude(height = 1.3){
        text(text2, halign = "center", valign = "center", size = textsize, font="Arial:style=Bold");
      }
    }

    if(flexibleClips){
      translate([wall, 0, 0])
      cube([1, 8, wall + 1]);

      translate([cardW - margin - 1, 0, 0])
      cube([1, 8, wall + 1]);
    }
  }
}

module deckbox(){
  difference(){
    union(){
      translate([wall, wall, 0])
      minkowski(){
        cube([cardW, innerDepth, cardH + wall - 1]);
        cylinder(r = wall, h = 1);
      }
      difference(){
        translate([wall, wall, wall + cardH])
        minkowski(){
          cube([cardW, innerDepth, wall - 1]);
          cylinder(r = wall, h = 1);
        }

        difference(){
          translate([wall, -1, wall + cardH])
          cube([cardW, totalDepth + 2, wall * 1 + 1]);

          translate([wall * 0.83, wall / 2, cardH + wall * 1.5])
          sphere(r = wall / 3);

          translate([cardW + wall * 1.17, wall / 2, cardH + wall * 1.5])
          sphere(r = wall / 3);

        }

        translate([wall / 2, wall, wall + cardH])
        rotate([0, 27, 0])
        cube([wall, totalDepth + 2, wall * 2]);

        translate([cardW + wall * 1.5, totalDepth + wall, wall + cardH])
        rotate([0, 27, 180])
        cube([wall, totalDepth, wall * 2]);
      }
    }

    // Top holes to pull cards out
    translate([cardW / 2 + wall, -1, cardH + wall])
    rotate([-90, 0, 0])
    cylinder(h = totalDepth + 2, d = 20);

    for(i = [0 : (nComps - 1)]){
      translate([wall, sum(sizes, 0, i) + (i * wall) + wall + i * tolerance, wall])
      cube([cardW, sizes[i] + tolerance, cardH + 1]);
    }

    logo();
    window();
  }
}

function sum(array, from = 0, to = 2000000000) = (from < to  && from < len(array) ? array[from] + sum(array, from + 1, to) : 0);

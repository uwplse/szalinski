// Standard poker chips are 39, 43, 47, or 49mm.
size = 39; // [30:60]

// Standard poker chips are 3.5mm thick.
thickness = 3.5;  // [2:.5:6]

// Width of the outer rim, used to imprint text
rim = 6; // [4:10]

quality = 40; // [20:Draft, 40:Standard, 100:High]

bevel_style = "a"; // [a:Angled, r:Rounded, n:None]
bevel = bevel_style == "n" ? 0 : .25;
bevel_facets = bevel_style == "a" ? 4 : 16;

rim_symbol = "\u2666"; // [\u25CF:Circle, \u25A0:Square, \u25B2:Triangle, \u2660:Spade, \u2663:Club, \u2665:Heart, \u2666:Diamond, \u2588:Cut Edge, none:None]
center_symbol = "nerdhaus"; // [nerdhaus:Nerdhaus Logo, \u2660:Spade, \u2663:Club, \u2665:Heart, \u2666:Diamond, none:None]

makeToken();

module makeToken() {
  makeTop();
  rotate([180]) makeTop();
}

module makeTop() {
  difference() {
    if (bevel_style == "n") {
      cylinder(h=thickness/2, d=size, $fn=quality);
    }
    else {
      hull() {
        rotate_extrude($fn = quality)
        translate([size/2, -bevel]) // A little overlap never hurt anyone
          hull() {
            translate([-bevel, thickness/2]) circle(r=bevel, $fn = bevel_facets);
            translate([-bevel, 0]) square(bevel);
          }
        }
      }
    makePattern();
  }
}

module makePattern() {
  translate([0,0,thickness/2 - .6]) {
    // Stick a nice circle on it
    rotate_extrude($fn = quality) translate([size/2 - rim -.5,0]) square(1);
    
    // Add a symbol in the center
    if (center_symbol == "none") {
      // No operation here.
    }
    else if (center_symbol == "nerdhaus") {
      scale([(size/2 - rim)/7,(size/2 - rim)/7]) nerdhaus(1);
    }
    else {
      linear_extrude(height=1)
      text(center_symbol, $fn = quality, size=size-rim*3, valign="center", halign="center");
    }
    
    // Rotate a symbol around the edge
    for (i = [0:20:360]) {
      rotate([0,0,i]) translate([0,size/2 - rim/2]) linear_extrude(height=1) {
        text(rim_symbol, $fn = quality, size=rim/1.7, valign="center", halign="center");
      }
    }
  }
}


/* Standard Nerdhaus logo stamp */
module nerdhaus(h = 1) {
  linear_extrude(height=h)
    polygon([[1.894990,0.863885],[1.894990,-2.944385],[-1.915271,0.863885],[-2.867510,0.863885],[-2.867510,-4.292885],[-1.915010,-4.292885],[-1.910190,-0.487875],[1.896800,-4.292885],[2.847492,-4.292885],[2.847492,0.863885]]);
  linear_extrude(height=h)
    polygon([[1.882472,3.093735],[-0.016830,3.853585],[-4.915385,1.879915],[-4.559422,0.996435],[-0.015576,2.827185],[4.561582,0.995995],[4.915385,1.880355],[2.834972,2.712665],[2.834972,4.292885],[1.882472,4.292885]]);
}
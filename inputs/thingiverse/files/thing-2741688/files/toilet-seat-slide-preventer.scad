// Version 1.0, Dec 31, 2017
// https://www.thingiverse.com/thing:2741688
// (C) Matthew Nielsen (xunker@pyxdis.org), 2018
// License: Created Commons - Attribution - Non-Commercial - Share ALike

// the clip is the main piece
render_clip = 1;  // [1:Yes,0:No]

// Number of pins to render. Pins are the dowel pins that connect the piece to the seat
render_pins = 2; // [0:2]

// Pin Diameter
pin_d = 6.0;

// Pin Height -- remember to include the part that inserts into the clip, too
pin_h = 7;

// Spacing between the pin holes on the clip, on-centre
pin_spacing = 30.5;

// width of the main body EXCLUDING the flange portion
clip_w = 17.5;

// length of the main body EXCLUDING the flange portion
clip_l = 48;

// height of the main body EXCLUDING the flange portion
clip_h = 8;

// How far is the inner edge retaining flange from the main body of the clip?
flange_offset = 5.5;

// Height of the retaining flange IN ADDITION TO clip_h
flange_h = 12;

// Thickness of the flange (on y-axis)
flange_t = 10;

// width of the base of the flange (x-axis). Should be equal to or greater than clip_w
flange_w = 22;

// radius of the rounded corners
corner_r = 3;

// smoothness of the rounded corners, larger numbers take longer to render
fn = 32;

/* [Hidden] */

ff = 0.1;

clip_l_inc_flange = clip_l + flange_offset + flange_t;

module pin() {
  total_h = (clip_h/2)+pin_h;
  cylinder(d=pin_d, h=total_h-(pin_d/2), $fn=24);
  translate([0,0,total_h-(pin_d/2)]) sphere(d=pin_d*1.008, $fn=24);
}

module rounded_cube(w, l, h, r=corner_r, fn=fn, r_adjust=1.02) {

  translate([0, 0, -0]) {
    hull() {
      translate([r, r, r]) sphere(r=r, $fn=fn);
      translate([r, r, h-r]) sphere(r=r*r_adjust, $fn=fn);

      translate([w-r, r, r]) sphere(r=r, $fn=fn);
      translate([w-r, r, h-r]) sphere(r=r*r_adjust, $fn=fn);

      translate([w-r, l-r, r]) sphere(r=r, $fn=fn);
      translate([w-r, l-r, h-r]) sphere(r=r, $fn=fn);

      translate([r, l-r, r]) sphere(r=r, $fn=fn);
      translate([r, l-r, h-r]) sphere(r=r, $fn=fn);
    }

  }
}


module clip_corner() {
  hull() {
    cylinder(r=corner_r, h=ff, $fn=fn);
    translate([0,0,clip_h-corner_r]) {
      intersection() {
        sphere(r=corner_r*1.02, $fn=fn);
        translate([0,0,corner_r/5]) cylinder(r=corner_r*1.02, h=(corner_r*1.02), $fn=fn);
      }
    }
  }
}

module flange_corner(h, r_adjust=1.02) {
  hull() {
    translate([0, 0, corner_r]) sphere(r=corner_r, $fn=fn); // no r_adjust here on purpose

    translate([0,0,h-corner_r]) {
      intersection() {
        sphere(r=corner_r*r_adjust, $fn=fn);
        translate([0,0,corner_r/5]) cylinder(r=corner_r*r_adjust, h=(corner_r*r_adjust), $fn=fn);
      }
    }
  }
}

module clip() {
  difference() {
    union() {
      //main clip body
      hull() {
        translate([corner_r, corner_r, 0]) clip_corner();
        translate([clip_w-corner_r, corner_r, 0]) clip_corner();
        translate([clip_w-corner_r, clip_l-corner_r, 0]) clip_corner();
        translate([corner_r, clip_l-corner_r, 0]) clip_corner();
      }

      // retaining flange:
      translate([-(flange_w-clip_w)/2, clip_l_inc_flange-flange_t, 0]) {
        hull() {
          translate([corner_r, corner_r, 0]) flange_corner(h=flange_h+clip_h);
          translate([flange_w-corner_r, corner_r, 0]) flange_corner(h=flange_h+clip_h);
          translate([flange_w-corner_r, flange_t-corner_r, 0]) flange_corner(h=clip_h); // taper
          translate([corner_r, flange_t-corner_r, 0]) flange_corner(h=clip_h); // taper
        }
      }

      // connect the flange to the clip with rounded portion
      hull() {
        translate([0, clip_l-(corner_r*2), -0]) {

          // make the connection point move inward as flange_w increases
          translate([0, -(flange_w-clip_w)/1.0, 0])
            rounded_cube(clip_w, (flange_offset+flange_t+corner_r)/2, clip_h);

          translate([-(flange_w-clip_w)/2, flange_offset+(flange_t/2), -0])
            rounded_cube(flange_w, (flange_offset+flange_t+corner_r)/2, clip_h);
        }
      }
    }

    // pin holes, domed at top to help with bridging
    for (offset=[(clip_l-pin_spacing)/2, ((clip_l-pin_spacing)/2+pin_spacing)]) {
      translate([clip_w/2, offset, -ff]) {
        cylinder(d=pin_d*1.05, h=(clip_h/2)+ff, $fn=24);
        translate([0,0,(clip_h/2)+ff]) scale([1,1,0.5]) sphere(d=pin_d*1.058, $fn=24);
      }
    }
  }

}

if (render_clip > 0) clip();

if (render_pins > 0)
  for (pin_number=[1:render_pins]) {
    translate([-10, pin_number*(pin_d*1.5), 0]) pin();
  }

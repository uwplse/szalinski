// Ultimate Parametric Base Generator and Customizer Script
// developed by Daniel Joyce
// Creative Commons Share Alike + Attribution
// Please see LICENSE.md
// 3D-Miniatures.com

/* [Base] */

// Polygon
base_style = 4; // [3:triangle,4:square,5:pentagon,6:hexagon,7:heptagon,8:octagon,50:round]

// Base diameter,
diameter = 25; // [15:250]

// Thickness of base, ~3 mm is standard:
thickness = 3; // [1:25]

// Stretch base along x-axis
stretch_perc = 0; // [0:400]

/* [Slot or Stand] */

// Should base have a slot or stand?
slot = 1; // [0:Neither, 1:Slot, 2:Stand]

// Orientation of base
base_orientation = 1; // [1:style 1, 2:style 2]

// Orientation of slot
slot_orientation = 1; // [1:x axis, 2:y axis]

// Normally 25 mm square / hex base diameter is measured side to side:
across_sides = 1; // [0:no, 1:yes]

// Stand height in mm from ground, does not include peg length
stand_height = 28; // [10:112]

// Diameter of peg in tenths of mm
peg_diameter = 10; // [10:100]

// Length of peg in mm
peg_height = 5; // [2:10]

/* [Texture] */

// File for surface texture
texture_filename = "texture.dat"; // [image_surface:100x100]

// How much to scale the texture vertically, 10 = no scaling
texture_scale = 10; // [1:50]

// How much the texture is moved up/down the top of the base
panel_offset = 0; // [-20:20]

/* [Hidden] */

radius = diameter / 2;

cos_r = cos(360/(2*base_style));

scale_factor = across_sides == 0 ? 1 : 1 / cos_r;

offset = (diameter * scale_factor) + 2;

stretch_x = stretch_perc / 100;

module texture(diameter, texture_scale) {
  scale_factor = (diameter+0.5)/100;
  scale([scale_factor,scale_factor,texture_scale]) {
    surface(file=texture_filename, center=true);
  }
}


module texture_panel(sides, diameter, texture_scale){
  radius = diameter/2;
  intersection(){
    cylinder(h=20,r=radius, $fn=sides);
    translate([0,0,1]) texture(diameter, texture_scale);
  }
}

module stand(stand_height, peg_height, peg_diam) {
  peg_r = peg_diam / 2;
  stand_r2 = peg_r +.5;
  stand_r1 = peg_r +1;
  union(){
    // peg
    cylinder(r1=peg_r, r2=peg_r,h=stand_height+peg_height, $fn=50);
    cylinder(r1=stand_r1, r2=stand_r2, h=stand_height - 0.01, $fn=50);
  }
}


module base(sides,
  diameter = 25,
  slot = false,
  stand = false,
  height = 3.33,
  base_x = true,
  slot_x = true,
  stand_height = 40,
  peg_height = 4,
  peg_diameter = 2,
  inset = false,
  texture_scale = 1.0,
  panel_offset = -0.4){
  radius = diameter / 2;
  cos_r = cos(360/(2*sides));
  scale_factor = inset ? 1 : 1 / cos_r;
  slot_width = cos_r*diameter*0.9*scale_factor;
  slot_angle = slot_x ? 0 : 90;
  even = sides % 2 == 0;
  base_angle = even ? 360 / (2*sides) : 90;
  base_r = base_x ? 0 : base_angle;
  top_radius = radius - 0.5;
  difference(){
    union(){
      if(stand){
        translate([0,0,0.5]){
          stand(stand_height-0.5, peg_height, peg_diameter);
        }
      }
      scale([scale_factor + stretch_x, scale_factor,1]) rotate([0,0,360/(2*sides)]) {
        rotate([0,0, base_r]) cylinder(h = height, r1=radius, r2=top_radius, $fn=sides);
        translate([0,0,height-1+panel_offset]){
          texture_panel(sides=sides,
                    diameter=diameter-1,
                    texture_scale=texture_scale);
        }
      }
    }
    if(slot){
      rotate([0,0,slot_angle]) cube([2.3,slot_width,height+10], center=true);
    }
  }
}


base(base_style,
    diameter = diameter,
    slot = (slot == 1),
    stand = (slot == 2),
    height = thickness,
    inset = (across_sides == 0),
    stand_height = stand_height,
    peg_height = peg_height,
    peg_diameter = peg_diameter/10,
    base_x = (base_orientation == 1),
    slot_x = (slot_orientation == 1),
    panel_offset = panel_offset/10,
    texture_scale = texture_scale/10);

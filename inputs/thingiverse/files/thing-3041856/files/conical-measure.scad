//Primary parameters
// bottom radius (mm)
r_bottom = 15;
// height (mm)
height = 65;
// slope (Δr:Δh)
slope = 1/2.5;
// major scale interval (ml)
scale_interval = 10;
// number of minor tick marks between major tick marks 
minor_ticks = 3;
// tick length (mm)
tick_length = 10;
// label on every n major tick marks
label_interval = 3;
// thickness (mm)
thickness = 2;
// whether has base
has_base = true;
// whether has a spout
has_spout = true;
// ------

use <text_on.scad> // https://github.com/aleung/text_on_OpenSCAD

$fn = 100;
label_font = "Arial";
spout_size = 4;
max_scale_height = height - spout_size;

r_top = radius_at_height(height);
echo (r_top=r_top);

scale_per_tick = scale_interval / (minor_ticks+1);
echo (scale_per_tick=scale_per_tick);

function radius_at_height(h) = r_bottom + h * slope;

function height_at_volume(v, r) 
  = pow((3*v*1000/(PI*pow(slope,2)) + pow(r,3)/pow(slope,3)), 1/3) - r/slope;

function height_at_tick(major, minor)
  = height_at_volume(scale_per_tick * ( major * (minor_ticks+1) + minor), r_bottom);

function volume_at_height(h, r)
  = (pow(slope,3) * pow((h + r/slope), 3) - pow(r,3)) * PI / (3*slope) / 1000;

// type: 1 - minor, 2 - major, 3 - major with label
module tick(h, type, label) {
  angle = 90 * tick_length / PI / radius_at_height(h);
  rotate_extrude(angle=angle*type) translate([radius_at_height(h)-1, h-1, 0]) square(size=1);
  if (type == 3) {
    text_on_cylinder(t=str(label), updown=h-height/2, location="inside", eastwest=angle*2+93, h=height+1, r1=r_bottom, r2=r_top, font=label_font);
  }
}

module ticks() {
  max_volume = volume_at_height(max_scale_height, r_bottom);
  for (major = [0 : max_volume/scale_interval]) {
    if (major > 0) {
      vol = scale_interval * major;
      type = ((major % label_interval) == 0) ? 3 : 2;
      tick(height_at_tick(major, 0), type, label=str(vol));
    }
    if (height_at_tick(major,1) - height_at_tick(major,0) > 2) {
      for (minor = [1 : minor_ticks]) {
        tick(height_at_tick(major, minor), 1);
      }
    }
  }
}

module base() {
  r = r_top * 0.7;
  difference() {
    union() {
      translate([0,0,-thickness]) cylinder(r=r, h=thickness);
      for (angle = [0:2])
        rotate([0,0,120*angle])
          cube([r, thickness, height]);
    }
    cylinder(h=height+1, r1=r_bottom, r2=r_top);
  }
}

module prism(size, in=false) {
  difference() {
    rotate([0, 0, 180])
      translate([r_top+thickness, 0, height + (in ? 0.1 : 0)]) 
        rotate(a=[0,50,0]) 
          translate([0, 0, -height]) cylinder(r = size, h=height, $fn=3);
    translate([0, -r_top/2, 0]) cube([height, r_top, height]);
  }
}


difference() {
  union() {
    translate([0,0,-thickness]) cylinder(h=height+thickness, r1=r_bottom+thickness, r2=r_top+thickness);
    if (has_spout) prism(spout_size + thickness);
  }
  if (has_spout) prism(spout_size, true);
  cylinder(h=height+1, r1=r_bottom, r2=r_top);
  translate([0,0,height]) cylinder(h=50, r = r_top + 20); 
}

ticks();

if (has_base) base();
use <write/Write.scad>;

// text 
// text on handles
text = "TV";

// text_thickness
// text depth in mm
text_thickness = 0.5;

// text_height
// text_height in mm
text_height = 7;

// clamp_dia
// inner diamaeter of the clamp
clamp_dia = 20; 

// clamp_height
// height of the clamp 
clamp_height = 10;

// clamp_wall
// wall thickness
clamp_wall = 2;

// handle_angle
// angle of the handles
handle_angle=25;

// handle_wall
// handle wall thickness
handle_wall=2;

// handle_length_factor
// length of the handle (clamp_dia x handle_length_factor)
handle_length_factor = 1;

clamp_rad = clamp_dia/2;

module clamp_ring() {
  $fn = clamp_dia * 2;
  difference() {
     cylinder(h=clamp_height, r=clamp_rad + clamp_wall, center=true);
     cylinder(h=clamp_height+1, r=clamp_rad, center=true);
     translate([0,-(clamp_rad+clamp_wall/2),0]) {
      cube([clamp_wall,clamp_wall+1,clamp_height+1],true);
     }
  }
}

module clamp_handle () {
  difference() {
    union() {
      rotate([0,0,handle_angle/2]) {
        translate([clamp_rad+clamp_wall-(handle_wall/2),clamp_rad*handle_length_factor,0 ]) {
          cube([handle_wall,clamp_dia*handle_length_factor,clamp_height], true);
          rotate([90,0,0]) rotate([0,90,0]) translate([0,0,handle_wall/2+text_thickness/2-0.1]) write(text, t=text_thickness, h=text_height, center=true);
        }
     
      }
      rotate([0,0,-handle_angle/2]) {
        translate([-(clamp_rad+clamp_wall-(handle_wall/2)),clamp_rad*handle_length_factor,0 ]) {
          cube([handle_wall,clamp_dia*handle_length_factor,clamp_height], true);  
          rotate([90,0,180]) rotate([0,90,0]) translate([0,0,handle_wall/2+text_thickness/2-0.1]) write(text, t=text_thickness, h=text_height, center=true);
        }
      }
    }
    cylinder(h=clamp_height+1, r=clamp_rad, center=true);
  }
}

module build() {
  union() {
    clamp_ring();
    clamp_handle();
  }
}

build();
// Reversible print-in-place word pencil case by whpthomas

// preview[view:north, tilt:top]

use <MCAD/fonts.scad>

/* [Word] */

// choose which part of the object to render
object=1;//[1:All,2:Pencil Case Only,3:Pencil Topper Only]

// the word to display on the pencil case
word="Fantastic";

// the relative size of the font
font_scale=2.1;

// the space between letters
font_spacing=0.81;

// add a helper tab print aid to the pencil topper
helper_tabs=1;//[0:Disable,1:Enable]

/* [Dimensions] */

// the case width
width=40;

// the case length
length=190;

// the case height
height=25;

// the case thickness
thickness=3.5;

/* [Hinge] */

// the number of x steps
x_steps=2;

// the number of y steps
y_steps=16;

// the x corner offset
x_corner=20;

// the y corner offset
y_corner=26;

// the gap between the hinge elements
tolerance=0.3;

/* [Hidden] */

part();

module part() {
  if(object==1) {
    translate([length/2+height/2+6, -width/2-height/2-6, 0]) topper();
    wordcase();
  //build_plate();
  }
  if(object==2) {
    wordcase();
  }
  if(object==3) {
    topper();
  }
}

$fn=20*1;

x_hinge=(width-20)/x_steps;
y_hinge=(length-26)/y_steps;
hinge_rad=thickness/2;

font_height=1*1;
the_font = 8bit_polyfont();
x_shift = the_font[0][0] * font_spacing;
y_shift = the_font[0][1];
the_indicies = search(word,the_font[2],1,1);
word_size = len(the_indicies);
word_length = (word_size+2)*font_scale;

module wordcase()
rotate([0,0,90])
translate([0,0,hinge_rad]) {
  base();
  x_side();
  rotate([0,0,180]) x_side(180);
  y_side();
  rotate([0,0,180]) y_side();
  lid(55);
  rotate([0,0,180]) lid(-55);
}

module base() {
  x_offset=width/2;
  y_offset=length/2;
  difference() {
    union() {
      cube([width, length, thickness], center=true);
      // edges
      translate([x_offset,0,0]) rotate([90,0,0]) cylinder(h=length, r=hinge_rad, center=true);
      translate([-x_offset,0,0]) rotate([90,0,0]) cylinder(h=length, r=hinge_rad, center=true);
      translate([0,y_offset,0]) rotate([0,90,0]) cylinder(h=width, r=hinge_rad, center=true);
      translate([0,-y_offset,0]) rotate([0,90,0]) cylinder(h=width, r=hinge_rad, center=true);
      // corners
      translate([x_offset,y_offset,0]) sphere(hinge_rad, center=true);
      translate([-x_offset,y_offset,0]) sphere(hinge_rad, center=true);
      translate([x_offset,-y_offset,0]) sphere(hinge_rad, center=true);
      translate([-x_offset,-y_offset,0]) sphere(hinge_rad, center=true);
    }
    // hinge
    translate([x_offset,0,0]) hinge(y_steps, y_hinge, hinge_rad, tolerance/2);
    translate([-x_offset,0,0]) rotate([0,0, 180]) hinge(y_steps, y_hinge, hinge_rad, tolerance/2);
    translate([0,y_offset,0]) rotate([0,0,90]) hinge(x_steps, x_hinge, hinge_rad, tolerance/2);
    translate([0,-y_offset,0]) rotate([0,0,-90]) hinge(x_steps, x_hinge, hinge_rad, tolerance/2);
  }
}

module lid(angle=60) {
  x_offset=width/4;
  y_len=length-thickness-tolerance;
  translate([-width/2-height-width/4,0,0])
  difference() {
    union() {
      cube([width/2, y_len, thickness], center=true);
      translate([-width/4,0,0]) cube([thickness*2, length+thickness, thickness], center=true);
      // rounded edge
      translate([x_offset,0,0]) rotate([90,0,0]) cylinder(h=y_len, r=hinge_rad, center=true);
    }
    // hinge
    translate([x_offset,0,0]) rotate([0,0, 180]) hinge(y_steps+2, y_hinge, hinge_rad, tolerance/2);
    // ruler edge
    translate([-width/4+tolerance/2,0,0]) rotate([0,angle,0]) translate([-thickness,0,0]) cube([thickness*2, length+thickness*2, thickness*3], center=true);
    // handle hole
    translate([-width/4,0,0]) cylinder(h=thickness*2, r=thickness*2.5, center=true);
    // ruler
    translate([-width/4+tolerance/2,-length/2,0]) rotate([0,angle,0]) darts();
  }
}

module darts() render() {
for(i=[0:10:length]) {
    translate([0,i,0]) rotate([0,0,45]) cube([0.5,0.5,thickness*2], center=true);
  }
}

module notch(tol=0) {
  y_offset=thickness+tol;
  n_len=thickness*0.7;
  cube([thickness+tol, thickness*2+tol*2, thickness*2], center=true);
  translate([0,y_offset,0]) rotate([0,0,45]) cube([n_len,n_len,thickness*2], center=true);
  translate([0,-y_offset,0]) rotate([0,0,-45]) cube([n_len,n_len,thickness*2], center=true);
}

module x_side(angle=0) {
  x_offset=height/2;
  y_len=length+thickness;
  translate([-width/2-height/2,0,0])
  difference() {
    union() {
      cube([height, y_len, thickness], center=true);
      // edges
      translate([x_offset,0,0]) rotate([90,0,0]) cylinder(h=y_len, r=hinge_rad, center=true);
      translate([-x_offset,0,0]) rotate([90,0,0]) cylinder(h=y_len, r=hinge_rad, center=true);
    }
    // hinge
    translate([x_offset,0,0]) rotate([0,0, 180]) hinge(y_steps+2, y_hinge, hinge_rad, tolerance/2);
    translate([-x_offset,0,0]) rotate([0,0, 180]) hinge(y_steps, y_hinge, hinge_rad, tolerance/2);
    // notch
    translate([0,length/2,0]) rotate([0,0,90]) notch(tolerance);
    translate([0,-length/2,0])  rotate([0,0,-90]) notch(tolerance);
    // word
    rotate([angle,0,angle ? -90 : 90])
    translate([-(word_size+1)*x_shift,0,0])
    scale([font_scale,font_scale,1]) {
      for( j=[0:(word_size-1)] )
      translate([j*x_shift, -y_shift/2, thickness/2-font_height]) {
        linear_extrude(height=font_height*2)
        polygon(points=the_font[2][the_indicies[j]][6][0], paths=the_font[2][the_indicies[j]][6][1]);
      }
    }
  }
}

module y_side() {
  y_offset=height/2;
  x_len=width-thickness-tolerance;
  translate([0,-length/2-height/2,0])
  difference() {
    union() {
      translate([0,-hinge_rad/2,0]) cube([x_len, height+hinge_rad, thickness], center=true);
      // notch
      translate([width/2-thickness/2,0,0]) rotate([0,90,0]) notch();      
      translate([-width/2+thickness/2,0,0]) rotate([0,-90,0]) notch();      
      // edges
      translate([0,y_offset,0]) rotate([0,90,0]) cylinder(h=x_len, r=hinge_rad, center=true);
    }
    // hinge
    translate([0,y_offset,0]) rotate([0,0,-90]) hinge(x_steps+2, x_hinge, hinge_rad, tolerance/2);
    // slot
    translate([0,-y_offset-thickness/2,0]) cube([thickness*2+tolerance*2, thickness*2+tolerance, thickness*2], center=true);
  }
}

module hinge(n=8, len=8, rad=2, tol=0) {
translate([0,-(n*len)/2,0])
for(i=[0:2:n]) {
  translate([0,i*len,0]) hinge_link(len, rad, tol);
}}

module hinge_link(len=8, rad=2, tol=0) {
  tip=rad+rad/2;
render()
translate([0,len/2+tol/2,0])
rotate([90,0,0]) {
  difference() {
    union() {
      translate([-rad-tol, -rad-tol, 0]) cube([(rad+tol)*2, (rad+tol)*2, len+tol]);
      translate([0,0,len+tol-0.02]) cylinder(h=tip, r1=rad+tol, r2=0);
    }
    translate([0,0,-0.02]) cylinder(h=tip, r1=rad+tol, r2=0);
  }
}}

module topper() translate([0,0,6]) {
  difference() {
	union() {
	  difference() {
		cube(12, center=true);
		rotate([0,0,180]) letter();
		rotate([90,0,0]) letter();    
		rotate([90,0,90]) letter();    
		rotate([90,0,180]) letter();    
		rotate([90,0,270]) letter();    
		corner();
		rotate([90,0,0]) corner();
		rotate([180,0,0]) corner();
		rotate([270,0,0]) corner();
		rotate([0,180,0]) corner();
		rotate([90,180,0]) corner();
		rotate([180,180,0]) corner();
		rotate([270,180,0]) corner();
	  }
	  if(helper_tabs) translate([0,0,-6]) cylinder(h=0.15, r=10);
	}
    translate([0,0,-7]) cylinder(h=9, r=3.926, $fn=6);
  }
}

module letter() translate([0,0,6]) {
scale([0.9,0.9,1])
translate([-the_font[0][0]/2, -y_shift/2, -0.5])
linear_extrude(height=1)
        polygon(points=the_font[2][the_indicies[0]][6][0], paths=the_font[2][the_indicies[0]][6][1]);
}

module corner() translate([4,-6,-6])  {
    cube(4, center=true);
    translate([2,2,0]) cube(4, center=true);
    translate([2,0,2]) cube(4, center=true);
}

// Replicator 2 Build Plate to check layout
module build_plate(){
color("gold") translate([0,0,-4]) cube([280, 150, 8], center = true);
}

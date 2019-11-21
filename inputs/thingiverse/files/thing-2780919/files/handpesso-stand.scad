// ////////////////////////////////////////////////////////////
//
// Handpresso stand
//
// Copyright 2018 Kevin F. Quinn
//
// This work is licensed under the Creative Commons
// Attribution-ShareAlike 4.0 International License. To view a
// copy of the license, visit
// https://creativecommons.org/licenses/by-sa/4.0/
//
// History
// 2018-01-08 1.0 Initial publication
// Handpresso stand - for people who don't like standing still holding
// the handpresso for a whole minute while dispensing the coffee.

// Number of segements in a circle (higher is more accurate)
resolution=360; // [30:360]

// Set filled model, or with holes
holes=1; // [0:filled, 1:holes]

// Size of the stand. Default 124 is a little over half the handle length, to ensure CoG is easily between the pillars. Over a certain size the model morphs to have three pillars.
stand_length=124; // [120:223]
// was handle_l*5/9 - made constant for Customzer

// Width of the stand pillars
stand_width=10; // [3:30]

// Height of the cup you'll be using
cup_height=65; // [50:200]


// below here is not customizable
module endcustomizer() {}

$fn=resolution;

// Dimensions in mm
// Full width across bowl and handle
full_w=100;

// Diameter of the handle
handle_d=34;

// Full length of the handpresso
handle_l=223;

// amount of gap to leave around the nozzle to allow for
// spillage bubbles around the nozzle 
splash=4;

// Tolerance in radius of bowl-shaped cutout
tol=0.5;

// Bowl dimensions (well, of the lid really) - profile:
//
// h: (height)
//  1 |
//    |_
//  2   \
//       \_____
//  3          \_
//
//    \ \ \     \
// d:  1 2 3     4  (diameter)
bowl_h1=12.5;
bowl_h2=10;
bowl_h3=5;
bowl_d1=70+tol*2;
bowl_d2=63+tol*2;
bowl_d3=43+tol*2;
bowl_d4=16+tol*2+splash;

stand_h=handle_d/2+bowl_h1+bowl_h2+bowl_h3+cup_height;
stand_d=handle_d*3/4;
stand_t=2;
brace_h=stand_width/2;

edger=2;
cutout_r=(stand_d-edger*2)/5.5;

module rcube(v) {
  linear_extrude(height=v[2])
  offset(delta=-edger) offset(r=edger) square([v[0],v[1]]);
}

module scube(v) {
  translate([edger,edger,edger])
  minkowski() {
    cube([v[0]-edger*2,v[1]-edger*2,v[2]-edger*2]);
    sphere(r=edger, $fn=60);
  }
}

module sbowl(v) {
  translate([edger,edger,edger])
  minkowski() {
    difference() {
      cube([v[0]-edger*2,v[1]-edger*2,v[2]-edger*2]);
      translate([(v[0]-edger*2)/2,v[1]-edger*2,0])
      rotate(a=-45,v=[0,0,1])
      cube([v[0]-edger*2,v[0]-edger*2,v[2]-edger*2]);
    }
    sphere(r=edger, $fn=60);
  }
}

module foot(x1,x2,y2,h,center=true) {
  edged=edger*3;
  translate([center?-x1/2:0,0,0])
  if (holes==1) {
    scube([x1,edged,h]);
    translate([0,0,h-edged])
    hull() {
      scube([x1,edged,edged]);
      translate([-(x2-x1)/2,y2-edged,0])
      scube([x2,edged,edged]);
    }
    hull() {
      scube([x1,edged,edged]);
      translate([-(x2-x1)/2,y2-edged,h-edged])
      scube([x2,edged,edged]);
    }
  } else {
    hull() {
      scube([x1,edged,h]);
      translate([-(x2-x1)/2,y2-edged,h-edged])
      scube([x2,edged,edged]);
    }
  }
}

// Solid model of the bowl hanging down under the pump
module bowl_by_profile() {
  rotate_extrude() //offset(r=edger) offset(delta=-edger)
  polygon([[0,0],[bowl_d1/2,0],[bowl_d1/2,bowl_h1],[bowl_d2/2,bowl_h1],[bowl_d3/2,bowl_h1+bowl_h2],[bowl_d4/2,bowl_h1+bowl_h2],[bowl_d4/2,bowl_h1+bowl_h2+bowl_h3],[0,bowl_h1+bowl_h2+bowl_h3]]);
}

module handle() {
  translate([-stand_width,0,0])
  rotate(a=90,v=[0,1,0])
  cylinder(d=handle_d,h=handle_l+stand_width*2); 
}

module bridge() {
  hull() {
    cube([bowl_d1,handle_d/2,handle_d/2]);
    translate([bowl_d1/2,full_w-bowl_d1/2-handle_d/2,handle_d/4])
    cylinder(d=bowl_d1,h=handle_d/2,center=true);
  }
}

// Main hand-presso sections
module handpresso() {
  color("Grey") {
    handle();
    translate([bowl_d1/2,full_w-bowl_d1/2-handle_d/2,handle_d/2]) bowl_by_profile();
    bridge();
  }
}

// Stand at bowl end
module bowl_stand() {
  w=bowl_d1*2/3+stand_t*2;
  h=bowl_h1+bowl_h2+bowl_h3;
  d=full_w-bowl_d1/3+stand_t;
  translate([-stand_t,-handle_d/2-stand_t,handle_d/2]) hull() {
    scube([w,edger*4,brace_h]); // equivalent to brace section to width of bowl stand
    translate([0,d/2,0])
    sbowl([w,d/2,h]);
  }
}

module diamond() {
  //translate([-stand_width,0,0])
  rotate(a=90,v=[0,1,0])
  linear_extrude(height=stand_width)
  circle(r=cutout_r,$fn=4);
}


// Additional stand piece
module stand(withfoot=true) {
  difference() {
    scube([stand_width,stand_d+edger*2,stand_h]);
    if (holes==1) {
      // hole pattern
      for(y=[1:1:15]) {
        translate([0,edger+cutout_r*(y%2==1?1:2.5),stand_h-y*(cutout_r*1.5)])
          diamond();
        translate([0,edger+cutout_r*(y%2==1?4:5.5),stand_h-y*(cutout_r*1.5)])
          diamond();
      }
    }
  }
  if (withfoot)
  translate([stand_width/2,stand_d,stand_h-bowl_d1/2])
  foot(stand_width,bowl_d1/4,bowl_d1*3/4+stand_t*2,bowl_d1/2);
}

module brace(l) {
  translate([-stand_width,-handle_d/2-stand_t,0])
  scube([l,handle_d/2,brace_h]);
}

module handpresso_stand() {
  translate([stand_width,-handle_d/2-stand_t,stand_h])
  rotate(a=180,v=[1,0,0])
  difference()
  {
    union() {
      bowl_stand();
      // Bowl end stand
      translate([-stand_width,-handle_d/2-stand_t,0])
      stand(withfoot=true);
      // Middle stand
      if (stand_length>(bowl_d1*2))
      translate([bowl_d1,-handle_d/2-stand_t,0])
      stand(withfoot=true);
      // Handle end stand
      translate([stand_length-stand_width,-handle_d/2-stand_t,0])
      stand(withfoot=stand_length<=(bowl_d1*2));
      // Horizontal Braces
      //translate([0,0,stand_h-brace_h])
      //brace(stand_length+stand_width);//bowl_d1+stand_width*2);
      translate([0,0,handle_d/2+(stand_h-handle_d/2-brace_h)*2/3])
      brace(stand_length+stand_width);//bowl_d1+stand_width*2+(handle_l+stand_width-bowl_d1-stand_width*2)/2);
      translate([0,0,handle_d/2])
      brace(stand_length+stand_width);
    }
    handpresso();
  }
}


rotate(a=-90,v=[1,0,0]) // rotate for printing
handpresso_stand();

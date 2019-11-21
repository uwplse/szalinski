/*
 * Customizable Sports Sight - https://www.thingiverse.com/thing:3576987
 * by Taras Kushnirenko
 * created 2019-04-20
 * version v1.0
 *
 * Changelog
 * --------------
 * v1.0 - 2019-02-26:
 *  - initial design
 * --------------
 * 
 * This work is licensed under the Creative Commons - Attribution - Non-Commercial ShareAlike license.
 * https://creativecommons.org/licenses/by-nc-sa/3.0/
 */

// Parameter Section //
//-------------------//

//preview[view:south, tilt:top diagonal]

/* [Global] */

// Choose, which part you want to see!
//part = "_separated_";  
part = "_separated_";  //[_single_:Solid,_separated_:2 elements]

// Choose form of the sight
form = "_rounded_"; //[_rounded_:Rounded cube,_cylinder_:Cylindrical]

// Choose type of the sight
type = "_straight_"; //[_straight_:Straight Sight,_conical_:Conical Sight]

/* [Sight Settings] */

// Total sign length
sight_lenght = 40; // [20:100]

// Inner width. Used only in straight type
sight_width = 40; // [20:100]

// Inner width. Used only in straight type
sight_height = 30; // [20:100]

// Inner diamerer for cylindrical sign
sight_diameter = 20; // [20:100]

//Sign wall thickness. Use a multiple of the nozzle diameter
wall_thickness = 1.6;  // [0.1:0.1:3]

// From eye to sign. Used only in conical type
view_distance = 300;  // [100:5:500]

// Used only in straight type
inner_sight_radius = 3;  // [1:1:10]

leg_width = 12.5;
leg_height = 5;

/* [Cross hairs settings] */

//Use a multiple of the nozzle diameter
crosshairs_width = 0.8;  // [0.1:0.1:2]

crosshairs_length = 3.0; // [0.5:0.5:4]

rear_aperture = 2.5;

// Used only in straight type
front_aperture = 3.5;

/* [Hot Shoe settings] */

foot_width = 18.1;
foot_lenght = 20;
foot_height = 1.99;
foot_radius = 2;

/* [Hidden] */

$fn = $preview ? 24 : 72;
eps = 0.0001;
f_cf = (type == "_straight_") ? 1 : 1+sight_lenght/view_distance;
l_sight = sight_lenght;
w_sight = (form == "_rounded_") ? sight_width : sight_diameter;
h_sight = (form == "_rounded_") ? sight_height : sight_diameter;

th_sight = wall_thickness;
//l_offset_sight = l_sight/2 - 12;

aperture_r = rear_aperture;
aperture_f = (type == "_straight_") ? front_aperture : rear_aperture * f_cf;
w_crosshairs = crosshairs_width;
l_crosshairs = crosshairs_length;

r_fillet = 1;
r_inner_sight = inner_sight_radius;
r_outer_sight = r_inner_sight + th_sight;

w_foot = foot_width;
l_foot = foot_lenght;
h_foot = foot_height;
r_foot = foot_radius;

w_leg = leg_width;
h_leg = leg_height;

hL = 1;
wL = 3;
sL = 0.1;

l_offset_sight = l_sight/2 - l_foot/2;

if (part == "_single_") {
  sign();
} else {
  
  difference(){
    sign();
    translate([-w_sight,-3*h_foot,l_foot+hL])cube([2*w_sight,2*w_sight,l_sight]);
    // grooves
    translate([(-w_sight/2-th_sight)*f_cf,h_sight/2+th_sight-wL/2,l_foot])cube([(w_sight+2*th_sight)*f_cf,wL,l_sight]);
    translate([-wL/2,-th_sight,l_foot])cube([wL,(h_sight+2*th_sight)*f_cf,l_sight]);
  }

  translate([0,2*h_sight*f_cf+10,l_sight])
  {
    rotate([180,0,0])difference(){
      sign();
      translate([-w_sight,-3*h_foot,l_foot-hL-l_sight])cube([2*w_sight,2*w_sight,l_sight]);
      if (form == "_rounded_") {
        difference() {
          translate([-w_sight,-h_sight+h_foot,0])cube([2*w_sight,2*w_sight,l_sight]);
          translate([0,h_sight/2+h_foot,0])hull() {
            linear_extrude (eps)offset(r=r_outer_sight)square ([w_sight + 2*th_sight - 2 * r_outer_sight, h_sight + 2*th_sight - 2 * r_outer_sight], center = true);
            translate([0,0,l_sight-eps])linear_extrude (eps)offset(r=r_outer_sight*f_cf)square ([(w_sight + 2*th_sight - 2 * r_outer_sight)*f_cf,(h_sight + 2*th_sight - 2 * r_outer_sight)*f_cf], center = true);
          }
        }
      } else {
        translate([0,h_sight/2+h_foot,0])difference() {
          cylinder (d1=w_sight+20*th_sight,d2=(w_sight+20*th_sight)*f_cf,h=l_sight);
          cylinder (d1=w_sight+2*th_sight,d2=(w_sight+2*th_sight)*f_cf,h=l_sight);
        }
      }
    translate([wL/2,h_sight/2+th_sight+wL/2,l_foot-l_sight])cube([2*w_sight,2*h_sight,l_sight]);
    translate([-2*w_sight-wL/2,h_sight/2+th_sight+wL/2,l_foot-l_sight])cube([2*w_sight,2*w_sight,l_sight]);

    translate([wL/2,-h_sight/2+th_sight-wL/2-h_sight,l_foot-l_sight])cube([2*w_sight,2*h_sight,l_sight]);
    translate([-2*w_sight-wL/2,-h_sight/2+th_sight-wL/2-h_sight,l_foot-l_sight])cube([2*w_sight,2*h_sight,l_sight]);
  }

  }
}

module sign(){
translate ([0,-h_foot-h_leg,l_foot/2])rotate ([-90, 0, 0])foot ();
translate ([0, h_sight/2+th_sight, 0])
    rotate ([0, 0, 0])
        sight (r_fillet);
}

module foot ()
{
    translate ([0, 0, h_foot])
        linear_extrude (h_leg)
            square ([w_leg, l_foot], center = true);

    linear_extrude (h_foot)
    {
      offset(r=r_foot)square ([w_foot - 2* r_foot, l_foot - 2 * r_foot], center = true);
      }
}

module sight(r)
{
    translate ([0, 0, l_sight - l_crosshairs])
        crosshairs (aperture_f, (w_sight+th_sight/2)*f_cf,(h_sight+th_sight/2)*f_cf);
    
    crosshairs (aperture_r, w_sight+th_sight/2,h_sight+th_sight/2);
    
    difference ()
    {
      union(){
        translate ([0, - h_sight/4 - h_leg, l_sight/2 - l_offset_sight])
        cube ([w_leg, h_sight/2, l_foot], center = true);
        sight_body (r);
      }
  if (form == "_rounded_") {
    hull() {
      translate ([0, 0, -eps])linear_extrude (eps)
        offset(r=r_inner_sight)square ([w_sight - 2 * r_inner_sight, h_sight - 2 * r_inner_sight], center = true);
      translate([0,0,l_sight])linear_extrude (eps)
        offset(r=r_inner_sight*f_cf)square ([(w_sight - 2 * r_inner_sight)*f_cf,(h_sight - 2 * r_inner_sight)*f_cf], center = true);
    }
    } else {
      translate ([0, 0, -1])
        cylinder (d1=w_sight, d2=w_sight*f_cf,h=l_sight+2);
    }
  }
}

module sight_body (rr)
{
  if (form == "_rounded_") {
    hull() {
      linear_extrude (eps)
        offset(r=r_outer_sight)square ([w_sight + 2*th_sight - 2 * r_outer_sight, h_sight + 2*th_sight - 2 * r_outer_sight], center = true);
      translate([0,0,l_sight-eps])linear_extrude (eps)
        offset(r=r_outer_sight*f_cf)square ([(w_sight + 2*th_sight - 2 * r_outer_sight)*f_cf,(h_sight + 2*th_sight - 2 * r_outer_sight)*f_cf], center = true);
    }
  } else {
    cylinder (d1=w_sight+2*th_sight,d2=(w_sight+2*th_sight)*f_cf,h=l_sight);
  }
}

module crosshairs (r,w,h)
{
        difference ()
        {
            union ()
            {
                translate([0,0,l_crosshairs/2])cube ([w, w_crosshairs,l_crosshairs], center = true);
                translate([0,0,l_crosshairs/2])cube ([w_crosshairs, h,l_crosshairs], center = true);
                cylinder (r=r + w_crosshairs,h=l_crosshairs);
            }
            translate([0,0,-0.1])cylinder (r=r,h=l_crosshairs+0.2);
        }
}
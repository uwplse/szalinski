/*
 * Customizable Angle template - https://www.thingiverse.com/thing:3593070
 * by Taras Kushnirenko
 * created 2019-04-27
 * version v1.0
 *
 * Changelog
 * --------------
 * v1.0 - 2019-04-27:
 *  - initial design
 * --------------
 * 
 * This work is licensed under the Creative Commons - Attribution - Non-Commercial ShareAlike license.
 * https://creativecommons.org/licenses/by-nc-sa/3.0/
 */

// Parameter Section //
//-------------------//

// preview[view:south, tilt:top diagonal]

/* [Template Settings] */

// Thickness of the angle template 
template_thickness = 2.0;

// Length of the angle template 
template_length = 40.0;

// Width of the angle template 
template_width = 15.0;

// Font size in mm 
font_size = 7.0;

// Depth of symbols 
sumbol_depth = 0.6;

// Center tag width
tag_width=0.2;

// Center tag length
tag_length=3.0;

/* [Angle Settings] */

angle_1=2.0;
angle_2=5.0;
angle_3=-0.5;
angle_4=-0.5;

/* [Hidden] */

h=template_thickness;
l=template_width;
w=template_length;
hS=sumbol_depth;
wS=tag_width;
lS=tag_length;
//===================

sectL(angle_1,1,0);
sectR(angle_2,0,1);

translate([0,l*2,0])rotate([0,0,180])union(){
  sectL(angle_3,1,0);
  sectR(angle_4,0,1);
};
//====================

module sectL(
    ang=2,  // Template angle
    hLt=0,  // 1 - Left section half size
    hRt=0){ // 1 - Right section half size
  difference(){
    union() {
      if(ang > 0){
        cube([w-w*hLt/2,l,h]);
        translate([w-w*hLt/2,0,0])rotate([0,0,ang])cube([w-w*hRt/2,l,h]);
      } else {
        cube([w-w*hLt/2+l*tan(-ang/2),l,h]);
        translate([w-w*hLt/2,0,0])rotate([0,0,ang])translate([-l*tan(-ang/2),0,0])cube([w-w*hRt/2+l*tan(-ang/2),l,h]);
      };
    };
    translate([w-w*hLt/2,0,h-hS])rotate([0,0,ang/2])translate([-wS/2,0,0])cube([wS,lS,hS+0.1]);
    translate([w-w*hLt/2,1,h-hS])linear_extrude(hS+0.1)text(str(ang, "°"), size=font_size, halign = "right", font = "Arial:style=Bold");

    translate([w-w*hLt/2,0,-0.1])rotate([0,0,ang/2])translate([-wS/2,0,0])cube([wS,lS,hS+0.1]);
    translate([w-w*hLt/2,0,-0.1])mirror([1,0,0])rotate([0,0,-ang])translate([0,1,0])linear_extrude(hS+0.1)text(str(ang, "°"), size=font_size, halign = "right", font = "Arial:style=Bold");
  };
};
module sectR(ang=2, hLt=0,hRt=0){
  difference(){
    union() {
      if(ang >= 0){
        translate([-w+w*hRt/2,0,0])cube([w-w*hRt/2,l,h]);
        translate([-w+w*hRt/2,0,0])rotate([0,0,-ang])translate([-w+w*hLt/2,0,0])cube([w-w*hLt/2,l,h]);
      } else {
        translate([-w+w*hRt/2-l*tan(-ang/2),0,0])cube([w-w*hRt/2+l*tan(-ang/2),l,h]);
        translate([-w+w*hRt/2,0,0])
        rotate([0,0,-ang])
        translate([-w+w*hLt/2,0,0])
        cube([w-w*hLt/2+l*tan(-ang/2),l,h]);
      };
    };
    translate([-w+w*hRt/2,0,h-hS])rotate([0,0,-ang/2])translate([-wS/2,0,0])cube([wS,lS,hS+0.1]);
    translate([-w+w*hRt/2,0,h-hS])rotate([0,0,-ang])translate([0,1,0])linear_extrude(hS+0.1)text(str(ang, "°"), size=font_size, halign = "right", font = "Arial:style=Bold");
    
    translate([-w+w*hRt/2,0,-0.1])rotate([0,0,-ang/2])translate([-wS/2,0,0])cube([wS,lS,hS+0.1]);
    translate([-w+w*hRt/2,0,-0.1])mirror([1,0,0])translate([0,1,0])linear_extrude(hS+0.1)text(str(ang, "°"), size=font_size, halign = "right", font = "Arial:style=Bold");
  };
};

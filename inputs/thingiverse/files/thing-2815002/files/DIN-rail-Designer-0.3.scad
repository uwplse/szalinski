/*
This software is licensed by Green Ellipsis Inc. under the GNU LESSER GENERAL PUBLIC LICENSE, Version 3
https://www.gnu.org/licenses/gpl.html

TODO: 
* Add multiples
* Add recyling symbol
* engrave image
* Add writing/labeling
* emboss dimensions
* trim the bottom as well as the top.
* add square clips
* add tight fit
* add screw holes through body
* Add rectangular cutouts
* Add option for spring release.
* Make DIN_clip a library function.

*
* Version 0.25 release notes
* Make wall thickness a function of dim_1.
* frugal cutout now of function of body_height instead of wall_thickness
* 
* Version 0.3 release notes
* Cleaned up parameters. 
* Added chamfer to bottom if frugal is checked.
* Created JSON file for presets (Requires OpenSCAD 2017 or later).
*
*/
use <MCAD/2Dshapes.scad>

/* [Customize] */
// radius of the top
dimension_1 = 7.5; // [1:100]
// radius of the bottom
dimension_2 = 7.5; // [1:0.1:100]
// radius of the chamfer around the top
dimension_3 = 8.5; // [1:0.1:100]
// length of the body of the DIN rail clip, front to back
body_length = 12; //[2:0.1:100]
// remove some material?
frugal = false;
// include a pull tab to release clip?
release_tab = false;

/* [Advanced] */
// bottom clip length
clip_length = 20; //[3:0.1:100]
// distance from back
release_tab_position=7.5; //[3:0.1:100]
// curvature of release tab
release_tab_radius = 10; //[5:100]
// length of release tab, in degrees
release_tab_arc = 90; //[5:180]

// Height of the snap tab on the bottom clip
bottom_tab_height = 4.1;

// wall thickness as a function of dimension1
wall_thickness_percent = 20;

/* [Hidden] */
// model parameters that shouldn't be messed with
bottom_clip_height=3;
clip_gap = 1;
top_clip_height = 9;
body_height = 43.785;
frugal_fraction = 0.8; // how much of the body to cut away;
lipHeight = body_height*(1-frugal_fraction)/2;


// rendering parameters
$fn=64;
EPSILON = 0.005;

// calculated parameters
clip_thickness=bottom_clip_height-clip_gap;
dimension1 = dimension_1;
dimension2 = min(dimension_1, dimension_2);
dimension3 = dimension_3;
wall_thickness = dimension1*wall_thickness_percent/100;
thing_width = (dimension1+wall_thickness)*2;

/* conventions:
* Each feature is created in a module.
* Features are aligned with bottom left at 0,0.
*/

module top_clip_2D(clip_style = "straight") {
    top_clip_width = 4;
    tab_height = 2.75;
    if (clip_style == "straight") {
        // TODO
        square([top_clip_width,top_clip_height]);
    } else { // clip_style = "angled"
        //square([6,9]);
        translate([0,tab_height,0]) 
        complexRoundSquare(size=[top_clip_width,top_clip_height-tab_height],rads1=[0,0], rads2=[0.0,0.0], rads3=[2,2], rads4=[0,0], center=false);
        x_offset = 1+1.943-1;
        translate([x_offset,0,0]) 
            complexRoundSquare(size=[top_clip_width-x_offset,tab_height],rads1=[1,1], rads2=[0.5,0.5], center=false);
        polygon(points=[[x_offset+(1-0.902),1-0.431],[x_offset,tab_height],[x_offset-1,tab_height]], paths=[[0,1,2]]);
    }
}

//body
module body_2D() {
    translate([0,0,0]) 
        complexRoundSquare(size=[body_length,body_height-bottom_clip_height],rads2=[0.5,0.5], center=false);
}

// release tab
module release_tab() {
    release_tab_height = sin(release_tab_arc/2)*release_tab_radius*2;
    release_tab_width = cos(release_tab_arc/2)*release_tab_radius;
    translate([release_tab_radius, release_tab_height/2,0])
    difference() 
    {
        union() {
            pieSlice(release_tab_radius,180-release_tab_arc/2,180+release_tab_arc/2);
            translate([-release_tab_radius,0,0]) square([release_tab_radius, release_tab_height/2]);
        }
        circle(release_tab_radius-clip_thickness); 
    }
}

// bottom clip
module bottom_clip_2D() {
    tab_width = 4.5;
    tab_gap = 1.25;
    bottom_clip_width=min(body_length, clip_length);
    difference() {
        square([bottom_clip_width+tab_gap, bottom_clip_height]);
        translate([clip_thickness,clip_thickness,0]) 
            complexRoundSquare(size=[bottom_clip_width-clip_thickness+tab_gap,clip_gap],rads1=[clip_gap/2,clip_gap/2],rads4=[clip_gap/2,clip_gap/2], center=false);
    }
    polygon(points=[[bottom_clip_width+tab_gap,0],[bottom_clip_width+tab_gap+tab_width,0],[bottom_clip_width+tab_gap,bottom_tab_height]], paths=[[0,1,2]]);
    // add release tab
    if (release_tab) {
        translate([max(0,bottom_clip_width-release_tab_position),-2*sin(release_tab_arc/2)*release_tab_radius+clip_thickness,0]) 
            release_tab();
    }
}

module DIN_clip_2D() {
    translate([body_length,body_height-top_clip_height,0]) top_clip_2D(clip_style="angled");
    translate([0,bottom_clip_height,0]) 
        body_2D();
    translate([max(0, body_length-clip_length),0,0])
        bottom_clip_2D();
}

module DIN_clip(width = 10) {
    linear_extrude(width)
        DIN_clip_2D();
/*
    // Shouldn't extrude on the side--it will interfere with its neighbors.
    str1 = str(dimension1*2);
    str2 = str(dimension2*2);
    textHeight = 4;
    translate([2,body_height-2,width]) write(str1,rotate=90, h= textHeight);
    translate([2,len(str2)*textHeight+bottom_clip_height,width]) write(str2,rotate=90, h=textHeight);
*/
}

// Cut a chamfer into the bottom of the frugal cut.
// Scale the chamfer to the top chamfer.
// Maximum chamfer size is dimension1, equal to no chamfer at all.
module bottom_chamfer() {
    bottomChamferRadius = min(dimension1,dimension2*(dimension3/dimension1));
    echo("bottomChamferRadius",bottomChamferRadius);
    // Create a cone whose bottom radius is dimension3,
    // whose radius at bottomLipZ is bottomChamferRadius,
    // and whose maxiumum radius is bodyWidth;
    height=sqrt(2)*(dimension1 - dimension2);
    z = lipHeight-sqrt(2)*(bottomChamferRadius - dimension2);
    undercutZ = height+z-EPSILON;
    undercutHeight = body_height/2-undercutZ+EPSILON*2;
    rotate([-90,0,0]) {
        // cut the chamfer using a cone
        translate([thing_width/2,-thing_width/2,z])
            cylinder(h=height, r1=dimension2, r2=dimension1);
        // clear out the undercut
        translate([thing_width/2,-thing_width/2,undercutZ])
            cylinder(h=undercutHeight, r=dimension1);
    }
}

// hole thing
module hole_thing(radius = 7.5, leadin_radius, bottom_radius, frugal=false) {
    leadin_r = (leadin_radius == undef ? radius*1.1 : leadin_radius);
    bottom_r = (bottom_radius == undef ? radius : bottom_radius);
    bottom_width = (bottom_r + wall_thickness)*2;
    echo(bottom_radius);
    echo(bottom_r);
    difference () 
    {
        union() {
            // extrude a cube for the close half of the body
            translate([thing_width/2,0,0]) cube([thing_width/2, body_height, thing_width]);
            // extrude a cylinder for the far half of the body
            rotate([-90,0,0]) 
                translate([thing_width/2,-thing_width/2]) 
                    cylinder(r1=bottom_width/2, r2=thing_width/2, h=body_height, center=false);
        }
        // cut a cone
        rotate([-90,0,0]) 
            translate([thing_width/2,-thing_width/2,-EPSILON]) {
                cylinder(h = body_height+2*EPSILON, r1 = bottom_r, r2 = radius, center=false);
                //cut the leadin
                translate([0,0,body_height-wall_thickness+EPSILON])
                    cylinder(h = wall_thickness+EPSILON*2, r1=radius, r2=leadin_radius, center=false);
            }
        if (frugal) {
            // cut the midsection out
            cut_radius = (body_height*frugal_fraction)/2;
            translate([0,body_height/2,-EPSILON])
                resize([thing_width*2,cut_radius*2,thing_width+EPSILON*2]) 
                    cylinder(center=false);
                //cube([thing_width/2,body_height-wall_thickness*6,thing_width+EPSILON*2]);
            bottom_chamfer();
        }
    }
}
/*
*/
DIN_clip(thing_width);
// build the thing in the -x area
translate([-thing_width, 0,0]) hole_thing(dimension1,dimension3,dimension2,frugal=frugal);


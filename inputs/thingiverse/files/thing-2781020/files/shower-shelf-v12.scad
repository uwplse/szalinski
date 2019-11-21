// monitor_shelf
// Thing that lets you place small items on the top edge of your
// computer monitor
//
// Rick Rofail
// rick.rofail at gmail.com
// Distributed under GPL version 2
// <http://www.gnu.org/licenses/gpl-2.0.html>
//
// Designed to use customizer at thingiverse
// <http://www.makerbot.com/blog/2013/01/23/openscad-design-tips-how-to-make-a-customizable-thing/>
// INCLUDING LEGOBRICK MODULES FROM 
// building Lego bricks - rdavis.bacs@gmail.com
// measurements taken from: 
//   http://www.robertcailliau.eu/Lego/Dimensions/zMeasurements-en.xhtml
// all copyrights and designs are property of their respective owners.

// K272HL 
//monitor_thickness = 24;
//shelf_depth = 44;
//front_length = 7.5;
//back_length = 20;


// HP LP2465 - 
//monitor_thickness = 49;
//shelf_depth = 65;
//back_length = 17.2;
//front_length = 17.2;

// XG270HU - 
//monitor_thickness = 19.5;
//shelf_depth = 50;
//back_length = 20;
//front_length = 6;


// Generate just a narrow test profile to ensure it fits your monitor
test_profile = 0; // [0: Full width, 1: Test profile]

include_connector = 1; // [0: No connectors, 1: Use Connectors]
// Thickness of the plastic in mm
thickness = 3.0;  // thickness

// Thickness of monitor at top edge (mm)
monitor_thickness = 52;

// Depth of the perch shelf (mm).
shelf_depth = 65;

// Thickness of the perch shelf (mm).
shelf_thickness = 4;


// Length of front leg
front_length = 0;

// Length of back leg
back_length = 50;

// Monitor back wedge (degrees: 0 means back is perp. to top edge, >0 means it is slanted)
monitor_back_slope = 0;

// Monitor top wedge (degrees: >0 means that the top slopes way instead of being perpendicular to the screen)
monitor_top_wedge = 0;

// Width of the perch shelf (mm).
shelf_width = 10;

//Size of the shelf lip bead. Default 1.2 for a small lip.
shelf_lip_size = 0;

//Depth of the hook size - mine is 48 mm
hook_depth=48;

//Hieight of the hook - dropping it 40 mm below top 
hook_height=130;

// Radius of bead along joints
bead = shelf_lip_size * thickness;

// epsilon to prevent problems with coincident planes
eps = 0.01;

// LEGO settings
/////////
h_pitch = 8.0;   // horizontal unit
v_pitch = 9.6;   // vertical unit
tol = 0.1;       // "play" in x and y directions
k_dia = 4.8;     // knob diameter
k_height = 1.8;  // knob height
k_n = 40;         // knob resolution
wall = 1.2;      // wall thickness

brick_cyl_ex = 8*sqrt(2)-2*2.4;
brick_cyl_in = 4.8;
beam_cyl = 3.0;

module Perch() // Top level module
{
    rotate([90,0,0]) union() {
        // Front is in the xy plane
//        translate([-bead*0.72,0,bead*0.72]) rotate([90,0,0]) cylinder(h=shelf_width-eps,r=bead,center=true); //front bead
        translate([-(shelf_depth/4.8),0,bead+thickness])rotate([90,0,0]) cylinder(h=shelf_width-eps,r=bead,center=true); //front bead

        translate([-thickness,-shelf_width/2,-front_length+eps]) cube([thickness, shelf_width, front_length]); //front riser
        rotate([0,monitor_top_wedge,0]) {
            union(){
                translate([-shelf_depth/4,-shelf_width/2,0]) cube([shelf_depth+ 2*thickness, shelf_width, shelf_thickness]); //top plane
                 
                translate([monitor_thickness+thickness,-shelf_width/2,thickness]) //back riser
                    rotate([0,180-monitor_back_slope-monitor_top_wedge,0])
                        cube([thickness,shelf_width,back_length]); //back riser
                translate([shelf_depth+thickness-(shelf_depth/4),(shelf_width-eps)/2,bead+thickness])
                    rotate([90,0,0]) cylinder(h=shelf_width-eps,r=bead,center=false);
            }
        }
     translate([55,0,0])rotate([90,180,0]) linear_extrude(height = shelf_width, center = true, convexity = 10, twist = 0)
polygon(points=[[0,0],[40,0],[0,40],[4,4],[30,4],[4,30]], paths=[[0,1,2],[3,4,5]]);   
      //hook section for shower door  
      translate([49,-shelf_width/2,0])rotate([0,0,0]) union() {
          translate([0,0,0])cube([thickness*2, shelf_width, hook_height-50]); //back riser for hook - bottom platform section
          translate([2.2,0,80]) {
              translate([0,0,0]) cube([thickness*2-4.4, shelf_width-2, 6.2]); //-male rod
              translate([-2.2,0,6.2]) cube([thickness*2, shelf_width-2, 2]); //-male - cross piece
          }// cube([thickness*2-4, shelf_width-2, 5]); //back riser for hook - bottom platform section-male
          difference() {
              translate([0,0,100])cube([thickness*2, shelf_width, hook_height-100]); //back riser for hook - top hook section
              translate([1.5,0,100]) { // cube([thickness*2-3, shelf_width-1.5, 6]); //back riser for hook - top hook section-FEmale
                translate([0,0,0]) cube([thickness*2-3, shelf_width-2, 7.2]); //-female rod
                translate([-1.5,0,4.4]) cube([thickness*2+2, shelf_width-1.7, 3.6]); //-female - cross piece
               }
          }
          translate([0,0,hook_height-thickness])cube([hook_depth+thickness*2+thickness*2, shelf_width, thickness*2]); //back riser for hook
          translate([hook_depth+thickness+thickness,0,hook_height-hook_height/3])    cube([thickness*2, shelf_width, hook_height/3]); //back riser for hook

      }
     //add back support rods - 12mm
      translate([61,-shelf_width/2,-40])rotate([0,0,0]) union() {
          cube([thickness*2, shelf_width, 80]);
          translate([-6,0,0]) rotate([0,90,00]) cube([thickness*2, shelf_width, 12]);
          translate([-6,0,44]) rotate([0,90,00]) cube([thickness*2, shelf_width, 12]);
          translate([-6,0,80]) rotate([0,90,00]) cube([thickness*2, shelf_width, 12]);
      }
    }
}

module Rod(leng) //rod module
{
    union() {
        difference() {
                    cube([thickness*2, shelf_width, leng]);
                    femaleConnector();
                }
                 translate([0,0,leng]) {
                     maleConnector();
                 }
            }
}

module Profile()
{
    intersection() {
        Perch();
        cube([1000,1000,2],center=true);
    }
}
// Rotate it so that ends up on the printer bed in the right orientation

module maleConnector() 
{
    translate([2.2,0,0]) cube([thickness*2-4.4, shelf_width-2, 6.2]); //-male rod
    translate([0,0,6.2]) cube([thickness*2, shelf_width-2, 1]); //-male - cross piece
}

module femaleConnector() 
{ //be sure to take this as the difference
    translate([1.5,0,0]) cube([thickness*2-3, shelf_width-2, 7.2]); //-female rod
    translate([0,0,4.4]) cube([thickness*2+2, shelf_width-1.7, 3.6]); //-female - cross piece
}



if (test_profile == 1) {
    Profile();
} else {
    
    Perch();
}

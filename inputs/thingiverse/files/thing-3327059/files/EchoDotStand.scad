//===========================================================================
// Stand for Amazon's Second Genertion Echo Dot.
// https://www.amazon.com/Amazon-Echo-Dot-Portable-Bluetooth-Speaker-with-Alexa-Black/dp/B01DFKC2SO
//
// NOTE: it does NOT fit the 3rd generation Dot.
//
// This part was designed 30 December 2018 by Joe McKeown. 
// It's available under the terms of the Creative Commons CC-BY license 
// (https://creativecommons.org/licenses/by/3.0/).
// 
// History:
// V1.0 30 December 2018 First version
//===========================================================================  
/*
Stand your Echo Dot (2nd Gen) upright. Or hang it from a cabinet door.

The Echo Dot can clip into this stand, the back of the stand is hollow for cable routing. I did end
up using my hex driver as a poker to get a secure fit after the Dot was snapped in, but once assembled
it's quite stable. 

The 2nd part is only needed if you want to hang the Dot from a shelf/cabinet/cupboard door. Measure your
door and use Customizer to create a hanger that fits perfectly. A hook for a 21.5 mm door is provided
as an example. It fits my cabinet perfectly, and is probably a match for a good number of "contractor
grade" cabinets sold in the U.S. (Lowes, Home Depot, etc...) To assemble, insert one M3 square nut into
each of the traps on the sides of the stand's cable channel. Then use 2 M3x16 Cap screws to secure the 
hook to the stand. The hook has a channel that aligns with the cable routing on the stand to help 
ensure the cable isn't pinched when the cabinet is closed.

I did get some stringing on the speaker grill when printing. Use caution if cleaning this with a heat
gun as the plastic is very thin and will want to contract, and warp. It would be better to clean the 
stringing with an X-Acto. Or leave the stringing alone.
*/

// Which part to generate. 
Part="Dot"; // ["Dot":"Dot Holder", "Hook":"Cabinet Hook"]
// Thickness of Cabinet in millimeters (applies to Cabinet Hook)
Cabinet_Thickness=21.5;

/* [Hidden] */
MM_PER_INCH=25.4;
// Echo dot 2nd Generation is 3.3 inches. add a 0.2mm additional clearance
dot_diameter=3.3*MM_PER_INCH + 0.2;
dot_radius=dot_diameter/2;
dot_height=1.3*MM_PER_INCH;
dot_fn=150;
base_height=40;
base_lower_width=0.90*dot_diameter;
base_upper_width=0.5*base_lower_width;
base_upper_thick=0.75*dot_height;
base_fn=100;
minkowski_fn=10;
numslots=50;
magnetD=8.1;
magnetH=3;

shelf_len=2*dot_height;
cabinetClipHt=1*MM_PER_INCH;

//http://mathworld.wolfram.com/CircularSector.html
// Given a circle, the apothem is the perpendicular distance r from the 
// midpoint of a chord to the circle's center.
function getApothem(radius, chordLen ) = 
    0.5*sqrt( 4*radius*radius - chordLen*chordLen );
// Given the apothem, what is the angle of the "Pie Slice" that is created.
function getCentralAngle(apothem, radius) =
    2*acos(apothem/radius);

// How much to adjust the height of the dot, so that the width of the top
// of the base aligns to the perimeter of the circle exactly.
apothem=getApothem(dot_radius, base_upper_width);

centeralAngle=getCentralAngle(apothem, dot_radius);
// The caPad distributes the "vents" around the perimeter of the dot.
caPad=(centeralAngle+10)/2;
// height of the center of the dot above the axis.
dot_Z=base_height+apothem;



module dot2ndGen(extra_height=0){
    cylinder(d=dot_diameter, h=dot_height+extra_height, $fn=dot_fn);
}

module _CapScrew(placement, orientation, length, cap=true,
cap_ht=3.25, cap_diameter=5.5, body_diameter=3.1){
  epsilon=0.01;
  translate(placement)
  rotate(orientation)
  if (cap) {
    union(){
      translate([0,0,-length-cap_ht+epsilon])
        cylinder(d=body_diameter, h=length+epsilon, $fn=30);
      translate([0,0,-cap_ht])
        cylinder(d=cap_diameter, h=cap_ht+epsilon, $fn=30);
    }
  } else {
    translate([0,0,-length+epsilon])
      cylinder(d=body_diameter, h=length+epsilon, $fn=30);
  }
}


module m3_CapScrew(placement, orientation, length, cap=true,
  cap_ht=3.25, cap_diameter=5.5){
  _CapScrew(placement, orientation, length, cap=cap,
    cap_ht=cap_ht, cap_diameter=cap_diameter, body_diameter=3.1);
}

module m3_SquareSlot(placement, orientation, length){
  nut_ht=2.053;  //2.0 actually plus some padding
  nut_width=5.53;//5.5 actually plus some padding
  
  translate(placement)
  rotate(orientation)
  translate([-nut_width/2,(nut_width/2)-length,-nut_ht])
    cube([nut_width, length, nut_ht]);
}

// The main dot Stand. This method creates the stand in it's usable position. When printing, it should
// be layed on it's back.
module DotStand(){
    difference(){
        minkowski(){
            sphere(d=2, $fn=minkowski_fn);
            union(){
                // main dot
                translate([0,0,dot_Z])
                    rotate([0,90,0])dot2ndGen(1);
                //the base
                difference(){
                    //main cube
                    translate([0,-base_lower_width/2,0])
                        cube([dot_height, base_lower_width, base_height]);
                    //remove the right (positive y) side;
                    translate([-1, base_lower_width/2, base_height])
                        rotate([0,90,0])
                            resize([2*base_height, base_upper_width, dot_height+2])
                                cylinder(r=base_height, h=dot_height+2, $fn=base_fn);
                    //remove the left (negative y) side;
                    translate([-1, -base_lower_width/2, base_height])
                        rotate([0,90,0])
                            resize([2*base_height, base_upper_width, dot_height+2])
                                cylinder(r=base_height, h=dot_height+2, $fn=base_fn);
                    //remove the front (positive X) side;
                    translate([dot_height, -1, base_height])
                        rotate([90,0,0])
                            resize([2*(dot_height-base_upper_thick), 2*base_height, base_lower_width+2])
                                cylinder(r=dot_height, h=base_lower_width+2, center=true, $fn=base_fn);
                }
            }
        }
        translate([base_upper_thick/2-2,0,base_height/2+1])
            cube([base_upper_thick,base_upper_width-8,base_height],true);
        translate([2,0,dot_Z])
            rotate([0,90,0])
            difference(){
                union(){
                    dot2ndGen(5);
                    for (a = [caPad:(360-2*caPad)/(numslots-1):361-caPad ])
                    rotate(-90 + a)
                    translate([0,dot_diameter/2,0])cube([2, 15, 25],true);
                }
                for (a = [0:90:361]){
                    rotate(a)
                    translate([0,dot_diameter/2+4,dot_height+1.5])cube([2, 10, 5],true);
                }
            }
        // center hole (conserve plastic, allow removal)
        translate([-2,0,dot_Z])
            rotate([0,90,0])
                cylinder(d=dot_diameter/2, h=dot_height, $fn=dot_fn);
        // 2 magnet insets
        translate([-1.1, base_upper_width/2+2,magnetD/2+1])
            rotate([0,90,0])
                cylinder(d=magnetD, h=magnetH);  
        translate([-1.1,-base_upper_width/2-2,magnetD/2+1])
            rotate([0,90,0])
                cylinder(d=magnetD, h=magnetH); 
        //cord slot
        cube([base_upper_thick, base_upper_width/3, 10], true); 
        //screws
        m3_CapScrew([dot_height/2,base_upper_width/2+2,-5], [0,180,0], 16);
        m3_SquareSlot([dot_height/2,base_upper_width/2+2,7], [0,0,0], 15);
        m3_CapScrew([dot_height/2,-base_upper_width/2-2,-5], [0,180,0], 16);
        m3_SquareSlot([dot_height/2,-base_upper_width/2+7,7], [0,0,0], 15);
    }
}

// This didn't work as well as I intended. I wanted this to stick to the metal corner bead
// embedded in a drywall soffet, but it dodn't hold. It should be fine for an actual metal
// shelf in a utility area...
module shelfAttachment(){
    difference(){
        translate([1,0,-3.5])cube([shelf_len, base_lower_width+2, 5], true); 
        //cord slot
        translate([-0.5*base_upper_thick,0,0])
        cube([2*base_upper_thick, base_upper_width/3, 10], true); 
        //screws
        m3_CapScrew([dot_height/2,base_upper_width/2+2,-6.0], [0,180,0], 16);
        m3_CapScrew([dot_height/2,-base_upper_width/2-2,-6.01], [0,180,0], 16);
        //magnet holes
        for( y= [-30, -15, 15, 30]){
        translate([-1.5-magnetD,y,-3.99])color("red")cylinder(d=magnetD, h=magnetH, $fn=50);  
        translate([-3.0*magnetD,y,-3.99])color("red")cylinder(d=magnetD, h=magnetH, $fn=50);  
        }
    }
}

// Create a hook that can be screwed to the bottom of the holder, to hand the stand 
// upside-down from a cabinet door or drawer front.
module cabinetAttachment(){
    clipwidth=2;
    hangarwidth=dot_height+clipwidth+Cabinet_Thickness;
    base_width=base_lower_width+2;
    difference(){
        union(){
            translate([1-clipwidth-Cabinet_Thickness,-base_width/2,-5.5])
                color("aqua")cube([hangarwidth, base_width, 5]); 
            translate([-1-Cabinet_Thickness,-base_width/2,-0.5])
                color("blue")cube([clipwidth, base_width, cabinetClipHt]);
        }
        //cord slot
        translate([-0.5*base_upper_thick,0,cabinetClipHt/2])
            cube([2*base_upper_thick, base_upper_width/3, cabinetClipHt+5], true); 
        //screws
        m3_CapScrew([dot_height/2,base_upper_width/2+2,-6.0], [0,180,0], 16);
        m3_CapScrew([dot_height/2,-base_upper_width/2-2,-6.01], [0,180,0], 16);

    }
}

// The reason for being here.
if (Part == "Dot"){
    rotate([0,-90,0])DotStand();
}

// Part for connecting to a metal shelf.
// Requires 2 M3x16 screws, 2 M3 square nuts and 10 8x3mm round magnets
if (Part == "Shelf") {
    shelfAttachment();
}

//shelfAttachment();
// Requires 2 M3x16 screws, 2 M3 square nuts
if (Part == "Hook"){
    cabinetAttachment();
}
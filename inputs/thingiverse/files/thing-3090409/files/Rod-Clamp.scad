// --------------------------------+---------------------------------------
// Title:        Parametric Rod Clamp
// Version:      1.0.0
// Release Date: 2018-08-01 (ISO)
// Author:       Nathan Brown
// --------------------------------+---------------------------------------
//
// Description:
//
// - Parametric rod clamp with options
//
// - Clamp for variable sized rods with various options to make the clamp more functional.
//
//   Print Recomendations:
//   * Use a higher perimiter count such as four or six.
//   * Radial infill may allow higher clamping force.
//   * Increase the top or bottom layers for any surface that will be exposed to force.
//   * Have fun! (required)
//
//
//   Features
//   * Variable Shaft & Clamp Size
//   * Variable Screw Size & Count
//   * Slide-on Option
//
// Release Notes:
//
//
// - Version 1.0
//   * First release with all the basic features to make a clamp
//
//

////////////////////////////////////////////////////////////////
// Constants

// Used to hide constant from Thingiverse.
C_CONSTANT = 0 + 0;

//Clamping split size for shafts radius
C_CLAMP_SIZE_1 = 1.0 + C_CONSTANT;
C_CLAMP_SIZE_5 = 1.5 + C_CONSTANT;
C_CLAMP_SIZE_20 = 2.0 + C_CONSTANT;

//M2 -> M5 Metric Screw Properties (Hole Sizes and Washer Diameters
C_M2_SIZE = 2.1 + C_CONSTANT;
C_M2_WASHER_DIAMETER = 5 + C_CONSTANT;
C_M2_WASHER_THICK = 0.35 + C_CONSTANT;
C_M2_NUT_THICK = 1.6 + C_CONSTANT;

C_M2p5_SIZE = 2.65 + C_CONSTANT;
C_M2p5_WASHER_DIAMETER = 5 + C_CONSTANT;
C_M2p5_WASHER_THICK = 0.55 + C_CONSTANT;
C_M2p5_NUT_THICK = 2 + C_CONSTANT;

C_M3_SIZE = 3.15 + C_CONSTANT;
C_M3_WASHER_DIAMETER = 7 + C_CONSTANT;
C_M3_WASHER_THICK = 0.55 + C_CONSTANT;
C_M3_NUT_THICK = 2.4 + C_CONSTANT;

C_M3p5_SIZE = 3.7 + C_CONSTANT;
C_M3p5_WASHER_DIAMETER = 8 + C_CONSTANT;
C_M3p5_WASHER_THICK = 0.55 + C_CONSTANT;
C_M3p5_NUT_THICK = 2.8 + C_CONSTANT;

C_M4_SIZE = 4.2 + C_CONSTANT;
C_M4_WASHER_DIAMETER = 9 + C_CONSTANT;
C_M4_WASHER_THICK = 0.9 + C_CONSTANT;
C_M4_NUT_THICK = 3.2 + C_CONSTANT;

C_M5_SIZE = 5.25 + C_CONSTANT;
C_M5_WASHER_DIAMETER = 10 + C_CONSTANT;
C_M5_WASHER_THICK = 1.1 + C_CONSTANT;
C_M5_NUT_THICK = 4.7 + C_CONSTANT;


////////////////////////////////////////////////////////////////
// Thingiverse Parameters

/* [Options] */

//Diameter (mm) of the shaft. 
shaft_diameter           = 8.0;

//Input Shaft Mode
shaft_mode              = 0;  // [ 0:Round, 1:Faced, 2:Double Faced ]

//Input Shaft Face Size (mm) (if faced)
shaft_face_size         = 1;

//Diameter (mm) of the output shoft
output_shaft_diameter    = 8.0;

//Output Shaft Mode
output_shaft_mode       = 0;  // [ 0:Round, 1:Faced, 2:Double Faced ]

//Output Shaft Face Size (mm) (if faced)
output_shaft_face_size   = 0;

//Outside Clamp Diameter (mm).  Mininum value of
clamp_diameter          = 30;

//Height of the clamp (mm)
clamp_height            = 20;

//Allows the clamp to be slid on from the side
clamp_slide_mode          = 0;  // [ 0:Off, 1:Slide On, 2:Slide with Wedge, 3:Double Sided ]




//Space between double sided clamp halves (only for Double Sided Clamp Style)
clamp_gap                 = 1;

//Number of clamping screws
screw_count            = 2;  // [ 0:None, 1:One, 2:Two, 3:Three, 4:Four ]

//Screw Size
screw_size             = 3;  // [ 2:M2, 2.5:M2.5, 3:M3, 3.5:M3.5, 4:M4, 5:M5 ]

//Screw Length (mm).  Actual length, will allow for washer(1) and nut(1).  Recommend at least Clamp Diameter * 0.5
screw_length            = 20;

//Model resolution.  Should be at least 64, but 96 will give you better circle.
resolution              = 96;

////////////////////////////////////////////////////////////////
// Module Variables

m_resolution = resolution;

m_clamp_radius = clamp_diameter / 2;
m_shaft_radius = shaft_diameter / 2;
m_shaft_radius_bottom = output_shaft_diameter / 2;

m_clamp_height = clamp_height;

m_clamp_gap = clamp_gap > m_shaft_radius ? m_shaft_radius : clamp_gap;

m_screw_size = screw_size + 0;

m_screw_radius = MX_ScrewHole(screw_size) / 2;

m_screw_length = screw_length < shaft_diameter ? shaft_diameter : (screw_length > clamp_diameter ? clamp_diameter : screw_length);

//Actual working length of the screw = Total Length - One Nut & One Washer
m_screw_working_length = m_screw_length - MX_ScrewWasherPlusNutHeight(screw_size);

//Countersing hole size
m_screw_washer_radius = MX_ScrewWasherHole(screw_size) / 2 + 0.1;

//Height of a single screw position
m_screw_height = (m_screw_washer_radius * 2) + 1;

//Offset from the center of the clamp for the screws
m_screw_x_offset = m_clamp_radius * 0.666666666;

//Screw count Calculation
m_screw_count = ((screw_count * m_screw_height) > m_clamp_height) ? floor(m_clamp_height / m_screw_height) : screw_count;

//Total Height of all Screws
m_screw_all_height = m_screw_height * m_screw_count;
m_screw_offset = (m_clamp_height - m_screw_all_height) / (m_screw_count + 1);

m_screw_starting_offset = (m_clamp_height * -0.5);

//Diameter to cut any when cutting through the entire clamp
m_cut_diameter = clamp_diameter + 1;

m_cut_wedge_extent = m_shaft_radius * 0.7 > m_clamp_radius ? m_clamp_radius - 1 : m_shaft_radius * 0.7;




////////////////////////////////////////////////////////////////
// Main


main();

// Main
module main() {

    //Set Resolution
    $fn = m_resolution;

    difference()
    {
        //Main Clamp Body
        clamp();
        
        screwHoles(m_screw_starting_offset, m_screw_x_offset);
        
        if(clamp_slide_mode == 3)
        {
            screwHoles(m_screw_starting_offset, -m_screw_x_offset);
        }
        
    };

    //Slide with Wedge
    if(clamp_slide_mode == 2){
        
        translate([m_clamp_radius + 2 , 0, 0]) {
            
            difference(){
                intersection() {
                    clampBody();
                
                    clampCutSlideWithBlock(clamp_height, m_cut_wedge_extent - 0.2, 0.2);    
                };
                
                //Cut Screw Holes Normal Position
                screwHoles(m_screw_starting_offset, m_screw_x_offset);
                
                //Then cut a second set to allow for the piece to wedge in to clamp
                screwHoles(m_screw_starting_offset, m_screw_x_offset + 0.3);
            }
        };
        
    }



}

////////////////////////////////////////////////////////////////
// Modules

module clamp() {


    if(clamp_slide_mode == 0) {
        //No slide on - just clamp
        difference() {
            clampBody();

            //Cut out the slide on portion
            clampCutNormal();
        };
    
    } else if(clamp_slide_mode == 1 || clamp_slide_mode == 2) {
        //Slit for Clamping or Slide on Option

        difference() {
            clampBody();

            //Cut out the slide on portion
            clampCutSlideNormal();
            
            //Cut out the Insert Block
            if(clamp_slide_mode == 2) {
                clampCutSlideWithBlock(clamp_height + 1, m_cut_wedge_extent, 0);
            }    
        }
    } else if(clamp_slide_mode == 3) {
      //Double Sided
        
        //First make one side
        difference() {
            clampBody();

            clampCutDoubleSided();
        };
        
        //Then make the second side
        intersection(){
            clampBody();
            
            translate([0, m_clamp_gap, 0]){
                clampCutDoubleSided();
            }
            
        }
        
        
    } else {
        //Normal Single Cut
        clampCutNormal();
    }
        
    
}


module clampBody(){
    
    //Main Clamp Body
    difference() {
        //Main
        cylinder(h = m_clamp_height, r = m_clamp_radius, center = true);
        
        //Center Hole - top
        shaft(m_shaft_radius, 0, shaft_mode, shaft_face_size, 0);
        //cylinder(h = m_clamp_height + 1, r = m_shaft_radius, center = true);
        
        //Center Hole - bottom
        shaft(m_shaft_radius_bottom, 1, output_shaft_mode, output_shaft_face_size, 0);
        ///cylinder(h = (m_clamp_height / 2) + 1, r = m_shaft_radius_bottom, center = false);

    };
    
}

/*
 @radius = shaft radius
 @bottom = 0 top, 1 bottom
 @mode = 0 round, 1 faced, 2 double faced, 3 keyed
 @fDepth = Feature Depth (face depth or Key height)
 @fWidth = Feature Width (key width)
*/
module shaft(radius, top, mode, fDepth, fWidth){

    holeHeight = (m_clamp_height / 2) + 1;

    translate([0, 0, (top * -1) * holeHeight]){
        difference() {
            //Center Hole - top
            cylinder(h = holeHeight, r = radius, center = false);
            
            if(mode == 1){
                //Single face
                linear_extrude(height = holeHeight, center = false) {
                    polygon(points = [ 
                        [-radius - fDepth,-radius], [-radius - fDepth, radius],
                        [-radius + fDepth, radius], [-radius + fDepth, -radius] ]);
                    
                }
                        
            }else if(mode == 2){
                //Double Face (90deg offset)
                linear_extrude(height = holeHeight, center = false) {
                    polygon(points = [ 
                        [-radius - fDepth,-radius], [-radius - fDepth, radius],
                        [-radius + fDepth, radius], [-radius + fDepth, -radius] ]);
                    
                }
                
                linear_extrude(height = holeHeight, center = false) {
                    polygon(points = [ 
                        [-radius, -radius - fDepth], [radius, -radius - fDepth],
                        [radius, -radius + fDepth], [-radius, -radius + fDepth] ]);
                    
                }
            }
            
        }
    }
    
    
}


//Cut for Normal Clamp
module clampCutNormal(){
    
    //Vary the clamping slit by the size of the shaft
    i_cut_extent = m_shaft_radius >= 20 ? C_CLAMP_SIZE_20 : 
        (m_shaft_radius > 5.0 ? C_CLAMP_SIZE_5 : C_CLAMP_SIZE_1 );
    
    //Taper the center to allow clamping
    linear_extrude(height = m_clamp_height + 1, center = true) {
        polygon(points = [ 
            [0,0], [ m_clamp_radius, -i_cut_extent ], [ m_clamp_radius, i_cut_extent ] ]);
        
        polygon(points = [ 
            [m_clamp_radius, 0], [ 0, 0.5 ], [ 0, -0.5 ] ]);
    }
    
}


//Cut out Slide on Clamp
module clampCutSlideNormal() {
    
    //Regular Slide on without any clamping block
    linear_extrude(height = m_clamp_height + 1, center = true) {
        //Primary rectangle
        polygon(points = [ 
            [0, m_shaft_radius], [0, -m_shaft_radius],
            [m_cut_diameter, -m_shaft_radius ], [ m_cut_diameter, m_shaft_radius ] 
            ]);
        
    }
}

//Cut out for Slide on with extra clamping block
module clampCutSlideWithBlock(extrudeHeight, wedgeExtent, startingX) {
   
    i_wedge_radius = m_clamp_radius + 1;
    
    linear_extrude(height = extrudeHeight, center = true) {

        //Angle cut for wedge
        polygon(points = [ 
            [startingX, m_shaft_radius + wedgeExtent], [startingX, -m_shaft_radius - wedgeExtent],
            [i_wedge_radius, -m_shaft_radius ], [ i_wedge_radius, m_shaft_radius ] 
            ]);

    }
    
}

module clampCutDoubleSided(){
    
    //m_cut_diameter
    m_cut_height = m_clamp_height * 0.5 + 1;
    
    i_height_vert = m_clamp_height * 0.5 - 4;

     rotate([0,90,0]){
        linear_extrude(height = clamp_diameter + 1, center = true) {
            polygon(points = [ 
                [ m_cut_height, 0], 
                [ m_cut_height - 4, 0 ], 
                [ 0 + 2 , m_clamp_radius * 0.2 ] ,
                [ 0 - 2 , m_clamp_radius * -0.2],
                [ -m_cut_height + 4, 0 ], 
                [ -m_cut_height, 0],
                [ -m_cut_height,  m_clamp_radius + 1],
                [ m_cut_height,  m_clamp_radius + 1]
                ]);
        };

    }
    
}

module screwHoles(screwStartingOffset, xOffset){
    
    for (i = [1 : m_screw_count])
    {
        
        //Cut Screw Holes & Countersink
        screwHole(xOffset, screwStartingOffset 
            + (i - 1) * (m_screw_height) 
            + (m_screw_height) * 0.5 
            + i * m_screw_offset);


    }

    
}


module screwHole(offsetX, offsetZ){
    
    //X
    //m_clamp_radius * (2/3)
    
    //Screw Hole
    translate([offsetX, 0, offsetZ])
    {
        rotate([90, 0, 0]){
            cylinder(h = m_clamp_radius * 2 + 1, r = m_screw_radius, center = true);
        }
    }

    
    //Screw Countersink Hole
    screwHoleCountersink (offsetX, offsetZ);
    mirror([0, 1, 0])
    {
        screwHoleCountersink (offsetX, offsetZ);
    }

    
}


module screwHoleCountersink(offsetX, offsetZ){

    
    //Screw Countersink Hole
    translate([offsetX, m_clamp_radius / 2 +  m_screw_working_length * 0.5, offsetZ])
    {
        rotate([90, 0, 0]){
            cylinder(h = m_clamp_radius, r = m_screw_washer_radius, center = true);
        }
    }
    
};



////////////////////////////////////////////////////////////////
// Functions and other Lookups


function MX_ScrewHole(x) = 
    x == 2 ? C_M2_SIZE 
    : x == 2.5 ? C_M2p5_SIZE
    : x == 3 ? C_M3_SIZE
    : x == 3.5 ? C_M3p5_SIZE
    : x == 4 ? C_M4_SIZE
    : C_M5_SIZE;

function MX_ScrewWasherHole(x) = 
    x == 2 ? C_M2_WASHER_DIAMETER
    : x == 2.5 ? C_M2p5_WASHER_DIAMETER
    : x == 3 ? C_M3_WASHER_DIAMETER
    : x == 3.5 ? C_M3p5_WASHER_DIAMETER
    : x == 4 ? C_M4_WASHER_DIAMETER
    : C_M5_WASHER_DIAMETER;

function MX_ScrewWasherPlusNutHeight(x) = 
    x == 2 ? C_M2_WASHER_THICK + C_M2_NUT_THICK
    : x == 2.5 ? C_M2p5_WASHER_THICK + C_M2p5_NUT_THICK
    : x == 3 ? C_M3_WASHER_THICK + C_M3_NUT_THICK
    : x == 3.5 ? C_M3p5_WASHER_THICK + C_M3p5_NUT_THICK
    : x == 4 ? C_M4_WASHER_THICK + C_M4_NUT_THICK
    : C_M5_WASHER_THICK + C_M5_NUT_THICK;



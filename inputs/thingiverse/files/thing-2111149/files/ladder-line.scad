//
// ladder_line.scad
//
//  Evilteach
//
//  12/30/2016
//
//  a prototype for ladder line spacers
//

use <utils/build_plate.scad>

build_plate(build_plate_selector,
        build_plate_manual_x,
        build_plate_manual_y);

function inches2mm(x) = x * 25.4;

// The distance from the center of one hole to the next in inches
inchesBetweenHoles = 6.0;   // [3 : .0625 : 8]

// The size of the wire you are using
wireGage = 12;  // [12:16]

// This sets the thickness of the T shaped bar
tThickness = 2; // [2:6]


/* [BUILD PLATE] */
build_plate_selector = 3;   //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]
build_plate_manual_x = 228; //[100:400]
build_plate_manual_y = 149;  //[100:400]

// Angle to reorient the model to fit on smaller print beds.
newAngle = 0; // [0:45]

/* [HIDDEN] */

wireDiameter = (wireGage == 12) ? 2.05232 :
               (wireGage == 13) ? 1.82880 :
               (wireGage == 14) ? 1.62814 :
               (wireGage == 15) ? 1.45034 :
                                  1.29032; 
    
tWidth  = inches2mm(inchesBetweenHoles) + 
              4 * wireDiameter;
tDepth  = 6;
tHeight = 6;


// Hard coded wedge that ought to be dependent on the hole variables
module wedge()
{
    color("yellow")
        linear_extrude(height=tDepth)
            polygon( points = [ [0, 0], [2.4, 0], [1.2, 5] ] );       
}



module hole()
{
    color("lime")
        cylinder(d = wireDiameter, tDepth, $fn=90);
}

module draw_t()
{
    color("cyan")
        cube([tWidth, tDepth, tThickness]);

    translate([0, tDepth / 2 + tThickness / 2, 0])
        rotate([90, 0, 0])
           cube([tWidth, tDepth, tThickness]);
    
}


module main()
{
    rotate([0, 0, newAngle])
    {
        translate([-tWidth / 2, -tDepth / 2, 0])
        {
            difference()
            {
                draw_t();

                rotate([90, 0, 0])
                    translate([wireDiameter, tHeight / 2 + .03, -tDepth])
                        hole();

                rotate([0, 90, -90])
                    translate([-tHeight / 2 - 1.2, -5 + 2 * wireDiameter, -tDepth])
                        wedge();
              
                
                rotate([90, 0, 0])
                    translate([tWidth - wireDiameter, tHeight / 2 + .03, -tDepth])
                        hole();     

                translate([tWidth + 5 - 2 * wireDiameter, tDepth, tHeight / 2 - 1.2])
                    rotate([90, -90, 0])
                        wedge();                
            }
        }
    }
}

main();



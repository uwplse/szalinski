/*----------------------------------------------------------------------------*/
/*  Created by Ziv Botzer                                                     */
/*  18.5.2016                                                                 */
/*  3.1.2017 increased maximum values                                         */
/*----------------------------------------------------------------------------*/


/*----------------------------------------------------------------------------*/
/*-------                           SETTINGS                          --------*/
/*----------------------------------------------------------------------------*/

// Diameter of your vacuum cleaner pipe + clearance (34.6mm worked good for me)
Base_Diameter = 34.6; // [20:0.1:80]

// Length of pipe overlapping vacuum clear pipe
Base_Overlap = 30; // [10:1:100]

// Length of chamfered area between nozzle and base
Base_Chamfer_Length = 30;  // [20:1:100]

// Material thickness at base
Base_Thickness = 1.8; // [0.5:0.2:5]

// Length of nozzle, total height of model
Nozzle_Length = 140; // [50:1:400]

// First dimension of nozzle section
Nozzle_Outer_A = 16; // [4:0.5:120]

// Second dimension of nozzle section
Nozzle_Outer_B = 8; // [4:0.5:120]

// Fillet radius of nozzle section
Nozzle_Fillet_Radius = 3; // [1:0.5:60]

// Material thickness along nozzle
Nozzle_Thickness = 1.4; // [0.5:0.2:5]

// Chamfer depth of nozzle tip
Nozzle_Chamfer_A = 20; // [0:1:120]

// Chamfer length of nozzle tip
Nozzle_Chamfer_B = 20; // [0:1:150]


/////////////


/* [Hidden] */

$fn=150;

Nozzle_Inner_A = Nozzle_Outer_A - Nozzle_Thickness;
Nozzle_Inner_B = Nozzle_Outer_B - Nozzle_Thickness;

mainRadius = Base_Diameter/2;

Nozzle_Fillet_s1 = (Nozzle_Fillet_Radius < Nozzle_Outer_A/2) ? Nozzle_Fillet_Radius : Nozzle_Outer_A/2-0.5;
Nozzle_Fillet = (Nozzle_Fillet_s1 < Nozzle_Outer_B/2) ? Nozzle_Fillet_s1 : Nozzle_Outer_B/2-0.5;
echo(Nozzle_Fillet);

// trim base chamfer length depending on maximum length and overlap length
Base_Chamfer_Length_ = ((Base_Overlap + Base_Chamfer_Length + 10) < Nozzle_Length) ?
    Base_Chamfer_Length : (Nozzle_Length - Base_Overlap - 10);

// trim chamfer A at width of nozzle
Nozzle_Chamfer_A_ = (Nozzle_Chamfer_A < Nozzle_Outer_A) ? Nozzle_Chamfer_A : Nozzle_Outer_A;

// trim chamfer B at length of nozzle - cylinder
Nozzle_Chamfer_B_ = (Nozzle_Chamfer_B < Nozzle_Length - (Base_Overlap + Base_Chamfer_Length)) ? Nozzle_Chamfer_B : (Nozzle_Length - (Base_Overlap + Base_Chamfer_Length_));

// WARNINGS
if ((Nozzle_Fillet_Radius >= Nozzle_Outer_A/2) || (Nozzle_Fillet_Radius >= Nozzle_Outer_B/2)) {
    echo ("Fillet size reduced to allow rebuild");
}
if ((Base_Overlap + Base_Chamfer_Length + 10) < Nozzle_Length) {
    echo ("Base chamfer length has been shortened to allow rebuild");
}
if ((Nozzle_Chamfer_A < Nozzle_Outer_A) ||
   (Nozzle_Chamfer_B < Nozzle_Length - (Base_Overlap + Base_Chamfer_Length))) {
    echo ("Nozzle chamfer has been shortened to allow rebuild");
}

difference() {
    // positive form
    union() {
        make_base ( mainRadius + Base_Thickness, Base_Overlap + Base_Thickness, Base_Chamfer_Length_);
        make_nozzle(Nozzle_Length, Nozzle_Outer_A, Nozzle_Outer_B, Nozzle_Fillet, 
                    Base_Overlap + Base_Chamfer_Length_/2);
    }
    
    // negative form
    union() {
        translate([0,0,-0.2]) make_base ( mainRadius, Base_Overlap, Base_Chamfer_Length_);
    
        translate([0,0,Nozzle_Thickness])
        make_nozzle(Nozzle_Length+10, Nozzle_Outer_A-2*Nozzle_Thickness, Nozzle_Outer_B-2*Nozzle_Thickness, 
            (Nozzle_Fillet-Nozzle_Thickness <= 0) ? 
            0.1 :  Nozzle_Fillet - Nozzle_Thickness, 
            Base_Overlap + Base_Chamfer_Length_/2 + Nozzle_Thickness);
    }
    
    // trim triangle for long angle
    translate([-0.05,0,Nozzle_Length+0.01] )
      rotate([90,0,0]) 
      linear_extrude(Nozzle_Outer_B+1, center=true)  
                    polygon( points = [[Nozzle_Outer_A/2-Nozzle_Chamfer_A_,0],
                                        [Nozzle_Outer_A/2+0.1,0],
                                        [Nozzle_Outer_A/2+0.1,-Nozzle_Chamfer_B_]] );
}




module make_base( radius, cylinder_length, chamfer_length ) {
    union() {
        linear_extrude(cylinder_length) circle (radius);
        translate([0,0,cylinder_length-0.05]) linear_extrude(chamfer_length, scale=0.1) circle (radius);
    }
}

module make_nozzle( length, a, b, filletR, offset_z ) {
    union() {
        translate([0,0,offset_z])
        linear_extrude(length-offset_z) {
            minkowski() {
                square ( [a-2*filletR, b-2*filletR], center = true);
                circle(filletR);
            }
        }
    
        translate([0,0,offset_z+0.1])
        rotate([0,180,0])
            linear_extrude(offset_z, scale=0.1) {
                minkowski() {
                    square ( [a-2*filletR, b-2*filletR], center = true);
                    circle(filletR);
                }
            }
    }
}



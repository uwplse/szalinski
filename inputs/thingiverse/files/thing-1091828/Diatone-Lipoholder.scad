//***********************************
//     Lipo Battery Holder for Diatone 250 FPV    *
//          Henning Stöcklein 25.10.2015            *
//          Free for Non-commercial Use             *
//***********************************

// Base Block Size X
cx = 10 ; // [7:15] 

// Base Block Size Y
cy = 9 ; // [7:15]

// Base Block Height
ch = 10 ; // [7:15]

// Type of Block Chamfer
chamfer_type = 2 ; // [0:None, 1:2D-Chamfer, 2:3D-Chamfer]

//  Block Chamfer Radius
rCham = 0.9 ;

// Block Ramp Cutout (only 3D chamfer)
ramp = 2.2 ; 

// M3 Thread Core Diameter
rM3 = 2.5 ;

// Ruber Slot Position X
slot_x = -0.5 ;

// Ruber Slot Position Z
slot_z = 0.4 ;

// Rubber Slot Width
rRub1 = 0.65 ; 

// Rubber Slot End Hole Diameter
rRub2 = 2.2 ;

//*********  End of Customizing Area******************

module roundcube (x, y, z, rad)
{
    hull() {
      translate ([rad,rad,0]) cylinder (r=rad,h=z, $fn=30) ;
      translate ([rad, y-rad, 0]) cylinder (r=rad,h=z, $fn=30) ;
      translate ([x-rad, rad, 0]) cylinder (r=rad,h=z, $fn=30) ;
      translate ([x-rad, y-rad, 0]) cylinder (r=rad,h=z, $fn=30) ;
    }
}

module ballcube (x, y, z, rad)
{
    hull() {
      translate ([rad,rad,rad]) sphere (r=rad, $fn=30) ;
      translate ([rad, y-rad, rad]) sphere (r=rad, $fn=30) ;
      translate ([x-rad, rad, rad]) sphere (r=rad, $fn=30) ;
      translate ([x-rad, y-rad, rad]) sphere (r=rad, $fn=30) ;

      translate ([rad,rad,z-rad]) sphere (r=rad, $fn=30) ;
      translate ([rad, y-rad, z-rad]) sphere (r=rad, $fn=30) ;
      translate ([x-rad-ramp, rad, z-rad]) sphere (r=rad, $fn=30) ;
      translate ([x-rad-ramp, y-rad, z-rad]) sphere (r=rad, $fn=30) ;
      translate ([x-rad, rad, z-rad-ramp]) sphere (r=rad, $fn=30) ;
      translate ([x-rad, y-rad, z-rad-ramp]) sphere (r=rad, $fn=30) ;
    }
}

module holder ()
{
    difference () 
    {
       // Basic Cube with 2D or 3D chamfers
       if (chamfer_type == 0) { cube ([cx, cy, ch]) ; }
       if (chamfer_type == 1) { roundcube (cx, cy, ch, rCham) ; }
       if (chamfer_type == 2) { ballcube (cx, cy, ch, rCham) ; }

        // M3 Screw hole and hole extension for support-free printing
        translate ([1.5+rM3/2,cy/2,0]) cylinder (r=rM3/2, h=50, $fn=20) ;
        translate ([1.5+rM3/2,cy/2-rM3/2*0.7,0]) 
               scale ([1,0.8,1]) rotate ([0,0,45]) cube ([rM3/2,rM3/2,50], center=true ) ;
 
        // Slot for Rubber
        translate ([cx*0.65,cy,ch*0.65]) 
            hull() {
              translate ([slot_x,0,slot_z]) rotate ([90,0,0]) cylinder (r=rRub1, h=cy, $fn=20) ;
              translate ([4.5,0,-4.5]) rotate ([90,0,0]) cylinder (r=rRub1, h=cy, $fn=20) ;
           } // hull
           
        // Hole at end of Rubber slot
        translate ([cx*0.65+slot_x,cy,ch*0.65+slot_z]) rotate ([90,0,0]) cylinder (r=rRub2/2, h=cy, $fn=20) ;
    }
}

holder() ;
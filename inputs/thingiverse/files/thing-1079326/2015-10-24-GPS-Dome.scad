//**********************************************
//       GPS Cover Dome for Quadcopter 30.5 x 30.5mm FC
//  Source Code and created objects are free for private use
//              (C) Henning Stöcklein   18.10.2015

//********** Change log **********************************
// 18.10.2015   Created as split off my FNQ Foldable Quadcopter Source
// 24.10.2015   Screw top head chamfer added, optional top hole added
//********** End Change log *******************************

/* [Object Selection] */

// What to print
visible = "all" ; // ["all", "top plate", "level plate"]

// Support Structure 
Support = 0 ;  // [0:No, 1:Yes]


/* [Base geometry] */

// Footprint Hole Distance
fhd = 30.5 ;

// Dome height
h_dome = 18.0; // [8:30]

// Top Plate thickness
h_Plate = 1.0 ;

// Plate Border height
h_Bord = 2.0 ;

// Weight reduction hole diameter
tophole_dia = 0 ; // [0:28]

// Cylinder Outer Diameter
Cyl_Dia = 5.5 ;

// Cylinder Segment Wall Thickness
Cyl_Wall = 1.2 ;

// Screw Hole Diameter
M3_Dia = 3.5 ;

// Screw Head Sink Diameter
M3_Sink_dia = 5.9 ;
    
// Screw Head Sink Depth (0=Flat on top)
M3_Sink_ht = 10 ;

// Screw Head Hole Chamfer depth
M3_Head_Chamfer = 0.2 ;

/* [Intermediate plate] */

// Level plate Z position
z_level = 9 ; // [9:22]

// Level plate thickness
h_level = 1.1 ;

// Gap between domes and level plate
Gap_level = 0.2 ;

// Weight reduction hole diameter
level_dia = 22 ; // [0:28]


//*******************************************
//*  Select here what to print
//*******************************************
if (visible == "all") {
    coverdome() ;
    levelplate() ;
}

if (visible == "top plate") {
    coverdome() ;
}

if (visible == "level plate") {
    levelplate() ;
}
    
// *************************************************
//    Cover dome for 30.5 x 30.5 FC footprint
// *************************************************
module coverdome()
{
   // Holder for FC footprint 30.5x30.5 (e.g. Naze32)
   difference() {
      union() {
		// Top plate = Round cube
        translate ([0,0,h_dome]) 
          hull() {
            translate ([+fhd/2,+fhd/2,0]) cylinder (r=Cyl_Dia/2, h=h_Plate, $fn=20) ;
            translate ([+fhd/2,-fhd/2,0]) cylinder (r=Cyl_Dia/2, h=h_Plate, $fn=20) ;		
            translate ([-fhd/2,+fhd/2,0]) cylinder (r=Cyl_Dia/2, h=h_Plate, $fn=20) ;		
            translate ([-fhd/2,-fhd/2,0]) cylinder (r=Cyl_Dia/2, h=h_Plate, $fn=20) ;		
        } // hull
        
        // 4 cylindrical legs with screw holes
        for (i=[0:90:350])
        {
            rotate ([0,0,i]) 
            {
        		// Domes for M3 screws
                translate ([+fhd/2,+fhd/2,0]) cylinder (r=Cyl_Dia/2, h=h_dome, $fn=20) ;

        	    // Small side wall
                translate ([0,+fhd/2+Cyl_Dia/2-h_Plate/2,h_dome-h_Plate/2]) 
                    cube ([fhd, h_Plate, h_Bord], center=true) ;

         		// Dome strengthening segments
                hull () 
                {
                intersection () {
                     translate ([+fhd/2,+fhd/2,h_dome+h_Plate-M3_Sink_ht])
                        cylinder (r=Cyl_Wall+Cyl_Dia/2, h=M3_Sink_ht, $fn=20) ;
                     hullplate() ;
                  } // intersection
                  translate ([+fhd/2,+fhd/2,h_dome+h_Plate-M3_Sink_ht-2.5]) 
                      cylinder (r=Cyl_Dia/2, h=0.1, $fn=20) ;
                 } // hull
             } // rotate
         } // for        
      } // union
      
      // Cutout objects for 4 screw holes
      for (i=[0:90:350])
      {
          rotate ([0,0,i]) 
          {
        	  // Holes for M3 bolts
              translate ([+fhd/2,+fhd/2,0]) 
                  cylinder (r=M3_Dia/2, h=50, $fn=20, center=true) ;
      
        	  // Sink Holes for M3 heads
              translate ([+fhd/2,+fhd/2,h_dome+h_Plate-M3_Sink_ht]) 
                  cylinder (r=M3_Sink_dia/2, h=M3_Sink_ht+0.05, $fn=20) ; 

        	  // Chamfer Cylinder for segmented area (if any)
              translate ([+fhd/2+M3_Sink_dia/2,+fhd/2+M3_Sink_dia/2,h_dome+h_Plate-M3_Sink_ht]) 
                  cylinder (r=M3_Sink_dia/1.25, h=M3_Sink_ht+0.05, $fn=20) ; 

        	  // Chamfer Cylinder at top screw hole cutout (if any)
              translate ([+fhd/2,+fhd/2,h_dome+h_Plate-M3_Head_Chamfer]) 
                  cylinder (r1=M3_Sink_dia/2, r2=M3_Sink_dia/2+2, h=2, $fn=20) ; 
          } // rotate
      } // for
      
      // Weight reduction hole
      translate ([0,0,h_dome]) cylinder (r=tophole_dia/2, h=h_Plate+3, $fn=40, center=true) ;  

   } // difference
   
   // Support structure (if cutout legs)
   if (Support == 1) {
     for (i=[0:90:350])
     { 
        rotate ([0,0,i]) 
        {
           translate ([+fhd/2+Cyl_Dia/3,+fhd/2+Cyl_Dia/3,h_dome+h_Plate-M3_Sink_ht]) 
               cylinder (r=0.8, h=M3_Sink_ht+0.05, $fn=20) ; 
        } // rotate
    } // for
  } // if
}

//********************************************
// Additional plate can be fixed in the middle of the Domes
//********************************************
module levelplate()
{
   // Intermediate level to fix GPS module
   difference() {
      union() {
		// Plate = Round cube
        translate ([0,0,z_level]) 
          hull() {
            translate ([+fhd/2,+fhd/2,0]) cylinder (r=Cyl_Dia/2, h=h_level, $fn=20) ;
            translate ([+fhd/2,-fhd/2,0]) cylinder (r=Cyl_Dia/2, h=h_level, $fn=20) ;		
            translate ([-fhd/2,+fhd/2,0]) cylinder (r=Cyl_Dia/2, h=h_level, $fn=20) ;		
            translate ([-fhd/2,-fhd/2,0]) cylinder (r=Cyl_Dia/2, h=h_level, $fn=20) ;		
        } // hull
      } // union

      // Weight reduction hole
      translate ([0,0,z_level]) cylinder (r=level_dia/2, h=h_level+2, $fn=40, center=true) ; 
        
      // 4 cylindrical legs with screw holes
      for (i=[0:90:350])
      {
          rotate ([0,0,i]) 
          {
        		// Holes for Domes 
                translate ([+fhd/2,+fhd/2,0]) 
                    cylinder (r=Cyl_Dia/2+Gap_level, h=h_dome, $fn=20) ;

                // Holes for Strengthening Dome Segments              
                translate ([+fhd/2,+fhd/2,h_dome+h_Plate-M3_Sink_ht])
                     cylinder (r=Cyl_Wall+Cyl_Dia/2+Gap_level, h=M3_Sink_ht, $fn=20) ;
          } // rotate
      } // for
  } // difference
}

module hullplate()
{
    // Top plate = Round cube
    hull() {
            translate ([+fhd/2,+fhd/2,0]) cylinder (r=Cyl_Dia/2, h=40, $fn=20) ;
            translate ([+fhd/2,-fhd/2,0]) cylinder (r=Cyl_Dia/2, h=40, $fn=20) ;		
            translate ([-fhd/2,+fhd/2,0]) cylinder (r=Cyl_Dia/2, h=40, $fn=20) ;		
            translate ([-fhd/2,-fhd/2,0]) cylinder (r=Cyl_Dia/2, h=40, $fn=20) ;		
   } // hull
}

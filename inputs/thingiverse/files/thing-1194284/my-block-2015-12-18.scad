//********************************************
//* Direct Drive NEMA17 Extruder block with spring force 
//* compatible to Replicator 2X lever parts
//*
//*   Designed for supportless prints and 4-hole flange
//*     by Henning Stöcklein     Version 18.12.2015
//*     Free for non commercial use
//********************************************

// use <my_lever.scad>

// Radius of spring hole
r_Spring = 4.7 ; 

// Radius of Filament hole
r_Filament = 1.1 ;

// Radius of Bowden tube hole
r_Bowden = 2.0 ;  

// Select Flange Type
Side_Flange = 1 ;   // [0:No Side Flange, 1:Use Side Flange]

// Radius NEMA Hole distance
rla = 15.5 ;

// Length of Bowden Tube Guide 
h_Bowden = 2 ; // [0:10]

// Radius of Bowden Tube Fixing Thread Hole
r_Bowden_Fix = 1 ; // [0:No Fixing Hole, 1:M2.5 Fixing Hole, 1.2:M3 Fixing Hole]

module roundcube (x, y, z, rad)
{
    hull() {
      translate ([-x/2+rad, -y/2+rad, 0]) cylinder (r=rad,h=z, center=true, $fn=30) ;
      translate ([-x/2+rad, y/2-rad, 0]) cylinder (r=rad,h=z, center=true, $fn=30) ;
      translate ([x/2-rad, -y/2+rad, 0]) cylinder (r=rad,h=z, center=true, $fn=30) ;
      translate ([x/2-rad, y/2-rad, 0]) cylinder (r=rad,h=z, center=true, $fn=30) ;
    }
}

module round2cube (x, y, z, rad)
{
    hull() {
      translate ([-x/2, -y/2, 0]) cylinder (r=0.01,h=z,center=true, $fn=30) ;
      translate ([-x/2+rad, y/2-rad, 0]) cylinder (r=rad,h=z,center=true, $fn=30) ;
      translate ([x/2, -y/2, 0]) cylinder (r=0.01,h=z,center=true, $fn=30) ;
      translate ([x/2-rad, y/2-rad, 0]) cylinder (r=rad,h=z,center=true, $fn=30) ;
    }
}

module mybaseblock() {
  difference() {
    union(){
       if (Side_Flange == 1) rotate ([0,0,-90]) round2cube (42.6, 42.6, 4, 5.8) ;
       rotate ([0,0,-90]) roundcube (42.6, 42.6, 4, 5.8) ;
       translate ([-rla,+rla,1]) cylinder (r=5.8, h=4, $fn=30, center=true) ;
    } 
    
    // NEMA17-Flange with chamfer
    cylinder (r=22.5/2, h=10, $fn=40, center=true) ;
    translate ([0,0,-2.3]) cylinder (r2=22.5/2, r1=25/2, h=2, $fn=40, center=true) ;
    
    // 4 Screw holes with chamfers
    translate ([+rla,+rla,0]) cylinder (r=3.5/2, h=10, $fn=20, center=true) ; 
    translate ([+rla,+rla,1.3]) cylinder (r1=3.5/2,r2=3.3,h=2,$fn=20,center=true) ;
    translate ([+rla,-rla,0]) cylinder (r=3.5/2, h=10, $fn=20, center=true) ; 
    translate ([+rla,-rla,1.3]) cylinder (r1=3.5/2,r2=3.3,h=2,$fn=20,center=true) ;
    translate ([-rla,-rla,0]) cylinder (r=3.5/2, h=10, $fn=20, center=true) ; 
    translate ([-rla,-rla,1.3]) cylinder (r1=3.5/2,r2=3.3,h=2,$fn=20,center=true) ;
    translate ([-rla,+rla,0]) cylinder (r=3.5/2, h=10, $fn=20, center=true) ; 

  // Horizontal Cylinder cutout for Bowden
  translate ([-6,-20,8]) rotate ([90,0,0]) cylinder (r=7,h=20,$fn=40, center=true) ; 
  } // difference
}

module myblock() 
{
   difference() {
      union() {
        translate ([14.3,-2.22,6.5]) cube ([14.0,18.55,13], center=true); // Federblock
        translate ([1.1,-7.0,6.5]) cube ([20,9,13], center=true);
        translate ([1.1,-10,6.5]) cube ([25,2,13], center=true);
        translate ([8,-2,6.5]) cube ([5,5,13], center=true);
        
        // Cylinder on Spring block with chamfer
        translate ([14.3,-1.65,7.6]) rotate ([90,0,0]) cylinder (r=r_Spring+1.7, h=17.45, $fn=50, center=true);
        translate ([14.3,-10.92,7.6]) rotate ([90,0,0]) cylinder (r1=r_Spring+1.7,r2=r_Spring+1, h=1.15, $fn=50, center=true);
        translate ([-13.2,-10,7]) cube ([16, 3, 12], center=true);
        translate ([-9.8,-8.9,7]) rotate ([0,0,45]) cube ([5.4, 2, 12], center=true);

       // Side flange and triangle blocks
       if (Side_Flange == 1)
       {
            translate ([-21.5,4.2,5.5]) rotate ([90,0,90]) round2cube (55,15,5,4);
            translate ([-16,23.3,0]) rotate ([0,0,-45]) cube ([15.5,7,4], center=true) ;
            translate ([-18.5,-20.5,0]) rotate ([0,0,45]) cube ([5,3,4], center=true) ;
       }

      // Cylinder at Filament outlet hole / Bowden guide
      hull() {
        translate ([-6,-9-(h_Bowden+2.5)/2, 1]) cube ([5.3*2, h_Bowden+2.5, 0.1], center=true) ;
        translate ([-6,-9-(h_Bowden+2.5)/2, 7.6]) rotate ([90,0,0]) 
                cylinder (r=5.35, h=h_Bowden+2.5, $fn=40, center=true);
        } // hull
      } // union

      // Chamfer at Spring block
      translate ([14.3+8.5,-2,13]) rotate ([0,45,0]) cube ([4,19,4], center=true);
      translate ([14.3-8.5,7.5,13]) rotate ([0,45,0]) cube ([4,14,4], center=true);
      translate ([14.3+8,7.5,6]) rotate ([0,0,45]) cube ([4,4,15], center=true);
      translate ([14.3+8,-11.5,6]) rotate ([0,0,45]) cube ([4,4,15], center=true);
      translate ([14.3-8,7.5,6]) rotate ([0,0,45]) cube ([4,4,15], center=true);

      // Kugelkuppe auf Rückseite Federblock
      translate ([14.3,-20.4,7.5]) sphere (r=10.1, $fn=40);

      // Hole for spring with chamfer
      translate ([14.3,3,7.6]) rotate ([90,0,0]) cylinder (r=r_Spring, h=13, $fn=30, center=true);
      translate ([14.3,6.8,7.6]) rotate ([90,0,0]) cylinder (r2=r_Spring, r1=r_Spring+1, h=1.5, $fn=30, center=true);

      // Cutout on top of spring hole for best printability
      translate ([14.3,3,7.0+r_Spring]) scale ([1.5,1,0.8]) rotate ([0,45,0]) cube ([2, 13, 2], center=true);

      // Hole for Filament, with flat chamfer 
      translate ([-6,-7,7.6]) rotate ([90,0,0]) cylinder (r=r_Filament, h=15, $fn=20, center=true);
      translate ([-6,-3.7,7.6]) rotate ([90,0,0]) cylinder (r2=r_Filament, r1=r_Filament+1.5, h=2.6, $fn=30, center=true);

      // Hole for Bowden with chamfer
      translate ([-6,-9-(h_Bowden+2.5)/2,7.6]) rotate ([90,0,0]) cylinder (r=r_Bowden, h=h_Bowden+4.5, $fn=20, center=true);
     translate ([-6,-9.2-(h_Bowden+2.5),7.6]) rotate ([90,0,0]) cylinder (r1=r_Bowden, r2=r_Bowden+2, h=2, $fn=30, center=true);
     translate ([-6,-8-(h_Bowden+2.5)/2, 11]) cylinder (r=r_Bowden_Fix, h=5, $fn=20, center=true);


      // Cutout for Lever
      hull() {
         translate ([-16,-3,2]) cylinder (r=6.7, h=20, $fn=30) ;
         translate ([-16,16,2]) cylinder (r=6.7, h=20, $fn=30) ;
      } 

      // Schraublöcher an seitlicher Befestistungsplatte mit Fasen
      translate([-26,-16,6]) rotate ([0,90,0]) cylinder (r=3.5/2, h=10,$fn=20);
      translate([-21,-16,6]) rotate ([0,90,0]) cylinder (r1=3.5/2, r2=6.5/2, h=2.1,$fn=20);
      translate([-26,26,6]) rotate ([0,90,0]) cylinder (r=3.5/2, h=10,$fn=20);
      translate([-21,26,6]) rotate ([0,90,0]) cylinder (r1=3.5/2, r2=6.5/2, h=2.1,$fn=20);

      // Aussparung für Andruckrolle
      translate ([-12.7,1.1,7.6]) cylinder (r=7, h=14, $fn=50, center=true);

      // Aussparung für Antriebsrad
      translate ([0.1,0,7.6]) cylinder (r=6.72, h=16, $fn=50, center=true);

      // Fase oberhalb Motorflansch
      translate ([0,0,0.8]) cylinder (r2=13/2, r1=27/2, h=5, $fn=40, center=true) ;
   } // difference

  // Zentrierzapfen für innere 2.Feder in der Bohrung
  translate ([14.3,-3,7.6]) rotate ([90,0,0]) cylinder (r1=0.8, r2=2, h=3, $fn=20, center=true);
}

translate ([0,0,2]) myblock () ;
translate ([0,0,2]) mybaseblock () ;

// translate ([-21,-16.5,0]) %lever(1);

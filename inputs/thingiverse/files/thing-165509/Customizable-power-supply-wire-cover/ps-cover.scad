// Power Supply end cover.
// Mounts on a corner the power supply is near to cover exposed screw terminals.
// Better than tape!

//CUSTOMIZER VARIABLES

//How thick your walls are (in mm)
wallThickness = 5;

// The "width" of your power supply
PSwidth = 112;

// The "height" of your power supply
PSHeight = 50;

// The lenght you want the cover to extend from the wall (to the PS)
DistToWall = 42;

//The amount of cover you want to go "up" the wall above the PS height
coverHeight=30;


//CUSTOMIZER VARIABLES END


$fn=60;

cornerCutoutSize = 20;
roundCutoutSize=15;

difference() {
  union() {
   // Wall plate 1
   color([0,0.75,0])  // Green
   translate([-wallThickness,-coverHeight,0])
   cube([PSwidth+wallThickness,coverHeight,wallThickness]);

   //Wall Plate 2
   color([0.5,0,0]) // Red
   translate([PSwidth-wallThickness,-coverHeight,0])
   cube([wallThickness,coverHeight,DistToWall] );

   // Wall Plate 3
   color([0,0,0.5]) // Blue
   translate([0,-wallThickness,0])
   cube([PSwidth,wallThickness,DistToWall]);

  // Wall Plate 4
   translate([-wallThickness,0,0])
   #cube([wallThickness,PSHeight,DistToWall]);
  
  // Outside cylinder:
   cylinder(r=wallThickness, h=DistToWall);
 
  // Inside cylinder 1:
   translate([PSwidth-wallThickness,-wallThickness,0])
   cylinder(r=wallThickness, h=DistToWall);

  // Inside cylinder 2:
   translate([PSwidth-wallThickness,0,wallThickness])
   rotate([90,0,0])
   cylinder(r=wallThickness, h=coverHeight);

  // Inside cylinder 3:
   translate([-wallThickness,-wallThickness,wallThickness])
   rotate([0,90,0])
   cylinder(r=wallThickness, h=PSwidth+wallThickness);

  

   //Acompanying sphere.. (make ins cyl 3 wallThickness less)
   //translate([0,-wallThickness,wallThickness])
  // sphere(r=wallThickness);
  }


  // Cut this cube representing the power supply out of everything that needs it...(the outside cylinder...)
  color([0.85,0.85,-0.1])
   #cube([PSwidth,PSHeight,DistToWall+0.2]);

  // Air holes
 for ( x = [ wallThickness : 9: PSwidth-wallThickness*2],
         z = [ wallThickness : 9 : coverHeight - wallThickness]  ){
  
  translate([x+1, 0.1,wallThickness*2.5+z])
     rotate([0,270,0])
     rotate([90,0,0])
    cylinder(h=wallThickness+0.2, r=3, $fn=4);
 }

 // Screw Hole 1
 translate([PSwidth / 4,-coverHeight/1.5,-0.1])
   cylinder(r1=2,r2=3, h=wallThickness+0.2);

 // Screw Hole 2
 translate([PSwidth/1.5,-coverHeight/1.5,-0.1])
   cylinder(r1=2, r2=3,h=wallThickness+0.2);

 // Screw Hole 3
 translate([PSwidth-wallThickness-0.1,-coverHeight/1.5,DistToWall/2+wallThickness])
   rotate([0,90,0])
   cylinder(r1=3, r2=1, h=wallThickness+0.2);

  //45-deg bottom wire cutout
 translate([-wallThickness-0.1,PSHeight,0])
 rotate([0,90,-0])
 cylinder(r=cornerCutoutSize,h=wallThickness+0.2, $fn=4);

  //Round Wire cutout
 translate([-wallThickness-0.1,PSHeight/2,DistToWall])
  rotate([0,90,-0])
   cylinder(r=roundCutoutSize,h=wallThickness+0.2);

} // end diffeerence

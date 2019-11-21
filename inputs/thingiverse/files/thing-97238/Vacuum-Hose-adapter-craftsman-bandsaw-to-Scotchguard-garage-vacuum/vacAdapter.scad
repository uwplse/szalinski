//CUSTOMIZER VARIABLES


//How thick your walls are (in mm)
wallThickness = 2;

//The diameter inside the "small" end. Fits over the vacuum.
insideVacuum = 32;
//The length of the tube that fits over the vacuum.
vacuumLength = 45;

//The diameter of the outside of the "large" end. Fits inside something else
outsideBandsaw = 58;
//The length of the larger tube.
bandsawLength=24;

//CUSTOMIZER VARIABLES END

$fn=45;
rotate([0,180,0])
difference() {
  union() {
    translate([0,0,bandsawLength+(vacuumLength+bandsawLength)/3])
    cylinder(r=(insideVacuum/2)+wallThickness, h=vacuumLength);


    translate([0,0,bandsawLength])
    cylinder(r2=(insideVacuum/2)+wallThickness, r1=(outsideBandsaw/2),h=(vacuumLength+bandsawLength)/3);

  cylinder(r=(outsideBandsaw/2), h=bandsawLength);
 }

translate([0,0,bandsawLength+(vacuumLength+bandsawLength)/3-0.5])
#cylinder(r=(insideVacuum/2),h=vacuumLength+1);

  translate([0,0,bandsawLength])
   #cylinder(r2=(insideVacuum/2), r1=(outsideBandsaw/2)-wallThickness,h=(vacuumLength+bandsawLength)/3 );

translate([0,0,-0.5])
#cylinder(r=(outsideBandsaw/2)-wallThickness, h=bandsawLength+1);
 }
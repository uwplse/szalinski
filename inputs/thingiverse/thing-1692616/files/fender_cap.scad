// SKS fender caps
/*[Fender Cap]*/
//Outer Diameter of Cap
outterDia = 6; 
//Inner diameter for rod
innerDia = 3.8;
//Entire length
overallLen = 31.3;
//Diameter of circular cutout
cutOut = 10; 
//Thickness
rectZ = 9.5;
//Width
rectX = 18.5;

/*[Hidden]*/
rectY = outterDia;
cubeDim = [rectX, rectY, rectZ]; 
length = overallLen - rectZ - outterDia/2;


module assemble() {
  rotate([90, 0, 0])
  difference() {
    union() {
      cylinder(r = outterDia/2, h = length, center = true, $fn = 36);
      translate([0, 0, length/2*.999])
        sphere(r = outterDia/2, center = true, $fn = 36);
      translate([0, 0, -length/2-cubeDim[2]/2])
        rect();
    }
    translate([0, 0, -rectZ/2])
      cylinder(r = innerDia/2, h = (overallLen - outterDia/2)*1.001 , center = true, $fn = 36);
  }
}

module rect() {
  difference() {
      cube(cubeDim, center = true);
      translate([0, 0, -cubeDim[2]/2]) 
      rotate([90, 0, 0])
        cylinder(r = cutOut/2, h = cubeDim[1]*1.001, center = true, $fn = 36); 


  }
}

for (i = [0:2]) {
  for (j = [0:2]) {
    translate([rectX*i*1.2, overallLen*j*1.2, 0])
      assemble();
  }
}

///////////////////////////////////////
// Container properties
    //Height (Default 10mm)
    height=10;
    //Inner Diameter(Change this for other bottle sizes).
    inner = 24.7;
    // Citadel Paint Bottle inner = 24.7;
    // Vallejo Paint Bottle inner = 32.7;
    //Outer Diameter
    outer = inner+3;
    //outer = inner+4;
    distortion = inner+2;
    outcut = inner/2;
    houtcut = height-5;
    //Smoothness
    $fn=50;
    
///////////////////////////////////////
// Number of bottles, type in desired #of for each Axis
    xaksis = 1;
    yaksis = 1;

module oppbevaring() {

// Main container
difference(){
cylinder (d = outer, h = height);

translate([0,0,3])    
cylinder (d = inner, h = height);

// Underside top cap hole (for stackability)
translate([0,0,0])        
//cylinder (d1 = 16, d2= 14, h = 4);
cylinder (d = 8, h = 4);
     
// Reduced print material
for(r=[0:4]) {
    rotate([0,0,r*360/4])
    translate([outcut,0,3])
    cylinder (d = 9, h = houtcut);
  }
   
}
}

///////////////////////////////////////
// Container generation
    XA = xaksis-1;
    YA = yaksis-1;

for (y = [0:YA]) {
    translate([0,y*distortion,0])
for(x = [0:XA]) {
translate([x*distortion,0,0])
oppbevaring();
}
}

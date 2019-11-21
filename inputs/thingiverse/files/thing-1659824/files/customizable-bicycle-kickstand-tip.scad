// Customizable Bicylce Kickstand Tip
// by HarlemSquirrel

// Inside diameter in mm
inside_d = 11; //[5:25]

// Base diameter in mm
base_d = 30; //[30:60]

// Base height in mm
base_h = 30; //[30:60]

// Tilt of the kickstand in degrees
tilt = 30; //[0:45]

// Roundness of the tip in number of sides
roundness=12; //[4:64]


module inside() {
  translate([0,0,base_h-15])
  //rotate([45,0,0])
  cylinder(d1=inside_d-1, d2=inside_d, h=22);
}

module outside() {
  difference() {
    cylinder(d1=base_d, d2=inside_d+4, h=base_h, $fn=roundness, $fs=100);
  }
}

module kickstand_tip() {
  difference() {outside();
    inside();
    
  }
}

module angled_kickstand_top() {
  difference() {
    translate([0,0,-sin(tilt)*base_d/2])
    rotate([0,tilt,0])
    kickstand_tip();
    
    translate([0,0,-base_d])
    cube(base_d*2, center=true);
  }
}

angled_kickstand_top();
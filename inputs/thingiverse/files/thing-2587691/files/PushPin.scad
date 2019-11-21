//-- Parametric push pin

// Parameters

// Diameter
diam = 12.0; // [5.0:20.0]

/* [Hidden] */
// diameter ratio
pin_diam = diam*0.32;
space = 0.5;
h = diam*3; // height ratio
e = 0.02;
pin_xy = diam + 10; // offset for pin print
$fn = 64;

// Modules
module cutout(){
    // corners
    translate([-diam/2,-diam/2,0]) cube([diam/2+pin_diam,diam/2+pin_diam,h*3], center=true);
    translate([diam/2,diam/2,0]) cube([diam/2+pin_diam,diam/2+pin_diam,h*3], center=true);
}

module push() {
 difference () {
   union() {
     // base
     difference() {
        cylinder(r1=diam*1.2, r2=diam*1.1, h=diam*0.25);
        // space for pin
        translate([0,0,-e]) cylinder(r=pin_diam+space-0.1, h=h+e);
     }
     // shaft
     difference() {
        cylinder(r=diam/2, h=h, $fn=100);
        cylinder(r=pin_diam+space, h=h);
        cutout();
     }
     // ball
     difference() {
	  translate([0,0,h/2])
       sphere(d=diam+pin_diam, $fn=100);
      // space for pin
      cylinder(r=pin_diam+space, h=h);
      cutout();
     }
     // hat
     difference() {
      translate([0, 0, h])
       cylinder(h = h/3, r1 = diam/2, r2 = 0);
      // sides
       cutout();
     }
   }
 }
}

module pin() {
 difference () {
  translate([pin_xy,pin_xy,0])
    union() {
     cylinder(r1=diam*0.7, r2=diam*0.6, h=diam*0.24); // base
	 cylinder(r=pin_diam, h=h*0.9, $fn=100); //rod
	 translate([0,0,h*0.9])
      sphere(r=pin_diam+0.2, $fn=100); // retainer
    }
 }
}

push();
pin();

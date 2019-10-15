// Licence: Creative Commons, Attribution
// Parametrized button battery holder

// Thingiverse user by bmcage
// Same idea as http://www.thingiverse.com/thing:21041
// from http://www.thingiverse.com/thing:394954

//number of slots to hold battery
nr = 4;  // [2:30]
//what button battery should this hold
battery = "CR2032";  //[CR2032, AG13, custom]
battery = "custom";  //[CR2032, AG13, custom]
//if custom battery, what is radius ?
custom_radius = 10;
//if custom battery, what is width ?
custom_width = 3.1;
//width of the divider, hint: take 2*nozzle diameter of your printer
sizedivider = 0.8;
sizedivider = 1.0; // for 0.5mm nozzle



// low-profile, shorter height than coin battery
module short_divider(radius) {
  translate([radius, 0,radius])
  rotate([-90,0,0]) { // vertical on Z
      intersection() {
      translate([0,5,0])
          cylinder(r=radius, h=sizedivider,$fn=50); //disc
      //translate([0,0,-0.02])
      translate([-radius, -radius,0])
          cube([2*radius,2*radius,radius]);
        //cylinder(r=radius-3, h=sizedivider +0.04,$fn=10); // cut hole
    }
  translate([-radius,0,0]) cube([2*radius,radius,sizedivider]);  // bottom divider/wall
  }
}

// full height of coin battery
module divider(radius) {
  translate([radius, 0,radius])
  rotate([-90,0,0]) { // vertical on Z
    difference() {
      cylinder(r=radius, h=sizedivider,$fn=50); //disc
      translate([0,0,-0.02])
        cylinder(r=radius-3, h=sizedivider +0.04); // cut hole
    }
  translate([-radius,0,0]) cube([2*radius,radius,sizedivider]);  // bottom divider/wall
  }
}

module holder(radius, width) {
  length = nr*(sizedivider+width) + sizedivider;
  //rotate([0,0,45])
  union() {
          for (i=[0:nr]) {
            translate([0,i*(sizedivider+width),0])
              // TODO: select a divider style...
              short_divider(radius);
              //divider(radius);
          }
      cube([2*radius, length, sizedivider]); // bottom
      translate([-sizedivider+0.01,0,0]) cube([sizedivider, length, radius]); // side
      translate([2*radius-0.01,0,0]) cube([sizedivider, length, radius]); // side
  }
}


if (battery == "CR2032") {
//    holder(10,3);
    holder(10,3.1);
}
if (battery == "AG13") {
    holder(6,6.3);
}
if (battery == "custom") {
    holder(custom_radius,custom_width);
} 
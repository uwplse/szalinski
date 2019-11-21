// Licence: Creative Commons, Attribution
// Parametrized button battery holder

// Thingiverse user by bmcage
// Same idea as http://www.thingiverse.com/thing:21041


//number of slots to hold battery
nr = 10;  // [5:25]
//what button battery should this hold
battery = "CR2032";  //[CR2032, AG13, custom]
//if custom battery, what is radius ?
custom_radius = 10; // [5:30]
//if custom battery, what is width ?
custom_width = 3; // [1:10]
//width of the divider, hint: take 2*nozzle diameter of your printer
sizedivider = 0.8;

module divider(radius) {
  translate([radius, 0,radius])
  rotate([-90,0,0]) {
    difference() {
      cylinder(r=radius, h=sizedivider,$fn=50);
      translate([0,0,-0.01]) cylinder(r=radius-3, h=sizedivider +0.02);
    }  
  translate([-radius,0,0]) cube([2*radius,radius,sizedivider]); 
  }
}

module holder(radius, width) {
  length = nr*(sizedivider+width) + sizedivider;
  rotate([0S,0,45])
  union() {
  for (i=[0:nr]) {
    translate([0,i*(sizedivider+width),0]) divider(radius);
  }
  cube([2*radius, length, sizedivider]);
  translate([-sizedivider+0.01,0,0]) cube([sizedivider, length, radius]);
  translate([2*radius-0.01,0,0]) cube([sizedivider, length, radius]);
  }
}


if (battery == "CR2032") {
    holder(10,3);
}
if (battery == "AG13") {
    holder(6,6.3);
}
if (battery == "custom") {
    holder(custom_radius,custom_width);
} 
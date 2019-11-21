// Licence: Creative Commons, Attribution
// Parametrized button battery clip holder

// Thingiverse user by bmcage
// Same idea as http://www.thingiverse.com/thing:48606 but 
// parametric


//what button battery should this hold
battery = "CR2032";  //[CR2032, AG13, custom]
//if custom battery, what is radius ?
custom_radius = 10; // [5:30]
//if custom battery, what is width ?
custom_width = 3; // [1:10]
//width of edges, hint: take 2*nozzle diameter of your printer
edge = 0.8;

module divider(radius,width) {
  difference() {
    cylinder(r=radius+edge, h=edge+0.8,$fn=50);
    translate([-radius/2,-2,0]) cylinder(r=0.4, h=edge+10,center=true,$fn=50);
    translate([radius/2,-2,0]) cylinder(r=0.4, h=edge+10,center=true,$fn=50);
    translate([-radius/2, -2-0.8/2,edge]) cube([radius,0.8,2*0.8]);
    }  
  difference() {
    cylinder(r=radius+edge, h=edge+0.8+width,$fn=50);
    cylinder(r=radius, h=4*(edge+0.8+width),$fn=50, center=true);
    translate([0,2*radius+radius/2,width+edge+0.8]) cube([4*radius, 4*radius,2*width], center = true);
    }
  
}

module holder(radius, width) {
  union() {
    difference() {
      translate([-radius/2,-radius-4,0]) cube([radius, 4, width+edge+0.8]);
      translate([radius/4, -radius-edge-1.5,0])cylinder(r=0.4, h=2*(width+edge+10),center=true,$fn=50);
      translate([-radius/4, -radius-edge-1.5,0])cylinder(r=0.4, h=2*(width+edge+10),center=true,$fn=50);
      }
    divider(radius,width);
    //now a ring to hang it to something
    difference() {
      translate([0,radius+0.4+2*edge,0]) cylinder(r=0.4+2*edge, h=edge+0.8,$fn=50);
      translate([0,radius+0.4+2*edge,-0.8]) cylinder(r=0.4, h=2*(edge+0.8),$fn=50);
    }
  }
}


if (battery == "CR2032") {
    holder(10, 3);
}
if (battery == "AG13") {
    holder(6, 6.3);
}
if (battery == "custom") {
    holder(custom_radius,custom_width);
} 
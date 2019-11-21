
connectors=3;
wall=3;
wiggle=0.4;
usb_connector_width=13.9 + wiggle;
usb_connector_height=14.3 + wiggle;
usb_connector_thickness=7.1 + wiggle;

module round_corners(depth=2, facets=50) {
  minkowski() {
    difference() {
      union() { for (i = [0 : $children-1]) children(i); }
      minkowski(){
        difference() {
          minkowski() {
            union() { for (i = [0 : $children-1]) children(i); }
            cube([depth*2,depth*2,depth*2], center=true);
          }
          for (i = [0 : $children-1]) children(i);
        }
        cube([depth*2,depth*2,depth*2], center=true);
      }
    }
    sphere(r=depth, $fn=facets);
  }
}

module powerblock() {
  difference() {
    round_corners() {
      cube([usb_connector_width + wall * 2,
	    usb_connector_height,
	    usb_connector_thickness * connectors + wall * connectors + wall]);
    }

    for (x = [0:connectors-1]) {
      translate([wall,-0.5,wall + (wall + usb_connector_thickness) * x])
	cube([usb_connector_width,
	      usb_connector_height + 1,
	      usb_connector_thickness]);
    }
  }
}

module backing() {
  difference() {
    round_corners() {
      cube([usb_connector_width + wall * 4,
	    usb_connector_height + wall,
	    usb_connector_thickness * connectors + wall * connectors + wall * 3]);
    }
    translate([wall-wiggle/2,-wall*2,wall-wiggle/2])
    round_corners() {
      cube([usb_connector_width + wall * 2 + wiggle,
	    usb_connector_height + wall + wiggle,
	    usb_connector_thickness * connectors + wall * connectors + wall + wiggle]);
    }
    translate([wall*2,-wall,wall])
    round_corners() {
      cube([usb_connector_width,
	    usb_connector_height + wall,
	    usb_connector_thickness * connectors + wall * connectors]);
    }
    translate([(usb_connector_width + wall * 4)/2-2.5,-wall,-5])
    round_corners() {
      cube([5,
             usb_connector_height + wall,
	     wall + 10]);
    }
  }
}

rotate([-90,0,0]) {
  translate([-10,0,0]) powerblock();
  translate([20,0,0]) backing();
}

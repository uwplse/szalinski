$fn=50*1; //For reasonable curves, but can be done on a pi
//$fn=300*1; //For really nice curves, but lots of resources

// What size fan do you want to use?
fan_size=40; // [30, 40]

// What size screw hole do you want?  2.6 will work for M3, 3.5 is good for a through hole.
fan_screw_size=2.6;

// Use these for development and debugging
//main_body();
//outside_body();
//inside_body();
//blow_ring();
//hotend_mount();
//fan_mount();

full_shroud();

module full_shroud() {
  union() {
    // main body trimmed for ring
    difference() {
      main_body();
      translate([0,16,0]) inside_ring();
    }
//    // blow ring trimmed for body
//    difference() {
//      translate([0,16,0]) blow_ring();
//      inside_body();
//    }
    if (fan_size <= 35) {
      translate([0,-4,50])
	rotate([45,0,0])
	translate([0,-fan_size/2,0])
	fan_mount();
    } else {
      translate([0,-0,50])
	rotate([45,0,0])
	translate([0,-(35/2)-1,-0])
	fan_mount();
    }
    translate([-35/2,-1,50]) rotate([-90,0,0]) hotend_mount();
  }
}

// variables for the hotend mount
pwidth = 35;  // plate width
pheight = 33; // plate height
rgap = 29.9;  // rail gap
rwidth = 2;   // rail width
module hotend_rail() {
  hull() {
    cube([rwidth,pheight-3,rwidth]);
    translate([0,pheight,0]) cube([rwidth,0.1,0.1]);
  }
}

module hotend_mount()
{
  difference() {
    union() {
      cube([pwidth,pheight,1],center=false);
      translate([(pwidth-rgap-(rwidth*2))/2,0,1]) {
	hotend_rail();
	translate([rgap+rwidth,0,0]) hotend_rail();
      }
    }
    translate([(pwidth/2),(pheight/2),0]) cylinder(h=3,d=29,center=true);
  }

  //clips
  translate([0,(pheight/2)-2,0]) clip_mount();
  translate([pwidth,(pheight/2)-2,0]) scale([-1,1,1]) clip_mount();

  // middle guide used for a visual reference for lining up clips
  //%translate([0,pheight/2-1.5,0]) cube([pwidth,3,1]);
}

module clip_mount() {
  translate([-2,0.5,0]) {
    // clip attachment point
    hull() {
      translate([-1,0,0]) cube([4,3,0.1],center=false);
      translate([-1,1.5,-4]) rotate([0,90,0]) cylinder(h=4,d=3,center=false);
    }
    // retaining lip
    translate([-1,1.5,-5])
      rotate([0,90,0]) cylinder(h=1.1,d=3,center=false);
    // wedge to avoid needing supports
    hull() {
      translate([2.25,4,-2]) cube([0.1,3,2]);
      translate([-1,2,-5.5]) cube([1,1,5.5]);
    }
  }
}

// fan size	hole spacing (fan size * 0.8)
// 30mm		24mm
// 40mm		32mm
// 50mm		40mm
module fan_mount()
{
  if (fan_size <= 35) {
    difference() {
      // mount plate
      translate([0,0,-4])
	hull() {
	  for (x=[-(fan_size*0.8)/2:fan_size*0.8:(fan_size*0.8)/2]) {
	    for (y=[-(fan_size*0.8)/2:fan_size*0.8:(fan_size*0.8)/2]) {
	      translate([x,y,0]) cylinder(h=4,d=fan_size*0.2);
	    }
	  }
	}
      // fan and screw holes
      fan_holes();
    }
  } else {
    phi=(1+sqrt(5))/2; //golden ratio
    off=fan_size-35;
    yoff=off*(phi-0.5);
    zoff=off*phi;
    rotate([0,0,180])
      difference() {
	difference() {
	  hull() {
	    cylinder(h=1,d=35);
	    translate([-35/2,-35/2-1,0]) cube([35,1,1]);
	    translate([0,-yoff,zoff]) {
	      hull() {
		for (x=[-(fan_size*0.8)/2:fan_size*0.8:(fan_size*0.8)/2]) {
		  for (y=[-(fan_size*0.8)/2:fan_size*0.8:(fan_size*0.8)/2]) {
		    translate([x,y,-1]) cylinder(h=1,d=fan_size*0.2);
		  }
		}
	      }
	    }
	  }
	  union() {
	    hull() {
	      translate([0,0,-0.1])
		cylinder(h=0.1,d=33);
	      translate([-33/2,-33/2-1,-0.1]) cube([33,1,0.1]);
	      translate([0,-yoff,zoff])
		cylinder(h=1.1,d=fan_size-2);
	    }
	    spacing=fan_size*0.8;
	    translate([0,-yoff,zoff])
	      for (x=[-(spacing/2):spacing:(spacing/2)]) {
		for (y=[-(spacing/2):spacing:(spacing/2)]) {
		  translate([x,y,-yoff+phi])
		    cylinder(h=zoff,d=2.9,center=true);
		}
	      }
	  }
	}
      }

  }
}

module fan_holes()
{
  spacing = fan_size * 0.8;
  for (x=[-(spacing/2):spacing:(spacing/2)]) // Final number/middle number = number across
  {
    for (y=[-(spacing/2):spacing:(spacing/2)]) // Final number/middle number = number deep
    {
      translate([x,y,0])
      {
	cylinder(h=10,d=fan_screw_size,center=true);
      }
    }
  }
  //2mm less than fan size for air hole
  cylinder(h=10,d=(fan_size - 2),center=true);
}

// only used for trimming bottom of body
module inside_ring() {
  rotate_extrude(convexity=10) { 
    translate([(25/2)+5.5,0,0]) {
      hull() { 
	circle(d=4);
	translate([1,0,0]) circle(d=4);
      } 
    }
  } 
}

//module blow_ring() {
//  rotate([0,0,55.75+90]) {
//    difference() {
//      union() {
//	rotate_extrude(angle=248.5,convexity= 10) {
//	  translate([25/2,0,0]) {
//	    difference() {
//	      // outside shape
//	      hull() {
//		translate([0,-3,0]) circle(d=0.1);
//		translate([6,0,0])  circle(d=6);
//		translate([7,0,0])  circle(d=6);
//	      }
//	      // inside shape
//	      translate([5.5,0,0]) {
//		hull() {
//		  circle(d=4);
//		  translate([1,0,0]) circle(d=4);
//		}
//	      }
//	    }
//	  }
//	}
//	rotate([0,0,0.01])translate([25/2,0,0]) end_cap();
//	rotate([0,0,248.5-0.01])translate([25/2,0,0])scale([1,-1,1]) end_cap();
//      }
//      // blow holes
//      union() {
//	for (h=[0:360/16:248.5]) { // hole locations
//	  rotate([0,0,h]) {
//	    translate([12,0,-3.5])
//	      rotate([0,62,0])
//	      cylinder(h=12,d=2.5,center=true);
//	  }
//	}
//      }
//    }
//  }
//}

module end_cap() {
  difference() {
    hull() {
      translate([0,0,-3]) sphere(d=0.1);
      translate([6,0,0])  sphere(d=6);
      translate([7,0,0])  sphere(d=6);
    }
    union() {
      translate([5.5,0,0]) {
	hull() {
	  sphere(d=4);
	  translate([1,0,0]) sphere(d=4);
	}
      }
      translate([0,0,-10]) cube([20,20,20]);
    }
  }
}

module main_body() {
  difference() {
    // Main body
    difference() {
      outside_body();
      inside_body();
    }
    // holes needed for fan and mount
    union() {
      // cutout for fan
      if (fan_size <= 35) {
	translate([-(fan_size-1)/2,-3.5,49.5]) {
	  rotate([-135,0,0])
	    translate([(fan_size-1)/2,(fan_size-1)/2,0])
	    hull() {
	      for (x=[-(fan_size*0.8-1)/2:fan_size*0.8-1:(fan_size*0.8-1)/2]) {
		for (y=[-(fan_size*0.8-1)/2:fan_size*0.8-1:(fan_size*0.8-1)/2]) {
		  translate([x,y,-1.5]) cylinder(h=5,d=fan_size*0.2);
		}
	      }
	    }
	}
      }
      // cutout for mount
      translate([0,-0.5,33.5])
	cube([34,2,32],center=true);
    }
  } // end difference for holes needed
}

module outside_body() {
  hull() {
    // bottom
//    hull() {
//      translate([3.5,-3,0])  cylinder(h=1,d=6,center=true);
//      translate([-3.5,-3,0]) cylinder(h=1,d=6,center=true);
//    }
    union() {
      // hotend
      translate([0,-.05,32.5]) cube([35,.1,35],center=true);
      // fan
      if (fan_size <= 35) {
	translate([-(fan_size+0)/2,-0.47,46.47]) {
	  rotate([-135,0,0])
	    translate([(fan_size+0)/2,fan_size/2,0])
	    hull() {
	      for (x=[-(fan_size*0.8)/2:fan_size*0.8:(fan_size*0.8)/2]) {
		for (y=[-(fan_size*0.8)/2:fan_size*0.8:(fan_size*0.8)/2]) {
		  translate([x,y,-5]) cylinder(h=5,d=fan_size*0.2);
		}
	      }
	    }
	}
      } else {
	translate([0,-0,50])
	  rotate([45,0,0])
	  translate([0,-(35/2)-1,0])
	  hull() {
	    cylinder(h=0.1,d=35);
	    translate([-35/2,35/2,0]) cube([35,1,0.1]);
	  }
      }
    }
  }
}

// use for trimming inside of main body
module inside_body()
{
  hull() {
    // bottom
//    hull() {
//      translate([3.5,-3,0])  cylinder(h=1.1,d=4,center=true);
//      translate([-3.5,-3,0]) cylinder(h=1.1,d=4,center=true);
//    }
    union() {
      // hotend
      translate([-33/2,-1.1,50-33-1]) cube([33,.1,31],center=false);
      // fan
      if (fan_size <= 35) {
	translate([-(fan_size-1)/2,-0.8,47.4]) {
	  rotate([-135,0,0])
	    translate([(fan_size-1)/2,fan_size/2,0])
	    hull() {
	      for (x=[-(fan_size*0.8-1)/2:fan_size*0.8-1:(fan_size*0.8-1)/2]) {
		for (y=[-(fan_size*0.8)/2:fan_size*0.8:(fan_size*0.8)/2]) {
		  translate([x,y,-0.1]) cylinder(h=0.1,d=fan_size*0.2);
		}
	      }
	    }
	}
      } else {
	translate([0,-0,50])
	  rotate([45,0,0])
	  translate([0,-(35/2)-1,0])
	  hull() {
	    cylinder(h=1,d=33);
	    translate([-33/2,33/2,0]) cube([33,1,1]);
	  }
      }
    } 
  } // end inside hull
}

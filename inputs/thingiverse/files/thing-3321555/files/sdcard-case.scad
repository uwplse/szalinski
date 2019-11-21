
// How many columns of SD Card spots
columns = 6;

// How many rows of SD Card spots
rows = 2;


module case (cols=5, rows=2, zlevel=true) {
     width=24;			/* sdcard width */
     height=32;			/* sdcard height */
     depth=2.1;			/* sdcard depth */
     pocket_depth=depth+2;
     padding=5;
     thumb_radius=12;
     
     module sdcard() {
	  distance=sqrt((height/2)*(height/2) + (width/2)*(width/2)) - 3;
	  corner=sqrt(32) + 0.1;
	  scale([-1,1,1]) {
	       translate([-width/2, -height/2, -depth/2]) {
		    difference() {
			 cube([width, height, depth]);
			 translate([width, height, -0.2]) {
			 rotate([0, 0, 45]) {
			      translate([-corner/2, -corner/2, 0]) {
				   cube([corner, corner, depth + 0.4]);
			      }
			 }
			 }
		    }
	       }
	  }
     }
     
     module pocket(zlevel=true,center=true) {
	  module thumb(r=12) {
	       difference() {
		    translate([0,0,r+2]) {
			 sphere(r=r);
		    }
		    translate([-r, -3.9, 0]) {
			 cube([r*2,r*2,r*4]);
		    }
	       }
	  }

	  difference() {
	       translate([center ? 0 : width/2 + padding, center ? 0 : height/2 + padding, zlevel ? pocket_depth : pocket_depth/2]) {
		    difference() {
			 translate([0, 0, -pocket_depth/2])
			      cube([width + 2 * padding, height + 2 * padding, pocket_depth], center=true);
			 rotate([0, 180, 0])
			      sdcard();
		    }
	       }
	       translate([0, -thumb_radius+0.1, zlevel ? 0 : -pocket_depth/2 + 0.1]) {
		    thumb(thumb_radius);
	       }
	  }
     }

     translate([-cols/2*(width+padding)+(width+padding)/2, rows/2*(height+padding)-height/2, zlevel ? 0 : -pocket_depth/2]) {
	  for (s=[0:rows-1]) {
	       translate([0, -(height+2*padding)*s, 0]) {
		    for (x=[0:cols-1]) {
			 translate([x*(width+padding), 0, 0]) {
			      rotate([0, 0, s*180]) {
				   pocket();
			      }
			 }
		    }
	       }
	  }
     }
}

case(columns, rows);

// Cap Paramteres
th=3;     //cap thickness
id=56.5;  // inside diameter (wheel fitting) 
od=66;   // cap diameter (Size of the top of cap)
slheight=15;   //height of inside clips

// Logo centre offsets
logoName = "Toyota-Emblem-Fixed.STL"; // File name of logo
logoXoffset = 30; // Use to Centre in the X axis (Start with 0)
logoYoffset = -19; // Use to Centre in the Y axis (Start with 0)
logoZoffset = 0; // Centre in Z axis (0 usually works)

// Logo scaling
logoXscale = 0.6; // Change Size to make logo fill cap
logoZscale = 1; // Thickness of the raised logo
logoYscale = logoXscale;

NoSides = 200; // smoothness of the circle (bigger is slower)

$fn=NoSides;

module pipe(he,rout,thick,cent=true,sides=50,quarters="1234",qarray=[1,1,1,1]){ 
	difference(){
		cylinder(h=he,r=rout,center=cent,$fn=sides);
		cylinder(h=he,r=rout-thick,center=cent,$fn=sides);
		// quarter 1 = top left then clockwise
		if (quarters == "23") {
			echo(quarters);
			translate([-rout*2,-rout,-thick/2]) rotate([0,0,0]) cube([rout*2,rout*2,thick]);
		}
		if (qarray[1-1] == 0 ){
			translate([-rout,0,-thick]) rotate([0,0,0]) cube([rout,rout,thick*2]);
		}
		if (qarray[2-1] == 0 ){
			translate([0,0,-thick]) rotate([0,0,0]) cube([rout,rout,thick*2]);
		}
		if (qarray[3-1] == 0 ){
			translate([0,-rout,-thick]) rotate([0,0,0]) cube([rout,rout,thick*2]);
		}
		if (qarray[4-1] == 0 ){
			translate([-rout,-rout,-thick]) rotate([0,0,0]) cube([rout,rout,thick*2]);
		}
	}
}

module clips(idc,he=4){ 
		intersection(){
		union(){
		translate([0,0,-3])rotate(45,0,0)cube([140,12,he]);
		translate([0,0,-3])rotate(135,0,0)cube([140,12,he]);
		translate([0,0,-3])rotate(225,0,0)cube([140,12,he]);
		translate([0,0,-3])rotate(315,0,0)cube([140,12,he]);
		} 
		rotate([0,180,0])
		difference(){ 
			translate([0,0,0])cylinder(h=he,r1=idc+1.25,r2=idc+1.25);
			difference(){ 
				translate([0,0,0])cylinder(h=he,r1=idc+1.25,r2=idc+1.25);
				translate([0,0,0])cylinder(h=he,r1=idc-0.75,r2=idc+1.25);
				}
			cylinder(h=he,r=idc-2);
			}
		}
	}



module wheelcap(){
	difference(){
		union(){
			//cylinder(h=th,r=od/2,$fn=NoSides);
            translate([0,0,th]) rotate([0,180,0]) fil_polar_o(od/2, th, 1, angle=90);
            
			translate([0,0,(slheight/2)+th]) rotate([0,0,0]) pipe(he=slheight,rout=id/2,thick=2);
            	logo();

			}
		for ( i = [1:8] ) {  
			translate([0,0,th])rotate(32+i*360/8,0,0)cube([140,4,slheight]);
			}
		}
	}


wheelcap();
translate([0,0,slheight+th-1]) rotate([0,0,0]) clips(idc=id/2+1);


module logo(){
      translate([logoXoffset, logoYoffset, logoZoffset]) 
        rotate([0,180,0])
          scale([logoXscale, logoYscale, logoZscale]) 
            import(logoName);  
	}



// Used to round top corner of disk
// I borrowed these functions from http://www.thingiverse.com/thing:38069
// by  mattschoenholz
    
// 2d primitive for outside fillets.
module fil_2d_o(r, angle=90) {
  intersection() {
    circle(r=r);
    polygon([
      [0, 0],
      [0, r],
      [r * tan(angle/2), r],
      [r * sin(angle), r * cos(angle)]
    ]);
  }
}


// 3d polar outside fillet.
module fil_polar_o(R, r, h, angle=90) {
  union(){
	  translate([0,0,h]) {
		rotate_extrude(convexity=10) {
		    translate([R-r, 0, 0]) {
		      fil_2d_o(r, angle);
		    }
		  }
	      cylinder(r=R-r+0.1, h=r);
      }
      cylinder(r=R, h=h);
  }
}


/* [Global] */
//Part to print
part = "all"; //[all:All parts,t:Top,m:Middle,b:Bottom]

//1 - for this top; 0 - for Gyrobot's top; 2 - Solid bottom 
ver=1; //[0:Girobot's top,1:Square top,2:Solid bottom]

/*[Main]*/
//hole for usb hub out
usb=0; //[0,1]

//hole for camera mode switch
sw=0; //[0,1]

/*[Advanced]*/
//middle part height
hgt = 24; //[10:50]

//bottom part height
bhgt = 6.25; //[2:20]

//top part height
thgt = 8; //[2:20]

//adapter nozle height
ahgt = 30; //[5:50]

/*[Hidden]*/
// print tension easer layer
l = 0.35; 

if (part == "all"){
	if (ver!=0){
		translate([60,0,0]) top();
	}else{
		translate([60,0,0]) import("Adapter.stl");
	}
	if(ver < 2){
		rotate([0,180,0]) translate([0,0,-hgt]) middle(ver,usb);
		translate([-60,0,0]) bottom(usb,sw);
	}else{
		translate([0,0,bhgt]) middle(ver,usb);
		translate([0,0,-0]) bottom(usb,sw);
	}
}else if (part == "t")
	top();
else if (part == "m")
	if(ver != 2)
		rotate([0,180,0]) translate([0,0,-hgt]) middle(ver,usb);
	else{
		translate([0,0,bhgt]) middle(ver,usb);
		translate([0,0,-0]) bottom(usb,sw);
	}
else if (part == "b")
	if(ver != 2)
		bottom(usb,sw);
	else{
		translate([0,0,bhgt]) middle(ver,usb);
		translate([0,0,-0]) bottom(usb,sw);
	}
else{
	if (ver==1){
		translate([0,0,2]) top();
		translate([0,0,-hgt]) middle(ver,usb);
	}else{
		translate([0,0,2]) import("Adapter.stl");
		translate([0,0,-hgt]) middle(ver,usb);
	}
	translate([0,0,-hgt-bhgt-2]) bottom(usb,sw);
}

module box(h, top, btm) {
		difference(){
			translate([-25,-25,0])
				minkowski() {
					cube([50,50,h-2]);
					cylinder(r=4, h=2, $fn=32);		
				}
			translate([-24,-24,-top+btm]) //inside square
				minkowski() {
					cube([48,48,h-2]);
					cylinder(r=3, h=2, $fn=32);		
				}
		}
}

module top(){
	
	union(){
		difference(){
			union(){
				box(thgt, 2, 0);
				translate([0,0,thgt])
					cylinder(r=1.25*25.4/2, h=ahgt, $fn=64);
				translate([-8,-7.5,0])
					cube([16,15,thgt]);
				for(i=[0,180]){
					rotate([0,0,i]){
						translate([-9,0,0])
							cylinder(r=2.5, h=thgt, $fn=32);
						translate([-9,-2.5,0])
							cube([5,5,thgt]);							
						translate([0,-7,0])
							cylinder(r=1, h=thgt, $fn=32);
					}
				}
			}
			translate([0,0,thgt])
				cylinder(r=1.25*25.4/2-2, h=ahgt+1, $fn=64);
			translate([-7,-6.5,-1])
				cube([14,13,thgt+3]);
			for(i=[0,180])
				rotate([0,0,i])
					translate([-9,0,-2])
						cylinder(r=0.75, h=thgt, $fn=32);
		}
		for(i=[0,180]){
			rotate([0,0,i]){
				translate([0,-7,0])
					cylinder(r=1, h=thgt, $fn=32);
			}

			rotate([0,0,i])
			translate([0,23.5,0]){
				difference(){
					union(){
						cylinder(r=2.5,h=thgt,$fn=16);
						translate([-2.5,0,0])
							cube([5,5,thgt]);
					}
					translate([0,0,-1])
						cylinder(r=1, h=thgt+2, $fn=16);
				}
			}
		}
	}		
}

module middle(ver=0,usb=1) {
	union(){
		difference(){
			union(){
				box(hgt, ver==0?2:0, 0);

				// translate([0,0,hgt])
				// 	cylinder(r=27-l,h=1,$fn=64);
			}
			translate([0,0,hgt-3])
			 	cylinder(r=27,h=6,$fn=64);
			// translate([-3, -30, hgt]) 
			// 	cube(size=[6, 60, 2]);
			if (usb==1)
			translate([26,-6.5,-1])
				cube([4,13,8.5/2+1]);
			translate([-10,-26,0]){
				rotate([90,0,0])
					cylinder(r=3.1, h=4, $fn=32);
				if (ver == 2)
				 translate([-4.6, -4, -1.75])
				 	cube([9.2, 4, 3.7]);
			}
		}
		for(i=[0,180]){
			rotate([0,0,i])
			translate([0,23.5,0]){
				difference(){
					union(){
						cylinder(r=2.5,h=hgt,$fn=16);
						translate([-2.5,0,0])
							cube([5,5,hgt]);
					}
					translate([0,0,-1])
						cylinder(r=1, h=hgt+2, $fn=16);
				}
			}
		}
	}//union
}

module bottom(usb=1,sw=1) {
	difference(){
		union(){
			box(bhgt, 0, 2);
			for(i=[0,180]){
				rotate([0,0,i])
				translate([0,23.5,0]){
						cylinder(r=2.5,h=bhgt,$fn=16);
						translate([-2.5,0,0])
							cube([5,5,bhgt]);
				}
			}
		}
		for(i=[0,180])
			rotate([0,0,i])
				translate([0,23.5,-1]){
					cylinder(r=1, h=bhgt+2, $fn=16);
					translate([0,0,0])
						cylinder(r=2, h=2, $fn=16);
				}
		if (usb==1)
		translate([26,-6.5,8.5/4])
			cube([4,13,8.5/2]);

		translate([-10,-26,bhgt]){
			rotate([90,0,0])
				cylinder(r=3.1, h=4, $fn=32);
			if (ver == 2)
				translate([-4.6, -4, -1.75])
			 		cube([9.2, 4, 3.7]);
		}
		if(sw==1)
		translate([-15, -5, -1])
			cylinder(r=2, h=bhgt+2, $fn=32);
	}	
}
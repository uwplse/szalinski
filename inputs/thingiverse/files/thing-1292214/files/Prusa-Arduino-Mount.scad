$fn=50;
pinheight=1.5;

pin(15.24,50.8);
pin(13.97,2.54);
pin(90.17,50.8);
pin(96.52,2.54);

//pin(15.24,2.54);
//pin(13.97,50.8);
//pin(90.17,2.54);
//pin(96.52,50.8);

difference(){
	translate([0,0,-pinheight*2]){
		minkowski(){
			cube([101.6,53.3,pinheight],false);
			cylinder(r=4,h=pinheight);		
		}
	}
	union(){
		minkowski(){
			translate([8,2.54+2.75+6,-pinheight*3])cube([101.6-14,42.9-12,pinheight*2]);
			cylinder(r=4,h=pinheight*2);	
		}
		minkowski(){
			translate([15.24+8,6,-pinheight*3])cube([69.43-6,53.3-20,pinheight*2]);
			cylinder(r=4,h=pinheight*2);	
		}
		minkowski(){
			translate([15.24+8,14,-pinheight*3])cube([69.43-10,53.3-20,pinheight*2]);
			cylinder(r=4,h=pinheight*2);	
		}
	}
}

translate([10,0,-pinheight*2])rotate([0,0,-90])clip();
translate([85,0,-pinheight*2])rotate([0,0,-90])clip();
translate([101.6+1,53.3-5,-pinheight*2])rotate([0,0,30])clip();

module pin(x,y){
	difference(){
		union(){
			translate([x,y,2.75])cylinder(h=6,d=5.5,center=true);
			translate([x,y,7])cylinder(h=3,d=3.25,center=true);
			translate([x,y,9])cylinder(h=1,r1=1.625,r2=1.75,center=true);
			translate([x,y,10.5])cylinder(h=2,r1=1.75,r2=1,center=true);
		}
		union(){
			translate([x,y,9])cube([0.75,7,10],center=true);
			translate([x,y+1.6,10.75])cube([7,0.75,10],center=true);
			translate([x,y-1.6,10.75])cube([7,0.75,10],center=true);
			
		}
	}
}

module clip(){
	difference(){
		union(){
			cube([27,10,pinheight*2]);
			translate([20,5,3])rotate([90,0,0])cylinder(h=10,d=8+pinheight*4,center=true);
			translate([0,5+pinheight,-8])rotate([90,-20,0])cube([20,10,pinheight*2]);
		}
		union(){
			translate([20,5,3])rotate([90,0,0])translate([0,0,0])cylinder(h=12,d=8,center=true);
			translate([-5,-2,-14])cube([35,14,14]);
		}
	}
}
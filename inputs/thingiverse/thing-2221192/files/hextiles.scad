// hex hole floor mat tiles for:
//   cat litter control (assemble a few together, put in front of litter box)
//   coasters (for cups/glasses)
//   soap holder?
//   anywhere else that a hollow bottomed tile is useful

height = 10;
thick = 4;
size = 100;
linkable = 1;
cornerRadius = 10;

function s(x) = x * size / 156;

module radiusMold(r=1,h=1,extra=s(1)) {
	difference() {
		translate([0,0,0]) cube([r+extra,r+extra,h]);
		translate([0,0,-1]) cylinder(r=r,h=h+2,$fn=50);
	}
}

module tile() {
	cr = (cornerRadius < size / 4 ? cornerRadius : size / 4);
	difference() {
		union() {
			difference() {
				union() {
					difference() {
						cube([size,size,height]);
						translate([s(3.5),s(3.5),-s(1)]) cube([s(149),s(149),height-thick+s(1)]);
					}
					for(x=[s(31):s(31.5):s(78)]) translate([x-s(1.25),0,0]) cube([s(2),size,height]);
					for(x=[s(94):s(31.5):s(131)]) translate([x-s(1.25),0,0]) cube([s(2),size,height]);
					for(y=[s(34):s(30):s(78)]) translate([0,y-s(1),0]) cube([size,s(3),height]);
					for(y=[s(91):s(30):s(131)]) translate([0,y-s(1),0]) cube([size,s(3),height]);
				}
				for(x=[s(6):s(9):s(155)]) for(y=[s(6):s(6):s(155)]) translate([x,y,-1]) cylinder(d=s(5),h=height+2,$fn=6);
				for(x=[s(6):s(9):s(149)]) for(y=[s(6):s(6):s(149)]) translate([x+s(4.5),y+s(3),-1]) cylinder(d=s(5),h=height+2,$fn=6);
			}
			if (cr > 0) {
				cr2 = cr + s(3);
				translate([cr2,cr2,0]) rotate([0,0,180]) radiusMold(r=cr,h=height);
				translate([size-cr2,cr2,0]) rotate([0,0,270]) radiusMold(r=cr,h=height);
				translate([cr2,size-cr2,0]) rotate([0,0,90]) radiusMold(r=cr,h=height);
				translate([size-cr2,size-cr2,0]) rotate([0,0,0]) radiusMold(r=cr,h=height);
			}	
		}
		if (cr > 0) {
			translate([cr,cr,-1]) rotate([0,0,180]) radiusMold(r=cr,h=height+2);
			translate([size-cr,cr,-1]) rotate([0,0,270]) radiusMold(r=cr,h=height+2);
			translate([cr,size-cr,-1]) rotate([0,0,90]) radiusMold(r=cr,h=height+2);
			translate([size-cr,size-cr,-1]) rotate([0,0,0]) radiusMold(r=cr,h=height+2);
		}
		if (linkable) {
			for(x=[s(15.6):s(156/5):s(141)]) translate([x-s(2),s(-1),-s(1)]) cube([s(4),size/6+s(2),height-thick]);
			for(y=[s(15.6):s(156/5):s(141)]) translate([s(-1),y-s(2),-s(1)]) cube([size/6+s(2),s(4),height-thick]);
			for(x=[s(15.6):s(156/5):s(141)]) translate([x-s(2),size-size/6-s(1),-s(1)]) cube([s(4),size/6+s(2),height-thick]);
			for(y=[s(15.6):s(156/5):s(141)]) translate([size-size/6-s(1),y-s(2),-s(1)]) cube([size/6+s(2),s(4),height-thick]);
		}
	}
}


translate([-size/2,size/2,height]) rotate([180,0,0]) tile();


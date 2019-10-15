cl=0.04;
$fs=0.05;

//board is 57mmx41mm

blength=57;
bwidth=41;
wall=1.7; //wall thickness
bottom=4; // bottom thickness
top = 2; // top thickness
height=9;

usbwidth=9;
usbheight=4;
usbplugwidth=11;
usbplugheight=8;
usbxoff=15.5;
footheight=3.5;
pcbheight=2;
pcbdist=2.5;

footsize=7;
holeDist=3.5;

headerXOff=3.5;
headerYOff=19.5;
headerWidth=6;
headerLength=27;

buttonYOff=1;
buttonXOff=26;
buttonSize=8.5;

jumperXOff=8.5;
jumperYOff=2;
jumperWidth=4;
jumperLength=7;

radius=3;
nutsize=7;

module roundBox(x, y, z, radius=2){
	hull(){
		translate([radius,radius,0])cylinder(r=radius,h=z);
		translate([x-radius,radius,0])cylinder(r=radius,h=z);
		translate([x-radius,y-radius,0])cylinder(r=radius,h=z);
		translate([radius,y-radius,0])cylinder(r=radius,h=z);
	}
}

module hexHole(height){
	union(){
		translate([0,0,-cl/2]) cylinder(d=nutsize, h=2.6+cl/2, $fn=6);
		translate([0,0,-cl/2]) cylinder(d=4.5, h=height);
	}
}

union(){
	difference(){
		union(){
			difference(){
				roundBox(bwidth+2*wall, blength+2*wall, top+footheight+pcbheight+pcbdist+bottom, radius);
				translate([wall,wall, top])roundBox(bwidth, blength, footheight+pcbheight+pcbdist+cl, radius-wall+cl/2);
				
				// lid cut
				// lidCut()
					
				translate([wall, wall, top+footheight+pcbheight+pcbdist+cl/2]) roundBox(bwidth, blength, bottom+cl, radius-wall);
				
				// headers
				translate([wall+headerXOff, wall+headerYOff, -cl/2]) roundBox(headerWidth, headerLength, top+cl, 1);
				translate([wall+bwidth-headerXOff-headerWidth, wall+headerYOff, -cl/2]) roundBox(headerWidth, headerLength, top+cl, 1);
				// button
				translate([wall+buttonXOff, wall+buttonYOff, -cl/2]) roundBox(buttonSize, buttonSize, top+cl, 1);
				
				// jumper
				translate([wall+jumperXOff, wall+blength-jumperYOff-jumperLength, -cl/2]) roundBox(jumperWidth, jumperLength, top+cl, 1);
			}
			
			translate([wall, wall, top]) cube([footsize, footsize, footheight]);
			translate([bwidth+wall-footsize,blength+wall-footsize,top]) cube([footsize, footsize, footheight]);
			translate([bwidth+wall-footsize+0.5,wall,top]) cube([footsize-0.5, footsize, footheight]);
			translate([wall,blength+wall-footsize,top]) cube([footsize, footsize, footheight]);
		}
		
		translate([wall+holeDist, wall+holeDist, -cl/2]) cylinder(d=4,h=top+footsize+cl);
		translate([bwidth+wall-holeDist,blength+wall-holeDist, -cl/2]) cylinder(d=4,h=top+footsize+cl);
		translate([bwidth+wall-holeDist,wall+holeDist, -cl/2]) cylinder(d=4,h=top+footsize+cl);
		translate([wall+holeDist,blength+wall-holeDist, -cl/2]) cylinder(d=4,h=top+footsize+cl);
		
		translate([wall+holeDist, wall+holeDist, -cl/2]) cylinder(d=6,h=3+cl/2);
		translate([bwidth+wall-holeDist,blength+wall-holeDist, -cl/2]) cylinder(d=6,h=3+cl/2);
		translate([bwidth+wall-holeDist,wall+holeDist, -cl/2]) cylinder(d=6,h=3+cl/2);
		translate([wall+holeDist,blength+wall-holeDist, -cl/2]) cylinder(d=6,h=3+cl/2);
		
		translate([usbxoff, -cl, top+footheight-usbheight+0.5]) cube([usbwidth, wall+cl*2, usbheight+0.5]);
		*translate([usbxoff-(usbplugwidth-usbwidth)/2, -cl/2, top+footheight-(usbplugheight-usbheight)/2-usbheight]) cube([usbplugwidth, 0.75+cl/2, usbplugheight]);
	}
}

module lidCut(){
	translate([wall/2,wall/2, top+footheight+pcbheight+pcbdist]) roundBox(bwidth+wall, blength+1.5*wall, bottom/2, 1);
	translate([wall, wall, top+footheight+pcbheight+pcbdist+bottom/2-cl/2]) roundBox(bwidth, blength+wall, bottom/2+cl, 1);
	translate([wall, wall, top+footheight+pcbheight]) cube([3, blength, pcbdist]);
	translate([bwidth+wall-3, wall, top+footheight+pcbheight]) cube([3, blength, pcbdist+cl/2]);	
	translate([wall, wall+blength-cl/2, top+footheight+pcbheight]) cube([bwidth, wall+cl, pcbdist+cl/2]);
}

module lid(){
	translate([wall/2+0.25,wall/2+0.5, top+footheight+pcbheight+pcbdist]) roundBox(bwidth-0.5+wall, blength-0.5+1.5*wall, bottom/2-0.4, 1-0.25);
	translate([wall+0.25, wall+0.25, top+footheight+pcbheight+pcbdist+bottom/2-cl/2-0.4]) roundBox(bwidth-0.5, blength+wall-0.25, bottom/2+cl+0.4, 1-0.25);
	translate([wall+0.25, wall+0.25, top+footheight+pcbheight]) cube([3, blength-0.25, pcbdist]);
	translate([bwidth+wall-3-0.25, wall+0.25, top+footheight+pcbheight]) cube([3, blength-0.25, pcbdist+cl/2]);
	translate([wall+0.25, wall+blength-cl/2, top+footheight+pcbheight]) cube([bwidth-0.5, wall+cl, pcbdist+cl/2]);
}


module screwLid(){
	width = bwidth-0.5;
	length = blength-0.5;
	fsize = footsize - 0.5;
	holed = holeDist-0.25;
	difference(){
		union(){
			translate([0,0,0]) roundBox(width, length, bottom+cl, radius-wall);
			translate([0, 0, bottom]) roundBox(fsize, fsize, pcbdist, radius-wall);
			translate([width-fsize, 0, bottom]) roundBox(fsize, fsize, pcbdist, radius-wall);
			translate([width-fsize, length-fsize, bottom]) roundBox(fsize, fsize, pcbdist, radius-wall);
			translate([0, length-fsize, bottom])  roundBox(fsize, fsize, pcbdist, radius-wall);
		}
			translate([holed, holed, 0]) hexHole(bottom+pcbdist+cl);
			translate([width-holed, holed, 0]) hexHole(bottom+pcbdist+cl);
			translate([width-holed, length-holed, 0]) hexHole(bottom+pcbdist+cl);
			translate([holed, length-holed, 0]) hexHole(bottom+pcbdist+cl);
			translate([-cl/2, -cl/2,-cl/2]) cube([5,3,2.6+cl/2]);
			translate([width+cl/2-5, -cl/2,-cl/2]) cube([5,3,2.6+cl/2]);
			translate([width+cl/2-5, length+cl/2-3,-cl/2]) cube([5,3,2.6+cl/2]);
			translate([-cl/2, length+cl/2-3,-cl/2]) cube([5,3,2.6+cl/2]);
	}
	

}

*translate([bwidth+wall-0.25, wall+0.25,bottom+pcbdist+top+pcbheight+footheight])rotate([0,180,0])screwLid();
translate([75,0,0]) screwLid();
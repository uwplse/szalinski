//////////////////////////////////////////////
// random parametric bee hive generator by Christoph Queck, chris@q3d.de, wwww.q3d.de
// Designed for Thingiverse "Light It Up Challenge" Summer 2015
// ReleaseCandidate V4.3 July 2015
// Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)
// http://creativecommons.org/licenses/by-sa/4.0/
// 
/////////////////////////////////////////////
//For testing different settings OpenSCAD preview function (F5) is recommended

// - Part Selection here:
whichpart=16;//[1:Back Plate,2:Front Plate,3:Lid Back,4:Lid Front,5:Preview All Hive Parts,6:Electronics Box,7:Lid for Electronics Box,8:Preview Backpack & Hive,9:Single Dummy Cell,10:Solar and Battery Housing,11:Top Plate Solar and Battery Housing,12:Solar and Battery Bottom Lid,13:ball joint or mounting bracket,14:Preview Solar Battery Pack,15:Mounting Bracket,16:PREVIEW ALL THE THINGS(may take some time!)]


// Input for the random number generator, you may need to try different numbers until the resulting hive is all connected.
seed=43; 

// Amount of random cells rendered from 1=none to 10=all
varamount=7;//[1:10]

// cell diameter in mm
Cell_diameter=20;

durchmesser=Cell_diameter;

//Wall strength in mm
Wall_strength=2;

wand=Wall_strength; 

// Diameter of led hole in mm. 5.4 should work fine for 5mm leds, 3.4 for 3mm
LED_hole_diameter=5.4;

hole=LED_hole_diameter/2;

// Number of Cells in X 
lengthx=8;

// Number of Cells in Y (only multiples of 2) 
lengthy=6;

// Height of the cells in mm
heightcell=12;

// Cell bottom strength in mm
cell_bottom_strength=2;//[1:8]

boden=cell_bottom_strength;



// Option to remove the LED holes
booleanledhole=1;//[1:LED holes,0:No LED holes] 

/* [Electronics box (optional)] */
// Nut for fastening electronics box, M5=8mm.
Nut_width=8;//[4:16]

nutw=Nut_width; 

// Length of the electronics board.
Electronics_length=35;

ardul=Electronics_length;

// Height of the electronics.
Electronics_height=15;

arduh=Electronics_height;


// Top mounting hole ?
ardumounthole=1;//[1:yes,0:no] 

// Radius of top mounting hole
ardumountholerad=2.7;

/* [SolarCell and Battery Pack (optional)] */

// Length of Solarcell in mm
solarlength=80;
// Width of Solarcell in mm
solarwidth=70;
// Height of batterypack in mm
battheight=15;

//Shape of the box
cell_pack_shape=0;//[0:Hexagonal,1:Rectangular]

//Hole for a switch?
switch=1;//[1:yes,0:no]

//Diameter of the hole for the switch 
Switch_dia=6.5;

rswitch=Switch_dia/2;

// Mounting plate width. (hole distance)
mphd=80;

// Ball joint connection to mount on top or just a bracket to mount elsewhere
mount=1;//[1:Balljoint,2:Bracket]

whichmount=mount;

// Mounting plate orientation.
mp_orientation=2;//[1:vertical,2:horizontal]

/* [Hidden] */

//Mounting Lugs? work in progress
lugs=0;//[0:no,1:on X,2:on Y]

/////////////////////////////////////////////////////////////////////////////////////
//Dont mess with the stuff below unless you know what youre doing.///////////////////
//Just kidding, mess around - I barely knew anything just 4 weeks ago.///////////////
/////////////////////////////////////////////////////////////////////////////////////
BalleR=10; // BallJoint Radius
radiusA=1.16*sqrt((solarlength/2)*(solarlength/2)+(solarwidth/2)*(solarwidth/2));
zuf1=rands(1,10,lengthx*lengthy,seed);

//Back//
if (whichpart==1){
	rotate([0,0,0])mirror([0,0,0])body(0,1);
}


//Front//
if (whichpart==2){  
	rotate([0,180,-90])mirror([0,0,1])body(0,0);
}

//LID Back//
if (whichpart==3){
	rotate([0,180,-90])mirror([0,0,1])body(1,0);
}

//LID Front//
if (whichpart==4){
	rotate([0,0,0])mirror([0,0,0])body(1,0);
}


//Preview all Hive parts(not for printing)//
if (whichpart==5){
	translate([0,0,(heightcell+wand*3)*2])mirror([0,0,1])union(){
		color("Aqua",1)translate([0,0,heightcell+wand*4])rotate([0,0,0])mirror([0,0,0])body(0,1);
		color("Yellow",1)translate([0,0,heightcell+wand*2])rotate([0,0,0])mirror([0,0,1])body(0,0);
		color("White",0.7)translate([0,0,(heightcell+wand*3)*2])rotate([0,0,0])mirror([0,0,1])body(1,0);
		color("Lavender",0.7)translate([0,0,-(wand)])rotate([0,0,0])mirror([0,0,0])body(1,0);
	}
	translate([-durchmesser*2,-durchmesser*2,heightcell*6])linear_extrude(height=2)text("PREVIEW ONLY", font ="Liberation Sans:style=Bold");
}


//ElectronicsPack (optional)//
if (whichpart==6){
	rotate([0,-90,0])
	translate([((durchmesser+2)/2)*1,(durchmesser+2)*1*1.732051/2+(2)*(durchmesser+2)*1.732051*1,boden*2])ardu(ardumounthole);
}

//ElectronicsPackLID//
if (whichpart==7){
	rotate([0,0,-90])translate([-durchmesser,0,0])mirror([0,0,1])ardulid(durchmesser,1,1);
}


//preview all parts except sobat(may take a long time, not for printing)//
if (whichpart==8){
	translate([0,0,(heightcell+wand*3)*2])mirror([0,0,1])union(){
		color("Aqua",1)translate([0,0,heightcell+wand*4])rotate([0,0,0])mirror([0,0,0])body(0,1);
		color("Yellow",1)translate([0,0,heightcell+wand*2])rotate([0,0,0])mirror([0,0,1])body(0,0);
		color("White",0.7)translate([0,0,(heightcell+wand*3)*2])rotate([0,0,0])mirror([0,0,1])body(1,0);
		color("Lavender",0.7)translate([0,0,-(wand)])rotate([0,0,0])mirror([0,0,0])body(1,0);
		
	}
	color("Aquamarine",1)translate([durchmesser/2+2+wand,durchmesser/2+wand+2,-heightcell*4])mirror([0,0,1])translate([0,2*(durchmesser+2)*1.732051,boden*2])rotate([0,0,180])ardulid(durchmesser,1,1);
	color("Lime",1)translate([durchmesser/2+2+wand,durchmesser/2+wand+2,0])mirror([0,0,1])translate([0,2*(durchmesser+2)*1.732051,boden*2])ardu(ardumounthole);
	color("PaleGreen",1)translate([durchmesser*3,durchmesser*3,heightcell*5])mirror([0,0,1])dummy(durchmesser);
	translate([-durchmesser*2,-durchmesser*2,heightcell*6])linear_extrude(height=2)text("PREVIEW ONLY", font ="Liberation Sans:style=Bold");
}

//DUMMY for closing down cells without the lid    
if (whichpart==9){
	dummy(durchmesser);
}

//solar and battery housing main part//
if (whichpart==10){
	sobatbottom();
}

//solar and battery housing top part//
if (whichpart==11){
	sobattop();
}

//solar and battery housing bottom lid//
if (whichpart==12){
	sobatlid();
}

//ball joint//
if (whichpart==13){
	if (whichmount==1){
		translate([0,radiusA/2+10,0])BallJ1();
		translate([0,0,20])mirror([0,0,1])BallJ2();
	}
	if (whichmount==2){
		elsewhere();
	}
}

//all parts for solar and battery housing//
if (whichpart==14){
	color("LightSeaGreen",1)sobatbottom();
	color("DarkSeaGreen",1)translate([0,radiusA*2.5,0])sobattop();
	color("Teal",1)translate([-radiusA*2,0,0])sobatlid();
	if (whichmount==1){
		color("Turquoise",1)translate([-radiusA*2,0,-boden*3-40])BallJ1();
		color("CadetBlue",1)translate([-radiusA*2,0,-boden*3])translate([0,0,-20])mirror([0,0,0])BallJ2();
	}
	if (whichmount==2){
		color("CadetBlue",1)translate([-radiusA*2,0,0])translate([0,0,-10])mirror([0,0,1])elsewhere();
	}
	translate([-durchmesser*2,-durchmesser*2,heightcell*6])linear_extrude(height=2)text("PREVIEW ONLY", font ="Liberation Sans:style=Bold");
}
//mounting bracket//
if (whichpart==15){
	mountingbracket();
}

//preview all parts (may take a long time, not for printing)//
if (whichpart==16){
	translate([0,0,(heightcell+wand*3)*2])mirror([0,0,1])union(){
		color("Aqua",1)translate([0,0,heightcell+wand*4])rotate([0,0,0])mirror([0,0,0])body(0,1);
		color("Yellow",1)translate([0,0,heightcell+wand*2])rotate([0,0,0])mirror([0,0,1])body(0,0);
		color("White",0.7)translate([0,0,(heightcell+wand*3)*2])rotate([0,0,0])mirror([0,0,1])body(1,0);
		color("Lavender",0.7)translate([0,0,-(wand)])rotate([0,0,0])mirror([0,0,0])body(1,0);
	}
	color("Aquamarine",1)translate([durchmesser/2+2+wand,durchmesser/2+wand+2,-heightcell*4])mirror([0,0,1])translate([0,2*(durchmesser+2)*1.732051,boden*2])rotate([0,0,180])ardulid(durchmesser,1,1);
	color("Lime",1)translate([durchmesser/2+2+wand,durchmesser/2+wand+2,0])mirror([0,0,1])translate([0,2*(durchmesser+2)*1.732051,boden*2])ardu(ardumounthole);
	color("PaleGreen",1)translate([durchmesser*3,durchmesser*3,heightcell*5])mirror([0,0,1])dummy(durchmesser);
	translate([0,durchmesser/2+wand+2+(durchmesser+2)*1.732051/2+(1)*(durchmesser+2)*1.732051,0])union(){
		translate([-radiusA,0,0])union(){
			color("SaddleBrown",1)translate([0,0,battheight*3+boden*2])mirror([0,0,1])rotate([0,0,180])sobatbottom();
			color("Maroon",1)translate([0,0,battheight*3+boden*3])sobattop();
			color("Chocolate",1)translate([0,0,0])sobatlid();
		}
		//color("Indigo",1)translate([-radiusA*1+7,0,-boden*3-40])rotate([0,-30,0])BallJ1();
		//color("CadetBlue",1)translate([-radiusA*1,0,-boden*3])translate([0,0,-20])mirror([0,0,0])BallJ2();
		
		if (whichmount==1){
			color("Turquoise",1)translate([-radiusA*1+7,0,-boden*3-40])rotate([0,-30,0])BallJ1();
			color("CadetBlue",1)translate([-radiusA*1,0,-boden*3])translate([0,0,-20])mirror([0,0,0])BallJ2();
		}
		if (whichmount==2){
			color("CadetBlue",1)translate([-radiusA*1,0,0])translate([0,0,-10])mirror([0,0,1])elsewhere();
		}
		
	}
	color("MediumPurple",1)translate([0,durchmesser/2+wand+2+(durchmesser+2)*1.732051/2+(1)*(durchmesser+2)*1.732051,-(boden*4+heightcell+arduh/2)])rotate([0,-90,0])rotate([0,0,90])mountingbracket();
	translate([-durchmesser*2,-durchmesser*2,heightcell*6])linear_extrude(height=2)text("PREVIEW ONLY", font ="Liberation Sans:style=Bold");
}
module Bolt5(){
	union(){
		translate([0,0,3])cylinder(r=2.8, h=40, center=true, $fn=24);
		translate([0,0,15])cylinder(r=4.6, h=8, center=true, $fn=24);
	}
}
module BallJ2() {
	difference(){
		rotate([0,0,30])union(){
			cylinder(r1=14,r2=11,10+BalleR,$fn = 48);
			rotate([175,0,0]) translate([0,0,-1.35]) {
				cylinder(r1=14,r2=14,BalleR/4,$fn = 48);
				translate([0,0,(BalleR/4)])
				cylinder(r1=14,r2=13,BalleR/4,$fn = 48);
			}
			rotate([0,0,-30])translate([0,0,10+BalleR-boden*1.5])hull(){        
				translate([0,radiusA/3,0])cylinder(r=nutw,h=boden*3,center=true);
				translate([0,-radiusA/3,0])cylinder(r=nutw,h=boden*3,center=true);
			}

			
		}
		translate([0,10,0])rotate([90,0,0])cylinder(r=1.25,h=10,center=true,$fn=14);
		translate([0,0,0])sphere(r=BalleR+0.5,$fn = 48);
		translate([0,radiusA/3,10+BalleR])cylinder(r=2.7,h=battheight*2+boden*3,center=true,$fn=16);
		translate([0,-radiusA/3,10+BalleR])cylinder(r=2.7,h=battheight*2+boden*3,center=true,$fn=16);

	}
}
module elsewhere(){
	difference(){
		union(){
			hull(){        
				translate([0,radiusA/2,boden*1.5])cylinder(r=nutw,h=boden*3,center=true);
				translate([0,-radiusA/2,boden*1.5])cylinder(r=nutw,h=boden*3,center=true);
			}
			translate([0,radiusA/2,boden*3+10])rotate([90,0,0])cylinder(r=nutw,h=wand*3,center=true);
			translate([0,-radiusA/2,boden*3+10])rotate([90,0,0])cylinder(r=nutw,h=wand*3,center=true);
			translate([0,radiusA/2,(boden*3+10)/2])cube([nutw*2,wand*3,boden*3+10],center=true);
			translate([0,-radiusA/2,(boden*3+10)/2])cube([nutw*2,wand*3,boden*3+10],center=true);
		}
		union(){
			translate([0,radiusA/3,0])cylinder(r=2.7,h=battheight*2+boden*3,center=true,$fn=16);
			translate([0,-radiusA/3,0])cylinder(r=2.7,h=battheight*2+boden*3,center=true,$fn=16);
			translate([0,radiusA/2,boden*3+10])rotate([90,0,0])cylinder(r=2.8,h=wand*4,center=true);
			translate([0,-radiusA/2,boden*3+10])rotate([90,0,0])cylinder(r=2.8,h=wand*4,center=true);
		}
		
	}
}
module BallJ1(){
	difference(){
		union(){
			translate([0,0,0])translate([0,0,BalleR*1.25])sphere(r=BalleR,$fn=64);
			intersection(){
				union(){
					cylinder(r=BalleR,h=BalleR/2);
					translate([0,0,BalleR/2])cylinder(r1=BalleR,r2=BalleR/2,h=BalleR/2);
				}
				translate([0,0,BalleR/4])cube([nutw*2,arduh,BalleR/2],center=true);
			}
		}
		union(){
			translate([0,0,4])Bolt5();
		}
	}
}

module mountingbracket(){
	difference(){
		union(){
			hull(){
				translate([-mphd/2,0,boden*1.5])cylinder(r=arduh/2+wand,center=true,h=boden*3,$fn=16);			
				translate([mphd/2,0,boden*1.5])cylinder(r=arduh/2+wand,center=true,h=boden*3,$fn=16);
			}
			if (mp_orientation==2){
				translate([-mphd/2,(arduh/2+wand)/2,boden*3+7])rotate([90,0,0])cylinder(r=5,center=true,h=(arduh+wand)/2,$fn=12);			
				translate([mphd/2,(arduh/2+wand)/2,boden*3+7])rotate([90,0,0])cylinder(r=5,center=true,h=(arduh+wand)/2,$fn=12);
				translate([-mphd/2,(arduh/2+wand)/2,(boden*3)/2+3.5])cube([10,(arduh+wand)/2,7+boden*3],center=true);
				translate([mphd/2,(arduh/2+wand)/2,(boden*3)/2+3.5])cube([10,(arduh+wand)/2,7+boden*3],center=true);
			}
		}
		union(){
			translate([0,0,boden*2])scale([1.05,1.05,4])intersection(){
				union(){
					cylinder(r=BalleR,h=BalleR/2);
					translate([0,0,BalleR/2])cylinder(r1=BalleR,r2=BalleR/2,h=BalleR/2);
				}
				translate([0,0,BalleR/4])cube([nutw*2,arduh,BalleR/2],center=true);
			}
			if (mp_orientation==1){
				translate([-mphd/2,0,boden*1.5])cylinder(r=3,center=true,h=boden*4,$fn=12);			
				translate([mphd/2,0,boden*1.5])cylinder(r=3,center=true,h=boden*4,$fn=12);
			}
			if (mp_orientation==2){
				translate([-mphd/2,(arduh/2+wand)/2,boden*3+7])rotate([90,0,0])cylinder(r=3,center=true,h=(arduh+wand),$fn=12);			
				translate([mphd/2,(arduh/2+wand)/2,boden*3+7])rotate([90,0,0])cylinder(r=3,center=true,h=(arduh+wand),$fn=12);
			}
			translate([0,0,boden*1.5])cylinder(r=2.8,center=true,h=boden*4,$fn=12);
		}
	}
}
module body(platem,booleancabhole){
	$fn=6;

	translate([durchmesser/2+2+wand,durchmesser/2+wand+2,0])mirror([0,0,0])
	difference(){
		union(){
			for(j=[0:((lengthy+1)/2-1)]){
				for(i=[0:lengthx-1]){
					if(zuf1[j*2*lengthx+i]<varamount){
						translate([i*(durchmesser+2),j*(durchmesser+2)*1.732051,0])qex(durchmesser,1,heightcell,platem);
					}             
				}

				translate([((durchmesser+2)/2)*1,(durchmesser+2)*1*1.732051/2+(j)*(durchmesser+2)*1.732051*1,0]) for(i=[0:lengthx-1]){
					if(zuf1[j*2*lengthx+i+lengthx]<varamount){
						translate([i*(durchmesser+2)*1,0,0])qex(durchmesser,1,heightcell,platem);
					}
				}
			}
		}
		union(){
			if (booleancabhole==1){
				for(j=[0:((lengthy+1)/2-1)]){
					for(i=[0:lengthx-1]){

						
						if(zuf1[j*2*lengthx+i]<varamount){
							
							if(zuf1[(j*2*lengthx+i)-1-lengthx]<varamount){
								if(i>0){
									translate([i*(durchmesser+2),j*(durchmesser+2)*1.732051,0])rotate([0,0,-120])translate([durchmesser/2,0,boden+heightcell/2])cube([durchmesser+wand/2,durchmesser/2,heightcell],center=true);
								}
							}   //7
							
							if(zuf1[(j*2*lengthx+i)-lengthx]<varamount){
								if(i<lengthx){
									translate([i*(durchmesser+2),j*(durchmesser+2)*1.732051,0])rotate([0,0,-60])translate([durchmesser/2,0,boden+heightcell/2])cube([durchmesser+wand/2,durchmesser/2,heightcell],center=true);
								}
							}   //5
							
							if(zuf1[(j*2*lengthx+i)+1]<varamount){
								if(i<lengthx-1){
									translate([i*(durchmesser+2),j*(durchmesser+2)*1.732051,0])rotate([0,0,0])translate([durchmesser/2,0,boden+heightcell/2])cube([durchmesser+wand/2,durchmesser/2,10],center=true);
								}
							}   //3
							
							if(zuf1[(j*2*lengthx+i)+lengthx]<varamount){
								if(i<lengthx){
									translate([i*(durchmesser+2),j*(durchmesser+2)*1.732051,0])rotate([0,0,60])translate([durchmesser/2,0,boden+heightcell/2])cube([durchmesser+wand/2,durchmesser/2,heightcell],center=true);
								}
							}   //1
							
							if(zuf1[(j*2*lengthx+i)-1+lengthx]<varamount){
								if(i>0){
									translate([i*(durchmesser+2),j*(durchmesser+2)*1.732051,0])rotate([0,0,120])translate([durchmesser/2,0,boden+heightcell/2])cube([durchmesser+wand/2,durchmesser/2,heightcell],center=true);
								}
							}   //11
							
							if(zuf1[(j*2*lengthx+i)-1]<varamount){
								if(i>0){
									translate([i*(durchmesser+2),j*(durchmesser+2)*1.732051,0])rotate([0,0,180])translate([durchmesser/2,0,boden+heightcell/2])cube([durchmesser+wand/2,durchmesser/2,heightcell],center=true);
								}
							}   //9
						}
						if(zuf1[j*2*lengthx+i+lengthx]<varamount){
							translate([(durchmesser+2)/2,(durchmesser+2)*1.732051/2+(j)*(durchmesser+2)*1.732051,0])union(){
								if(zuf1[(j*2*lengthx+i+lengthx)+1]<varamount){if(i<lengthx-1){translate([i*(durchmesser+2),0,0])rotate([0,0,0])translate([durchmesser/2,0,boden+heightcell/2])cube([durchmesser,durchmesser/2,heightcell],center=true);}}   //3
							}
						}


					}
				}
			}
		}
	}
}

module ardu(mount){
	rotate([0,0,180])union(){
		difference(){
			union(){
				qex(durchmesser,1,heightcell,2);
				if (mount==1){
					translate([((durchmesser/2)*1.16-wand-1-1-nutw/2)*1,((durchmesser+2)*1.732051)/2,boden+heightcell+arduh/2])cube([nutw,nutw*2,arduh-boden],center=true);
				}
			}
			union(){
				translate([-durchmesser/3,0,boden+(heightcell-boden*2)/2])cylinder(r=(durchmesser-wand*2)/2,h=heightcell-boden*2, center=true, $fn=6);
				translate([0,(durchmesser+2)*1.732051,0])translate([-durchmesser/3,0,boden+(heightcell-boden*2)/2])cylinder(r=(durchmesser-wand*2)/2,h=heightcell-boden*2, center=true, $fn=6);
				if (mount==1){
					union(){
						translate([((durchmesser/2)*1.16-wand-1-1-nutw/2)*1.16,((durchmesser+2)*1.732051)/2,boden*2+heightcell+arduh/2])rotate([0,90,0])cylinder(r=ardumountholerad,h=wand*10,center=true,$fn=16);
						translate([((durchmesser/2)*1.16-wand*3-2-nutw/2),((durchmesser+2)*1.732051)/2,boden*2+heightcell+arduh/2])rotate([0,90,0])rotate([0,0,30])cylinder(r=nutw/2+0.5,h=wand*4,center=true,$fn=6);
					}
				}
			}      
		}
	}


}
module dummy(durch){
	difference(){
		hull(){
			translate([0,(durch/2)*1.16-wand-1,0])cylinder(r=1,h=heightcell,$fn=6);   
			rotate([0,0,60])translate([0,(durch/2)*1.16-wand-1,0])cylinder(r=1,h=heightcell,$fn=6);
			rotate([0,0,120])translate([0,(durch/2)*1.16-wand-1,0])cylinder(r=1,h=heightcell,$fn=6);
			rotate([0,0,180])translate([0,(durch/2)*1.16-wand-1,0])cylinder(r=1,h=heightcell,$fn=6);
			rotate([0,0,240])translate([0,(durch/2)*1.16-wand-1,0])cylinder(r=1,h=heightcell,$fn=6);
			rotate([0,0,300])translate([0,(durch/2)*1.16-wand-1,0])cylinder(r=1,h=heightcell,$fn=6);
		}
		hull(){
			translate([0,(durch/2)*1.16-wand*2-1,boden])cylinder(r=1,h=heightcell+1,$fn=6);   
			rotate([0,0,60])translate([0,(durch/2)*1.16-wand*2-1,boden])cylinder(r=1,h=heightcell+1,$fn=6);
			rotate([0,0,120])translate([0,(durch/2)*1.16-wand*2-1,boden])cylinder(r=1,h=heightcell+1,$fn=6);
			rotate([0,0,180])translate([0,(durch/2)*1.16-wand*2-1,boden])cylinder(r=1,h=heightcell+1,$fn=6);
			rotate([0,0,240])translate([0,(durch/2)*1.16-wand*2-1,boden])cylinder(r=1,h=heightcell+1,$fn=6);
			rotate([0,0,300])translate([0,(durch/2)*1.16-wand*2-1,boden])cylinder(r=1,h=heightcell+1,$fn=6);
		}
	}
}
module sobatbottom(){
	if (cell_pack_shape==0){
		difference(){
			//bottom part
			union(){
				difference(){
					
					hull(){
						translate([0,radiusA,0])cylinder(r=wand*2,h=battheight+15+boden,$fn=12);   
						rotate([0,0,60])translate([0,radiusA,0])cylinder(r=wand*2,h=battheight+15+boden,$fn=12);
						rotate([0,0,120])translate([0,radiusA,0])cylinder(r=wand*2,h=battheight+15+boden,$fn=12);
						rotate([0,0,180])translate([0,radiusA,0])cylinder(r=wand*2,h=battheight+15+boden,$fn=12);
						rotate([0,0,240])translate([0,radiusA,0])cylinder(r=wand*2,h=battheight+15+boden,$fn=12);
						rotate([0,0,300])translate([0,radiusA,0])cylinder(r=wand*2,h=battheight+15+boden,$fn=12);
					}
					
					
					
					union(){
						cylinder(r=3,h=battheight*6+15+boden,center=true); 
						hull(){
							translate([0,radiusA-wand*2,boden])cylinder(r=wand*2,h=battheight+15+boden,$fn=12);   
							rotate([0,0,60])translate([0,radiusA-wand*2,boden])cylinder(r=wand*2,h=battheight+15+boden,$fn=12);
							rotate([0,0,120])translate([0,radiusA-wand*2,boden])cylinder(r=wand*2,h=battheight+15+boden,$fn=12);
							rotate([0,0,180])translate([0,radiusA-wand*2,boden])cylinder(r=wand*2,h=battheight+15+boden,$fn=12);
							rotate([0,0,240])translate([0,radiusA-wand*2,boden])cylinder(r=wand*2,h=battheight+15+boden,$fn=12);
							rotate([0,0,300])translate([0,radiusA-wand*2,boden])cylinder(r=wand*2,h=battheight+15+boden,$fn=12);
						}
						translate([0,radiusA-6,-boden])cylinder(r=2,h=boden*6,$fn=12);   
						rotate([0,0,120])translate([0,radiusA-6,-boden])cylinder(r=2,h=boden*6,$fn=12);
						rotate([0,0,240])translate([0,radiusA-6,-boden])cylinder(r=2,h=boden*6,$fn=12);
					}
				}

				rotate([0,0,60])translate([0,radiusA-6,boden])cylinder(r=6,h=battheight+15-boden*2.5,$fn=16);
				rotate([0,0,180])translate([0,radiusA-6,boden])cylinder(r=6,h=battheight+15-boden*2.5,$fn=16);
				rotate([0,0,300])translate([0,radiusA-6,boden])cylinder(r=6,h=battheight+15-boden*2.5,$fn=16);
			}
			union(){
				rotate([0,0,60])translate([0,radiusA-6,boden*2+battheight])cylinder(r=1.4,h=battheight+15-boden*2.5,$fn=16);
				rotate([0,0,180])translate([0,radiusA-6,boden*2+battheight])cylinder(r=1.4,h=battheight+15-boden*2.5,$fn=16);
				rotate([0,0,300])translate([0,radiusA-6,boden*2+battheight])cylinder(r=1.4,h=battheight+15-boden*2.5,$fn=16);
			}
		}
	}
	if (cell_pack_shape==1){
		rotate([0,0,90])difference(){
			hull(){
				translate([(solarlength+10)/2,(solarwidth+10)/2,0])cylinder(r=wand*2,h=battheight+10+boden,$fn=16);
				translate([-(solarlength+10)/2,(solarwidth+10)/2,0])cylinder(r=wand*2,h=battheight+10+boden,$fn=16);
				translate([(solarlength+10)/2,-(solarwidth+10)/2,0])cylinder(r=wand*2,h=battheight+10+boden,$fn=16);
				translate([-(solarlength+10)/2,-(solarwidth+10)/2,0])cylinder(r=wand*2,h=battheight+10+boden,$fn=16);
				
			}
			translate([0,0,boden])union(){
				translate([0,0,(battheight+10)/2])cube([solarlength+10+wand,solarwidth+wand-6,battheight+10+boden],center=true);
				translate([0,0,(battheight+10)/2])cube([solarlength+wand-6,solarwidth+10+wand,battheight+10+boden],center=true);
				translate([(solarlength)/2+wand,(solarwidth)/2+wand,battheight+10+boden])cylinder(r=1.4,h=battheight+10+boden,center=true,$fn=12);
				translate([-((solarlength)/2+wand),(solarwidth)/2+wand,battheight+10+boden])cylinder(r=1.4,h=battheight+10+boden,center=true,$fn=12);
				translate([(solarlength)/2+wand,-((solarwidth)/2+wand),battheight+10+boden])cylinder(r=1.4,h=battheight+10+boden,center=true,$fn=12);
				translate([-((solarlength)/2+wand),-((solarwidth)/2+wand),battheight+10+boden])cylinder(r=1.4,h=battheight+10+boden,center=true,$fn=12);
				cylinder(r=3,h=10+boden,center=true,$fn=12);
			}
		}
		
	}
}

module sobattop(){
	if (cell_pack_shape==0){    
		//Top Part
		difference(){
			hull(){
				translate([0,radiusA,0])cylinder(r=wand*2,h=boden*4,$fn=12);   
				rotate([0,0,60])translate([0,radiusA,0])cylinder(r=wand*2,h=boden*4,$fn=12);
				rotate([0,0,120])translate([0,radiusA,0])cylinder(r=wand*2,h=boden*4,$fn=12);
				rotate([0,0,180])translate([0,radiusA,0])cylinder(r=wand*2,h=boden*4,$fn=12);
				rotate([0,0,240])translate([0,radiusA,0])cylinder(r=wand*2,h=boden*4,$fn=12);
				rotate([0,0,300])translate([0,radiusA,0])cylinder(r=wand*2,h=boden*4,$fn=12);
			}
			union(){
				translate([0,0,boden*3])cube([solarlength+1,solarwidth+1,boden*2.5],center=true);
				translate([0,0,boden*3])cube([solarlength-10,solarwidth-10,boden*5],center=true);
				cylinder(r=3,h=10+boden,center=true,$fn=12); 
				rotate([0,0,60])translate([0,radiusA-6,-boden])cylinder(r=2,h=boden*6,$fn=12);
				rotate([0,0,180])translate([0,radiusA-6,-boden])cylinder(r=2,h=boden*6,$fn=12);
				rotate([0,0,300])translate([0,radiusA-6,-boden])cylinder(r=2,h=boden*6,$fn=12);    
			}
			
		}
	}
	if (cell_pack_shape==1){
		rotate([0,0,90])difference(){
			hull(){
				translate([(solarlength+10)/2,(solarwidth+10)/2,0])cylinder(r=wand*2,h=boden*2+5,$fn=16);
				translate([-(solarlength+10)/2,(solarwidth+10)/2,0])cylinder(r=wand*2,h=boden*2+5,$fn=16);
				translate([(solarlength+10)/2,-(solarwidth+10)/2,0])cylinder(r=wand*2,h=boden*2+5,$fn=16);
				translate([-(solarlength+10)/2,-(solarwidth+10)/2,0])cylinder(r=wand*2,h=boden*2+5,$fn=16);
				
			}
			cylinder(r=3,h=10+boden*2,center=true,$fn=12);
			translate([0,0,(2.5+boden)/2+boden+0.5])cube([solarlength-5,solarwidth-5,boden+2.5],center=true);
			translate([0,0,(boden*2+5)-boden/2])cube([solarlength+2,solarwidth+2,boden+0.5],center=true);
			
		}
	}
}

module sobatlid(){
	//Lid
	if (cell_pack_shape==0){
		difference(){
			union(){
				hull(){
					translate([0,radiusA,0])cylinder(r=wand*2,h=boden,$fn=12);   
					rotate([0,0,60])translate([0,radiusA,0])cylinder(r=wand*2,h=boden,$fn=12);
					rotate([0,0,120])translate([0,radiusA,0])cylinder(r=wand*2,h=boden,$fn=12);
					rotate([0,0,180])translate([0,radiusA,0])cylinder(r=wand*2,h=boden,$fn=12);
					rotate([0,0,240])translate([0,radiusA,0])cylinder(r=wand*2,h=boden,$fn=12);
					rotate([0,0,300])translate([0,radiusA,0])cylinder(r=wand*2,h=boden,$fn=12);
				}
				union(){
					
					hull(){
						translate([0,radiusA-wand*2,boden])cylinder(r=wand*2,h=boden,$fn=12);   
						rotate([0,0,60])translate([0,radiusA-wand*2,boden])cylinder(r=wand*2,h=boden,$fn=12);
						rotate([0,0,120])translate([0,radiusA-wand*2,boden])cylinder(r=wand*2,h=boden,$fn=12);
						rotate([0,0,180])translate([0,radiusA-wand*2,boden])cylinder(r=wand*2,h=boden,$fn=12);
						rotate([0,0,240])translate([0,radiusA-wand*2,boden])cylinder(r=wand*2,h=boden,$fn=12);
						rotate([0,0,300])translate([0,radiusA-wand*2,boden])cylinder(r=wand*2,h=boden,$fn=12);
					}
				}
			}
			union(){
				translate([radiusA/2,0,0])cylinder(r=3,h=battheight*2+boden,center=true);
				//mounting holes
				translate([0,radiusA/3,0])cylinder(r=2.7,h=battheight*2+boden,center=true);
				translate([0,-radiusA/3,0])cylinder(r=2.7,h=battheight*2+boden,center=true);
				
				translate([0,radiusA-6,-boden])cylinder(r=2,h=boden*6,$fn=12);   
				rotate([0,0,120])translate([0,radiusA-6,-boden])cylinder(r=2,h=boden*6,$fn=12);
				rotate([0,0,240])translate([0,radiusA-6,-boden])cylinder(r=2,h=boden*6,$fn=12);
				
				if (switch==1){
					translate([radiusA/2,radiusA/3,0])cylinder(r=rswitch,h=battheight*2,center=true,$fn=16);
				}
			}
			
		}
	}
	if (cell_pack_shape==1){
		rotate([0,0,90])difference(){
			hull(){
				translate([(solarlength+10)/2,(solarwidth+10)/2,0])cylinder(r=wand*2,h=boden,$fn=16);
				translate([-(solarlength+10)/2,(solarwidth+10)/2,0])cylinder(r=wand*2,h=boden,$fn=16);
				translate([(solarlength+10)/2,-(solarwidth+10)/2,0])cylinder(r=wand*2,h=boden,$fn=16);
				translate([-(solarlength+10)/2,-(solarwidth+10)/2,0])cylinder(r=wand*2,h=boden,$fn=16);
				
			}
			translate([0,0,boden])union(){
				translate([(solarlength)/2+wand,(solarwidth)/2+wand,0])cylinder(r=2,h=battheight+10+boden,center=true,$fn=12);
				translate([-((solarlength)/2+wand),(solarwidth)/2+wand,0])cylinder(r=2,h=battheight+10+boden,center=true,$fn=12);
				translate([(solarlength)/2+wand,-((solarwidth)/2+wand),0])cylinder(r=2,h=battheight+10+boden,center=true,$fn=12);
				translate([-((solarlength)/2+wand),-((solarwidth)/2+wand),0])cylinder(r=2,h=battheight+10+boden,center=true,$fn=12);
				translate([0,solarwidth/3,-boden])cylinder(r=3,h=10+boden*2,center=true);
				translate([radiusA/3,0,0])cylinder(r=2.7,h=battheight*2+boden,center=true);
				translate([-radiusA/3,0,0])cylinder(r=2.7,h=battheight*2+boden,center=true);
				if (switch==1){
					translate([radiusA/2-5,radiusA/3,0])cylinder(r=rswitch,h=battheight*2+boden,center=true,$fn=16);
				}
			}
		}
	}
}
module ardulid(durch,rad,hoch)
{
	mirror([0,0,1])difference(){
		union(){
			hull(){
				
				translate([0,(durchmesser+2)*1.732051,0])translate([0,((durch/2)*1.16-wand-1-rad)*1.16+0.5,hoch+boden*2])cylinder(r=rad,h=boden);   
				translate([-ardul,0,0])translate([0,(durchmesser+2)*1.732051,0])rotate([0,0,60])translate([0,((durch/2)*1.16-wand-1-rad)*1.16+0.5,hoch+boden*2])cylinder(r=rad,h=boden);
				translate([-ardul,0,0])rotate([0,0,120])translate([0,((durch/2)*1.16-wand-1-rad)*1.16+0.5,hoch+boden*2])cylinder(r=rad,h=boden);
				rotate([0,0,180])translate([0,((durch/2)*1.16-wand-1-rad)*1.16+0.5,hoch+boden*2])cylinder(r=rad,h=boden);
				rotate([0,0,240])translate([0,((durch/2)*1.16-wand-1-rad)*1.16+0.5,hoch+boden*2])cylinder(r=rad,h=boden);
				translate([0,(durchmesser+2)*1.732051,0])rotate([0,0,300])translate([0,((durch/2)*1.16-wand-1-rad)*1.16+0.5,hoch+boden*2])cylinder(r=rad,h=boden);
			}
			hull(){
				
				translate([0,(durchmesser+2)*1.732051,0])translate([0,((durch/2)*1.16-wand*2-2-rad)*1.16+0.5,hoch+boden*3])cylinder(r=rad,h=boden);   
				translate([-ardul,0,0])translate([0,(durchmesser+2)*1.732051,0])rotate([0,0,60])translate([0,((durch/2)*1.16-wand*2-2-rad)*1.16+0.5,hoch+boden*3])cylinder(r=rad,h=boden);
				translate([-ardul,0,0])rotate([0,0,120])translate([0,((durch/2)*1.16-wand*2-2-rad)*1.16+0.5,hoch+boden*3])cylinder(r=rad,h=boden);
				rotate([0,0,180])translate([0,((durch/2)*1.16-wand*2-2-rad)*1.16+0.5,hoch+boden*3])cylinder(r=rad,h=boden);
				rotate([0,0,240])translate([0,((durch/2)*1.16-wand*2-2-rad)*1.16+0.5,hoch+boden*3])cylinder(r=rad,h=boden);
				translate([0,(durchmesser+2)*1.732051,0])rotate([0,0,300])translate([0,((durch/2)*1.16-wand*2-2-rad)*1.16+0.5,hoch+boden*3])cylinder(r=rad,h=boden);
			}
			

		}
		translate([-durchmesser,((durchmesser+2)*1.732051)/2,0])cylinder(r=2,h=200,center=true,$fn=16);   
	}
}
module qex(durch,rad,hoch,plate){
	$fn=12;
	if(plate==0){
		difference(){
			hull(){
				translate([0,(durch/2)*1.16+0.5,0])cylinder(r=rad,h=hoch);   
				rotate([0,0,60])translate([0,(durch/2)*1.16+0.5,0])cylinder(r=rad,h=hoch);
				rotate([0,0,120])translate([0,(durch/2)*1.16+0.5,0])cylinder(r=rad,h=hoch);
				rotate([0,0,180])translate([0,(durch/2)*1.16+0.5,0])cylinder(r=rad,h=hoch);
				rotate([0,0,240])translate([0,(durch/2)*1.16+0.5,0])cylinder(r=rad,h=hoch);
				rotate([0,0,300])translate([0,(durch/2)*1.16+0.5,0])cylinder(r=rad,h=hoch);
			}
			union(){
				hull(){
					translate([0,(durch/2)*1.16-wand,boden])cylinder(r=rad,h=hoch+1);   
					rotate([0,0,60])translate([0,(durch/2)*1.16-wand,boden])cylinder(r=rad,h=hoch+1);
					rotate([0,0,120])translate([0,(durch/2)*1.16-wand,boden])cylinder(r=rad,h=hoch+1);
					rotate([0,0,180])translate([0,(durch/2)*1.16-wand,boden])cylinder(r=rad,h=hoch+1);
					rotate([0,0,240])translate([0,(durch/2)*1.16-wand,boden])cylinder(r=rad,h=hoch+1);
					rotate([0,0,300])translate([0,(durch/2)*1.16-wand,boden])cylinder(r=rad,h=hoch+1);
				}
				if (booleanledhole==1){
					translate([0,0,0])cylinder(r=hole,h=boden*2+1, center=true, $fn=16);
				}
			}
		}
	}
	else if (plate==1){
		union(){
			hull(){
				translate([0,(durch/2)*1.16+0.5,0])cylinder(r=rad,h=boden/2);   
				rotate([0,0,60])translate([0,(durch/2)*1.16+0.5,0])cylinder(r=rad,h=boden/2);
				rotate([0,0,120])translate([0,(durch/2)*1.16+0.5,0])cylinder(r=rad,h=boden/2);
				rotate([0,0,180])translate([0,(durch/2)*1.16+0.5,0])cylinder(r=rad,h=boden/2);
				rotate([0,0,240])translate([0,(durch/2)*1.16+0.5,0])cylinder(r=rad,h=boden/2);
				rotate([0,0,300])translate([0,(durch/2)*1.16+0.5,0])cylinder(r=rad,h=boden/2);
			}
			union(){
				hull(){
					translate([0,durch/2*1.16-wand-1-rad,boden/2])cylinder(r=rad,h=boden/2);   
					rotate([0,0,60])translate([0,durch/2*1.16-wand-1-rad,boden/2])cylinder(r=rad,h=boden/2);
					rotate([0,0,120])translate([0,durch/2*1.16-wand-1-rad,boden/2])cylinder(r=rad,h=boden/2);
					rotate([0,0,180])translate([0,durch/2*1.16-wand-1-rad,boden/2])cylinder(r=rad,h=boden/2);
					rotate([0,0,240])translate([0,durch/2*1.16-wand-1-rad,boden/2])cylinder(r=rad,h=boden/2);
					rotate([0,0,300])translate([0,durch/2*1.16-wand-1-rad,boden/2])cylinder(r=rad,h=boden/2);
				}
			}
		}
	}
	else if (plate==2){
		union(){
			
			difference(){
				union(){
					hull(){             
						translate([0,((durch/2)*1.16-wand-1-rad)*1.16+0.5,0])cylinder(r=rad,h=hoch+boden);   
						rotate([0,0,60])translate([0,((durch/2)*1.16-wand-1-rad)*1.16+0.5,0])cylinder(r=rad,h=hoch+boden);
						rotate([0,0,120])translate([0,((durch/2)*1.16-wand-1-rad)*1.16+0.5,0])cylinder(r=rad,h=hoch+boden);
						rotate([0,0,180])translate([0,((durch/2)*1.16-wand-1-rad)*1.16+0.5,0])cylinder(r=rad,h=hoch+boden);
						rotate([0,0,240])translate([0,((durch/2)*1.16-wand-1-rad)*1.16+0.5,0])cylinder(r=rad,h=hoch+boden);
						rotate([0,0,300])translate([0,((durch/2)*1.16-wand-1-rad)*1.16+0.5,0])cylinder(r=rad,h=hoch+boden);
					}
					translate([0,(durchmesser+2)*1.732051,0])hull(){             
						translate([0,((durch/2)*1.16-wand-1-rad)*1.16+0.5,0])cylinder(r=rad,h=hoch+boden);   
						rotate([0,0,60])translate([0,((durch/2)*1.16-wand-1-rad)*1.16+0.5,0])cylinder(r=rad,h=hoch+boden);
						rotate([0,0,120])translate([0,((durch/2)*1.16-wand-1-rad)*1.16+0.5,0])cylinder(r=rad,h=hoch+boden);
						rotate([0,0,180])translate([0,((durch/2)*1.16-wand-1-rad)*1.16+0.5,0])cylinder(r=rad,h=hoch+boden);
						rotate([0,0,240])translate([0,((durch/2)*1.16-wand-1-rad)*1.16+0.5,0])cylinder(r=rad,h=hoch+boden);
						rotate([0,0,300])translate([0,((durch/2)*1.16-wand-1-rad)*1.16+0.5,0])cylinder(r=rad,h=hoch+boden);
					}
					hull(){
						
						translate([0,(durchmesser+2)*1.732051,0])translate([0,((durch/2)*1.16-wand-1-rad)*1.16+0.5,hoch+boden])cylinder(r=rad,h=boden);   
						translate([0,(durchmesser+2)*1.732051,0])rotate([0,0,60])translate([0,((durch/2)*1.16-wand-1-rad)*1.16+0.5,hoch+boden])cylinder(r=rad,h=boden);
						rotate([0,0,120])translate([0,((durch/2)*1.16-wand-1-rad)*1.16+0.5,hoch+boden])cylinder(r=rad,h=boden);
						rotate([0,0,180])translate([0,((durch/2)*1.16-wand-1-rad)*1.16+0.5,hoch+boden])cylinder(r=rad,h=boden);
						rotate([0,0,240])translate([0,((durch/2)*1.16-wand-1-rad)*1.16+0.5,hoch+boden])cylinder(r=rad,h=boden);
						translate([0,(durchmesser+2)*1.732051,0])rotate([0,0,300])translate([0,((durch/2)*1.16-wand-1-rad)*1.16+0.5,hoch+boden])cylinder(r=rad,h=boden);
						
					}
					difference(){
						hull(){
							
							translate([0,(durchmesser+2)*1.732051,0])translate([0,((durch/2)*1.16-wand-1-rad)*1.16+0.5,hoch+boden*2])cylinder(r=rad,h=arduh);   
							translate([-ardul,0,0])translate([0,(durchmesser+2)*1.732051,0])rotate([0,0,60])translate([0,((durch/2)*1.16-wand-1-rad)*1.16+0.5,hoch+boden*2])cylinder(r=rad,h=arduh);
							translate([-ardul,0,0])rotate([0,0,120])translate([0,((durch/2)*1.16-wand-1-rad)*1.16+0.5,hoch+boden*2])cylinder(r=rad,h=arduh);
							rotate([0,0,180])translate([0,((durch/2)*1.16-wand-1-rad)*1.16+0.5,hoch+boden*2])cylinder(r=rad,h=arduh);
							rotate([0,0,240])translate([0,((durch/2)*1.16-wand-1-rad)*1.16+0.5,hoch+boden*2])cylinder(r=rad,h=arduh);
							translate([0,(durchmesser+2)*1.732051,0])rotate([0,0,300])translate([0,((durch/2)*1.16-wand-1-rad)*1.16+0.5,hoch+boden*2])cylinder(r=rad,h=arduh);
						}
						hull(){
							
							translate([0,(durchmesser+2)*1.732051,0])translate([0,((durch/2)*1.16-wand*2-1-rad)*1.16+0.5,hoch+boden*3])cylinder(r=rad,h=arduh);   
							translate([-ardul,0,0])translate([0,(durchmesser+2)*1.732051,0])rotate([0,0,60])translate([0,((durch/2)*1.16-wand*2-1-rad)*1.16+0.5,hoch+boden*3])cylinder(r=rad,h=arduh);
							translate([-ardul,0,0])rotate([0,0,120])translate([0,((durch/2)*1.16-wand*2-1-rad)*1.16+0.5,hoch+boden*3])cylinder(r=rad,h=arduh);
							rotate([0,0,180])translate([0,((durch/2)*1.16-wand*2-1-rad)*1.16+0.5,hoch+boden*3])cylinder(r=rad,h=arduh);
							rotate([0,0,240])translate([0,((durch/2)*1.16-wand*2-1-rad)*1.16+0.5,hoch+boden*3])cylinder(r=rad,h=arduh);
							translate([0,(durchmesser+2)*1.732051,0])rotate([0,0,300])translate([0,((durch/2)*1.16-wand*2-1-rad)*1.16+0.5,hoch+boden*3])cylinder(r=rad,h=arduh);
						}
						

					}
					
				}
				union(){
					hull(){
						translate([0,((durch-wand-2)/2)*1.16-wand,boden*3])cylinder(r=rad,h=hoch*2+1+boden);   
						rotate([0,0,60])translate([0,((durch-wand-2)/2)*1.16-wand,boden*3])cylinder(r=rad,h=hoch*2+1+boden);
						rotate([0,0,120])translate([0,((durch-wand-2)/2)*1.16-wand,boden*3])cylinder(r=rad,h=hoch*2+1+boden);
						rotate([0,0,180])translate([0,((durch-wand-2)/2)*1.16-wand,boden*3])cylinder(r=rad,h=hoch*2+1+boden);
						rotate([0,0,240])translate([0,((durch-wand-2)/2)*1.16-wand,boden*3])cylinder(r=rad,h=hoch*2+1+boden);
						rotate([0,0,300])translate([0,((durch-wand-2)/2)*1.16-wand,boden*3])cylinder(r=rad,h=hoch*2+1+boden);
					}
					translate([0,(durchmesser+2)*1.732051,0])hull(){
						translate([0,((durch-wand-2)/2)*1.16-wand,boden*3])cylinder(r=rad,h=hoch*2+1+boden);   
						rotate([0,0,60])translate([0,((durch-wand-2)/2)*1.16-wand,boden*3])cylinder(r=rad,h=hoch*2+1+boden);
						rotate([0,0,120])translate([0,((durch-wand-2)/2)*1.16-wand,boden*3])cylinder(r=rad,h=hoch*2+1+boden);
						rotate([0,0,180])translate([0,((durch-wand-2)/2)*1.16-wand,boden*3])cylinder(r=rad,h=hoch*2+1+boden);
						rotate([0,0,240])translate([0,((durch-wand-2)/2)*1.16-wand,boden*3])cylinder(r=rad,h=hoch*2+1+boden);
						rotate([0,0,300])translate([0,((durch-wand-2)/2)*1.16-wand,boden*3])cylinder(r=rad,h=hoch*2+1+boden);
					}
					translate([0,(durchmesser+2)*1.732051,0])translate([0,0,boden*2+0.5])rotate([0,0,30])cylinder(r=nutw*1.1/2+0.5,h=boden*3, center=true, $fn=6);
					translate([0,0,boden*2+0.5])rotate([0,0,30])cylinder(r=nutw*1.1/2+0.5,h=boden*3, center=true, $fn=6);
					if (booleanledhole==1){
						translate([0,(durchmesser+2)*1.732051,0])cylinder(r=hole,h=boden*7+1, center=true, $fn=16);
						translate([0,0,0])cylinder(r=hole,h=boden*7+1, center=true, $fn=16);
					}
				}
			}
		}
	}
}
//////////////////////////////////////////////
// random parametric bee hive generator by Christoph Queck, chris@q3d.de, wwww.q3d.de
// Designed for Thingiverse "Light It Up Challenge" Summer 2015
// July 2015
/////////////////////////////////////////////
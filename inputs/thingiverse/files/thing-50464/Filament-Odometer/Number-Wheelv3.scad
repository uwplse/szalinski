include <write/Write.scad>
//Print Numbers on Gears (recommended that you add numbers using marker after printing)
Numbers=1; // [0:Manual Numbering,1:Automatic Numbering]
//select shaft type (printed not recommended)
Shaft=1; // [1:2mm steel rod,2:Printed Shaft]
//numbering system
Format=10; // [8:Oct, 10:Decimal, 16:Hexidecimal]
//What do you want to view/print
Print=1; // [0:Assembled View,1:All Parts on 1 Platform,2:Numbered Gears Only, 3:Lower Body, 4:Upper Body, 5:Drive Wheels]
//How many digits do you want to have
Digits=3; // [1:5]
//Select your units
Units=10; // [10:cm, 25.4:mm]
//Select size of filament to measure in mm (not recommended that you change this)
FilSize=1.75; 
//Select to show build platform (not recommended)
Build=0; //[0:On, 1:Off]
//Choose build size
BuildSize=254; //[[203.2:8" Build, 254:10" Build, 304.8:12" Build]
//(optional) External wheel for measuring linear distances, or manual adjustment
ExternalWheel=0; // [0:Off,1:On]

//PARTS
//Optional shafts
module PrintShaft(){
	difference(){
		translate([0,0,1.6]) rotate([0,90,0])cylinder(r=1.95,h=13*Digits+25,$fn=res2,center=true);
		translate([(-13*Digits-30)/2,-2,-4]) cube([13*Digits+30,4,4]);
	}
}
//Print center of Wheel (part with numbers)
module Wheel_Center(){
	difference(){
		union(){
			cylinder(r=Format,h=8,$fn=Format);
			cylinder(r=Format,h=1,$fn=res3);
			translate([0,0,7]) cylinder(r=Format,h=1,$fn=res3);
		}
		cube([Format*.9,Format*.9,30],center=true);
	}
	if (Numbers==1 && Format==10){
		rotate([0,0,-108]){
			rotate([0,0,0]) translate ([1.75,-9,3]) rotate([0,-90,0]) rotate([90,0,0]) write("0",[0,0,0],(W)/2,3,font=Font,h=4);
			rotate([0,0,36]) translate ([1.75,-9,3]) rotate([0,-90,0]) rotate([90,0,0]) write("1",[0,0,0],(W)/2,3,font=Font,h=4);
			rotate([0,0,72]) translate ([1.75,-9,3]) rotate([0,-90,0]) rotate([90,0,0]) write("2",[0,0,0],(W)/2,3,font=Font,h=4);
			rotate([0,0,108]) translate ([1.75,-9,3]) rotate([0,-90,0]) rotate([90,0,0]) write("3",[0,0,0],(W)/2,3,font=Font,h=4);
			rotate([0,0,144]) translate ([1.75,-9,3]) rotate([0,-90,0]) rotate([90,0,0]) write("4",[0,0,0],(W)/2,3,font=Font,h=4);
			rotate([0,0,180]) translate ([1.75,-9,3]) rotate([0,-90,0]) rotate([90,0,0]) write("5",[0,0,0],(W)/2,3,font=Font,h=4);
			rotate([0,0,216]) translate ([1.75,-9,3]) rotate([0,-90,0]) rotate([90,0,0]) write("6",[0,0,0],(W)/2,3,font=Font,h=4);
			rotate([0,0,252]) translate ([1.75,-9,3]) rotate([0,-90,0]) rotate([90,0,0]) write("7",[0,0,0],(W)/2,3,font=Font,h=4);
			rotate([0,0,288]) translate ([1.75,-9,3]) rotate([0,-90,0]) rotate([90,0,0]) write("8",[0,0,0],(W)/2,3,font=Font,h=4);
			rotate([0,0,324]) translate ([1.75,-9,3]) rotate([0,-90,0]) rotate([90,0,0]) write("9",[0,0,0],(W)/2,3,font=Font,h=4);
		}
	} else if (Numbers==1 &&Format==8){
		rotate([0,0,22.5-135]){
			rotate([0,0,0]) translate ([1.75,-7,3]) rotate([0,-90,0]) rotate([90,0,0]) write("0",[0,0,0],(W)/2,3,font=Font,h=4);
			rotate([0,0,45]) translate ([1.75,-7,3]) rotate([0,-90,0]) rotate([90,0,0]) write("1",[0,0,0],(W)/2,3,font=Font,h=4);
			rotate([0,0,90]) translate ([1.75,-7,3]) rotate([0,-90,0]) rotate([90,0,0]) write("2",[0,0,0],(W)/2,3,font=Font,h=4);
			rotate([0,0,135]) translate ([1.75,-7,3]) rotate([0,-90,0]) rotate([90,0,0]) write("3",[0,0,0],(W)/2,3,font=Font,h=4);
			rotate([0,0,180]) translate ([1.75,-7,3]) rotate([0,-90,0]) rotate([90,0,0]) write("4",[0,0,0],(W)/2,3,font=Font,h=4);
			rotate([0,0,225]) translate ([1.75,-7,3]) rotate([0,-90,0]) rotate([90,0,0]) write("5",[0,0,0],(W)/2,3,font=Font,h=4);
			rotate([0,0,270]) translate ([1.75,-7,3]) rotate([0,-90,0]) rotate([90,0,0]) write("6",[0,0,0],(W)/2,3,font=Font,h=4);
			rotate([0,0,315]) translate ([1.75,-7,3]) rotate([0,-90,0]) rotate([90,0,0]) write("7",[0,0,0],(W)/2,3,font=Font,h=4);
		}
	} else if (Numbers==1 && Format==16){
		rotate([0,0,-123.75]){
			rotate([0,0,0])translate ([1.75,-15,3]) rotate([0,-90,0]) rotate([90,0,0]) write("0",[0,0,0],(W)/2,3,font=Font,h=4);
			rotate([0,0,22.5])translate ([1.75,-15,3]) rotate([0,-90,0]) rotate([90,0,0]) write("1",[0,0,0],(W)/2,3,font=Font,h=4);
			rotate([0,0,45])translate ([1.75,-15,3]) rotate([0,-90,0]) rotate([90,0,0]) write("2",[0,0,0],(W)/2,3,font=Font,h=4);
			rotate([0,0,67.5])translate ([1.75,-15,3]) rotate([0,-90,0]) rotate([90,0,0]) write("3",[0,0,0],(W)/2,3,font=Font,h=4);
			rotate([0,0,90])translate ([1.75,-15,3]) rotate([0,-90,0]) rotate([90,0,0]) write("4",[0,0,0],(W)/2,3,font=Font,h=4);
			rotate([0,0,112.5])translate ([1.75,-15,3]) rotate([0,-90,0]) rotate([90,0,0]) write("5",[0,0,0],(W)/2,3,font=Font,h=4);
			rotate([0,0,135])translate ([1.75,-15,3]) rotate([0,-90,0]) rotate([90,0,0]) write("6",[0,0,0],(W)/2,3,font=Font,h=4);
			rotate([0,0,157.5])translate ([1.75,-15,3]) rotate([0,-90,0]) rotate([90,0,0]) write("7",[0,0,0],(W)/2,3,font=Font,h=4);
			rotate([0,0,180])translate ([1.75,-15,3]) rotate([0,-90,0]) rotate([90,0,0]) write("8",[0,0,0],(W)/2,3,font=Font,h=4);
			rotate([0,0,202.5])translate ([1.75,-15,3]) rotate([0,-90,0]) rotate([90,0,0]) write("9",[0,0,0],(W)/2,3,font=Font,h=4);
			rotate([0,0,225])translate ([1.75,-15,3]) rotate([0,-90,0]) rotate([90,0,0]) write("A",[0,0,0],(W)/2,3,font=Font,h=4);
			rotate([0,0,247.5])translate ([1.75,-15,3]) rotate([0,-90,0]) rotate([90,0,0]) write("B",[0,0,0],(W)/2,3,font=Font,h=4);
			rotate([0,0,270])translate ([1.75,-15,3]) rotate([0,-90,0]) rotate([90,0,0]) write("C",[0,0,0],(W)/2,3,font=Font,h=4);
			rotate([0,0,292.5])translate ([1.75,-15,3]) rotate([0,-90,0]) rotate([90,0,0]) write("D",[0,0,0],(W)/2,3,font=Font,h=4);
			rotate([0,0,315])translate ([1.75,-15,3]) rotate([0,-90,0]) rotate([90,0,0]) write("E",[0,0,0],(W)/2,3,font=Font,h=4);
			rotate([0,0,337.5])translate ([1.75,-15,3]) rotate([0,-90,0]) rotate([90,0,0]) write("F",[0,0,0],(W)/2,3,font=Font,h=4);
			
		}
	}
}
//print cogs for sides of wheels
module Wheel_Cog(n){
	difference(){
		union(){
			//filler center
			cylinder(r=Format*.7,h=2,$fn=res3);
			//cogs
			for (i=[1:n]){
				rotate([0,0,(360/n)*i]) {
					translate([Format-1.5,0,0]) cylinder(r=1.5,h=2,$fn=res2);
					translate([0,-1.5,0]) cube([Format-1.5,3,2]);
				}
			}
			//cube to hold in place
			translate([0,0,-2]) cube([Format*.9-.2,Format*.9-.2,4],center=true);
		}
		//hole for shaft
		cylinder(r=Shaft,h=20,$fn=res2,center=true);
	}
}
//Print the smaller drive gears
module Connecting_Cog(){
	difference(){
		union(){
			cylinder(r=3.5,h=4.5,$fn=res2);
			for (i=[1:6]){
				rotate([0,0,60*i]) {
					translate([5.75,0,0])  cylinder(r=.9,h=4.5,$fn=res2);
					translate([0,-.9,0]) cube([5.75,1.8,4.5]);
				}
			}
		}
		cylinder(r=Shaft,h=20,$fn=res2,center=true);
	}
}
//drive wheel for reading rotation
module Drive_Wheel(n){
	Rad=(n*Units)/(2*Pi);
	difference(){
		cylinder(r=Rad,h=8,$fn=res3);
		cube([Format*.9,Format*.9,30],center=true);
	}
}
//Print Idler Wheel
module Idle_Wheel(n){
	Rad=(n*Units)/(2*Pi);
	difference(){
		cylinder(r=(Format+3.75)-Rad-(FilSize*.8),h=8,$fn=res3);
		cylinder(r=Shaft,h=20,$fn=res2,center=true);
	}
}
//Print Bottom part of body
module Body_Lower(){
	
	module Drive_Holes(n){
		Rad=(n*Units)/(2*Pi);
		rotate([90,0,0]) cylinder(r=Rad+.5,h=8.5,$fn=res2);
		translate([-Rad-.5,-8.5,0]) cube([Rad*2 + 1,8.5,30]);
		translate([Format+3.75,0,0])rotate([90,0,0]) cylinder(r=(Format+3.75)-Rad-(FilSize*.8)+.5,h=8.5,$fn=res2);
		translate([Rad+FilSize*.8-.5,-8.5,0]) cube([2*((Format+3.75)-Rad-(FilSize*.8)+.5),9,50]);
		if (ExternalWheel==1){
			translate([-Rad-Format*1.5,10,0]) rotate([90,0,0]) cylinder(r=Shaft,h=30,$fn=res2);
			translate([-Rad-Format*1.5,-4,0]) rotate([90,0,0]) cylinder(r=Format*1.5+.5,h=8,$fn=res2,center=true);
		}
	}
	difference(){
		//basic shape
		union(){
			translate([-Format-5,-15,-3-Format]) cube([2*Format+20,13*Digits+25,Format+5]);
			//holes for mounting upper cover
			translate([-Format-3,-12,2]) cylinder(r=.9,h=2,$fn=res1);
			translate([-Format-3,13*Digits+8,2]) cylinder(r=.9,h=2,$fn=res1);
			translate([-Format-3,-13+(13*Digits+25)/2,2]) cylinder(r=.9,h=2,$fn=res1);
			translate([-Format-3,-17+(13*Digits+25)/2,2]) cylinder(r=.9,h=2,$fn=res1);
			translate([Format+13,-12,2]) cylinder(r=.9,h=2,$fn=res1);
			translate([Format+13,13*Digits+8,2]) cylinder(r=.9,h=2,$fn=res1);
			translate([Format+13,-13+(13*Digits+25)/2,2]) cylinder(r=.9,h=2,$fn=res1);
			translate([Format+13,-17+(13*Digits+25)/2,2]) cylinder(r=.9,h=2,$fn=res1);
			//Optional external wheel
			if (ExternalWheel==1){
				translate([-Format*2.5-5,-12,-3-Format]) cube([2*Format+20,16,Format+5]);
			}
		}
		//cut-away for gears
		for (i=[1:Digits]){
			translate([0,13*(i-1)-1,0]) rotate([-90,0,0]) cylinder(r=Format+1,h=17,$fn=res2);
			translate([-Format-1,13*(i-1)-1,0]) cube([2*(Format+1),17,2*(Format+1)]);
			translate([Format+3.75,13*(i-1),0])rotate([-90,0,0]) cylinder(r=7,h=5,$fn=res2);
			translate([Format+3.75,13*(i-1),0]) cube([7,5,7]);
		}
		//cut-away for drive wheels
		if (Units==10 && Format==8){
			Drive_Holes(4);
		} else if (Units==25.4 && Format==8){
			Drive_Holes(2);
		} else if (Units==10 && Format==10){
			Drive_Holes(5);
		} else if (Units==25.4 && Format==10){
			Drive_Holes(2);
		} else if (Units==10 && Format==16){
			Drive_Holes(8);
		} else if (Units==25.4 && Format==16){
			Drive_Holes(3);
		}
		//cut-away for filement feed
		translate([Format,-5+(FilSize*1.2)/2,0]) cylinder(r=FilSize*1.2,h=50,$fn=res1,center=true);
		translate([Format-FilSize*3,-5+(FilSize*1.2)/2,0]) cylinder(r=FilSize*1.2,h=50,$fn=res1,center=true);
		translate([Format-FilSize*3,-5-(FilSize*1.2)/2,-50]) cube([FilSize*3,FilSize*2.4,100]);
		//cut-away for shafts
		rotate([90,0,0]) cylinder(r=Shaft,h=40*Digits,$fn=res2,center=true);
		translate([Format+3.75,0,0])rotate([90,0,0]) cylinder(r=Shaft,h=40*Digits,$fn=res2,center=true);
	}
}
//Print Upper Body Parts
module Body_Upper(){
	module FeedHole(n){
		Rad=(n*Units)/(2*Pi);
		translate([Rad+(FilSize)/2,-5+(FilSize*1.2)/2,0]) cylinder(r=FilSize,h=50,$fn=res2);
	}
	//dial Cover
	difference(){
		union(){
			rotate([-90,0,0]) translate([0,0,-10]) cylinder(r=Format+2,h=Digits*13+15,$fn=res3);
			translate([Format+3.75,-10,0]) rotate([-90,0,0]) cylinder(r=8,h=(Digits-.5)*13+15,$fn=res3);
			//echo(13*Digits+25);
			translate([-Format-5,-15,2]) cube([2*Format+20,13*Digits+25,2]);
		}
		for (i=[1:Digits]){
			translate([0,i*13-4,0]) {
				if (Format==10){
					rotate([0,-36,0]) cube([6,6,500], center=true);
				}else if (Format==8){
					rotate([0,-22.5,0]) cube([6,6,500], center=true);
				}else if (Format==16){
					rotate([0,-33.75,0]) cube([6,6,500], center=true);
				}
			}
		}
		//holes for mounting
		translate([-Format-3,-12,1]) cylinder(r=1,h=10,$fn=res1);
		translate([-Format-3,13*Digits+8,1]) cylinder(r=1,h=10,$fn=res1);
		translate([-Format-3,-13+(13*Digits+25)/2,1]) cylinder(r=1,h=10,$fn=res1);
		translate([-Format-3,-17+(13*Digits+25)/2,1]) cylinder(r=1,h=10,$fn=res1);
		translate([Format+13,-12,1]) cylinder(r=1,h=10,$fn=res1);
		translate([Format+13,13*Digits+8,1]) cylinder(r=1,h=10,$fn=res1);
		translate([Format+13,-13+(13*Digits+25)/2,1]) cylinder(r=1,h=10,$fn=res1);
		translate([Format+13,-17+(13*Digits+25)/2,1]) cylinder(r=1,h=10,$fn=res1);
		
		
		rotate([-90,0,0]) translate([0,0,-9]) cylinder(r=Format+.5,h=Digits*13+13,$fn=res3);
		translate([Format+3.75,-9,0]) rotate([-90,0,0]) cylinder(r=7,h=(Digits-.5)*13+13,$fn=res3);
		translate([-50,-50,-50]) cube([600,600,52]);
		if (Units==10 && Format==8){
			FeedHole(4);
		} else if (Units==25.4 && Format==8){
			FeedHole(2);
		} else if (Units==10 && Format==10){
			FeedHole(5);
		} else if (Units==25.4 && Format==10){
			FeedHole(2);
		} else if (Units==10 && Format==16){
			FeedHole(8);
		} else if (Units==25.4 && Format==16){
			FeedHole(3);
		}
		//if there is the external wheel option cut a hole for it
		if (ExternalWheel==1){
			translate([-Format*2,-8,-1]) cube([Format*2,8,Format]);
		}
	}
}
//Print Manual Wheel
module ManualWheel(){
	module Locate_and_Print(n){
		Rad=(n*Units)/(2*Pi);
		translate([-Rad-Format*1.5+0.01,0,0]) difference(){
			cylinder(r=Format*1.5,h=7,$fn=res3);
			cylinder(r=Shaft,h=16,$fn=res2,center=true);
		}
	}
	if (Units==10 && Format==8){
		Locate_and_Print(4);
	} else if (Units==25.4 && Format==8){
		Locate_and_Print(2);
	} else if (Units==10 && Format==10){
		Locate_and_Print(5);
	} else if (Units==25.4 && Format==10){
		Locate_and_Print(2);
	} else if (Units==10 && Format==16){
		Locate_and_Print(8);
	} else if (Units==25.4 && Format==16){
		Locate_and_Print(3);
	}
}
//PRINT ASSEMBLIES
//Drive Mechanism
module AssembledDriveWheel(){
	if (Units==10 && Format==8){
		Drive_Wheel(4);
		rotate([180,0,0]) Wheel_Cog(4);
		translate([Format+3.75,0,0]) Idle_Wheel(4);
	} else if (Units==25.4 && Format==8){
		Drive_Wheel(2);
		rotate([180,0,0]) Wheel_Cog(2);
		translate([Format+3.75,0,0]) Idle_Wheel(2);
	} else if (Units==10 && Format==10){
		Drive_Wheel(5);
		rotate([180,0,0]) Wheel_Cog(5);
		translate([Format+3.75,0,0]) Idle_Wheel(5);
	} else if (Units==25.4 && Format==10){
		Drive_Wheel(2);
		rotate([180,0,0]) Wheel_Cog(2);
		translate([Format+3.75,0,0]) Idle_Wheel(2);
	} else if (Units==10 && Format==16){
		Drive_Wheel(8);
		rotate([180,0,0]) Wheel_Cog(8);
		translate([Format+3.75,0,0]) Idle_Wheel(8);
	} else if (Units==25.4 && Format==16){
		Drive_Wheel(3);
		rotate([180,0,0]) Wheel_Cog(3);
		translate([Format+3.75,0,0]) Idle_Wheel(3);
	}
	
}
//Number Wheels
module AssembledWheel(){
	Wheel_Center();
	translate([0,0,8.01]) Wheel_Cog(Format);
	translate([0,0,-.01]) rotate([180,0,0]) Wheel_Cog(1);
}
module Assembled(){
	for (i=[1:Digits]){
		color("Blue") translate([0,13*i,0]) rotate([90,0,0]) AssembledWheel();
		color("green") translate([Format+3.75,13*(i-1)+4.75,0]) rotate([90,30,0]) Connecting_Cog();
	}
	color("red") rotate([90,0,0]) AssembledDriveWheel();
	color("grey") Body_Lower();
	Body_Upper();
	if (ExternalWheel==1){ translate([0,-.5,0]) rotate([90,0,0]) ManualWheel();}
}

//PRINT PARTS
module Parts_Wheel(){
	Wheel_Center();
	translate([Format*2.2,0,2]) rotate([0,180,0]) Wheel_Cog(Format);
	translate([-Format*2.2,0,2]) rotate([0,180,0]) Wheel_Cog(1);
	translate([Format*4+1,0,0]) Connecting_Cog();
}
module NumbersOnly(){ //Print only the numbered wheel parts
/*	Part List
	---------
	Digits x AssembledWheel()
		1 x Wheel_Center()
		1 x Wheel_Cog(1)
		1 x Wheel_Cog(Format)
	Digits x Connecting_Cog()
*/
	//Print Cogs and Gears
	translate([0,-((Digits-1)/2)*Format*2.2,0])
	for (i=[1:Digits]){
		translate([0,Format*(i-1)*2.2,0]) Parts_Wheel();
	}
	//print optional shaft
	if (Shaft==2){
		translate([0,-((Digits+1)/2)*(Format*2.2),0]) PrintShaft();
		translate([0,-((Digits+1)/2)*(Format*2.2)-8,0]) PrintShaft();
	}
}
module PartsDriveWheel(){
	//Drive wheel parts
	if (Units==10 && Format==8){
		Drive_Wheel(4);
		translate([-17,0,2]) rotate([0,180,0]) Wheel_Cog(4);
		translate([Format+3.75,0,0]) Idle_Wheel(4);
	} else if (Units==25.4 && Format==8){
		Drive_Wheel(2);
		translate([-20,0,2]) rotate([0,180,0])  Wheel_Cog(2);
		translate([Format+3.75,0,0]) Idle_Wheel(2);
	} else if (Units==10 && Format==10){
		Drive_Wheel(5);
		translate([-Format*2.2+3.75,0,2]) rotate([0,180,0])  Wheel_Cog(5);
		translate([Format+3.75,0,0]) Idle_Wheel(5);
	} else if (Units==25.4 && Format==10){
		Drive_Wheel(2);
		translate([-20,0,2]) rotate([0,180,0])  Wheel_Cog(2);
		translate([Format+3.75,0,0]) Idle_Wheel(2);
	} else if (Units==10 && Format==16){
		Drive_Wheel(8);
		translate([-Format*2.2+3.75,0,2]) rotate([0,180,0])  Wheel_Cog(8);
		translate([Format+3.75,0,0]) Idle_Wheel(8);
	} else if (Units==25.4 && Format==16){
		Drive_Wheel(3);
		translate([-Format*2.2+3.75,0,2]) rotate([0,180,0])  Wheel_Cog(3);
		translate([Format+3.75,0,0]) Idle_Wheel(3);
	}
	if (ExternalWheel==1){translate([0,Format*2.6,0]) ManualWheel();}
}
module Parts(){ //print all parts on a single bed
/*	Part List
	---------
	Digits x AssembledWheel()
		1 x Wheel_Center()
		1 x Wheel_Cog(1)
		1 x Wheel_Cog(Format)
	Digits x Connecting_Cog()
	1 x AssembledDriveWheel
		1 x Drive_Wheel(#)
		1 x Wheel_Cog(#)
		1 x Idle_Wheel(#)
			TABLE
			Units	Format	#
			8		10		4
			8		25.4	2
			10		10		5
			10		25.4	2
			16		10		8
			16		25.4	3
	1 x Body_Lower
	1 x Body_Upper (Split in half for printing
	(optional) 2 x Shafts
*/
	//Print Cogs and Gears
	translate([0,-((Digits-1)/2)*Format*2.2,0])
	for (i=[1:Digits]){
		translate([0,Format*(i-1)*2.2,0]) Parts_Wheel();
	}
	//Print Lower Body
	translate([-Format*5.75-5,-15*(Digits-1)/2,+3+Format]) rotate([0,0,0]) Body_Lower();
	//Print Upper Body (splint in half for easier printing)
	translate([(Format)*6.5,0,0]) rotate([0,0,90]) difference(){
		rotate([90,0,0]) translate([0,-(13*Digits)/2+2,0]) Body_Upper();
		translate([-50,-50,-100]) cube([100,100,100]);
	}
	translate([Format*6.5,0,0]) rotate([0,0,90]) difference(){
		rotate([-90,0,0]) translate([0,-(13*Digits)/2+2,0]) Body_Upper();
		translate([-50,-50,-100]) cube([100,100,100]);
	}
	//print optional shaft
	if (Shaft==2){
		translate([0,-((Digits+1)/2)*(Format*2.2),0]) PrintShaft();
		translate([0,-((Digits+1)/2)*(Format*2.2)-8,0]) PrintShaft();
	}
	translate([0,((Digits+1)/2)*(Format*2.2),0]) PartsDriveWheel();
}

res1=25;
res2=50;
res3=100;
Pi=3.141592653589793238462643382795;

// [0:Assembled View,1:All Parts on 1 Platform,2:Numbered Gears Only, 3:Lower Body, 4:Upper Body, 5:Drive Wheels]
if (Print==1){
	Parts();
} else if(Print==0) {
	Assembled();
} else if (Print==2){
	NumbersOnly();
}else if (Print==3){
	//Print Lower Body
	translate([0,0,+3+Format]) rotate([0,0,0]) Body_Lower();
}else if (Print==4){
	//Print Upper Body (splint in half for easier printing)
	rotate([0,0,90]) difference(){
		rotate([90,0,0]) translate([0,-(13*Digits)/2+2,0]) Body_Upper();
		translate([-50,-50,-100]) cube([100,100,100]);
	}
	rotate([0,0,90]) difference(){
		rotate([-90,0,0]) translate([0,-(13*Digits)/2+2,0]) Body_Upper();
		translate([-50,-50,-100]) cube([100,100,100]);
	}
}else if (Print==5){
	PartsDriveWheel();
}

if (Build==1){
	%translate([0,0,-.1]) cube([BuildSize,BuildSize,.1],center=true);
}
Font="write/Letters.dxf";

/*
	Assembly notes
	Single nub gear needs to be placed between
		Oct - 4 and 5
		Dec - 5 and 6
		Hex - 9 and A
	
	Part List
	---------
x	Digits x AssembledWheel()
x		1 x Wheel_Center()
x		1 x Wheel_Cog(1)
x		1 x Wheel_Cog(Format)
x	Digits x Connecting_Cog()
	1 x AssembledDriveWheel
		1 x Drive_Wheel(#)
		1 x Wheel_Cog(#)
		1 x Idle_Wheel(#)
			TABLE
			Units	Format	#
			8		10		4
			8		25.4	2
			10		10		5
			10		25.4	2
			16		10		8
			16		25.4	3
x	1 x Body_Lower
x	1 x Body_Upper (Split in half for printing
*/
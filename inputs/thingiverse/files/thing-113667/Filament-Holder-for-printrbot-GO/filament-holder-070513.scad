//filament holder for printrbot GO design by John Davis 5-26-13
//to be used in conjunction with corner protectors
//www.ei8htohms.tinyparts.net

/*[Overall Dimensions]*/
//The diameter of the bar that will hold the filament or spool
Bar_Diameter = 18;
//The thickness of the arms
Arm_Thickness = 10;
//How thick should the support material around the corner protector be
Brim = 3;
//How far out does the bar extend from side of the box
Extension = 100;
//How large of a hole does the bungie cord need to pass through
Bungie_Hole = 12;
//How thick are the snap fit pins
Pin_Thickness=6;

/*[Corner Protector Dimensions]*/
//What is the size of the corner protector
Corner_Size = 31;
//What is the thickness of the corner protector
Corner_Thickness = 6;
 




/*[Printer Settings]*/
//Clearance for interlocking parts
Clearance = 0.1;
//To control the number facets rendered, fine ~ 0.1 coarse ~1.0. 0.3 is fine for home printers.
$fs = 0.3;


/*[Hidden]*/
//leave $fn disabled, do not change
$fn = 0;
//leave $fa as is, do not change
$fa = 0.01;
//padding to insure manifold, ignore
Padding = 0.06; 

//Bar - split in two
translate([Bar_Diameter/2-Brim,Corner_Size+4*Brim+Bungie_Hole+1,0]){
	//Bar side 1
	difference(){
		intersection(){
			rotate([0,90,0])
			union(){
				cylinder(r=Bar_Diameter/2,h=140-Arm_Thickness);
				translate([0,0,-Arm_Thickness])
				cylinder(r=Bar_Diameter/2-Brim-Clearance,h=140+Arm_Thickness);
			}	
			translate([-Arm_Thickness-Padding,-Bar_Diameter/2-Padding,0])	
			cube([140+Arm_Thickness+Padding*2,Bar_Diameter+Padding,Bar_Diameter/2+Padding]);
		}
		translate([140/4-Arm_Thickness/2,0,0])
		cube([Pin_Thickness+Clearance,Pin_Thickness+Clearance,Bar_Diameter-2*Brim+Clearance*2],center=true);
		translate([3*140/4-Arm_Thickness/2,0,0])
		cube([Pin_Thickness+Clearance,Pin_Thickness+Clearance,Bar_Diameter-2*Brim+Clearance*2],center=true);
	}

	//Bar side 2
	translate([0,Bar_Diameter+1,0])
	difference(){
		intersection(){
			rotate([0,90,0])
			union(){
				cylinder(r=Bar_Diameter/2,h=140-Arm_Thickness);
				translate([0,0,-Arm_Thickness])
				cylinder(r=Bar_Diameter/2-Brim-Clearance,h=140+Arm_Thickness);
			}	
			translate([-Arm_Thickness-Padding,-Bar_Diameter/2-Padding,0])	
			cube([140+Arm_Thickness+Padding*2,Bar_Diameter+Padding,Bar_Diameter/2+Padding]);
		}
		translate([140/4-Arm_Thickness/2,0,0])
		cube([Pin_Thickness+Clearance,Pin_Thickness+Clearance,Bar_Diameter-2*Brim+Clearance*2],center=true);
		translate([3*140/4-Arm_Thickness/2,0,0])
		cube([Pin_Thickness+Clearance,Pin_Thickness+Clearance,Bar_Diameter-2*Brim+Clearance*2],center=true);
	}

	//Snapfit Pins
	translate([-Arm_Thickness,-Bar_Diameter/2-Pin_Thickness*2, 0])
	cube([Bar_Diameter-2*Brim-Clearance*2,Pin_Thickness-Clearance,Pin_Thickness-Clearance]);

	translate([-Arm_Thickness,-Bar_Diameter/2-Pin_Thickness*4, 0])
	cube([Bar_Diameter-2*Brim-Clearance*2,Pin_Thickness-Clearance,Pin_Thickness-Clearance]);
}




//Left side
translate([0,-Bar_Diameter/2-2*Brim-3,0])
difference(){
	union(){
		cylinder (r=Bar_Diameter/2, h = Arm_Thickness);
		linear_extrude(height = Arm_Thickness)
		polygon([[0,-(Bar_Diameter/2-Brim)],[0,Bar_Diameter/2-Brim],[Extension,Bar_Diameter/2-Brim],[Extension,Bar_Diameter/2-4*Brim-Corner_Size-Bungie_Hole]]);
		translate([Extension-Padding,Bar_Diameter/2-Brim,0])
		intersection(){
			cylinder(r=Corner_Size+3*Brim+Bungie_Hole,h=Arm_Thickness);
			difference(){
				translate([0,-(Corner_Size+Bar_Diameter+Brim*4)-Padding,0])
				cube([Corner_Size+Bar_Diameter+Brim*4+Padding,Corner_Size+Bar_Diameter+Brim*4+Padding,Arm_Thickness]);
				translate([Brim,-(Corner_Size+Clearance+Brim),Arm_Thickness/2-Corner_Thickness-Clearance])
				cube([Corner_Size+Clearance,Corner_Size+Clearance,Corner_Size+Clearance]);	
				translate([Brim+Corner_Thickness+Clearance,-(Corner_Size+Bar_Diameter+2*Brim+Padding),Arm_Thickness/2])
				cube([Corner_Size+Bar_Diameter+2*Brim+Padding,Corner_Size+Bar_Diameter+Padding+Brim-Corner_Thickness+Clearance,Arm_Thickness]);
			}
		}	
		translate([Extension+Corner_Size+Brim*9/8,Bar_Diameter/2-Brim,Arm_Thickness/2])
		rotate([0,90,0])
		cylinder(r=Arm_Thickness/2, h = 2*Brim);		
	}
	translate([0,0,-Padding])
	cylinder (r=Bar_Diameter/2-Brim+Clearance, h = Arm_Thickness + 2 * Padding);
	translate([Extension-Bungie_Hole/3,Bar_Diameter/2-Brim-Brim-Corner_Size-Bungie_Hole/3,-Padding])
	cylinder(r=Bungie_Hole/2+Clearance, h = Arm_Thickness + 2 * Padding);
}

//Right side
translate([3*Brim,0,0])
mirror([0,1,0]){
	difference(){
		union(){
			cylinder (r=Bar_Diameter/2, h = Arm_Thickness);
			linear_extrude(height = Arm_Thickness)
			polygon([[0,-(Bar_Diameter/2-Brim)],[0,Bar_Diameter/2-Brim],[Extension,Bar_Diameter/2-Brim],[Extension,Bar_Diameter/2-4*Brim-Corner_Size-Bungie_Hole]]);
			translate([Extension-Padding,Bar_Diameter/2-Brim,0])
			intersection(){
				cylinder(r=Corner_Size+3*Brim+Bungie_Hole,h=Arm_Thickness);
				difference(){
					translate([0,-(Corner_Size+Bar_Diameter+Brim*4)-Padding,0])
					cube([Corner_Size+Bar_Diameter+Brim*4+Padding,Corner_Size+Bar_Diameter+Brim*4+Padding,Arm_Thickness]);
					translate([Brim,-(Corner_Size+Clearance+Brim),Arm_Thickness/2-Corner_Thickness-Clearance])
					cube([Corner_Size+Clearance,Corner_Size+Clearance,Corner_Size+Clearance]);	
					translate([Brim+Corner_Thickness+Clearance,-(Corner_Size+Bar_Diameter+2*Brim+Padding),Arm_Thickness/2])
					cube([Corner_Size+Bar_Diameter+2*Brim+Padding,Corner_Size+Bar_Diameter+Padding+Brim-Corner_Thickness+Clearance,Arm_Thickness]);
				}
			}	
			translate([Extension+Corner_Size+Brim*9/8,Bar_Diameter/2-Brim,Arm_Thickness/2])
			rotate([0,90,0])
			cylinder(r=Arm_Thickness/2, h = 2*Brim);		
		}
		translate([0,0,-Padding])
		cylinder (r=Bar_Diameter/2-Brim+Clearance, h = Arm_Thickness + 2 * Padding);
		translate([Extension-Bungie_Hole/3,Bar_Diameter/2-Brim-Brim-Corner_Size-Bungie_Hole/3,-Padding])
		cylinder(r=Bungie_Hole/2+Clearance, h = Arm_Thickness + 2 * Padding);
	}
}
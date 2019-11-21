//Length of Leg
Length=46;
//Depth of Leg
Depth=24;
//Thickness at narrow side
Thickness=2.1;
//Corner radius
Corner_Radius=4;
//Length of cut away section
Leg_Length=11;
//Width of cut away section
Leg_Width=4;
// Complete height of leg
Total_Height=5.3;
//Diameter of pin
Pin_Diameter=3.5;
//Length of pin
Pin_Length=3.5;
//Height of pinn from bottom of foot
Pin_Height=1.8;
//Gap for pin support structure
Pin_Support_Gap=1;

difference(){
	union(){
		cube([Length,Depth-Pin_Diameter/2-Pin_Height,Thickness]);
		translate([-Pin_Length,Depth-Pin_Length,Pin_Height+Pin_Diameter/2])rotate(a=[0,90-0])cylinder(r=Pin_Diameter/2,h=Length+Pin_Length*2,$fn=30);
		translate([0,Depth-Pin_Length,Pin_Height+Pin_Diameter/2])rotate(a=[0,90-0])cylinder(r=Pin_Diameter/2+Pin_Height,h=Length,$fn=30);
	}
	difference(){
		translate([-Thickness,-Thickness,-Thickness/2])cube([Corner_Radius+Thickness,Corner_Radius+Thickness,Thickness*2]);
		translate([Corner_Radius,Corner_Radius,-Thickness])cylinder(r=Corner_Radius,h=Thickness*3,$fn=30);
	}
	translate([Length,0,0]){
		mirror([1,0,0]){
			difference(){
				translate([-Thickness,-Thickness,-Thickness/2])cube([Corner_Radius+Thickness,Corner_Radius+Thickness,Thickness*2]);
				translate([Corner_Radius,Corner_Radius,-Thickness])cylinder(r=Corner_Radius,h=Thickness*3,$fn=30);
			}
		}
	}
	translate([Leg_Width,Depth-Leg_Length,-Total_Height])cube([Leg_Width/2,Leg_Length*2,Total_Height*2+Pin_Diameter+Pin_Height*2]);
	translate([Length-Leg_Width*1.5,Depth-Leg_Length,-Total_Height])cube([Leg_Width/2,Leg_Length*2,Total_Height*2+Pin_Diameter+Pin_Height*2]);
	translate([Leg_Width,Leg_Width,Thickness*1.1])cube([Length-Leg_Width*2,Depth,Pin_Diameter+Pin_Height*2]);
}
translate([-Pin_Length,Depth-Pin_Diameter*.75-Pin_Height,0])cube([Pin_Length-Pin_Support_Gap,Pin_Diameter/2,Pin_Diameter/2+Pin_Height]);
translate([Length+Pin_Support_Gap,Depth-Pin_Diameter*.75-Pin_Height,0])cube([Pin_Length-Pin_Support_Gap,Pin_Diameter/2,Pin_Diameter/2+Pin_Height]);
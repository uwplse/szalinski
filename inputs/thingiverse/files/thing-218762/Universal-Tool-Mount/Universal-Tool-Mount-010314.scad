//Universal Tool Mount by John Davis 8-4-13

/*[Number of Clips]*/
//Number of Clips
Clip_Quantity=3;//[1,2,3]

/*[Dimensions of 1st Clip]*/
//1st Tool width
Tool_Width1=6;
//1st Tool thickness
Tool_Thickness1=4;
//Angle of 1st clip opening
Angle1=45;
//1st Clip thickness
Clip_Thickness1=1.34;
//1st Clip height
Clip_Height1=6;
//Clearance between first and second clips
Clip_Clearance1=2;
//Elevation of 1st Clip
Clip_Elev1=0;

/*[Dimensions of 2nd Clip]*/
//2nd Tool width
Tool_Width2=11.7;
//2nd Tool thickness
Tool_Thickness2=11.7;
//Angle of 2nd clip opening
Angle2=45;
//2nd Clip thickness
Clip_Thickness2=4;
//2nd Clip height
Clip_Height2=8;
//Clearance between second and third clips
Clip_Clearance2=2;
//Elevation of 2nd Clip
Clip_Elev2=6;




/*[Dimensions of 3rd Clip]*/
//3rd Tool width
Tool_Width3=12.4;
//3rd Tool thickness
Tool_Thickness3=12.4;
//Angle of 3rd clip opening
Angle3=45;
//3rd Clip thickness
Clip_Thickness3=1.34;
//3rd Clip height
Clip_Height3=10;
//Elevation of 3rd Clip
Clip_Elev3=0;

//Thickness of mount base
Thickness = 2.68;
//Height of base
Height = max(Clip_Height1,Clip_Height2,Clip_Height3);

/*[Screw Dimensions]*/
//Screw shaft diameter
Screw_Shaft_Diameter = 2.5; 
//Screw head diameter
Screw_Head_Diameter = 4.3;
//Length of screw hole 
Screw_Length = Thickness;
//Screw head thickness or depth of head recesss for countersunk 
Screw_Head_Height = 1;
//Countersunk (1) or flat head (0)? 
Countersink = 1; //[0,1] 

/*[Printer Settings]*/
//To control the number facets rendered, fine ~ 0.1 coarse ~1.0. 0.3 is fine for home printers.
$fs = 0.3;

/*[Hidden]*/
//leave $fn disabled, do not change
$fn = 0;
//leave $fa as is, do not change
$fa = 0.01;
//padding to insure manifold, ignore
Padding = 0.01; 

if (Clip_Quantity==1) assign(O1=1,O2=0,O3=0, Height=Clip_Height1){
mount(O1,O2,O3,Height);
}
else if (Clip_Quantity==2) assign(O1=0,O2=1,O3=0,Height=max(Clip_Height1,Clip_Height2)){
mount(O1,O2,O3,Height);
}
else assign(O1=0,O2=1,O3=1,Height=max(Clip_Height1,Clip_Height2,Clip_Height3)){
mount(O1,O2,O3,Height);
}

module mount(O1,O2,O3,Height){
rotate([90,0,0])
difference(){
	union(){
		//mount base
		hull(){
			translate([-Screw_Head_Diameter/2-O1*(Tool_Width1/2+Clip_Thickness1)-O2*(Tool_Width1+Clip_Thickness1+Clip_Thickness1+Clip_Clearance1+Tool_Width2/2+Clip_Thickness2),0,0])
			cylinder(r=Height/2,h=Thickness);
			translate([O1*(Tool_Width1/2+Clip_Thickness1)+O2*(Tool_Width2/2+Clip_Thickness2)+O3*(Clip_Clearance2+2*Clip_Thickness3+Tool_Width3)+Screw_Head_Diameter/2,0,0])
			cylinder(r=Height/2,h=Thickness);
		}
		
		//1st clip
		translate([-O2*Tool_Width2/2-O2*Clip_Thickness2-O2*Clip_Clearance1-O2*Tool_Width1/2-O2*Clip_Thickness1,-(Height-Clip_Height1)/2,Thickness])
		clip(Tool_Width1, Tool_Thickness1, Angle1, Clip_Thickness1, Clip_Height1, Clip_Elev1);	

		//2nd clip
		translate([0,-(Height-Clip_Height2)/2,Thickness])
		clip(Tool_Width2*O2, Tool_Thickness2*O2, Angle2, Clip_Thickness2*O2, Clip_Height2*O2, Clip_Elev2*O2);

		//3rd clip
		translate([Tool_Width2/2+Clip_Thickness2+Clip_Clearance2+Clip_Thickness3+Tool_Width3/2,-(Height-Clip_Height3)/2,Thickness])
		clip(Tool_Width3*O3, Tool_Thickness3*O3, Angle3, Clip_Thickness3*O3, Clip_Height3*O3, Clip_Elev3*O3);
	}
	
	//screw holes for mount base
	translate([-Screw_Head_Diameter/2-O1*(Tool_Width1/2+Clip_Thickness1)-O2*(Tool_Width1+Clip_Thickness1+Clip_Thickness1+Clip_Clearance1+Tool_Width2/2+Clip_Thickness2),0,Thickness])
	rotate([180,0,0])
	screw_hole(Screw_Length);
	translate([O1*(Tool_Width1/2+Clip_Thickness1)+O2*(Tool_Width2/2+Clip_Thickness2)+O3*(Clip_Clearance2+2*Clip_Thickness3+Tool_Width3)+Screw_Head_Diameter/2,0,Thickness])
	rotate([180,0,0])
	screw_hole(Screw_Length);
}
}

module clip(Tool_Width, Tool_Thickness, Angle, Clip_Thickness, Clip_Height, Clip_Elev){
	
	union(){
		difference(){
			union(){
				hull(){
					translate([-(Tool_Width/2-Tool_Thickness/2),0,Tool_Thickness/2+Clip_Elev])
					rotate([-90,0,0])
					cylinder(r=Tool_Thickness/2+Clip_Thickness,h=Clip_Height, center=true);
					translate([Tool_Width/2-Tool_Thickness/2,0,Tool_Thickness/2+Clip_Elev])
					rotate([-90,0,0])
					cylinder(r=Tool_Thickness/2+Clip_Thickness,h=Clip_Height, center=true);
				}
				if(Clip_Elev>0) translate([-Tool_Width/2,-Clip_Height/2,-Padding])
				cube([Tool_Width,Clip_Height,Clip_Elev+Tool_Thickness/2+2*Padding]);
			}
			hull(){
				translate([-(Tool_Width/2-Tool_Thickness/2),0,Tool_Thickness/2+Clip_Elev])
				rotate([-90,0,0])
				cylinder(r=Tool_Thickness/2,h=Clip_Height+Padding*2, center=true);
				translate([Tool_Width/2-Tool_Thickness/2,0,Tool_Thickness/2+Clip_Elev])
				rotate([-90,0,0])
				cylinder(r=Tool_Thickness/2,h=Clip_Height+Padding*2, center=true);
			}
			translate([0,0,Tool_Thickness/2+Clip_Elev])
			rotate([90,0,0])
			linear_extrude(height=Clip_Height+Padding*2, center=true)
			polygon(points=[
				[-(Tool_Width/2-Tool_Thickness/2),0],
				[-(Tool_Width/2-Tool_Thickness/2)-sin(Angle)*(Tool_Thickness/2+Clip_Thickness+Padding),cos(Angle)*(Tool_Thickness/2+Clip_Thickness+Padding)],
				[-(Tool_Width/2-Tool_Thickness/2)-sin(Angle)*(Tool_Thickness/2+Clip_Thickness+Padding),cos(Angle)*(Tool_Thickness/2+Clip_Thickness+Padding)+Tool_Thickness/2],
				[(Tool_Width/2-Tool_Thickness/2)+sin(Angle)*(Tool_Thickness/2+Clip_Thickness+Padding),cos(Angle)*(Tool_Thickness/2+Clip_Thickness+Padding)+Tool_Thickness/2],
				[(Tool_Width/2-Tool_Thickness/2)+sin(Angle)*(Tool_Thickness/2+Clip_Thickness+Padding),cos(Angle)*(Tool_Thickness/2+Clip_Thickness+Padding)],
				[Tool_Width/2-Tool_Thickness/2,0]]);
		}
		translate([-(Tool_Width/2-Tool_Thickness/2)-sin(Angle)*(Tool_Thickness/2+(3*Clip_Thickness/4)),0,(Tool_Thickness/2+cos(Angle)*(Tool_Thickness/2+(3*Clip_Thickness/4)))+Clip_Elev])
		rotate([90,0,0])
		cylinder(r=(3*Clip_Thickness/4),h=Clip_Height+Padding*2,center=true);
		translate([(Tool_Width/2-Tool_Thickness/2)+sin(Angle)*(Tool_Thickness/2+(3*Clip_Thickness/4)),0,(Tool_Thickness/2+cos(Angle)*(Tool_Thickness/2+(3*Clip_Thickness/4)))+Clip_Elev])
		rotate([90,0,0])
		cylinder(r=(3*Clip_Thickness/4),h=Clip_Height+Padding*2,center=true);
	}
}

module screw_hole(L){
 	translate([0,0,-Padding])
	union() {
   	cylinder(h=L+Padding*2, r=Screw_Shaft_Diameter/2);
      cylinder(h=Screw_Head_Height, r=Screw_Head_Diameter/2);
		if (Countersink == 1) 
			{translate([0,0,Screw_Head_Height-Padding])
			cylinder(h=Screw_Head_Diameter/2-Screw_Shaft_Diameter/2+Padding, r1=Screw_Head_Diameter/2, r2=Screw_Shaft_Diameter/2);
			}
    }
}

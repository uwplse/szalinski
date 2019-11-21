//fancy 3d printable cord stopper design by John Davis 5-26-13
//this version has a provision for an additional circle spring loop and grippy teeth on either one or both sides
//www.ei8htohms.tinyparts.net

/*[Overall Dimensions]*/
//Approximate total length of the stopper.
Stopper_Length = 21; 
//The housing that the plunger fits into - must be approx 75% of Stopper Height or less
Housing_Width = 15;  
//The overall thickness should be less than Housing Width for print stability
Stopper_Thickness = 13; 
//Determines strength of circle spring - set to your extrusion width and add 2nd spring for more tension
Stopper_Spring_Width = 0.6;
//1 or 2 circle springs? 2nd spring will increase overall height by twice spring thickness
Number_of_Springs = 2;//[1,2]
//Determines the tightness of snap rotation after inserting plunger in housing - too tight may break spring(s) when installing
Twist_Snap = 0.6; 


/*[Cord Hole Dimensions]*/
//For cord to fit through - must be approx 40% stopper thickness or less
Stopper_Hole_Width = 4;
//For cord to fit through - must be greater than Stopper Hole Width 
Stopper_Hole_Length = 6;
//To better grip cord. 0=no teeth, 1=teeth on one side, 2=both sides 
Teeth = 1; 


/*[Printer Settings]*/
//For plunger to slide in housing - you'll probably have to do a little sanding or filing also for smooth action 
Clearance = 0.15; 
//To control the number facets rendered, fine ~ 0.1 coarse ~1.0. 0.3 is fine for home printers.
$fs = 0.3;

/*[Hidden]*/
//leave $fn disabled, do not change
$fn = 0;
//leave $fa as is, do not change
$fa = 0.01;
//padding to insure manifold, ignore
Padding = 0.01; 


//stopper
//uncomment these two lines to separate the parts for printing
translate([0,9/8*Stopper_Length,1/4*Stopper_Thickness-Clearance/2])
rotate([90,0,0])

//uncomment these two lines to show insertion
//translate([1/2*Stopper_Thickness,Stopper_Thickness/2,Stopper_Thickness/2])
//rotate([90,0,0])

//uncomment this line to show the assembled unit
//translate([5/16*Stopper_Thickness,0,0])

union(){
	difference(){
		union(){
			translate([0,-(1/4*Stopper_Thickness-Clearance/2),Stopper_Thickness/2-(1/16*Stopper_Thickness-Clearance/2)])
			cube([3/4*Stopper_Length,1/2*Stopper_Thickness-Clearance,1/8*Stopper_Thickness]);
			translate([0,0,Stopper_Thickness/2-(1/16*Stopper_Thickness)])
			rotate([0,90,0])
			cylinder(r=1/4*Stopper_Thickness-Clearance/2, h=3/4*Stopper_Length);
			translate([0,0,Stopper_Thickness/2+(1/16*Stopper_Thickness)])
			rotate([0,90,0])
			cylinder(r=1/4*Stopper_Thickness-Clearance/2, h=3/4*Stopper_Length);
			translate([13/16*Stopper_Length-Padding,0,Stopper_Thickness/2])
			cube([1/8*Stopper_Length,sqrt(pow(Stopper_Thickness/2,2)/2)+Twist_Snap,sqrt(pow(Stopper_Thickness/2,2)/2)+Twist_Snap],center=true);
			translate([7/8*Stopper_Length-Padding,-(1/4*Stopper_Thickness-Clearance/2),5/16*Stopper_Thickness])
			cube([3*Stopper_Spring_Width,1/2*Stopper_Thickness-Clearance,3/8*Stopper_Thickness]);
			translate([7/8*Stopper_Length-Padding,0,5/16*Stopper_Thickness])
			rotate([0,90,0])
			cylinder(r=1/4*Stopper_Thickness-Clearance/2, h=3*Stopper_Spring_Width);
			translate([7/8*Stopper_Length-Padding,0,11/16*Stopper_Thickness])
			rotate([0,90,0])
			cylinder(r=1/4*Stopper_Thickness-Clearance/2, h=3*Stopper_Spring_Width);
		}
		translate([7/16*Stopper_Length,0,Stopper_Thickness/2])
		union(){
			cube([Stopper_Hole_Length-Stopper_Hole_Width,Stopper_Hole_Width,Stopper_Thickness+Padding*2],center=true);
			translate([-(Stopper_Hole_Length-Stopper_Hole_Width)/2,0,0])
			cylinder(r=Stopper_Hole_Width/2, h=Stopper_Thickness+Padding*2, center =true);
			translate([(Stopper_Hole_Length-Stopper_Hole_Width)/2,0,0])
			cylinder(r=Stopper_Hole_Width/2, h=Stopper_Thickness+Padding*2, center =true);
		}
		translate([-Padding,0,1/2*Stopper_Thickness])
		rotate([0,90,0])
		cylinder(r=3/8*Stopper_Thickness, h=3/32*Stopper_Length+Padding);
	}
	//stopper teeth
	if (Teeth>0){
	translate([7/16*Stopper_Length-Stopper_Hole_Length/2,-5/24*Stopper_Hole_Width,1/4*Stopper_Thickness])
	rotate([180,0,0])	
	tooth(); 
	translate([7/16*Stopper_Length-Stopper_Hole_Length/2,5/24*Stopper_Hole_Width,1/4*Stopper_Thickness])
	rotate([180,0,0])	
	tooth();	
	}
	if (Teeth>1){
	translate([7/16*Stopper_Length-Stopper_Hole_Length/2,-5/24*Stopper_Hole_Width,3/4*Stopper_Thickness])
	rotate([0,0,0])	
	tooth(); 
	translate([7/16*Stopper_Length-Stopper_Hole_Length/2,5/24*Stopper_Hole_Width,3/4*Stopper_Thickness])
	rotate([0,0,0])	
	tooth(); 
	}		
}


	

//housing and spring
union(){
	//housing
	difference(){
		union(){
			translate([0,-(Housing_Width-Stopper_Thickness)/2,0])
			cube([3/4*Stopper_Length,Housing_Width-Stopper_Thickness,Stopper_Thickness]);
			translate([0,-(Housing_Width-Stopper_Thickness)/2,Stopper_Thickness/2])
			rotate([0,90,0]) 
			cylinder(r=Stopper_Thickness/2, h=3/4*Stopper_Length);
			translate([0,(Housing_Width-Stopper_Thickness)/2,Stopper_Thickness/2])
			rotate([0,90,0]) 
			cylinder(r=Stopper_Thickness/2, h=3/4*Stopper_Length);
		}
		translate([-Padding,0,Stopper_Thickness/2])
		rotate([0,90,0])
		cylinder(r=5/16*Stopper_Thickness, h=3/4*Stopper_Length+Padding*2);//hole for stopper
		translate([3/8*Stopper_Length,0,Stopper_Thickness/2])
		//hole for cords
		union(){
			cube([Stopper_Hole_Length-Stopper_Hole_Width,Stopper_Hole_Width,Stopper_Thickness+Padding*2],center=true);
			translate([-(Stopper_Hole_Length-Stopper_Hole_Width)/2,0,0])
			cylinder(r=Stopper_Hole_Width/2, h=Stopper_Thickness+Padding*2, center =true);
			translate([(Stopper_Hole_Length-Stopper_Hole_Width)/2,0,0])
			cylinder(r=Stopper_Hole_Width/2, h=Stopper_Thickness+Padding*2, center =true);
		}
		
		translate([Stopper_Length/2,0,-Padding])
		rotate_extrude () 
   	translate([Stopper_Length/2-Stopper_Spring_Width/2, 0, 0])
   	square([Housing_Width, Stopper_Thickness+Padding*2]);
	}
	//housing teeth
	if (Teeth>0) { 
		translate([3/8*Stopper_Length+Stopper_Hole_Length/2,0,0])
		rotate([180,0,180])	
		tooth(); 
	}
	if (Teeth>1) {
		translate([3/8*Stopper_Length+Stopper_Hole_Length/2,0,Stopper_Thickness])
		rotate([0,0,180])	
		tooth(); 
	}

	//circle spring
	difference(){
		if (Number_of_Springs == 1) {
		translate([Stopper_Length/2,0,0])
		rotate_extrude () 
   	translate([Stopper_Length/2-Stopper_Spring_Width, 0, 0])
   	square([Stopper_Spring_Width, Stopper_Thickness]);
		}
		if (Number_of_Springs == 2) {
		translate([Stopper_Length/2+Stopper_Spring_Width,0,0])
		rotate_extrude () 
   	translate([Stopper_Length/2-2*Stopper_Spring_Width, 0, 0])
   	square([Stopper_Spring_Width, Stopper_Thickness]);
		}
		
		union(){
			translate([9/10*Stopper_Length,-1/16*Stopper_Thickness,1/4*Stopper_Thickness])
			cube([1/5*Stopper_Length, 1/8*Stopper_Thickness, 1/2*Stopper_Thickness]);
			translate([9/10*Stopper_Length,-1/16*Stopper_Thickness,1/2*Stopper_Thickness])
			rotate([0,90,0])
			cylinder(r=1/4*Stopper_Thickness, h=1/5*Stopper_Length);
			translate([9/10*Stopper_Length,1/16*Stopper_Thickness,1/2*Stopper_Thickness])
			rotate([0,90,0])
			cylinder(r=1/4*Stopper_Thickness, h=1/5*Stopper_Length);
		}
		translate([-Padding,0,Stopper_Thickness/2])
		rotate([0,90,0])
		cylinder(r=5/16*Stopper_Thickness, h=3/4*Stopper_Length+Padding*2);
	}

	//2nd circle spring
	if (Number_of_Springs == 2) {
		difference(){
			translate([Stopper_Length/2+Stopper_Spring_Width,0,0])
			scale(v=[Stopper_Length/(Stopper_Length+Stopper_Spring_Width),1,1])
			rotate_extrude () 
   		translate([Stopper_Length/2+Stopper_Spring_Width/2, 0, 0])
   		square([Stopper_Spring_Width, Stopper_Thickness]);
			union(){
				translate([9/10*Stopper_Length,-1/16*Stopper_Thickness,1/4*Stopper_Thickness])
				cube([1/5*Stopper_Length, 1/8*Stopper_Thickness, 1/2*Stopper_Thickness]);
				translate([9/10*Stopper_Length,-1/16*Stopper_Thickness,1/2*Stopper_Thickness])
				rotate([0,90,0])
				cylinder(r=1/4*Stopper_Thickness, h=1/5*Stopper_Length);
				translate([9/10*Stopper_Length,1/16*Stopper_Thickness,1/2*Stopper_Thickness])
				rotate([0,90,0])
				cylinder(r=1/4*Stopper_Thickness, h=1/5*Stopper_Length);
			}
			translate([-Padding,0,Stopper_Thickness/2])
			rotate([0,90,0])
			cylinder(r=5/16*Stopper_Thickness, h=3/4*Stopper_Length+Padding*2);
		}
	}
} 


module tooth(){
	difference(){
		translate([0,0,-1/16*Stopper_Length])
		linear_extrude(height = 1/16*Stopper_Length)
		polygon(points=[[0,-1/6*Stopper_Hole_Width],[1/3*Stopper_Hole_Width,0],[0,1/6*Stopper_Hole_Width]]);
		translate([0,-1/6*Stopper_Hole_Width,-1/16*Stopper_Length])
		rotate([0,60,0])
		cube([1/4*Stopper_Hole_Width,1/2*Stopper_Hole_Width,Stopper_Hole_Width]);
	}
}

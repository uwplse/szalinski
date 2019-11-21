
/*Corner support/protector by ei8htohms.tinypart.net - 7-4-13*/

/*[General]*/
//Overall size of corner support
Corner_Size = 31;
//Thickness of support
Thickness = 6; 
//Percentage of thickness to make fillet radius (how rounded)
Fillet_Percentage = 80;//[0:100] 

/*[Screw Dimensions]*/
//Screw shaft diameter
Screw_Shaft_Diameter = 3;
//Screw head diameter 
Screw_Head_Diameter = 5;
//Enter "yes" for countersunk screws, "no" for flat 
Countersink = "Yes";//[Yes,No] 

/*[Screw Placement]*/
//Screw head thickness or depth of head recesss for countersunk
Screw_Head_Thickness = 2; 
//How far from the edge of the protected object should the screws be inset
Distance_From_Edge_To_Screw = 13; 



/*[Resolution]*/
//To control the number facets rendered, fine ~ 0.1 coarse ~1.0. 0.3 is fine for home printers.
$fs = 0.3;

/*[Hidden]*/
//Fillet radius, do not change
fRad = Thickness * (Fillet_Percentage / 100); 
//leave $fn disabled, do not change
$fn = 0;
//leave $fa as is, do not change
$fa = 0.01;
//padding to insure manifold, do not change
Padding = 0.01; 


difference(){
    translate([-Thickness, -Thickness, -Thickness]) cube([Corner_Size, Corner_Size, Corner_Size]);
	 cube([Corner_Size-Thickness+Padding, Corner_Size-Thickness+Padding, Corner_Size-Thickness+Padding]);

    //Add screw holes
    translate ([Distance_From_Edge_To_Screw,-(Thickness/2),Distance_From_Edge_To_Screw]) 
    rotate([-90,0,0]) 
    screw_hole(); //xz plane screw hole
    translate ([Distance_From_Edge_To_Screw,Distance_From_Edge_To_Screw,-(Thickness/2)]) 
    rotate([0,0,0]) 
    screw_hole(); //xy plane screw hole
    translate ([-(Thickness/2),Distance_From_Edge_To_Screw,Distance_From_Edge_To_Screw]) 
    rotate([0,90,0]) 
    screw_hole(); //yz plane screw hole

    //Add fillet edges
    translate([-Thickness,-Thickness,-Thickness])
    rotate([0,0,0])
    fillet(); //z axis fillet
    translate([-Thickness,-Thickness,-Thickness])
    rotate([90,0,90])
    fillet(); //x axis fillet
    translate([-Thickness,-Thickness,-Thickness])
    rotate([-90,-90,0])
    fillet(); //y axis fillet
    translate([-Thickness,-Thickness,Corner_Size-Thickness])
    rotate([0,90,0])
    fillet(); //x axis z offset fillet
    translate([Corner_Size-Thickness,-Thickness,-Thickness])
    rotate([0,0,90])
    fillet(); //z axis x offset fillet
    translate([-Thickness,-Thickness,Corner_Size-Thickness])
    rotate([-90,0,0])
    fillet(); //y axis z offset fillet
    translate([-Thickness,Corner_Size-Thickness,-Thickness])
    rotate([0,0,-90])
    fillet(); //z axis y offset fillet
    translate([-Thickness,Corner_Size-Thickness,-Thickness])
    rotate([180,-90,0])
    fillet(); //x axis y offset fillet
    translate([Corner_Size-Thickness,-Thickness,-Thickness])
    rotate([-90,180,0])
    fillet(); //y axis x offset fillet

    //Add fillet corners
    translate([-Thickness, -Thickness, -Thickness])
    rotate([0,0,0])
    fillet_corner(); //origin corner
    translate([Corner_Size-Thickness, -Thickness, -Thickness])
    rotate([0,0,90])
    fillet_corner(); //x axis corner 
    translate([-Thickness, -Thickness, Corner_Size-Thickness])
    rotate([-90,0,0])
    fillet_corner(); //z axis corner
    translate([-Thickness, Corner_Size-Thickness, -Thickness])
    rotate([0,0,-90])
    fillet_corner(); //y axis corner

    //Add big round corners
    translate([Distance_From_Edge_To_Screw, Distance_From_Edge_To_Screw, -Thickness])
    rotate([0,0,0])
    big_round_corner(); //on xy plane
    translate([Distance_From_Edge_To_Screw, -Thickness, Distance_From_Edge_To_Screw])
    rotate([-90,-90,0])
    big_round_corner(); //on xz plane
    translate([-Thickness, Distance_From_Edge_To_Screw, Distance_From_Edge_To_Screw])
    rotate([90,0,90])
    big_round_corner(); //on yz plane	 	
}

//Create a big, rounded, fillet corner around the screw holes
module big_round_corner() {
    difference() {
        translate([0,0,-Padding])
        cube([Corner_Size-Thickness-Distance_From_Edge_To_Screw+Padding,Corner_Size-Thickness-Distance_From_Edge_To_Screw+Padding,Thickness+Padding*2]);           
        translate([0,0,-Padding*2])
        cylinder(r = Corner_Size-Thickness-Distance_From_Edge_To_Screw-fRad, h = Thickness+Padding*4); 
        rotate_extrude () 
        translate([Corner_Size-Thickness-Distance_From_Edge_To_Screw-fRad, fRad, 0])
        circle(r = fRad+Padding); /*This be the donut itself*/
        translate([0,0,fRad]) 
        cylinder(r =  Corner_Size-Thickness-Distance_From_Edge_To_Screw+Padding,h = Thickness-fRad+Padding*2); 
    }
};

 
//Create rounded corners
module fillet_corner() {
    difference () {
        translate([-Padding, -Padding, -Padding]) cube([fRad, fRad, fRad]);
    	translate([fRad, fRad, fRad]) sphere(r = fRad+Padding);
    }
};

//Create rounded edges
module fillet() {
    difference() {
        translate([-Padding,-Padding,-Padding])
        cube([fRad, fRad, Corner_Size + (Padding * 2)]);
        translate([fRad, fRad, -(Padding * 2)])
        cylinder(h = Corner_Size + (Padding * 4), r = fRad + Padding);
    }
}

//Create screw holes
module screw_hole(){
 	union() {
   	cylinder(h = Thickness+Padding, r= (Screw_Shaft_Diameter/2), center = true);
      translate([0,0,-((Thickness+Padding)/2)])
      cylinder(h = Screw_Head_Thickness, r = (Screw_Head_Diameter/2));
		if (Countersink == "Yes") 
			{translate([0,0,-((Thickness+Padding)/2)+(Screw_Head_Thickness-Padding)])
			cylinder(h = (Screw_Head_Diameter/2-Screw_Shaft_Diameter/2) + Padding, r1 = Screw_Head_Diameter/2, r2 = Screw_Shaft_Diameter/2);
			}
    }
};
//watchband by isaac budmen @ibudmen

// Width of strap?
strap_width = 22; // [8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,24,26]
// Length of strap?
strap_length = 24; // [22,24,26,28,30,32,34,36,38,40,42]

//Other variables
pin_radius = 1.2; // Actual pin size divided by 2

//WHERE THE MAGIC HAPPENS
union(){
	pins(); 
	band();
};

module pins(){
	difference(){
	translate([-4.4,-strap_length,-(strap_width/2)+1])cylinder(strap_width-2,pin_radius+1,pin_radius+1,$fn = 50);
	translate([-4.4,-strap_length,-(strap_width/2)])cylinder(strap_width+3,pin_radius,pin_radius,$fn = 50);
	};

	difference(){
	translate([4.4,strap_length,-(strap_width/2)+1])cylinder(strap_width-2,pin_radius+1,pin_radius+1,$fn = 50);
	translate([4.4,strap_length,-(strap_width/2)])cylinder(strap_width+3,pin_radius,pin_radius,$fn = 50);
};
};

module pin_holes(){
translate([0,strap_length,-(strap_width/2)])cylinder(strap_width+3,pin_radius,pin_radius,$fn = 50);
translate([0,strap_length,(-strap_width/2)])cylinder(strap_width+3,pin_radius,pin_radius,$fn = 50);
};

module inside(){
cylinder(strap_width-2,strap_length+1.25,strap_length+1.25,center=true, $fn=150);
};

module outband(){
hull(){inside();
cube(size = [2,2,18],center=true);} // Add platform shape to watch band for watch head
};

module band(){
difference(){	
outband();
scale([0.97,0.97,1.1])outband();
cube(size = [12,strap_length*3,24],center=true);
translate([4.4,-strap_length,0])cylinder(strap_width+3,2*(pin_radius),2*(pin_radius),center=true,$fn = 50); // //outside latch - clearing interfering watch band bit for pin
};

difference(){
translate([4.4,-strap_length-.5,0])cylinder(strap_width-2,1.5*(pin_radius+1),1.5*(pin_radius+1),center=true,$fn = 50); //outside latch - body  
translate([4.4,-strap_length-.5,0])cylinder(strap_width+3,1.5*(pin_radius),1.75*(pin_radius),center=true,$fn = 50); // //outside latch - clearing cylinder for pin
translate([2.4,-strap_length-1,0])rotate([0,0,12])cube([6,2,30],center=true);
 // clearing cube for band
};
translate([-4.4,strap_length,0])cylinder(strap_width-2,1.4*(pin_radius),1.4*(pin_radius),center=true,$fn = 50); // inside latch pin
};
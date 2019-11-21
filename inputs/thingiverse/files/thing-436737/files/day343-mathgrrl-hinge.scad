// mathgrrl cone hinge

//////////////////////////////////////////////////////
// parameters

// Length of the complete hinge
length = 20;

// Height (diameter) of the hinge
height = 3;

// Clearance between cones and holes
clearance = .7;		

// Clearance between hinge and sides
gap = .6; 				

// Parameters that the user does not get to specify
$fn=24*1;
border = 2*1; 
fudge = .01*1;			// to preserve mesh integrity
corner = 0*1;      	// space between hinge and corner
hinge_radius = height/2;
cone_height = 1.5*hinge_radius;  

//////////////////////////////////////////////////////
// renders

rotate(90,[0,1,0]) 
	translate([-hinge_radius,0,0])
		hinge();

translate([0,hinge_radius+gap,0]) bar();
translate([0,-2*border-hinge_radius-gap,0]) bar();

//translate([0,hinge_radius+gap,0]) square();
//translate([0,-length-hinge_radius-gap,0]) square();


//////////////////////////////////////////////////////
// module for hinge

module hinge(){
	rad = hinge_radius;
	clr = clearance;
	len = (length-2*corner)/3; 
	con = cone_height;
	// left outside hinge = (cylinder+box)-cone
	difference(){
		union(){
			translate([0,0,corner]) cylinder(h=len-clr,r=rad);
			translate([-rad,0,corner]) cube([2*rad,rad+gap,len-clr]);
		}
		translate([0,0,corner+len-con-clr+fudge]) cylinder(h=con,r1=0,r2=rad);
	}
	// inside hinge = cylinder+box+cone+cone
	union(){
		translate([0,0,corner+len]) cylinder(h=len,r=rad);
		translate([-rad,-rad-gap,corner+len]) cube([2*rad,rad+gap,len]);
		translate([0,0,corner+len-con]) cylinder(h=con,r1=0,r2=rad);
		translate([0,0,corner+2*len]) cylinder(h=con,r1=rad,r2=0);
	}
	// right outside hinge = (cylinder+box)-cone
	difference(){
		union(){
			translate([0,0,corner+2*len+clr]) cylinder(h=len-clr,r=rad);
			translate([-rad,0,corner+2*len+clr]) cube([2*rad,rad+gap,len-clr]);
		}
		translate([0,0,corner+2*len+clr-fudge]) cylinder(h=con,r1=rad,r2=0);	
	}
}

//////////////////////////////////////////////////////
// module for square shape

module square(){
	difference(){
		cube([length,length,height]);
		translate([border,border,-fudge])
			cube(	[length-2*border,length-2*border,height+2*fudge]);
	}
}

//////////////////////////////////////////////////////
// module for bar shape

module bar(){
	cube([length,2*border,height]);
}

// mathgrrl hinge/snap octahedron

//////////////////////////////////////////////////////
// parameters

/* [Size] */

// Side length
length = 30;

// Width of the border edge
border = 3; 

// Thickness of the side pieces (height when printing)
height = 3;

/* [Clearances] */

// Clearance between hinge cones and holes
clearance = .55;	

// Clearance between hinge and sides
gap = .55; 				

// Clearance between snap tines
space = .55;

// Parameters that the user does not get to specify
$fn=24;
hinge_radius = height/2;
cone_height = 1.5*hinge_radius; 
corner = 0*1;      	// space between hinge and corner
fudge = .01*1;			// to preserve mesh integrity
jump = 2*hinge_radius+2*gap;

//////////////////////////////////////////////////////
// renders

// center triangle
union(){
	poly_maker(sides=3);
	attach(type=2,side=1,sides=3);
	attach(type=2,side=2,sides=3);
	attach(type=1,side=3,sides=3);
}

// A triangle
translate([	(length/tan(180/3)+jump)*cos(180/3),
					(length/tan(180/3)+jump)*sin(180/3),
					0]) 
rotate(180/3,[0,0,1])
union(){
	poly_maker(sides=3);
	attach(type=2,side=2,sides=3);	
	attach(type=1,side=3,sides=3);	
}

// B triangle
translate([	0,
					2*(length/tan(180/3)+jump)*sin(180/3),
					0]) 
rotate(2*180/3,[0,0,1])
union(){
	poly_maker(sides=3);
	attach(type=1,side=2,sides=3);	
	attach(type=1,side=3,sides=3);	
}

// BX triangle
translate([	-2*(length/tan(180/3)+jump)*cos(180/3),
					2*(length/tan(180/3)+jump)*sin(180/3),
					0]) 
rotate(3*180/3,[0,0,1])
union(){
	poly_maker(sides=3);
	attach(type=2,side=2,sides=3);	
	attach(type=2,side=3,sides=3);	
}

// C triangle
translate([	(length/tan(180/3)+jump)*cos(180/3),
					3*(length/tan(180/3)+jump)*sin(180/3),
					0]) 
rotate(3*180/3,[0,0,1])
union(){
	poly_maker(sides=3);
	attach(type=1,side=1,sides=3);	
	attach(type=1,side=2,sides=3);	
}

// CX triangle
translate([	3*(length/tan(180/3)+jump)*cos(180/3),
					3*(length/tan(180/3)+jump)*sin(180/3),
					0]) 
rotate(4*180/3,[0,0,1])
union(){
	poly_maker(sides=3);
	attach(type=2,side=1,sides=3);	
	attach(type=2,side=3,sides=3);	
}

// D triangle
translate([	0,
					4*(length/tan(180/3)+jump)*sin(180/3),
					0]) 
rotate(4*180/3,[0,0,1])
union(){
	poly_maker(sides=3);
	attach(type=1,side=1,sides=3);	
	attach(type=2,side=2,sides=3);	
}

// E triangle
translate([	(length/tan(180/3)+jump)*cos(180/3),
					5*(length/tan(180/3)+jump)*sin(180/3),
					0]) 
rotate(5*180/3,[0,0,1])
union(){
	poly_maker(sides=3);
	attach(type=2,side=1,sides=3);	
	attach(type=2,side=3,sides=3);	
}

//////////////////////////////////////////////////////
// module for hinge

module hinge(){

	rad = hinge_radius;
	clr = clearance;
	len = (length-2*corner)/3; 
	con = cone_height;

	rotate(90,[0,1,0]) rotate(-90,[1,0,0]) 
	translate([-rad,-rad-gap+fudge,0])
		union(){
	
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
}

//////////////////////////////////////////////////////
// module for snap

module snap(sides){

radius = length/(2*sin(180/sides)); 
snapwidth = radius*sin(180/sides)/3;

//build snaps for first side at the origin and move into positions
for(i=[0:2]){	

	//for i^th snap translate 2*i snapwidths over from origin
	translate([0-fudge,2*i*snapwidth,0-fudge]) 

		//rounded box for snap made from a box and cylinder
		union(){

			//cube part of snap shape at the origin
			cube([height/2+gap+fudge,snapwidth-space+fudge,height+fudge]);

			//round part of snap shape at the origin
			//move cylinder to the end of the box
			translate([height/2+gap,snapwidth-space+fudge,height/2])

				//rotate cylinder to match box orientation
				rotate(90,[0,1,0]) 
					rotate(90,[1,0,0]) 

						//cylinder of the correct size to match box
						cylinder(	
							r=height/2,
							h=snapwidth-space,
							$fn=16  //number of sides
						);
					}
			}

}

//////////////////////////////////////////////////////
// module for polygon shape
//shape is made up of n=sides wedges that are rotated around

module poly_maker(sides){

	radius = length/(2*sin(180/sides)); 
	inside = radius-border/(cos(180/sides));

	translate([0,0,height/2])

	//subtract the smaller polygon from the larger polygon
	difference(){

		//extrude to thicken the polygon
		linear_extrude(height=height,center=true){ 

			//rotate the wedge n=sides times at angle of 360/n each time
			for(i=[0:sides]){

				//rotation is around the z-axis [0,0,1]
				rotate(i*360/sides,[0,0,1])	

					//make triangular wedge with angle based on number of sides
					polygon(

						//the three vertices of the triangle
						points = [[0-.05,0-.05], //tweaks fix CGAL errors
									 [radius,0-.01],
									 [radius*cos(360/sides)-.01,radius*sin(360/sides)+.01]],

						//the order to connect the three vertices above
						paths = [[0,1,2]]
					);
			}
		}
		//extrude to thicken the center polygon that will be the hole
		linear_extrude(height=height+2,center=true){ 

			//rotate the wedge n=sides times at angle of 360/n each time			
			for(i=[0:sides]){

				//rotation is around the z-axis [0,0,1]
				rotate(i*360/sides,[0,0,1])	

					//make triangular wedge with angle based on number of sides
					polygon(

						//the three vertices of the triangle
						points =	[[0-.1,0-.1], //tweaks fix CGAL errors
									 [inside,0-.01],
									 [inside*cos(360/sides)-.01,inside*sin(360/sides)+.01]],

						//the order to connect the three vertices above
						paths = [[0,1,2]]
					);
			}
		}
	}
}

//////////////////////////////////////////////////////
// module for attaching hinges or snaps to shape
// type=1 for hinges, type=2 for snaps

module attach(type,side,sides){

	radius = length/(2*sin(180/sides)); 

	//rotation is around the z-axis [0,0,1]
	rotate(side*360/sides,[0,0,1]) 	

		//translate the attachment to the first side
		translate([radius,0,0+fudge]) 

			//rotate the attachment to correct angle for first side
			rotate(180/sides) 

				union(){
					if (type==1) hinge();
					if (type==2) snap(sides);
				}

}
// mathgrrl hinge/snap dodecahedron

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
$fn=24*1;
hinge_radius = height/2;
cone_height = 1.5*hinge_radius; 
corner = 0*1;      	// space between hinge and corner
fudge = .01*1;			// to preserve mesh integrity
jump = 2*hinge_radius+2*gap;

//////////////////////////////////////////////////////
// renders

// 1center hexagon
union(){
	poly_maker(sides=5);
	attach(type=1,side=1,sides=5);
	attach(type=1,side=2,sides=5);
	attach(type=1,side=3,sides=5);
	attach(type=1,side=4,sides=5);
	attach(type=1,side=5,sides=5);
}

// 1A hexagon
translate([	(length/tan(36)+jump)*cos(36),
					(length/tan(36)+jump)*sin(36),
					0]) 
rotate(36,[0,0,1])
union(){
	poly_maker(sides=5);
	attach(type=2,side=1,sides=5);	
	attach(type=2,side=3,sides=5);
	attach(type=1,side=4,sides=5);
	attach(type=2,side=5,sides=5);
}

// 1B hexagon
rotate(-72,[0,0,1])
translate([	(length/tan(36)+jump)*cos(36),
					(length/tan(36)+jump)*sin(36),
					0]) 
rotate(36,[0,0,1])
union(){
	poly_maker(sides=5);
	attach(type=2,side=1,sides=5);	
	attach(type=2,side=3,sides=5);	
	attach(type=2,side=4,sides=5);	
	attach(type=2,side=5,sides=5);			
}

// 1C hexagon
rotate(-2*72,[0,0,1])
translate([	(length/tan(36)+jump)*cos(36),
					(length/tan(36)+jump)*sin(36),
					0]) 
rotate(36,[0,0,1])
union(){
	poly_maker(sides=5);		
	attach(type=2,side=1,sides=5);	
	attach(type=2,side=3,sides=5);	
	attach(type=2,side=4,sides=5);	
	attach(type=2,side=5,sides=5);	
		}

// 1D hexagon
rotate(-3*72,[0,0,1])
translate([	(length/tan(36)+jump)*cos(36),
					(length/tan(36)+jump)*sin(36),
					0]) 
rotate(36,[0,0,1])
union(){
	poly_maker(sides=5);		
	attach(type=2,side=1,sides=5);	
	attach(type=2,side=3,sides=5);	
	attach(type=2,side=4,sides=5);	
	attach(type=2,side=5,sides=5);	
}

// 1E hexagon
rotate(-4*72,[0,0,1])
translate([	(length/tan(36)+jump)*cos(36),
					(length/tan(36)+jump)*sin(36),
					0]) 
rotate(36,[0,0,1])
union(){
	poly_maker(sides=5);		
	attach(type=2,side=1,sides=5);	
	attach(type=2,side=3,sides=5);	
	attach(type=2,side=4,sides=5);	
	attach(type=2,side=5,sides=5);	
}

// 2center hexagon
translate([	2*(length/tan(36)+jump)*cos(36)+2*length/(2*tan(36))+jump,
					2*(length/tan(36)+jump)*sin(36),
					0]) 
rotate(36,[0,0,1])
union(){
	poly_maker(sides=5);
	attach(type=1,side=1,sides=5);	
	attach(type=1,side=2,sides=5);	
	attach(type=1,side=3,sides=5);
	attach(type=1,side=4,sides=5);
	attach(type=1,side=5,sides=5);
}

// 2A hexagon
translate([	2*(length/tan(36)+jump)*cos(36)+2*length/(2*tan(36))+jump,
					2*(length/tan(36)+jump)*sin(36),
					0]) 
rotate(36,[0,0,1])
translate([	(length/tan(36)+jump)*cos(36),
					(length/tan(36)+jump)*sin(36),
					0]) 
rotate(36,[0,0,1])
union(){
	poly_maker(sides=5);
	attach(type=2,side=1,sides=5);	
	attach(type=2,side=3,sides=5);
	attach(type=2,side=4,sides=5);
	attach(type=2,side=5,sides=5);
}

// 2B hexagon
translate([	2*(length/tan(36)+jump)*cos(36)+2*length/(2*tan(36))+jump,
					2*(length/tan(36)+jump)*sin(36),
					0]) 
rotate(-72,[0,0,1])
rotate(36,[0,0,1])
translate([	(length/tan(36)+jump)*cos(36),
					(length/tan(36)+jump)*sin(36),
					0]) 
rotate(36,[0,0,1])
union(){
	poly_maker(sides=5);
	attach(type=2,side=1,sides=5);	
	attach(type=2,side=3,sides=5);
	attach(type=2,side=4,sides=5);
	attach(type=2,side=5,sides=5);
}

// 2C hexagon
translate([	2*(length/tan(36)+jump)*cos(36)+2*length/(2*tan(36))+jump,
					2*(length/tan(36)+jump)*sin(36),
					0]) 
rotate(-2*72,[0,0,1])
rotate(36,[0,0,1])
translate([	(length/tan(36)+jump)*cos(36),
					(length/tan(36)+jump)*sin(36),
					0]) 
rotate(36,[0,0,1])
union(){
	poly_maker(sides=5);
	attach(type=2,side=1,sides=5);	
	attach(type=2,side=3,sides=5);
	attach(type=2,side=4,sides=5);
	attach(type=2,side=5,sides=5);
}

// 2D hexagon
translate([	2*(length/tan(36)+jump)*cos(36)+2*length/(2*tan(36))+jump,
					2*(length/tan(36)+jump)*sin(36),
					0]) 
rotate(-3*72,[0,0,1])
rotate(36,[0,0,1])
translate([	(length/tan(36)+jump)*cos(36),
					(length/tan(36)+jump)*sin(36),
					0]) 
rotate(36,[0,0,1])
union(){
	poly_maker(sides=5);
	attach(type=2,side=1,sides=5);	
	attach(type=2,side=3,sides=5);
	attach(type=2,side=5,sides=5);
}

// 2E hexagon
translate([	2*(length/tan(36)+jump)*cos(36)+2*length/(2*tan(36))+jump,
					2*(length/tan(36)+jump)*sin(36),
					0]) 
rotate(-4*72,[0,0,1])
rotate(36,[0,0,1])
translate([	(length/tan(36)+jump)*cos(36),
					(length/tan(36)+jump)*sin(36),
					0]) 
rotate(36,[0,0,1])
union(){
	poly_maker(sides=5);
	attach(type=2,side=1,sides=5);	
	attach(type=2,side=3,sides=5);
	attach(type=2,side=4,sides=5);
	attach(type=2,side=5,sides=5);
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
	
			// left outside hinge = (cylinder+box)-cone (with .1 for overlap)
			difference(){
				union(){
					translate([0,0,corner]) cylinder(h=len-clr,r=rad);
					translate([-rad,0,corner]) cube([2*rad,rad+gap+.1,len-clr]);
				}
				translate([0,0,corner+len-con-clr+fudge]) cylinder(h=con,r1=0,r2=rad);
			}

			// inside hinge = cylinder+box+cone+cone (with .1 for overlap)
			union(){
				translate([0,0,corner+len]) cylinder(h=len,r=rad);
				translate([-rad,-rad-gap-.1,corner+len]) cube([2*rad,rad+gap+.1,len]);
				translate([0,0,corner+len-con]) cylinder(h=con,r1=0,r2=rad);
				translate([0,0,corner+2*len]) cylinder(h=con,r1=rad,r2=0);
			}

			// right outside hinge = (cylinder+box)-cone (with .1 for overlap)
			difference(){
				union(){
					translate([0,0,corner+2*len+clr]) cylinder(h=len-clr,r=rad);
					translate([-rad,0,corner+2*len+clr]) cube([2*rad,rad+gap+.1,len-clr]);
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
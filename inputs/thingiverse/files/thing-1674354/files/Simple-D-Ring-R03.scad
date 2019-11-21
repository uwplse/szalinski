//D Ring - Simple D Ring - likely want in different sizes

//REV01 - initial version - will likely need to do different sizes
//REV02 - Larger size - 5 mm cross section - 30 mm wide
//REV03 - Customizable version - default values - cs=5, width=30, side=16, angle=115

//Variable requests for Thingiverse Customizer - Real word names here, but changed to shorter variable names below for easier use in code

//cross section of D-Ring
cross_section=5;//[2:20]

//outer dimension of D-Ring width
width_od=30;//[6:200]

//length of side from base up to start of arc
side_length=16;//[0:150]

//included angle of loop for and arc
included_angle=115;//[60:5:180]

//variables set to constants or from user input
cs=cross_section;//cross section
width=width_od;//base width
side=side_length;//side length
angle=included_angle;


$fn=24*1;//facets for spheres

//calculated variables
radius=(width-cs)/(2*sin(angle/2));
halfcord=(width-cs)/2;
offcenter=sqrt((radius*radius)-(halfcord*halfcord));




//move complete assembly to z=0 and close to center of x-y
translate([-halfcord,-side/2,cs/2]){//hole part translate

difference(){
	union(){
		//base part
		hull(){
			scale([1,1,1.2])
			sphere(d=cs);
			translate([width-cs,0,0])
			scale([1,1,1.2])
			sphere(d=cs);
		}
		//one of the sides
		hull(){
			scale([1,1,1.2])
			sphere(d=cs);
			translate([0,side,0])
			scale([1,1,1.2])
			sphere(d=cs);
		}
		//the other side
		hull(){
			translate([width-cs,0,0])
			scale([1,1,1.2])
			sphere(d=cs);
			translate([width-cs,side,0])
			scale([1,1,1.2])
			sphere(d=cs);
		}
		
		//curved end
		intersection(){
			//rect hull of sphere to keep part of rot extrude
			if(angle>160)
			translate([-cs/2,side,-cs/2-1])
			cube([width+cs,width+cs,cs+2]);
			else
			hull(){
				translate([0,side,0])
				scale([1,1,1.2])
				sphere(d=cs);
				translate([width-cs,side,0])
				scale([1,1,1.2])
				sphere(d=cs);
				translate([0,side+width/2,0])
				scale([1,1,1.2])
				sphere(d=cs);
				translate([width-cs,side+width/2,0])
				scale([1,1,1.2])
				sphere(d=cs);
			}
			//rotate extrude to create end arc
			translate([(width-cs)/2,(side-offcenter),0])
			rotate_extrude($fn=8640/angle)
			translate([radius, 0, 0])
			scale([1,1.2])
			circle(d=cs);
		}



	}//union end
translate([width/2,side/2,-cs*2.5])
cylinder(r=width+side,h=cs*2);
translate([width/2,side/2,cs/2])
cylinder(r=width+side,h=cs*2);

}//difference end

}//hole part translate end
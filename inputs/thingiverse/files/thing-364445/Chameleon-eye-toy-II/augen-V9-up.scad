
//Select the view
part = "Basic"; // [Basic,CutSide,CutTop]

//Select the ring thickness in mm
ring_thick=5;

//The distance between the eyeball and the outer shell in mm, they shouldnt touch.
print_dist=.4;



/* [Hidden] */

/*
Chameleon Eye Toy II for your finger
Version 9, June 2014
Written by MC Geisler (mcgenki at gmail dot com)

The eyes mooove!

Have fun!

License: Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0)
You are free to:
    Share - copy and redistribute the material in any medium or format
    Adapt - remix, transform, and build upon the material
Under the following terms:
    Attribution - You must give appropriate credit, provide a link to the license, and indicate if changes were made. 
    You may do so in any reasonable manner, but not in any way that suggests the licensor endorses you or your use.
    NonCommercial - You may not use the material for commercial purposes.
    ShareAlike - If you remix, transform, or build upon the material, you must distribute your contributions under the same license as the original. 
*/


//The ring radius in mm
ring_r=9; 

$fs=1;

ring_width=2;

control_r=ring_r+ring_width*2;

eye_r=10;
eye_dist=4;
//    eye_shiftside = ring_r/sqrt(2)+eyering_r/sqrt(2) == eye_r+eye_dist/2
// => eyering_r/sqrt(2) = eye_r+eye_dist/2-ring_r/sqrt(2)
eyering_r=(eye_r+eye_dist/2)*sqrt(2)-ring_r; 

openring_shiftdown=ring_r/sqrt(2)+eyering_r/sqrt(2);
eye_shiftside=openring_shiftdown;

shiftbottom= - eye_r * .65;

control_rod_r=1.5;
control_rod_lock_r=control_rod_r*2;
control_ring_thick=ring_thick/2;

//iris
eyeball_r=eye_r-ring_width-print_dist;
iris_r=eyeball_r/2;
iris_bottom=eyeball_r/sqrt(2);
iris_bottomheight=control_rod_lock_r+control_rod_r+print_dist+1;//iris_r; measured from the bottom...
iris_linew=0.4;
pupil_r=iris_r/2;
iris_width=iris_r-pupil_r;
iris_bottomcutout=iris_bottom-1;
//iris_depth=2*eyeball_r-(eyeball_r+iris_bottomheight);
eyeball_height=(-shiftbottom)+eyeball_r*.85;
iris_depth=eyeball_height-iris_bottomheight;

control_rod_percent=0.75;
control_rod_shiftout=control_rod_r*1.5+(1-control_rod_percent)*iris_bottom;
control_rod_length=iris_bottom*2*control_rod_percent+control_rod_shiftout;
control_rod_locklength=2;

module control_rod(adder)
{
	translate([0,-control_rod_shiftout/2,shiftbottom+control_rod_r])
		rotate([90,0,0])
			cylinder(r=control_rod_r+adder, h=control_rod_length+2*adder, center=true, $fn=36);

	translate([0,(control_rod_length-control_rod_shiftout)/2-control_rod_locklength/2,shiftbottom+control_rod_r])
		rotate([90,0,0])
			cylinder(r=control_rod_r*2+adder, h=control_rod_locklength+2*adder, center=true, $fn=36);

}
 
module iris()
{
	for (i=[0:360/22:360])
		rotate([0,0,i])
			translate([pupil_r+iris_width/2,0,shiftbottom+iris_bottomheight+iris_depth/2])
				cube([iris_width,iris_linew,iris_depth],center=true);
}


module eyeball()
{
	difference()
	{
		//eye 
		union()
		{
			//eyeball
			sphere(eyeball_r);

			//ring
			translate([0,0,shiftbottom+iris_bottomheight/2])
				cylinder(r=iris_bottom,h=iris_bottomheight,center=true);
		}

		//cutout center for the iris and the central hole 
		translate([0,0,shiftbottom+iris_bottomheight +eyeball_r])
			cylinder(r=iris_r,h=2*eyeball_r,center=true);

		//cutout for control rod
		control_rod(print_dist);

		//cutout for the finger to move it
//		translate([0,0,shiftbottom+iris_bottomheight/8])
//		{
//			translate([0,0,-iris_bottomheight/8])
//				cylinder(r=iris_bottomcutout,h=iris_bottomheight/4,center=true);
//			scale([1,1,.3])
//				sphere(r=iris_bottomcutout);
//		}
	}

	//control rod
	control_rod(0);

	//iris
	iris();
}

module ringouter(radius,width,thick)
{
	cylinder(r=radius+width/2,h=thick,center=true);
}

module ringinner(radius,width,thick)
{
	cylinder(r=radius-width/2,h=2*thick,center=true);
}

module ring(radius,width,thick)
{
		difference()
		{
			ringouter(radius,width,thick);
			ringinner(radius,width,thick);
		}
}


module openring(ring_r,ring_width,ring_thick,shorter)
{
	translate([0,-openring_shiftdown,ring_thick/2+shiftbottom])
	difference()
	{
		ring(ring_r,ring_width,ring_thick);
		translate([0,ring_r*2+(ring_r-ring_width/2)/sqrt(2)-shorter,0])
			cube([ring_r*4,ring_r*4,ring_r*4],center=true);
	}
}

module openringhalf(ring_r,ring_width,ring_thick,shorter)
{
	difference()
	{
		openring(ring_r,ring_width,ring_thick,shorter);
		translate([-ring_r*4-.2,0,0])
			cube([ring_r*8,ring_r*8,ring_r*8],center=true);
	}
}

module eye()
{
	translate([eye_shiftside,0,0])
	{
		difference()
		{
			union()
			{
				//outer shell
				sphere(eye_r);

				//ring for printing
				translate([0,0,ring_thick/2+shiftbottom])
					 ringouter(eyering_r,ring_width,ring_thick);
				
				//half ring around finger
				translate([-eye_shiftside,0,0])
					openringhalf(ring_r,ring_width,ring_thick,0);
			}

			//cutout outer shell
			sphere(eye_r-ring_width);

			//cutout hole on top
			cylinder(r=eye_r/1.5,h=ring_r*4,center=true);

			//cutout hole in bottom
			translate([0,0,ring_thick/2+shiftbottom])
				ringinner(eyering_r,ring_width,ring_thick);

			//cutout for half ring for movement of eyes
			translate([-eye_shiftside,0,-.1])
				openringhalf(control_r,ring_width+4,control_ring_thick+4,0);
		
			//cutout for control rod
			//control_rod(print_dist);
		}

		eyeball();

		//half ring for movement of eyes
		translate([-eye_shiftside,0,-control_ring_thick/2*0])
			openringhalf(control_r,ring_width,control_ring_thick,4);

	}
}

module fullring()
{
	eye();
	mirror([1,0,0])
		eye();
}

difference()
{
	fullring();

	//top cutoff - to make a nicer finish
	translate([0,0,eye_r*3-shiftbottom+ring_thick*.1])
		cube(eye_r*6,center=true);

	//bottom cutoff - to cutoff the spheres for printing
	translate([0,0,-eye_r*3+shiftbottom])
		cube(eye_r*6,center=true);

	//look into the side
	if (part=="CutSide")
         translate([20+eye_shiftside,0,0]) cube(40,center=true);
        if (part=="CutTop")
	 translate([20,20,0]) cube(40,center=true);
}


//Want more eye pairs? Just select the number here...
Num_Eye_Pairs=1;//[1,2,3,4,5,6]

//The ring radius in mm, please stay beteween 5mm and maximum 20mm.
ring_r=9; 

//Select the ring thickness in mm
ring_thick=5; 

//The distance between the eyeball and the outer shell in mm. Adjust it so the two dont touch. Recommended is to stay between 0.1 and 0.6 mm.
print_dist=0.4; 

//For printing, select "Basic". For fun, select "CustSide" or "CutTop" to cut into the model to see the inside. 
part = "Basic"; // [Basic,CutSide,CutTop]

/* [Hidden] */

/*
Eye Toy for your finger
Version 13, March 2019
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



$fs=1;

ring_width=2;

eye_r=10;
eye_dist=4; //correct for ring_r=9 only!
//    eye_shiftside = ring_r/sqrt(2)+eyering_r/sqrt(2) == eye_r+eye_dist/2
// => eyering_r/sqrt(2) = eye_r+eye_dist/2-ring_r/sqrt(2)
eyering_r=(eye_r+eye_dist/2)*sqrt(2)-9;//ring_r; //better to move the eyes together than to change the eyes radius

openring_shiftdown=ring_r/sqrt(2)+eyering_r/sqrt(2);
eye_shiftside=openring_shiftdown;

openring_shiftbottom=-eye_r+ring_thick/2 +  eye_r*.35;

//iris
eyeball_r=eye_r-ring_width-print_dist;
iris_r=eyeball_r/2;
iris_bottom=eyeball_r/sqrt(2);
iris_bottomheight=iris_r+2;
iris_linew=0.55;
pupil_r=iris_r/1.9;
iris_width=iris_r-pupil_r;

module eyeball()
{
	difference()
	{
		sphere(eyeball_r);
		translate([0,0,iris_bottomheight])
			cylinder(r=iris_r,h=2*eyeball_r,center=true);
	}

	translate([0,0,openring_shiftbottom-ring_thick/2+iris_bottomheight/2])
			cylinder(r=iris_bottom,h=iris_bottomheight,center=true);

	//iris
	for (i=[0:360/16:360])
	rotate([0,0,i])
		translate([pupil_r+iris_width/2,0,0])
			cube([iris_width,iris_linew,2*eyeball_r-iris_r/2-.5],center=true);
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

module openring()
{
	translate([0,-openring_shiftdown,openring_shiftbottom])
	difference()
	{
		ring(ring_r,ring_width,ring_thick);
		translate([0,ring_r*2+(ring_r-ring_width/2)/sqrt(2),0])
			cube([ring_r*4,ring_r*4,ring_r*4],center=true);
	}
}

module openringhalf()
{
	difference()
	{
		openring();
		translate([-ring_r*4-.2,0,0])
			cube([ring_r*8,ring_r*8,ring_r*8],center=true);
	}
}

module eye(doIt)
{
	translate([eye_shiftside,0,0])
	{
		difference()
		{
			union()
			{
				sphere(eye_r);
				translate([0,0,openring_shiftbottom])
					 ringouter(eyering_r,ring_width,ring_thick);

				//only the first eye pair needs a ring
				if (doIt=="withRing")
					translate([-eye_shiftside,0,0])
						openringhalf();
			}

			sphere(eye_r-ring_width);

			cylinder(r=eye_r/1.5,h=ring_r*4,center=true);

			translate([0,0,openring_shiftbottom])
				ringinner(eyering_r,ring_width,ring_thick);
		}

		eyeball();

		//translate([0,0,openring_shiftbottom])
		//	ring(eyering_r,ring_width,ring_thick);
	}
}

module TwoEyes(doIt)
{
	eye(doIt);
	mirror([1,0,0])
		eye(doIt);
}

difference()
{
	union()
	{
		//TwoEyes();

		for (i=[0:Num_Eye_Pairs-1])
			translate([0,(eye_r*2-ring_width)*i,0])
				TwoEyes( (i==0?"withRing":"") );
	}

	//top cutoff
	translate([0,0,eye_r*3-openring_shiftbottom+ring_thick*.6])
		cube(eye_r*6,center=true);

	//bottom cutoff
	translate([0,0,-eye_r*20+openring_shiftbottom-ring_thick/2])
		cube(eye_r*40,center=true);

	//look into the side
	if (part=="CutSide")
		translate([20+eye_shiftside,0,0]) cube([40,40*Num_Eye_Pairs,40],center=true);
   if (part=="CutTop")
		translate([20,20,0]) cube(40,center=true);
}


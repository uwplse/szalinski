// Title: MultiStand
// Author: http://www.thingiverse.com/Jinja
// Date: 29/1/2013

/////////// START OF PARAMETERS /////////////////

// The thickness of your tablet. This will determine the size of the slots your tablet will fit into. mm =
tablet_thickness = 11.2;

// The height of your tablet. If you only want landscape, then use the short length. Otherwise use the long length. mm =
tablet_height = 190;

// How deep each slot will be, just under 10% of your tablet height is a good guide. mm =
slot_depth = 10.0;

// Increase the length of your stand to get more slots, % =
extra_length_percent=0; //[0:100]

// How many lids do you want for your stand. 
number_of_lids = 1; // [1:OneLid, 2:TwoLids]

// How wide in mm each rest will be. mm =
stand_width = 10; //[6:20]

// To discover the calibration value of your printer, first print out the lid. Then print out the calibration rest which will fit onto the lid. If the fit is too loose then increase the calibration and try again. If the fit is too tight then decrease the calibration value. I suggest printing out CalibrationRests for values 0, 2 & 4 simultaneously and go from there. When you've found your value then you can print out the full sized Rest. Zero means your printer is perfectly calibrated. Value = 
calibration = 0;//[-8:8]

// Select which STL plate you want to create. 
plate = "FullPlate"; //[ Lid, CalibrationRest, Rest, FullPlate ]

// Choose the pattern for the lid. For speed, use the circle to iterate on positioning before choosing the pattern you want. This is because the circle is faster to process. In fact, the list is ordered from fast to slow.
patternID = 0; // [0:NoPattern, 1:Circle, 4:Fish, 3:Apple, 5:Makerbot, 2:Android]

// Offset the pattern in the X axis. mm =
pattern_offset_x = 0; //[-20:20]

// Offset the pattern in the Y axis. mm =
pattern_offset_y = 0; //[-20:20]

// The size of the pattern. mm =
pattern_size = 35; //[8:60]

// Spacing percentage. 100=no overlap. Less than 100 means some overlap. More than 100 means more space between the patterns. % =
pattern_overlap_percent = 105; //[50:150]

// preview[view:south, tilt:top]

/////////// END OF PARAMETERS /////////////////
// not parameters, do not change
pattern_overlap = pattern_overlap_percent/100;
overhang = 40*1;  // the angle of overhang your printer can manage (no need to exceed 45)
rounded = 1*1;    // the mm width of the bevelled edge
rear_buf = 5*1;
front_buf = 2+tablet_thickness;

holder_height = 6*1;
holder_thick = 2*1;

extra_length=1+ (extra_length_percent/100);
base_min = holder_height+2;
height = base_min+slot_depth/sin(45);
slot_range = tablet_height*sin(45)*0.75*extra_length;
depth = rear_buf+slot_range + front_buf;
spacing = (1.1*tablet_thickness)/sin(45);
num_slots = floor(slot_range/spacing);
buffer = (calibration)*0.05;

calib_width = 2*(stand_width+holder_thick)+4;

if( plate == "Calibration" )
{
	test_stand();
	translate([-7,12,0])
	holder(3, 20, 0, 0);
}
else if( plate == "CalibrationRest" )
{
//		translate([0,-depth*0.5+5+holder_thick+2,0])
//		final_stand(number_of_lids);
	difference()
	{
	intersection()
	{
		translate([0,-depth*0.5+stand_width+holder_thick+2,0])
		final_stand(1);
		cube([holder_height+2,calib_width,5]);
	}

	for(i=[-8:1:8])
	{
		translate([holder_height+2,(0.5+(i/16))*calib_width,5*0.5])
		cube([calib_width/32,calib_width/32,calib_width/32],true);
	}
	for(i=[-8:8:8])
	{
		translate([holder_height+2,(0.5+(i/16))*calib_width,5*0.3])
		cube([calib_width/32,calib_width/32,calib_width/32],true);
	}
	translate([holder_height+2,(0.5+(calibration/16))*calib_width,5*0.7])
	cube([calib_width/32,calib_width/32,calib_width/32],true);
	}
}
else if( number_of_lids == 1 )
{
   if( plate == "FullPlate" )
	{
		translate([-(stand_width+holder_thick)-2,depth*0.5,0])
		holder(stand_width, depth, 0, patternID);
	
		translate([2*height+2,0,0])
		scale([-1,1,1])
		final_stand(number_of_lids);
	
		translate([0,0,0])
		final_stand(number_of_lids);
	}
	else if ( plate == "Lid" )
	{
		translate([-(stand_width+holder_thick)-2,depth*0.5,0])
		holder(stand_width, depth, 0, patternID);
	}
	else if ( plate == "Rest" )
	{
		final_stand(number_of_lids);
	}
}
else if ( number_of_lids == 2 )
{
   if( plate == "FullPlate" )
	{
		translate([3*-(stand_width+holder_thick)-4,depth*0.5,0])
		holder(stand_width, depth, 0, patternID);
	
		translate([-(stand_width+holder_thick)-2,depth*0.5,0])
		holder(stand_width, depth, 0, patternID);
	
		translate([2*height+2,0,0])
		scale([-1,1,1])
		final_stand(number_of_lids);
	
		translate([0,0,0])
		final_stand(number_of_lids);
	}
	else if ( plate == "Lid" )
	{
		translate([-(stand_width+holder_thick)-2,depth*0.5,0])
		holder(stand_width, depth, 0, patternID);
	}
	else if ( plate == "Rest" )
	{
		final_stand(number_of_lids);
	}

}


$fs=0.3;
//$fa=5; //smooth
$fa=10; //not so smooth
//$fa=20; //rough

module lid_cutter(pos, patternID )
{
	translate([0.2,depth*0.5,0])
	rotate([90,0,90])
	holder(stand_width, depth, buffer, patternID);

	translate([-1,depth*0.5,0])
	rotate([90,0,90])
	holder(stand_width, depth, buffer, patternID);
}

module test_stand()
{
	step = 13;
	difference()
	{
		minkowski()
		{
			translate([rounded, rounded, rounded])
			cube([11, 8*step+2, 1]);
			diamond(rounded);
		}
	for(i=[0:1:7])
	{
		translate([0,i*step+8,0])
		rotate( [90,0,90] )
   	holder( 3, 20, 0.0+(i*0.05) );
		translate([-1,i*step+8,0])
		rotate( [90,0,90] )
   	holder( 3, 20, 0.0+(i*0.05) );
		
		translate([7,i*step+4,1])
		{
			if(i==0)
			{
				write("1",h=8,t=4);
			}
			else if(i==1)
			{
				write("2",h=8,t=4);
			}
			else if(i==2)
			{
				write("3",h=8,t=4);
			}
			else if(i==3)
			{
				write("4",h=8,t=4);
			}
			else if(i==4)
			{
				write("5",h=8,t=4);
			}
			else if(i==5)
			{
				write("6",h=8,t=4);
			}
			else if(i==6)
			{
				write("7",h=8,t=4);
			}
			else if(i==7)
			{
				write("8",h=8,t=4);
			}
		}

	}
	}
}

module final_stand(number_of_lids)
{
	pos = -stand_width*2;
	if( number_of_lids == 1 )
	{
		difference()
		{
			stand2();
			lid_cutter(pos,0);
		}
	}
	else if (number_of_lids == 2 )
	{
		difference()
		{
			stand2();
			translate([0,depth*0.25,0])	
			lid_cutter(pos,0);
			translate([0,depth*-0.25,0])	
			lid_cutter(pos,0);
		}
	}
}

module right_stand(number_of_lids)
{
//	pos = -stand_width;
	pos = -stand_width*2;
	if( number_of_lids == 1 )
	{
		difference()
		{
			stand();
			lid_cutter(pos,0);
		}
	}
	else if (number_of_lids == 2 )
	{
		difference()
		{
			stand();
			translate([0,depth*0.25,0])	
			lid_cutter(pos,0);
			translate([0,depth*-0.25,0])	
			lid_cutter(pos,0);
		}
	}

}

module left_stand(number_of_lids)
{
//	pos = -depth-2*holder_thick;
	pos = -stand_width*2;
	if( number_of_lids == 1 )
	{
		difference()
		{
			stand();
			lid_cutter(pos,0);
		}
	}
	else if (number_of_lids == 2 )
	{
		difference()
		{
			stand();

			translate([0,depth*0.25,0])	
			lid_cutter(pos,0);
			translate([0,depth*-0.25,0])	
			lid_cutter(pos,0);
		}
	}
}

module holder(stand_width, depth, outerextra, patternID)
{
	difference()
	{
		minkowski()
		{
			translate([0, 0, (holder_height+outerextra)*0.5])
			cube([(stand_width+holder_thick+outerextra)*2-(2*rounded), depth+2*(outerextra+holder_thick)-(2*rounded), holder_height+outerextra-(2*rounded)],true);
			diamond(rounded);
		}
		translate([0, 0, holder_thick+holder_height*0.5 + outerextra])
		cube([(stand_width-outerextra)*2, depth-2*outerextra, holder_height+outerextra],true);

		if( patternID > 0 )
		{
			pattern(stand_width, depth, outerextra, patternID );
		}
	}
}

module pattern(stand_width, depth, extra, patternID)
{
	xoffset = pattern_offset_x;
	yoffset = pattern_offset_y;
	steps = pattern_size;
	radius = steps*0.45;
	overlap = pattern_overlap;
	intersection()
	{
		for(x=[xoffset-10:steps*overlap:(stand_width+holder_thick+extra)*2-(2*rounded)+(steps)+xoffset+10])
		{
			for(y=[yoffset-10:steps*overlap:depth+2*(extra+holder_thick)-(2*rounded)+(steps)+yoffset+10])
			{
				translate([-stand_width*2, -0.5*(depth+2*(extra+holder_thick)-(2*rounded)), 0])
				translate([x,y,-1])
				rotate([0,0,x*57+y*79])
				pattern_shape( radius, 10, patternID );
//				android( radius*2, 10 );
//				cylinder(10, radius, radius);
			}
		}
		translate([0, 0, (holder_height+extra)*0.5])
		cube([(stand_width+extra)*2, depth+2*extra, holder_height*3],true);
	}
}

module stand2()
{
	final_spacing = slot_range/(num_slots);
	between = (final_spacing - tablet_thickness);
	adj_spacing = final_spacing - (between/num_slots);
	difference()
	{
		minkowski()
		{
			translate([rounded-buffer, rounded-buffer, rounded])
			cube([height-(2*rounded), depth-(2*rounded)-(2*buffer)-(2*buffer), stand_width-(2*rounded)-(2*buffer)]);
			diamond(rounded);
		}
		if( num_slots > 7 )
		{

			for(i=[0:1:(num_slots)])
			{
				
				translate([base_min,(i*adj_spacing)+rear_buf+(((i/num_slots)*(i/num_slots)*(i/num_slots)*(i/num_slots)*(i/num_slots)*(i/num_slots))*between),-0.1])
				rotate([0,0,-(0+i*(45/(num_slots)))])
				cube([height*2, tablet_thickness, stand_width-2*buffer+0.2]);
			}
		}
		else if( num_slots > 5 )
		{
			for(i=[0:1:(num_slots)])
			{
				
				translate([base_min,(i*adj_spacing)+rear_buf+(((i/num_slots)*(i/num_slots)*(i/num_slots)*(i/num_slots)*(i/num_slots))*between),-0.1])
				rotate([0,0,-(0+i*(45/(num_slots)))])
				cube([height*2, tablet_thickness, stand_width-2*buffer+0.2]);
			}
		}
		else
		{
			for(i=[0:1:(num_slots)])
			{
				
				translate([base_min,(i*adj_spacing)+rear_buf+(((i/num_slots)*(i/num_slots)*(i/num_slots))*between),-0.1])
				rotate([0,0,-(2+i*(43/(num_slots)))])
				cube([height*2, tablet_thickness, stand_width-2*buffer+0.2]);
			}
		}
	}
}

module cutter(dist, overhang)
{
	size = dist*2;

	translate([dist,-dist,-dist])
	cube([size,size,size]);

	translate([-dist-size,-dist,-dist])
	cube([size,size,size]);

	translate([dist,-dist,0])
	rotate([0,-overhang,0])
	cube([size,size,size]);

	translate([-dist,-dist,0])
	rotate([0,-90+overhang,0])
	cube([size,size,size]);

	translate([dist,-dist,0])
	rotate([0,90+overhang,0])
	cube([size,size,size]);

	translate([-dist,-dist,0])
	rotate([0,180-overhang,0])
	cube([size,size,size]);

}

module diamond( rounded )
{
	dist = rounded;
	difference()
	{
		cube([2*rounded,2*rounded,2*rounded], true);
		for(i=[0:45:179])
		{
			rotate([0,0,i])
			cutter(dist, overhang);
		}
	}
}

//translate([0,0,30])
//android( 20, 4 );

module android( oheight, depth )
{
	scale = 1.1;
	height = oheight*scale;
	width = height*0.4;
	gap = height*0.03;
	radius = height*0.045;

//	cube( [ oheight,2,oheight] );

	translate( [-oheight*0.5,oheight*0.5,0])
	rotate([90,0,0])
	translate( [-(height-oheight)*0.5,-depth-1,-height*0.14])
	{
	translate( [(height-width)*0.5+radius,depth,(height-width)*0.5+radius])

/*	minkowski()
	{
		translate([0,0,0])
		cube( [ width-(2*radius),depth-1,width-(2*radius)] );
		rotate([-90,0,0])
		cylinder( 1, radius, radius );
	}*/

	hull()
	{
		translate([0,0,0])
		rotate([-90,0,0])
		cylinder( depth, radius, radius );

		translate([width-(2*radius),0,0])
		rotate([-90,0,0])
		cylinder( depth, radius, radius );

/*		translate([width-(2*radius),0,width-(2*radius)])
		rotate([-90,0,0])
		cylinder( depth, radius, radius );

		translate([0,0,width-(2*radius)])
		rotate([-90,0,0])
		cylinder( depth, radius, radius );*/

		translate( [-((height-width)*0.5+radius),-depth,-((height-width)*0.5+radius)])
		translate( [(height-width)*0.5,depth,(height)*0.5])
		cube( [ width,depth,width*0.5] );

	}


	translate( [height*0.5,depth,(height+width)*0.5+gap])

	rotate([-90,0,0])
	difference()
	{
		cylinder( depth, width*0.5, width*0.5 );
		translate([-width*0.5,0,0])
		cube( [width,width,depth]);
		if(radius*0.25>0.7)
		{
			translate([-radius*2,-radius*2,0])
			cylinder( depth, radius*0.5, radius*0.5 );
			translate([radius*2,-radius*2,0])
			cylinder( depth, radius*0.5, radius*0.5 );

			// the next two cubes are the things that keep the eyes in place
			translate([-radius*2,-radius*2,0])
			rotate([0,0,-135])
			translate([0,radius*-0.125,0])
			cube([radius*2,radius*0.25,depth]);
		
			translate([radius*2,-radius*2,0])
			rotate([0,0,-45])
			translate([0,radius*-0.125,0])
			cube([radius*2,radius*0.25,depth]);
		}
	}
			

	translate( [((height-width)*0.5)-radius-gap,depth,((height+width)*0.5)-radius])
	arm(radius,depth);
	translate( [((height+width)*0.5)+radius+gap,depth,((height+width)*0.5)-radius])
	arm(radius,depth);

	translate( [(height*0.5)+(1.8*radius),depth,(height*0.4)])
	arm(radius,depth);
	translate( [(height*0.5)-(1.8*radius),depth,(height*0.4)])
	arm(radius,depth);

	translate([height*0.5+width*0.35,depth,height*0.95])
	rotate([0,40,0])
	arm(radius*0.3,depth);

	translate([height*0.5-width*0.35,depth,height*0.95])
	rotate([0,-40,0])
	arm(radius*0.3,depth);
	}
}

module arm(radius,depth)
{
	hull()
	{
		rotate([-90,0,0])
		cylinder(depth,radius,radius);
		translate([0,0,-4.7*radius])
		rotate([-90,0,0])
		cylinder(depth,radius,radius);
	}
}


/*translate([0,0,20])
pattern_shape(10, 5, 1);

translate([0,0,30])
pattern_shape(10, 5, 2);

translate([0,0,40])
pattern_shape(10, 5, 3);

translate([0,0,50])
pattern_shape(10, 5, 4);

translate([0,0,60])
pattern_shape(10, 5, 5);
*/

module pattern_shape( radius, height, patternID )
{
	if( patternID == 1 )
	{
		cylinder(height, radius, radius);
	}
	else if (patternID == 2)
	{
		android(radius*2, height);
	}
	else if (patternID == 3)
	{
		apple( radius, height );
	}
	else if (patternID == 4)
	{
		fish( radius, height );
	}
	else if (patternID == 5)
	{
		makerbot_logo( radius, height );
	}
}

module apple(radius, depth)
{
	fish_scale = 0.22 * (radius/5);
	fish_height = depth/fish_scale;

	difference()
	{
		translate( [-radius*0.9,0,depth*0.5] )
		scale(fish_scale)
		translate( [20,0,0] )
		linear_extrude(height = fish_height, center = true)
		polygon([[0,-15],[-4,-16],[-7,-16],[-10,-14],[-12,-11],[-15,-5],[-17,3],[-17,7],[-16,11],[-15,13],[-13,15],[-9,16],[-5,16],[-3,15],[0,14],[3,15],[5,16],[9,16],[13,15],[15,13],[16,11],[17,7],[17,3],[15,-5],[12,-11],[10,-14],[7,-16],[4,-16]]);

		translate( [radius*0.8,radius*0.2,0] )
		cylinder(depth, radius*0.4, radius*0.4);
	}

	translate( [-radius*0.9,0,depth*0.5] )
	scale(fish_scale)
	translate( [20,0,0] )
	linear_extrude(height = fish_height, center = true)
	polygon([[0,20],[0,17],[3,17],[6,18],[7,19],[8,20],[9,23],[9,26],[9,26],[6,26],[3,25],[2,24],[1,23]]);


}

module fish(radius, depth)
{
	fish_scale = 0.22 * (radius/5);
	fish_height = depth/fish_scale;
	translate( [-radius*0.9,0,depth*0.5] )
	scale(fish_scale)
	translate( [43,-12,0] )
	linear_extrude(height = fish_height, center = true)
	polygon([[-45,12],[-41,16],[-38,18],[-34,20],[-30,21],[-25,21],[-21,20],[-19,19],[-16,17],[-14,14],[-13,15],[-12,18],[-9,21],[-4,22],[-6,19],[-8,17],[-9,13],[-9,11],[-8,7],[-6,5],[-4,2],[-9,3],[-12,6],[-13,9],[-14,10],[-16,7],[-19,5],[-21,4],[-25,3],[-30,3],[-34,4],[-38,6],[-41,8]]);
}

module makerbot_logo(radius, height)
{
	width=radius*0.13;
	cut=width*1.3;
	angle=asin(cut/radius);
	aangle=0;
	x1=(radius-width*0.5)*sin(angle+aangle);
	y1=(radius-width*0.5)*cos(angle+aangle);
	x2=(radius-width*0.5)*sin(-angle+aangle);
	y2=(radius-width*0.5)*cos(-angle+aangle);
	mwidth=width*1.8;
	mgap=width*1.3;
	mheight = radius*1.3;

	difference()
	{
		cylinder(height, radius, radius);
		cylinder(height, radius-width, radius-width);
		translate([0,0,height*0.5])
		rotate([0,0,-aangle])
		{
			cube([2*radius,cut+width,height],true);
			cube([cut+width,2*radius,height],true);
		}
	}

	translate([x1,y1,0])
	cylinder(height, width*0.5, width*0.5);
	translate([y1,-x1,0])
	cylinder(height, width*0.5, width*0.5);
	translate([-y1,x1,0])
	cylinder(height, width*0.5, width*0.5);
	translate([-x1,-y1,0])
	cylinder(height, width*0.5, width*0.5);
	translate([x2,y2,0])
	cylinder(height, width*0.5, width*0.5);
	translate([y2,-x2,0])
	cylinder(height, width*0.5, width*0.5);
	translate([-y2,x2,0])
	cylinder(height, width*0.5, width*0.5);
	translate([-x2,-y2,0])
	cylinder(height, width*0.5, width*0.5);


	translate([0,mwidth*-0.25,height*0.5])	
	cube([mwidth,mheight-1.5*mwidth,height],true);
	translate([mwidth+mgap,mwidth*-0.25,height*0.5])
	cube([mwidth,mheight-1.5*mwidth,height],true);
	translate([-mwidth-mgap,mwidth*-0.25,height*0.5])
	cube([mwidth,mheight-1.5*mwidth,height],true);
	translate([0,(mheight-mwidth)*0.5,height*0.5])	
	cube([mwidth+2*mgap,mwidth,height],true);

	translate([-mgap-mwidth*0.5,mheight*0.5-mwidth,0])
	difference()
	{
		cylinder(height,mwidth,mwidth);
		translate([0,-mwidth,0])
		cube([mwidth,mwidth,height]);
	}

	translate([mgap+mwidth*0.5,mheight*0.5-mwidth,0])
	difference()
	{
		cylinder(height,mwidth,mwidth);
		translate([-mwidth,-mwidth,0])
		cube([mwidth,mwidth,height]);
	}

	translate([-mwidth-mgap,-(mheight-mwidth)*0.5,0])
	cylinder(height,mwidth*0.5,mwidth*0.5);

	translate([0,-(mheight-mwidth)*0.5,0])
	cylinder(height,mwidth*0.5,mwidth*0.5);

	translate([mwidth+mgap,-(mheight-mwidth)*0.5,0])
	cylinder(height,mwidth*0.5,mwidth*0.5);

}
//Code by Griffin Nicoll 9/2011
//commented paramiters and added better infill 2/2012
//Licence: Attribution-Share Alike-Creative Commons

gap_w = 0.6; //width of gap in joints
gap_h = 0.5; //height of gap over and under link
handle_x = 125; //length of handle
handle_y = 16; //width of handle
handle_z = 16; //height of handle
handle_b = 5.5; //height of handle bevel. less then half total height
handle_w1 = 2; //handle wall width
handle_w2 = 1; //extra wall thickness by teeth
handle_w3 = 1; //wall width at top and bottom
handle_cut = 12; //offset of sniped off corners
joint_r1 = 8; //radius of joints in the middle
joint_r2 = 4; //radius of joints at exterior
joint_a = 30; //widest angle the cracker can open
link_x = 4; //width of link
link_y = 13; //length of link. controls handle seperation
link_z = 7; //height of link
tooth_n = 5; //number of teeth
tooth_r = 3; //radius of teeth
tooth_s = 8; //teeth spacing
tooth_x = 9; //teeth placement in x
tooth_y = 15; //teeth placement in y
tooth_z = 4; //teeth placement in z
truss_n = 13; //number of internal truss elements

//a shape used in the joint
module part_cylinder(h,r1,r2,a)
{
intersection()
	{
	cylinder(h,r1,r2);
	if(a<360 && a>0)linear_extrude(height=h,twist=0)
	polygon(points=([[0,0],[2*max(r1,r2),0],[2*max(r1,r2)*cos(a*1/4),2*max(r1,r2)*sin(a*1/4)],[2*max(r1,r2)*cos(a*2/4),2*max(r1,r2)*sin(a*2/4)],[2*max(r1,r2)*cos(a*3/4),2*max(r1,r2)*sin(a*3/4)],[2*max(r1,r2)*cos(a),2*max(r1,r2)*sin(a)]]),paths=([[0,1,2,3,4,5]]));
	}
if(a>=360)cylinder(h,r1,r2);
}

//used to make the gap between sliding parts
module gap_shape(h,w)
{
	union()
	{
		cylinder(h=h,r1=w,r2=0);
		mirror([0,0,1])cylinder(h=h,r1=w,r2=0);
	}
}

module handle(x,y,z,b)
{
	difference()
	{
		union()
		{
			//teeth
			for(i=[1:tooth_n])translate([tooth_x+tooth_s*i,tooth_y,tooth_z])sphere(r=tooth_r);
			//body
			minkowski()
			{
				translate([0,b*sqrt(2)-b,0])cube(size=[x+b-b*sqrt(2),y+b-b*sqrt(2),z-b]);
				intersection()
				{
					intersection_for(n=[2:5])
					{
						rotate([0,0,n*270/6])translate([b,0,0])sphere(r=b*sqrt(2),$fn=32);
					}
					translate([0,-b,0])cube(size=b);
				}
			}
		}
		//subtracted inside
		translate([(max(joint_r1,joint_r2)+gap_w+handle_w1)*2,handle_w1,-handle_w3])
		inside(x-(max(joint_r1,joint_r2)+gap_w)*2-handle_w1*3,y-handle_w1*2-handle_w2,z,handle_b-handle_w3);
	}
}

//inside subtracted shape
module inside(x,y,z,b)
{
	difference(){
		cube(size=[x,y,z]);
		//truss elements
		for(i=[0:truss_n]){
			translate([i*x/truss_n,y/2,z/2])rotate([0,0,i%2*60-30])
			cube(size=[handle_w1,2*y,z],center=true);
		}
		//clipped corner to avoid bevel
		translate([0,0,z-b])rotate([65,0,0])cube(size=[x,b*2,b]);
	}
}

//one quarter of the cracker
module side()
{
	difference()
	{
		//handle solid
		translate([-max(joint_r1,joint_r2)-gap_w-handle_w1,-(max(joint_r1,joint_r2)+gap_w)*sin(joint_a)-handle_w1,0])handle(x=handle_x,y=handle_y,z=handle_z/2,b=handle_b);
		//joint subtraction
		minkowski()
		{
			gap_shape(gap_h,gap_w);
			part_cylinder(h=handle_z/2,r1=joint_r1,r2=joint_r2,a=180+joint_a,$fn=32);
		}
		//gap to let the link move
		minkowski()
		{
			gap_shape(gap_h,gap_w);
			rotate([0,0,90])part_cylinder(h=0.00001,r1=link_y,r2=link_y,a=joint_a);
			part_cylinder(h=min(link_x,link_z)/2,r1=min(link_x,link_z)/2,r2=0,a=180);
			if(link_x>link_z) translate([-(link_x-link_z)/2-1,0,0])cube(size=[link_x-link_z,link_y,2]);
			else if (link_x<link_z) translate([-1,0,0])cube(size=[2,link_y,link_z-link_x]);
			else translate([-1,0,0])cube(size=[2,link_y,2]);
		}
		//snipped corner
		rotate([0,0,joint_a-90])translate([-handle_y-handle_cut,-handle_z/2,-1])cube(size=handle_z);
	}
	union()
	{
		//joint inside
		part_cylinder(h=handle_z/2,r1=joint_r1,r2=joint_r2,a=180,$fn=32);
		//link shaft
		minkowski()
		{
			part_cylinder(h=min(link_x,link_z)/2,r1=min(link_x,link_z)/2,r2=0,a=180);
			if(link_x>link_z) translate([-(link_x-link_z)/2-1,0,0])cube(size=[link_x-link_z,link_y,2]);
			else if (link_x<link_z) translate([-1,0,0])cube(size=[2,link_y,link_z-link_x]);
			else translate([-1,0,0])cube(size=[2,link_y,2]);
		}
	}
}

//all the quarters together. comment one out to see inside
side();
mirror([0,0,1])side();
mirror([0,1,0])translate([0,-link_y*2,0])side();
mirror([0,1,0])translate([0,-link_y*2,0])mirror([0,0,1])side();
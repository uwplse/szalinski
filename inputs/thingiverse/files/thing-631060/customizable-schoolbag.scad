// bag

//Move the height.
h_bag = 35; //[20:50]

//Move the lenght.
l_bag = 30; // [20:50]

//Move the width.
w_bag = 12; // [10:30]


l_pocket = l_bag/4;

r_round   = w_bag/6;
e_flap    = w_bag/8;
r_handle  = l_bag/5.5;
r_handle2 = r_handle/3.5;
h_handle  = r_handle+r_handle2;
w_handle  = r_handle2*2;
d_handle  = 2*(h_handle)/3;
h_flap    = 40*(h_bag-h_handle-w_bag/2)/100;

$fn=100;

module support()  
{
	cube([w_handle,h_handle/2,+l_bag/2-r_handle-r_handle2]);
}

module handle()
{
	difference()
	{
		rotate_extrude(convexity = 10)
		translate([r_handle, 0, 0])
		circle(r = r_handle2, $fn =100);
		translate([ -(r_handle+r_handle2),-(r_handle+r_handle2), -r_handle2])cube([(r_handle+r_handle2)*2,(r_handle+r_handle2),r_handle2*2]);
	}
}

module pocket(l,h,r,e)
{
	hull()
	{
		translate(v=[-l+r,0,0])cube([l,h-r,e]);
		cylinder(r=r,h=e);
	   translate(v=[-l+r*2,0,0])cylinder(r=r,h=e);
	}
}

module pocket_h(l,h,r,e)
{
	hull()
	{
		translate(v=[-l+r,0])cube([l,h-r,e]);
		translate(v=[0,h,0])cylinder(r=r,h=e);
	   translate(v=[-l+r*2,h,0])cylinder(r=r,h=e);
	}
}

module front_flap()
{
	hull()
	{
		translate(v=[-l_bag+r_round,0,0])cube([l_bag,h_flap-r_round,e_flap]);
		cylinder(r=r_round,h=e_flap);
	   translate(v=[-l_bag+r_round*2,0,0])cylinder(r=r_round,h=e_flap);
	}
}

module flap()
{
	translate(v=[-r_round+w_bag/2,h_bag-r_round-h_handle-w_bag/2])color("yellow")

			{	
             intersection()
             { 
             	 translate(v=[-w_bag,0])square([w_bag*2,w_bag]);		
				    difference()
				    {
				    	circle(r=w_bag/2);
				      circle(r=w_bag/2-e_flap);
				    }
				 }
			}
}

module section()
{
	difference()
	{
		union()
		{
			hull()
			{
				translate(v=[-r_round,h_bag-r_round-h_handle-w_bag/2])square([w_bag  - e_flap,0.1]);
				color("green")square([w_bag - 2*r_round - e_flap,
			                       h_bag-r_round-h_handle-w_bag/2]);
				circle(r=r_round);
				translate(v=[w_bag-2*r_round-e_flap,0])circle(r=r_round);
			}		   
         flap();			
		}

		// inside
		translate(v=[-r_round+w_bag/2,0.1+h_bag-r_round-h_handle-w_bag/2])scale([1,0.32])circle(r=w_bag/2-e_flap);

		// below
		translate(v=[-r_round+(w_bag-e_flap)/2,-r_round-.68])color("yellow")scale([1.1,0.38])circle(r=(w_bag-e_flap-r_round)/2-1);
	
		// behind
		translate(v=[-r_round*1.2,(h_bag-r_round-h_handle-w_bag/2)/2])color("yellow")scale([0.1,1.2])circle(r=(h_bag-r_round-h_handle-w_bag/2-e_flap)/2);

	}
}

///////////////////////////////////////////////////////////////////////////
rotate(90,[1,0,0])
{
linear_extrude(height = l_bag)
section();

translate(v=[w_bag-r_round-e_flap,-h_flap+h_bag-h_handle-w_bag/2,+r_round])rotate(90,[0,1,0])pocket(l=l_bag,h=h_flap,r=r_round,e=e_flap);

//pockets
translate(v=[w_bag-r_round-e_flap,-h_flap*2+h_bag-h_handle-w_bag/2,
r_round+(l_bag-l_pocket*2)/4])
color("yellow")rotate(90,[0,1,0])pocket(l=l_pocket,h=h_flap,r=r_round,e=e_flap*0.75);

translate(v=[w_bag-r_round-e_flap,-h_flap*2+h_bag-h_handle-w_bag/2,
r_round+l_bag-l_pocket-(l_bag-l_pocket*2)/4])
color("yellow")rotate(90,[0,1,0])pocket(l=l_pocket,h=h_flap,r=r_round,e=e_flap*0.75);

// handle
translate(v=[-r_round+w_bag/2,h_bag-r_round-h_handle-e_flap/2,+l_bag/2])
rotate(90,[0,1,0])handle();


// support
//translate(v=[w_bag/2-r_round-w_handle/2,h_bag-r_round-h_handle+0.5,0])support();

}
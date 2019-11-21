
module roundedRect(size, radius)
{
	x = size[0];
	y = size[1];
	z = size[2];

	linear_extrude(height=z)
	hull()
	{
		// place 4 circles in the corners, with the given radius
		translate([(-x/2)+(radius/2), (-y/2)+(radius/2), 0])
		circle(r=radius);
	
		translate([(x/2)-(radius/2), (-y/2)+(radius/2), 0])
		circle(r=radius);
	
		translate([(-x/2)+(radius/2), (y/2)-(radius/2), 0])
		circle(r=radius);
	
		translate([(x/2)-(radius/2), (y/2)-(radius/2), 0])
		circle(r=radius);
	}
}

module mx1000_bat_cov()
{

//dimensions
L1 = 53.5;//length of main body
L2 = 23.4;//width of main body (flat section only)
L3 = 9;//width of main body (angled section only)
L4 = 14.75;//center-to-center
L5 = 4-1.35;//height of end clips
L6 = 2.2;//Length of end clips
L7 = 4.9;//width of end clips
L8 = 15.6;//width of retension clip
L9 = 11.1;//height of retension clip
L10 = 5.25;// offset for catch
L11 = 3;// length of catch
T1 = 1.35;//thickness of main body
T2 = 1.1;//thickness of end clips
T3 = 1; //thickness of retension clip
T4 = 2.25; //thickness of catch
D1 = 5; //outer diamater of retension clip
D2 = D1 - 2*T3;//inner diamater of retension clip
A1 = 5.5; //angle of main (angled) body (trimming)
//Calculate the offset from rotation using (a^2 + b^2 = c^2)
CL1 = sqrt(((L3/2)*(L3/2))/2);
//add half the length of the main section
CL2 = CL1 + L2/2;
//Now move based on the material thickness using (a^2 + b^2 = c^2)
CL3 = CL2 - sqrt(((T1/2)*(T1/2))/2);

			union() 
			{
				//the main body
				//cube([L1, L2, T1], center = true);
                roundedRect([L1, L2, T1], 1, $fn=50);
                
				//The angled sections (#1)
				//translate([0,CL3,(L3/2)-.75*T1])
				//rotate([45,0,0])
				//difference () //difference
				//{
				//	cube([L1, L3, T1], center = true);

				//	translate([(((L1*1.1)/2)-L3*sin(A1)),L3/2,0])
				//	rotate([0,0,A1])
				//	cube([L1*.1, L3*2, T1], center = true);
				//	translate([-(((L1*1.1)/2)-L3*sin(A1)),L3/2,0])
				//	rotate([0,0,-A1])
				//	cube([L1*.1, L3*2, T1], center = true);
				//}
				//The angled sections (#2)
				//translate([0,-CL3,(L3/2)-.75*T1])
				//rotate([-45,0,0])
				//difference () //difference
				//{
				//	cube([L1, L3, T1], center = true);

				//	translate([-(((L1*1.1)/2)-L3*sin(A1)),-L3/2,0])
				//	rotate([0,0,A1])
				//	cube([L1*.1, L3*2, T1], center = true);
				//	translate([(((L1*1.1)/2)-L3*sin(A1)),-L3/2,0])
				//	rotate([0,0,-A1])
				//	cube([L1*.1, L3*2, T1], center = true);
				//}
				// the end clips
				translate([(L1/2)-.5,L4/2,(L5+T2)/2])
				cube([T2, L7, L5], center = true);
				translate([(L1/2)-.5,-L4/2,(L5+T2)/2])
				cube([T2, L7, L5], center = true);
				// the end clip extensions
				translate([L1/2,L4/2,L5])
				cube([L6, L7, T2], center = true);
				translate([L1/2,-L4/2,L5])
				cube([L6, L7, T2], center = true);
			

			translate([-((L1/2)+(D2/2)),0,0]) {
			difference () //difference
				{
				//The outer cylinder (OD)
				translate([0,0,L9-(D1/2)])
				rotate([90,0,0])
				scale([1/100,1/100,1/100])
				cylinder(100*L8, 100*(D1/2), 100*(D1/2), center = true);
				//The inner cylinder (ID)
				translate([0,0,L9-(D1/2)])
				rotate([90,0,0])
				scale([1/100,1/100,1/100])
				cylinder(100*L8, 100*(D2/2), 100*(D2/2), center = true);
				translate([0,0,L9-(D1/2)-((D1/2)/2)])
				cube([D1, L8+.1, D1/2], center = true);
				}//difference

				translate([((D1/2)-(T3/2)),0,(L9/2)-D1/4])
				cube([T3, L8, L9-(D1/2)], center = true);
				translate([-((D1/2)-(T3/2)),0,(L9/2)-D1/4])
				cube([T3, L8, L9-(D1/2)], center = true);	
				//The retension catches
				translate([-D1/2,((L8/2)-(T4/2)),L10+L11/2])
				rotate([0,15,0])
				cube([T3,T4,L11]	, center = true);	
				translate([-D1/2,-((L8/2)-(T4/2)),L10+L11/2])
				rotate([0,15,0])
				cube([T3,T4,L11]	, center = true);	
			}//Translate
		}//union
}

 mx1000_bat_cov();


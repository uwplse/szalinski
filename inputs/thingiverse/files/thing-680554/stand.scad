//-----------------------------------------------------------------------------------
//libraries
//-----------------------------------------------------------------------------------
//polyholes lib is in local dir
use <MCAD/polyholes.scad>

//-----------------------------------------------------------------------------------
//global configuration settings
//-----------------------------------------------------------------------------------
//epsilon param, so differences are scaled and do not become manifold
de = 0.1; 

//-----------------------------------------------------------------------------------
//parametric settings (object dimensions)
//-----------------------------------------------------------------------------------
//length of arm section
P10 = 80;  
//length of bracket section
P12 = 20; 
//thickness of bracket arms
P20 = 5;
//clearance between bracket arms
P21 = 7.6; 
//height of foot
P30 = 2*P20+P21;
//distance of holes from top end of bracket arms
P40 = 9;
//holes diameter
P41 = 6.2; 
//bracket nut trap wrench size
P42 = 10.2; 
//bracket nut trap depth
P43 = 4;     
//Angle of arm (0..90)
Angle=75;

//Base Radius
BaseRadius=60;
//Base Height, radius of profile
BaseH=12;
module micholder()
{
    difference()
    {
        union()
        {
            //main body
            //translate([0, 0, 0])
                cube([P10+P12-P30/2, 2*P20+P21, P30]);
				translate([P10+P12-P30/2, P30, P30/2])
					 rotate([90,0,0])
						cylinder(r=P30/2, h= P30);
        }  //union 1

        union()
        {
            //cutout for bracket arms
            translate([P10, P20, -de])
                cube([P12+de, P21, P30+2*de]);

            //bracket arms bores
            translate([P10+P12-P40, -de, P30/2])
                rotate([-90, 0, 0])
                polyhole(d=P41, h=2*P20+P21+2*de);
            //and nut trap on south arm
            translate([P10+P12-P40, -de, P30/2])
                rotate([-90,0,0])
                cylinder(r = P42 / 2 / cos(180 / 6) + 0.05, h=P43+de, $fn=6);
 
        }  //union 2
    }  //difference
}

module base(r,R) {
	difference(){
		hull()
		rotate_extrude(convexity = 10, $fn=50)
			translate([R-r,0,0]) circle(r=r);
		translate([0,0,-r]) cylinder(r=2*R, h=r);
	}
}

difference(){
union(){
	translate([(2*P20+P21)/2,-P30/2, BaseH-cos(Angle)*P30]) rotate([0,-Angle,0]) micholder();
	base(BaseH,BaseRadius);
}
translate([0,0,-2*P30]) cylinder(r=BaseRadius, h=2*P30);
}
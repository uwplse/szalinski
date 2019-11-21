

diameter=60; //[5:100]
hight=20;	//[0:100]
column_number=8; //[0:36]

$fn=30; 

base_hight=2+hight/10;
column_diameter=1+diameter/8;
radius=diameter/2;

translate([0,0,base_hight/2])
cylinder(h=base_hight, r=radius, center=true);

column_z=base_hight+hight/2;

for ( i = [0 : column_number-1] )
{
    rotate( i * 360 / column_number, [0, 0, 1])
    translate([0, (diameter-column_diameter)/2, base_hight+hight/2])
  		cylinder(h=hight, r=column_diameter/2, center=true);
}

cupola();


module cupola()
{
	translate([0,0,base_hight+hight])
	difference()
	{
	
		sphere(r=radius, center=true);
		sphere(r=radius-column_diameter, center=true);
		translate([0,0,-diameter/2])
		cube(diameter, center=true);
	}

}

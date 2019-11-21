
Cone_Height = 50; 
Upper_Radius = 37; 
Lower_Radius = 34; 

Ecig_body_Width= 23; 
Ecig_body_Length = 36; 
Bottom_Wall_Height = 10;
// - Corner radius (optional)
Corner_radius = 2;


difference  (){

translate([0,0,0]) cylinder( h = Cone_Height, r2 = Upper_Radius , r1 = Lower_Radius , $fn=300);
 roundedRect([Ecig_body_Width, Ecig_body_Length,Cone_Height +2],  Corner_radius, $fn=30);

}

module roundedRect(size, radius)
{
	x = size[0];
	y = size[1];
	z = size[2];

	translate ([0,0,Bottom_Wall_Height ]) linear_extrude(height=z+2)
	hull()
	{

		translate([(-x/2)+(radius), (-y/2)+(radius), 0])
		circle(r=radius);
	
		translate([(x/2)-(radius), (-y/2)+(radius), 0])
		circle(r=radius);
        
		translate([(-x/2)+(radius), (y/2)-(radius), 0])
		circle(r=radius);
	
		translate([(x/2)-(radius), (y/2)-(radius), 0])
		circle(r=radius); 

	}
} 

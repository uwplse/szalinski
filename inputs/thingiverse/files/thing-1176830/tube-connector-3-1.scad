hole_diameter=4.5;

hole_resolution=20;//[6:50]

wall_thickness=1;

insertion_depth=10;

bend_height=7;

bend_resolution=15;//[5:30]




radius_to_hole_center=(hole_diameter+wall_thickness)/sqrt(3);

difference()
{
positive_shapes(hole_diameter,wall_thickness,insertion_depth,radius_to_hole_center,bend_height);
translate([0,0,-0.5])
negative_shapes(hole_diameter,wall_thickness,insertion_depth,radius_to_hole_center,bend_height,bend_resolution);
}



module positive_shapes(
    HD,
    WT,
    ID,
    RHC,
	BH,)
{
	cylinder(r=HD/2+WT+RHC,h=ID+BH/2);
	translate([0,0,ID+BH/2])
		cylinder(r1=HD/2+WT+RHC,r2=HD/2+WT,h=BH/2);
	translate([0,0,ID+BH])
	cylinder(r=HD/2+WT,h=ID);
}

module negative_shapes(
    HD,
    WT,
    ID,
    RHC,
	BH,
    BR)
    {
    for(i=[0:120:359])
        {
        rotate([0,0,i])
        translate([cos(i)*RHC,sin(i)*RHC,0])
            {       
			cylinder(r=HD/2,h=ID,$fn=hole_resolution);
			translate([0,0,ID])
			rotate([0,0,i])
				s_bend(RHC,BH,BR)
				   cylinder(r=HD*9/20,h=0.1,$fn=hole_resolution,center=true);
            }           
        }
		translate([0,0,ID+BH])
			cylinder(r=HD/2,h=ID+1,$fn=hole_resolution);
    }    
    
module s_bend(X,Z,BR)
    {
		
		degree=atan((X*2)/Z);
		echo (degree);
		step=degree/BR;
		echo(step);
        for(i=[0:step:degree-step])
        {
		hull()
			{
			translate([(((cos(i)-cos(degree))/(1-cos(degree))*X/2)-X/2),0,((sin(i)/(sin(degree))*Z/2))])
			rotate([0,-i,0])
				children();
			translate([(((cos(i+step)-cos(degree))/(1-cos(degree))*X/2)-X/2),0,((sin(i+step)/(sin(degree))*Z/2))])
			rotate([0,-i-step,0])
				children();
			}
			
			hull()
				{
				translate([-X/2,0,Z])
					{
					mirror([1,0,0])
					mirror([0,0,1])
						{
					translate([(((cos(i)-cos(degree))/(1-cos(degree))*X/2)),0,((sin(i)/(sin(degree))*Z/2))])
					rotate([0,-i,0])
						children();
					translate([(((cos(i+step)-cos(degree))/(1-cos(degree))*X/2)),0,((sin(i+step)/(sin(degree))*Z/2))])
					rotate([0,-i-step,0])
						children();
						}
					}
				}
		}
    }

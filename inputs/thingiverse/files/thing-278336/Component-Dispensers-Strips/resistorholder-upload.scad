strip_width=65; //65
storage_diameter=17; //17
component_diameter=3; //3
wall_mounting_thickness=2; //2
length_of_feed=2; //2
length_of_endcap=0;  //0
n=2; //5
wall_mounting=true; //true
module holder()
{
difference()
{
	cube([storage_diameter+wall_mounting_thickness*2+length_of_feed, strip_width+wall_mounting_thickness*2+length_of_endcap, storage_diameter+wall_mounting_thickness*2]);
	translate([wall_mounting_thickness+storage_diameter/2, wall_mounting_thickness, wall_mounting_thickness+storage_diameter/2])
	{
		rotate(a=[90,0,180]){
			cylinder(h=strip_width+length_of_endcap+wall_mounting_thickness+1, r=storage_diameter/2);
		}
	}
	translate([storage_diameter+wall_mounting_thickness*2+length_of_feed,wall_mounting_thickness,component_diameter+wall_mounting_thickness])
	{
		rotate(a=[0,180,0]) {
			cube([length_of_feed+wall_mounting_thickness+storage_diameter/2,strip_width, component_diameter]);
		}
	}
	translate([storage_diameter/2+wall_mounting_thickness,wall_mounting_thickness+strip_width,wall_mounting_thickness])
	{
		rotate(a=[0,0,0]) {
			cube([storage_diameter/2,length_of_endcap+wall_mounting_thickness, component_diameter]);
		}
	}
}
} 

module wall_mounting()
{
difference()
{
	translate([0,0,component_diameter+storage_diameter])
	{
		cube([wall_mounting_thickness, strip_width+wall_mounting_thickness*2+length_of_endcap, 8]);
	}


	translate([-.5,(strip_width+wall_mounting_thickness+length_of_endcap)/6, 4+component_diameter+storage_diameter])
	{
		rotate([0,90,0])
		{
			cylinder(h=wall_mounting_thickness+1, r=2.5/2);
		}
	}
	translate([-.5,((strip_width+wall_mounting_thickness+length_of_endcap)*5/6)+2.5/2, 4+component_diameter+storage_diameter])
	{
		rotate([0,90,0])
		{
			cylinder(h=wall_mounting_thickness+1, r=2.5/2);
		}
	}

}	
}
rotate(a=[90,0,0]){
if (wall_mounting==true)
{
	wall_mounting();
}
for (i=[0:n-1])
{
	translate([0,0,-i*(storage_diameter+wall_mounting_thickness)])
	{
	holder();
	}
}
}
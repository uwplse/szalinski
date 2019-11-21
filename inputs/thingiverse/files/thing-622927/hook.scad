/* [Size] */

//the inside diameter of the hook (=fit around a pipe with this diameter) [mm], must be > 0
diameter=30;

//the thickness of the hook [mm], must be > 0
thickness=5;

//the width of the hook [mm], must be > 0
width=10;

//the hole diameter [mm], must be > 0 and < width
hole=3;


/* [Hidden] */

//makes the customizer preview faster than the final rendering by using lower quality

preview_tab="";
if (preview_tab=="")
	hook(roughness=1,$fa=2,$fs=.2);
else
	hook(roughness=10,$fa=5,$fs=.4);


module hook(roughness)
{
	
	hole_roundness=min(width-hole,thickness)/2;
	
	difference()
	{
		cylinder(r=diameter/2+thickness,h=width);
		translate([0,0,-1]) cylinder(r=diameter/2,h=width+2);
		translate([-diameter-thickness,0,-1]) cube([2*(diameter+thickness),diameter,width+2]);
	}
	
	translate([diameter/2,0,0]) cube([thickness,diameter/4,width]);
	
	for(i=[roughness:roughness:180])
		hull()
		{
			translate([(1+cos(i-roughness))*(diameter+thickness)/4,diameter*(0.25+(i-roughness)/180),0])cylinder(r=thickness/2,h=width);
			translate([(1+cos(i))*(diameter+thickness)/4,diameter*(0.25+i/180),0])cylinder(r=thickness/2,h=width);
		}
	
	difference()
	{
		translate([-thickness/2,1.25*diameter,0]) cube([thickness,width+thickness/2-hole_roundness,width]);
		translate([0,1.25*diameter+width/2+thickness/2-hole_roundness,width/2])
			rotate([0,90,0])
				difference()
				{
					cylinder(r=hole/2+hole_roundness,h=thickness*2,center=true);
					rotate_extrude()
						hull()
						{
							translate([hole/2+hole_roundness,thickness/2-hole_roundness,0]) circle(r=hole_roundness);
							translate([hole/2+hole_roundness,hole_roundness-thickness/2,0]) circle(r=hole_roundness);
						}
			}
	}
	
}
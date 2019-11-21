barrel_diameter= 51;
barrel_diameter_min = 48.5;
depth=25;
arm_length=80;
screw_offset = 0;

rotate([0,90,0]) intersection()
{
	cube([depth+1,arm_length*2,barrel_diameter+14],center=true);
	difference()
    {
        //Main Body
		union()
        {
			rotate([0,90,0])
                cylinder(d=barrel_diameter+6,h=depth,center=true,$fa=5);
            
			rotate([-135,0,0]) 
                translate([0,barrel_diameter/2,barrel_diameter/2]) 
                    cube([depth,barrel_diameter,barrel_diameter],center=true);
			
            //translate([-depth/2,0,-barrel_diameter/2-7]) cube([depth,arm_length,barrel_diameter/2+4]);
			
            translate([-depth/2,0,-barrel_diameter/2-7]) 
                cube([depth,arm_length,7]);
			
            translate([-depth/2,0,-barrel_diameter/2]) 
                cube([depth,barrel_diameter+3,barrel_diameter/2]);
		}
        
        //All the holes
		union()
        {
            //Binocular Barrel - can be concial
			rotate([0,90,0]) 
                cylinder(d2=barrel_diameter, d1=barrel_diameter_min,h=depth+1,center=true,$fa=5);
			
            
            //Cut-out inside of barrel clamp
            translate([0,barrel_diameter+4.5,0]) 
                rotate([0,90,0]) 
                    minkowski ()
                        {
                            cube ([barrel_diameter-3, barrel_diameter-3, 2 * depth], center=true);
                            sphere (3, $fn=16);
                        }
            
            //Top barrel clamp cut-out
			translate([0,0,barrel_diameter/2]) 
                rotate([0,90,0]) 
                    cylinder(d=barrel_diameter,h=depth+1,center=true,$fa=5);
            
            //Fillet lower outside of barrel clamp
			rotate([135,0,0]) 
                translate([0,0,barrel_diameter+3]) 
                    rotate([0,90,0]) 
                        cylinder(d=barrel_diameter,h=depth+1,center=true,$fa=5);
            
			//rotate([-135,0,0]) translate([0,0,barrel_diameter+3]) rotate([0,90,0]) cylinder(d=barrel_diameter,h=depth+1,center=true,$fa=5);
            
            //Screw hole        
			translate([0,arm_length/2 + screw_offset,-barrel_diameter/2-3]) 
                cylinder(h=10, d=6.35, center=true, $fn=32);
            
            //Screw head cut-out
			translate([0,arm_length/2 + screw_offset,-barrel_diameter/2-5]) 
                cylinder(h=10, d=12.4, $fa=60);
		}
	}
}
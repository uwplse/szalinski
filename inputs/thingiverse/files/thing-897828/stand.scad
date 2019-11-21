// Base - Dimension (X & Y) in mm
base_dimension = 50;
// Base - Depth in mm
base_thickness = 10;
// Tube - Inner diameter in mm
tube_inner = 33;
// Tube - Height from base in mm
tube_height = 50;
// Tube - Lower outer diameter in mm
tube_lower = 42;
// Tube - Upper outer diameter in mm
tube_upper = 40;
// Tube - Bevel height in mm
tube_bevel_height = 35;
// Anchor hole - Diameter in mm
anchor_hole = 3.4;
// Countersunk head diameter in mm
screwhead_diameter = 7.8;
// Slot width in mm
slot_width = 2;
// Slot depth in mm
slot_depth = 15;
// Anchor location in mm from center
anchor_offset = (base_dimension - 10)/2;

module dd_umbrella_stand(dim,dep,inner,height,lower,upper,bevel) 
	{

	difference()
		{
		union()
			{
                cube([dim,dim,dep],center=true); // base
                cylinder(d=lower,h=bevel,$fn=100); // holder
                cylinder(d=upper,h=height,$fn=100); // bevel top
                }
		union()
			{
                translate([0,0,-6]) cylinder(d=inner,h=height + dep,$fn=100); // pole hole
                translate([0,0,(slot_depth/2) + tube_height - slot_depth+0.1]) cube([tube_lower + 0.1,slot_width,slot_depth],center=true); // cut X axis
                rotate([0,0,90]) translate([0,0,(slot_depth/2) + tube_height - slot_depth+0.1]) cube([tube_lower + 0.1,slot_width,slot_depth],center=true); // cut Y axis
                translate([anchor_offset,anchor_offset,(base_thickness + 0.2)/2]) rotate([180,0,0]) screw(); // screw hole
                translate([-anchor_offset,anchor_offset,(base_thickness + 0.2)/2]) rotate([180,0,0]) screw(); // screw hole
                translate([anchor_offset,-anchor_offset,(base_thickness + 0.2)/2]) rotate([180,0,0]) screw(); // screw hole
                translate([-anchor_offset,-anchor_offset,(base_thickness + 0.2)/2]) rotate([180,0,0]) screw(); // screw hole
                }
		}	

	}
    module screw()
    {
        difference()
        {
            union()
            {
                cylinder(d=anchor_hole, h=base_thickness + 0.2,$fn=100); // screw shaft
                cylinder(r1=screwhead_diameter/2, r2=anchor_hole/2,$fn=100); // screw head
                
            }
            union()
            {
            }
        }
    }
//   screw();
dd_umbrella_stand(base_dimension , base_thickness , tube_inner , tube_height , tube_lower , tube_upper , tube_bevel_height);
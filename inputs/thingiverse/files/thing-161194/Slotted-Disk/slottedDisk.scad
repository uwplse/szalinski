// Slotted disk for use in controlling the timing 
// of solenoid motors (or whatever else).
// This code is released to the Public Domain.
// Attribution would be nice but is not essential.
// Matt Moses 2013

/* [Slots] */
slot_number = 4;
slot_inside_radii = [10, 14, 18, 22];
slot_outside_radii = [11.5, 15.5, 19.5, 23.5];
slot_start_angles = [0, 90, 180, 270];
slot_end_angles = [180, 270, 360, 450];

/* [Disk] */
disk_height = 4;
disk_radius = 26;

/* [Hub] */
hub_height = 8;
hub_diameter = 10;
hub_bore_diameter = 5;

/* [Hidden] */
// facet number. higher = smoother surfaces
$fn = 100; 

slottedDiskWithHub(slot_number, slot_inside_radii, slot_outside_radii,
					slot_start_angles, slot_end_angles, 
					disk_height, disk_radius, hub_height, hub_diameter, hub_bore_diameter);

// This makes a slotted disk with a hub and bore
module slottedDiskWithHub(n,r_in,r_out,a_start,a_end,d_height,disk_outside_rad,hub_height,hub_diameter,hub_bore_diameter)
{
	difference(){
		union(){
			slottedDisk(n,r_in,r_out,a_start, a_end, d_height, disk_outside_rad);
			cylinder(r = hub_diameter/2, h=hub_height, center=false);
		}
		translate([0,0,-0.1*hub_height])
		cylinder(r = hub_bore_diameter/2, h=1.2*hub_height, center=false);
	}
}

// This makes a disk with arc-shaped holes in  it
module slottedDisk(n,r_in, r_out, a_start, a_end, disk_height, disk_r)
{
	
	difference(){
		cylinder(r = disk_r, h = disk_height, center=false);
		for (i=[0:n-1])
		{	
			translate([0,0,-0.1*disk_height])
			arc(r_in[i], r_out[i], 1.2*disk_height, a_start[i], a_end[i]);
		}
	}
}

// This makes an arc shape
module arc(r_in, r_out, arc_height, angle_start, angle_end)
{
	intersection(){
	difference(){
		cylinder(r = r_out, h = arc_height, center = false);
		translate([0,0,-0.1*arc_height])
		cylinder(r = r_in, h = 1.2 * arc_height, center = false);
		
	}
	translate([0,0,-0.1*arc_height])
	wedge(r_out/0.86, 1.2*arc_height, angle_start, angle_end);
	}
}

// This makes a wedge shape for use in boolean operations
// to make arcs. 
// The minimum distance from the origin to an outside edge of 
// the wedge is sqrt(3)/2 * rw = 0.866 * rw
// (angle_end - angle_start) must be more than 0 and less than 360
module wedge(rw, wedge_height, angle_start, angle_end)
{
	dt = (angle_end - angle_start)/6;
	rotate([0,0,angle_start])
	linear_extrude(height = wedge_height, center = false){
	polygon( points = [ [0,0], [rw,0], 
	[rw*cos(dt), rw*sin(dt)],
	[rw*cos(2*dt), rw*sin(2*dt)],
	[rw*cos(3*dt), rw*sin(3*dt)],
	[rw*cos(4*dt), rw*sin(4*dt)],
	[rw*cos(5*dt), rw*sin(5*dt)],
	[rw*cos(6*dt), rw*sin(6*dt)]]);
	}
}



/* [Filament] */

//Filament Diameter
filament_dia=1.75+0.2;

/* [Mounting Holes] */

//Mount Hole Diameter
mount_hole_dia=3.63;
mount_hole_offset_left=19.5;
mount_hole_offset_right=12.5;
mounting_block_left_width=10;
mounting_block_right_width=10;

/* [Caliper Area Settings] */
measurable_length=20;
caliper_rest_length=50;
filament_guide_length=5;
bowden_coupler_length=17;

rotate([90,0,0]){
	difference(){
		translate([-mount_hole_offset_left-(mounting_block_left_width/2),-7.5,9])cube([mounting_block_left_width,14,8]);
		color("red")translate([-mount_hole_offset_left,0,0])cylinder(d=mount_hole_dia,h=30,$fn=8);
	}
	difference(){
		translate([mount_hole_offset_right-(mounting_block_right_width/2),-7.5,9])cube([mounting_block_right_width,14,8]);
		color("red")translate([mount_hole_offset_right,0,0])cylinder(d=mount_hole_dia,h=30,$fn=8);
	}
	difference(){
		color("orange")translate([-16,-7.5,9])cube([26,7.5+3,14+8+measurable_length+caliper_rest_length]);//Base
		color("blue")translate([0,0,9])cylinder(d=filament_dia,h=14+8+measurable_length+caliper_rest_length,$fn=64);//Filament
		color("blue")cylinder(d=14,h=9+bowden_coupler_length,$fn=16);//bowden coupler
		color("green")translate([-7,0,0])cube([14,14,9+bowden_coupler_length]);
		color("black")translate([-(16/2),0,9+bowden_coupler_length+filament_guide_length])cube([16,3,measurable_length+caliper_rest_length]);//Caliper Slot
		color("red")translate([-(16/2),-2,9+bowden_coupler_length+filament_guide_length+measurable_length])cube([16,5,10]);//Caliper Slot Lower bit
		}
}



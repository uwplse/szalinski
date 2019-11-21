$fn=50;

/*PumpHoseAdapter by Mattis Männel
This is a hose adapter for pmumps. It was designed for http://www.thingiverse.com/thing:4881 but should be configureable for any size. Unfortunatly you'll have to merge the adapter to the pump manually in 3D-Design software which is able to load STL-file (i can personally recommend Blender for this purposes). 
*/

/* [Hose Adapter (Idigo, (and Purple, just for length)] */
hose_adapter_length = 7;
inner_diameter = 3.5; 
outer_diameter = 5;

/* [Size] */
width=9;    //9
length=11;   //5
height=5;  //11
hoppper_width=7.8;   
hopper_height=10;   

/* [Ring of the hose mount (Lime)] */
postion_of_the_ring = 3;
ring_diameter = 6;
ring_height = 1;
ring_bevel_difference = 0.5;
ring_bevel_height = 0.25;

/* [Hose adapters' end bevel (Light Purple)] */
end_bevel_differnce = 0.5;
end_bevel_length = 1;

/* [Hose mount guide (Deep Purple)] */
hose_mount_guide_factor = 1;
hose_mount_guide_length = 1;
hose_mount_wall_thickness_top = 0;
hose_mount_wall_thickness_bottom = 1;




module hoseAdapter()
{
    difference()
    {
        /// Don't forget it's rotated by 90° in x-direction later
        union()
        {
            color("Cyan")translate([0,height/2,0])cube([width,height,length],center=true);
            //hose mount guide
            color("MidnightBlue")translate([0,height,0])rotate([270,0,0])difference()
            {
                cylinder(hose_mount_guide_length,d1=outer_diameter * hose_mount_guide_factor + hose_mount_wall_thickness_bottom, d2=outer_diameter * hose_mount_guide_factor +hose_mount_wall_thickness_top);
                cylinder(hose_mount_guide_length,d=outer_diameter * hose_mount_guide_factor);
            }
        }
        
        //hopper
        color("SkyBlue")hull()
        {
            //circle(d=10);
            translate([0,height,0])rotate([90,0,0])cylinder(0.01,d=inner_diameter);
            cube([hoppper_width,.1,hopper_height],center=true);
        }
        //cut through the hose mount guide
        color("DarkSlateGray")translate([0,5,0])rotate([-90,0,0])translate([0,0,-1 ])cylinder(length+1,d=inner_diameter);
    }
    
    
}

module hoseMount()
{
    difference()
    {
        union()
        {
            color("Indigo")cylinder(hose_adapter_length-end_bevel_length,d=outer_diameter);
            color("Purple")translate([0,0,hose_adapter_length-end_bevel_length])cylinder(end_bevel_length,d1=outer_diameter,d2=outer_diameter-end_bevel_differnce);
            color("Lime")translate([0,0,postion_of_the_ring ])cylinder(ring_height,d=ring_diameter);
            color("Lime")translate([0,0,postion_of_the_ring + ring_height])cylinder(ring_bevel_height,d1=ring_diameter,d2=ring_diameter - ring_bevel_difference);
            color("Lime")translate([0,0,postion_of_the_ring - ring_bevel_height])cylinder(ring_bevel_height,d2=ring_diameter,d1=ring_diameter - ring_bevel_difference);
        }
        color("DarkSlateGray")translate([0,0,-0.4 ])cylinder(hose_adapter_length+1,d=inner_diameter);
    }
}

        
translate([0,0,height])hoseMount();
rotate([90,0,0])hoseAdapter();


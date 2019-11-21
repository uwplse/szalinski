$fn=72;


//Plate measures
Plate_horizontal_size=150;
Plate_vertical_size=100;
Plate_thickness=10;
//TV fixing holes measures
Holes_radius=1.75;
Screws_recess_radius=4;
Screws_recess_depth=5;
Holes_horizontal_interaxis=115;
Holes_vertical_interaxis=75;
//If you want it square put this measure to zero
Cut_radius=30;
//Rod measures
Rod_insert_cylinder_radius_top=10;
Rod_insert_cylinder_radius_bottom=15;
Rod_insert_cylinder_height=50;
Rod_radius=5.1;
//Size of nuts for the rods (same as wrench size used to tighten)
Rod_nut_size=20;
Rod_nut_height=15;
//Rounding radius of the rod insert
Rounding_radius=5;
//Reinforcements
Reinforcements_thickness=5;


difference()
    {
    union()
        {
        hull()
            {
            translate([Plate_horizontal_size/2-Plate_thickness/2,Plate_vertical_size/2-Plate_thickness/2,0])
                sphere(r=Plate_thickness);
            translate([-Plate_horizontal_size/2+Plate_thickness/2,Plate_vertical_size/2-Plate_thickness/2,0])
                sphere(r=Plate_thickness);
            translate([Plate_horizontal_size/2-Plate_thickness/2,-Plate_vertical_size/2+Plate_thickness/2,0])
                sphere(r=Plate_thickness);
            translate([-Plate_horizontal_size/2+Plate_thickness/2,-Plate_vertical_size/2+Plate_thickness/2,0])
                sphere(r=Plate_thickness);
            }
//Reinforcements
        hull()
            {
            translate([0,0,Plate_thickness+Rod_insert_cylinder_height-Reinforcements_thickness/2])
                sphere(r=Reinforcements_thickness/2);
            translate([Holes_horizontal_interaxis/2,Holes_vertical_interaxis/2,0])
                sphere(r=Reinforcements_thickness/2);
            translate([-Holes_horizontal_interaxis/2,-Holes_vertical_interaxis/2,0])
                sphere(r=Reinforcements_thickness/2);
            }

        hull()
            {
            translate([0,0,Plate_thickness+Rod_insert_cylinder_height-Reinforcements_thickness/2])
                sphere(r=Reinforcements_thickness/2);
            translate([-Holes_horizontal_interaxis/2,Holes_vertical_interaxis/2,0])
                sphere(r=Reinforcements_thickness/2);
            translate([Holes_horizontal_interaxis/2,-Holes_vertical_interaxis/2,0])
                sphere(r=Reinforcements_thickness/2);
            }

//Rod insert

            translate([0,0,Plate_thickness+Rod_insert_cylinder_height/2])
                rotate([0,0,0])
                    cylinder(r1=Rod_insert_cylinder_radius_bottom,r2=Rod_insert_cylinder_radius_top,h=Rod_insert_cylinder_height,center=true);
        }
//Rod hole
    translate([0,0,Plate_thickness])
        rotate([0,0,0])
            cylinder(r=Rod_radius,h=Rod_insert_cylinder_height*5,center=true);

//Nut hole
    translate([0,0,-1])
        rotate([0,0,0])
            cylinder(r=Rod_nut_size/2*1.117647059,h=Rod_nut_height*2,$fn=6,center=true);

//Cuts
    translate([0,Plate_vertical_size/2,0])
        cylinder(r=Cut_radius,h=Plate_thickness*8,center=true);
    translate([0,-Plate_vertical_size/2,0])
        cylinder(r=Cut_radius,h=Plate_thickness*8,center=true);
    translate([Plate_horizontal_size/2,0,0])
        cylinder(r=Cut_radius,h=Plate_thickness*8,center=true);
    translate([-Plate_horizontal_size/2,0,0])
        cylinder(r=Cut_radius,h=Plate_thickness*8,center=true);

//Fixing holes
    translate([Holes_horizontal_interaxis/2,Holes_vertical_interaxis/2,0])
        cylinder(r=Holes_radius,h=Plate_thickness*4,center=true);
    translate([-Holes_horizontal_interaxis/2,Holes_vertical_interaxis/2,0])
        cylinder(r=Holes_radius,h=Plate_thickness*4,center=true);
    translate([Holes_horizontal_interaxis/2,-Holes_vertical_interaxis/2,0])
        cylinder(r=Holes_radius,h=Plate_thickness*4,center=true);
    translate([-Holes_horizontal_interaxis/2,-Holes_vertical_interaxis/2,0])
        cylinder(r=Holes_radius,h=Plate_thickness*4,center=true);

//Fixing holes screw recess
    translate([Holes_horizontal_interaxis/2,Holes_vertical_interaxis/2,Plate_thickness+Screws_recess_depth*4])
        cylinder(r=Screws_recess_radius,h=Screws_recess_depth*10,center=true);
    translate([-Holes_horizontal_interaxis/2,Holes_vertical_interaxis/2,Plate_thickness+Screws_recess_depth*4])
        cylinder(r=Screws_recess_radius,h=Screws_recess_depth*10,center=true);
    translate([Holes_horizontal_interaxis/2,-Holes_vertical_interaxis/2,Plate_thickness+Screws_recess_depth*4])
        cylinder(r=Screws_recess_radius,h=Screws_recess_depth*10,center=true);
    translate([-Holes_horizontal_interaxis/2,-Holes_vertical_interaxis/2,Plate_thickness+Screws_recess_depth*4])
        cylinder(r=Screws_recess_radius,h=Screws_recess_depth*10,center=true);


//Removal bottom
    translate([-Plate_horizontal_size,-Plate_vertical_size,-Plate_thickness*2])
        cube([Plate_horizontal_size*2,Plate_vertical_size*2,Plate_thickness*2]);

    }



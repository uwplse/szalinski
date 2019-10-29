$fn=50;

//Plate measures
Plate_horizontal_size=100;
Plate_vertical_size=100;
Plate_thickness=10;
//TV fixing holes measures
Holes_radius=1.75;
Screws_recess_radius=4;
Screws_recess_depth=6;
Holes_horizontal_interaxis=75;
Holes_vertical_interaxis=75;
//If you want it square put this measure to zero
Cut_radius=25;
//Rod measures
Rod_insert_cylinder_radius=18;
Rod_insert_cylinder_height=80;
Rod_radius=10.2;
//Size of nuts for the rods (same as wrench size used to tighten)
Rod_nut_size=17;
//Rounding radius of the rod insert
Rounding_radius=5;

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
//Rod insert
        hull()
            {
            translate([0,0,Plate_thickness+Rod_nut_size+Rounding_radius])
                rotate([0,90,0])
                    cylinder(r=Rod_insert_cylinder_radius,h=Rod_insert_cylinder_height,center=true);
            translate([0,0,0])
            cube([Rod_insert_cylinder_height,Rod_insert_cylinder_radius*2,1],center=true);
            }
    
                        translate([0,0,Plate_thickness])
                            cube([Rod_insert_cylinder_height+Rounding_radius*2,Rod_insert_cylinder_radius*2+Rounding_radius*2,Rounding_radius*2],center=true);
        }
//Rod hole
    translate([0,0,Plate_thickness+Rod_nut_size+Rounding_radius])
        rotate([0,90,0])
            cylinder(r=Rod_radius,h=Rod_insert_cylinder_height*2,center=true);
//Cuts
    translate([0,Plate_vertical_size/2,0])
        cylinder(r=Cut_radius,h=Plate_thickness*8,center=true);
    translate([0,-Plate_vertical_size/2,0])
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
    translate([Holes_horizontal_interaxis/2,Holes_vertical_interaxis/2,Plate_thickness])
        cylinder(r=Screws_recess_radius,h=Screws_recess_depth*2,center=true);
    translate([-Holes_horizontal_interaxis/2,Holes_vertical_interaxis/2,Plate_thickness])
        cylinder(r=Screws_recess_radius,h=Screws_recess_depth*2,center=true);
    translate([Holes_horizontal_interaxis/2,-Holes_vertical_interaxis/2,Plate_thickness])
        cylinder(r=Screws_recess_radius,h=Screws_recess_depth*2,center=true);
    translate([-Holes_horizontal_interaxis/2,-Holes_vertical_interaxis/2,Plate_thickness])
        cylinder(r=Screws_recess_radius,h=Screws_recess_depth*2,center=true);

//Rod insert rounding
    translate([0,0,Plate_thickness+Rounding_radius])
        {
        hull()
            {
            translate([Rod_insert_cylinder_height/2+Rounding_radius*4,Rod_insert_cylinder_radius+Rounding_radius,0])
                sphere(r=Rounding_radius);
            translate([-Rod_insert_cylinder_height/2-Rounding_radius*4,Rod_insert_cylinder_radius+Rounding_radius,0])
                sphere(r=Rounding_radius);
            }
        hull()
            {
            translate([Rod_insert_cylinder_height/2+Rounding_radius*4,-Rod_insert_cylinder_radius-Rounding_radius,0])
                sphere(r=Rounding_radius);
            translate([-Rod_insert_cylinder_height/2-Rounding_radius*4,-Rod_insert_cylinder_radius-Rounding_radius,0])
                sphere(r=Rounding_radius);
            }

        hull()
            {
            translate([Rod_insert_cylinder_height/2+Rounding_radius,Rod_insert_cylinder_radius+Rounding_radius*4,0])
                sphere(r=Rounding_radius);
            translate([Rod_insert_cylinder_height/2+Rounding_radius,-Rod_insert_cylinder_radius-Rounding_radius*4,0])
                sphere(r=Rounding_radius);
            }

        hull()
            {
            translate([-Rod_insert_cylinder_height/2-Rounding_radius,Rod_insert_cylinder_radius+Rounding_radius*4,0])
                sphere(r=Rounding_radius);
            translate([-Rod_insert_cylinder_height/2-Rounding_radius,-Rod_insert_cylinder_radius-Rounding_radius*4,0])
                sphere(r=Rounding_radius);
            }

        }

//Removal bottom
    translate([-Plate_horizontal_size,-Plate_vertical_size,-Plate_thickness*2])
        cube([Plate_horizontal_size*2,Plate_vertical_size*2,Plate_thickness*2]);

    }



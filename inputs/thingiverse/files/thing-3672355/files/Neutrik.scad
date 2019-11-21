/* [Global Settings] */
// Output Type
part = "plate";                                 // [plate,shell]
facets = 360;


/* [Neutrik D-Hole Dimensions] */
// Number of holes to punch in the plate
holes = 5;                                      // [2:16]
// Horizontal padding of each hole
padding_x = 1;                                  // [1:0.5:10]
// Vertical padding of each hole
padding_y = 6;                                  // [4:0.5:10]

hole_x = 26 + padding_x;
hole_y = 31 + padding_y;


/* [Plate Dimensions] */
// Inset depth of the front plate
front = 4;                                      // [2:0.5:10]
// Inset depth of the back plate
back = 4;                                       // [2:0.5:10]
// Extra horizontal margins of the plate
margin = 9;                                     // [8:0.5:100]
// Diameter of the hole for the cable
cable = 10;                                     // [4:0.5:40]

plate_x = (margin * 2) + (holes * hole_x);
plate_y = hole_y;
// Thickness of the plate
plate_z = 2;                                    // [1:0.5:3]


/* [Shell Dimensions] */
// Thickness of the shell
shell_z = 3;                                    // [2:0.5:5] 
shell_l = plate_x + shell_z;
shell_h = (plate_y / 2) + (shell_z / 2);
// Depth of the shell
shell_d = 60;                                   // [60:200]
// Depth of the screw holes
screw_d = 4;                                    // [2:10]







print_part();

module print_part()
{
	if (part == "plate")
    {
        CasePlate();
    }
    else
    {
        CaseShell();
    }
}




module CasePlate()
{
    difference()
    {
        cube([plate_x,plate_y,plate_z]);
        
        for (i = [0:holes-1])
        {
            translate([margin+(hole_x/2)+(i*hole_x),hole_y/2])
            {
                cylinder(h=plate_z,d=24,$fn=facets);
                
                translate([9.5,12])
                    cylinder(h=plate_z,d=3.2,$fn=facets);
                translate([-9.5,-12])
                    cylinder(h=plate_z,d=3.2,$fn=facets);
            }
        }
    }
    
    translate([0,plate_y+5])
    difference()
    {
        cube([plate_x,plate_y,plate_z]);
        
        translate([plate_x/2,plate_y/2])
            cylinder(h=shell_z,d=cable,$fn=facets);
    }
}


module CaseShell()
{
    difference()
    {
        union()
        {
            difference()
            {
                union()
                {
                    cube([shell_l,shell_d,shell_z]);
                    
                    cube([shell_z,shell_d,shell_h]);
                    translate([shell_l-shell_z,0])
                        cube([shell_z,shell_d,shell_h]);
                }
                
                translate([0,plate_z+front])
                    ScrewCuts();
                translate([shell_l-10,plate_z+front])
                    ScrewCuts();
                translate([0,shell_d-plate_z-back-10])
                    ScrewCuts();
                translate([shell_l-10,shell_d-plate_z-back-10])
                    ScrewCuts();
            
                translate([(shell_l/2)+cable,shell_d-plate_z-back-cable-10])
                    ScrewCuts();
                translate([(shell_l/2)-cable-10,shell_d-plate_z-back-cable-10])
                    ScrewCuts();
            }
            
            translate([0,plate_z+front])
                ScrewPosts();
            translate([shell_l-10,plate_z+front])
                ScrewPosts();
            translate([0,shell_d-plate_z-back-10])
                ScrewPosts();
            translate([shell_l-10,shell_d-plate_z-back-10])
                ScrewPosts();
            
            translate([(shell_l/2)+cable,shell_d-plate_z-back-cable-10])
                ScrewPosts();
            translate([(shell_l/2)-cable-10,shell_d-plate_z-back-cable-10])
                ScrewPosts();
        }
        
        translate([(shell_z/2)-0.05, front-0.05,(shell_z/2)-0.05])
            cube([plate_x+0.1,plate_z+0.1,plate_y]);
        
        translate([(shell_z/2)-0.05, shell_d-plate_z-back-0.05,(shell_z/2)-0.05])
            cube([plate_x+0.1,plate_z+0.1,plate_y]);
    }
}


module ScrewPosts()
{
    translate([5,5])
    difference()
    {
        cylinder(h=shell_h,d=10,$fn=facets);
        
        cylinder(h=shell_h,d=3.2,$fn=facets);
        rotate([0,0,90])
            cylinder(h=screw_d,d=6.5,$fn=6);
    }
}
module ScrewCuts()
{
    translate([5,5])
        cylinder(h=shell_h,d=10,$fn=facets);
}
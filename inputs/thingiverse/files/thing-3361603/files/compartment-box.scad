/* [Part] */
part = 0; // [0:base,1:lid]

/* [Base] */
// height of base (mm)
height = 50;
// Width of compartment (mm)
x_width = 35;
// Width of compartment (mm)
y_width = 35;
// Number of compartments
x_num = 4;
// Number of compartments
y_num = 4;
// Width of internal separator walls (mm)
separator_width = 1.2;
// Separator wall shorter than outer wall by (mm)
separator_shorter_by = 0;
// Thickness of base outer wall (mm)
base_wall_thickness = 1.2;
// Thickness of base bottom (mm)
base_thickness = 2;

/* [Lid] */
// Thicknes of lid outer wall (mm)
lid_wall_thickness = 1.2;
// Thickness of lid top (mm)
lid_thickness = 2;
// Height of lid as percentage of base height
lid_height_percent = 50;
// Clearance between lid and base
clearance = 0.75;

base_x = (base_wall_thickness * 2) + (x_width * x_num) + (separator_width * (x_num - 1));
base_y = (base_wall_thickness * 2) + (y_width * y_num) + (separator_width * (y_num - 1));
base_height = base_thickness + height;

lid_x = base_x + (lid_wall_thickness * 2) + (clearance * 2);
lid_y = base_y + (lid_wall_thickness * 2) + (clearance * 2);
lid_height = base_height * (lid_height_percent / 100);

if (part == 0)
    bottom();
else
    top();

module bottom()
    {
    difference()
        {
        cube([base_x, base_y, base_height]);
        for (x = [0:x_num - 1])
            {
            for (y = [0:y_num - 1])
                {
                translate([base_wall_thickness + ((x_width + separator_width) * x), base_wall_thickness + ((y_width + separator_width) * y), base_thickness]) cube([x_width, y_width, height + 1]);
                }
            }
        if (separator_shorter_by > 0)
            {
            translate([base_wall_thickness, base_wall_thickness, base_height - separator_shorter_by]) cube([base_x - base_wall_thickness * 2, base_y - base_wall_thickness * 2, separator_shorter_by + 1]);
            }
        }
    }
    
module top()
    {
    difference()
        {
        cube([lid_x, lid_y, lid_height]);
        translate([lid_wall_thickness, lid_wall_thickness, lid_thickness])
            cube([lid_x - (lid_wall_thickness * 2) , lid_y - (lid_wall_thickness * 2), lid_height + 1]);
        }
    }
// What to render: 'trunk', 'topper', 'sections', or 'all' (case sensitive)
Render = "all";

// Colors
trunk_color = "white";
topper_color = "red";
sections_color = "red";

// Section parameters
sections = 10;
section_thickness = 3;
space_between_sections = 9;
section_height = section_thickness + space_between_sections;

// Bottom section parameters
bottom_section_diameter = 130;
bottom_section_diameter_delta = 10;

// Trunk parameters
trunk_bottom_diameter = 40;
trunk_tip_diameter = 4;
// This determines where on the Z-axis the first section starts
trunk_stump_height = 24;

// Topper parameters
topper_z = (trunk_stump_height + (section_height * sections)) - (section_height * .2);
topper_bottom_diameter = bottom_section_diameter - (bottom_section_diameter_delta * sections);

// Height of the entire object
total_height = (section_height * sections) + trunk_stump_height;

// Each section is rotated this number of degrees. For visualization only -- You can assemble it however you want.
section_rotation_degrees = 0;
section_number_of_sides = 6;

module GenerateTrunk()
{
    cylinder(
            h=total_height,
            d1=trunk_bottom_diameter, 
            d2=trunk_tip_diameter, 
            center=false);
}

module GenerateSectionsWithCenterHole()
{
    difference()
    {
        GenerateSections();
        GenerateTrunk();
    }
}

module GenerateSections()
{
    for(section = [0:sections-1])
    {
        section_z = trunk_stump_height + (section_height * section);
        translate(v = [0, 0, section_z])            
                rotate([0,0, section_rotation_degrees * section])
                    cylinder(
                        h = section_thickness, 
                        d=bottom_section_diameter - (bottom_section_diameter_delta * section), 
                        $fn=section_number_of_sides);
    }
}

module GenerateTopperWithCenterHole()
{
    difference()
    {
        translate(v = [0, 0, topper_z])
            cylinder(
                h=topper_bottom_diameter * 1.3,
                d1=topper_bottom_diameter,
                d2=topper_bottom_diameter*.1);
        GenerateTrunk();
    }
}

// render() is required due to bug. See https://github.com/openscad/openscad/issues/1000
if (Render == "trunk" || Render == "all")
    color(trunk_color) render() GenerateTrunk();
if (Render == "sections" || Render == "all")
    color(sections_color) render() GenerateSectionsWithCenterHole();
if (Render ==  "topper" || Render == "all")
    color(topper_color) render() GenerateTopperWithCenterHole();
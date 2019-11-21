//The spacing between the teeth
cable_width = 3;

//The strength (thickness) of the holder clamp
cable_holder_thickness = 4;

//The depth of a tooth
tooth_depth = 3;

//Number of teeth in 1 holder
number_of_teeth = 4;

//The amount of holders on the base
number_of_holders = 3;

//The spacing between the holders
holder_spacing = 10;

/*[Hidden]*/
total_width = number_of_holders * (((tooth_depth*3) + cable_width) + holder_spacing) - holder_spacing;

module cableholder(width, tooth, teeth, thickness)
{
    //translate([-(tooth/2 + ((tooth*2) + width)/2),0,0])
    {
        union()
        {
            for(t=[1:teeth])
            {
                translate([tooth/2,0,t*tooth])
                rotate([90,0,0])
                cylinder(r=tooth,h=thickness,$fn=3,center=true);
            }
        }

        union()
        {
            for(t=[1:teeth])
            {
                translate([tooth/2 + ((tooth*2) + width),0, t*tooth])
                rotate([90,0,180])
                cylinder(r=tooth,h=thickness,$fn=3,center=true);
            }
        }
    }
}

for(h=[1:number_of_holders])
{
    translate([(h-1) * (((tooth_depth*3) + cable_width) + holder_spacing), 0, 0])
    cableholder(cable_width,tooth_depth,number_of_teeth,cable_holder_thickness);
}

render()
translate([0,-cable_holder_thickness/2 - 9,0])
{
    difference()
    {
        cube([total_width,cable_holder_thickness + 18,tooth_depth]);
        
        for(h=[1:number_of_holders])
        {
            translate([(h-1) * (((tooth_depth*3) + cable_width) + holder_spacing) + tooth_depth*1.5 + cable_width/2, 0, 0])
            {
                translate([0,4.5,0])
                cylinder(r=1.6,h=tooth_depth + 1,$fn=18);

                translate([0,4.5 + 9 + cable_holder_thickness,0])
                cylinder(r=1.6,h=tooth_depth + 1,$fn=18);
            }
        }
    }
}
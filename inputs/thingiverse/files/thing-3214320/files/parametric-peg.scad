///Split the object in two so that you can clamp them later
split = true;
///Rotates the print flat down with value 1, or some other funnier direction with other numbers
rotate_down = 1;
///Hole diameter
hole = 6;
///Shaft diameter
shaft = 12;
///Diameter of the thicker part in the end of the shaft
shaft_end = 13;
///Lenght of the shaft part (the thicker part is excluded)
shaft_lenght = 21;
///Lenght of the thicker part
shaft_end_lenght = 4;
///Distance of the hole from the end of shaft part
hole_distance = 10;
///Lenghtwise angle. Remember to switch -+ for the other half
lenghtwise_angle = 0;
///Sideways angle. Remember to switch -+ for the other half
sideways_angle = 0;
///Coned end, to guide the peg
guide_lenght = 2;
///Guide end diameter
guide = 8;

holer = hole / 2;
shaftr = shaft / 2;
shaft_endr = shaft_end / 2;
guider = guide / 2;
$fn = 2 * PI * shaftr;  //Render-accuracy

module peg()
{
    union()
    {
        cylinder(r1 = guider, r2 = shaftr, h = guide_lenght);
        translate([0,0,guide_lenght])cylinder(r = shaftr, h = shaft_lenght);
        translate([0,0,guide_lenght + shaft_lenght]){cylinder(r = shaft_endr, h = shaft_end_lenght);}
    }
}

module peg_with_hole()
{
    difference()
    {
        peg();
        rotate([90-lenghtwise_angle,0,sideways_angle])translate([0,shaft,-hole_distance]){cylinder(r = holer, h = 1000);}
    }
}

module thing()
{
    rotate([0,90*rotate_down,0])
    {
        difference()
        {
            peg_with_hole();
            if (split)
                translate([0,-500,-0]){cube([1000,1000,1000]);}
        }
    }
}

thing();
$fn=16;// make this number smaller to speed up generation when playing with measurements

radius = 1+1;

letter_height = 3*radius;

font = "Liberation mono:style=Bold";

top = "O";
name1 = "Si";
name2 = "Al";
name3 = "Fe";
name4 = "Ca";
name5 = "Na";
name6 = "Mg";
name7 = "K";
name8 = "Ti";
name9 = "H";
name10 = "P";
name11 = "Mn";


xLength = 9 * 2;
letter_size = 5+1;

echo("xLength = ", xLength);

module dodecahedron(height)
{
    scale([height,height,height]) //scale by height parameter
    {
        intersection()
        {
            //make a cube
            cube([2,2,1], center = true);
            intersection_for(i=[0:4]) //loop i from 0 to 4, and intersect results
            {
                //make a cube, rotate it 116.565 degrees around the X axis,
                //then 72*i around the Z axis
                rotate([0,0,72*i])
                rotate([116.565,0,0])
                cube([2,2,1], center = true);
            }
        }
    }
}

module stringMaker(stringVal)
{
    linear_extrude(height = letter_height) {text(stringVal, size = letter_size * 2 / 2, font = font, halign = "center", valign = "center", $fn = 16);}
}

shiftY = xLength/2 * cos(28);
shiftZ = xLength/2 * sin(28);

difference()
{
    minkowski()
    {
        // round theedges of the dice slightly
        dodecahedron(xLength);
       sphere(r=radius);
    }

    color("gray")  translate([0 ,0,xLength/2]) rotate([0,0,180]) stringMaker(top);
    color("gray")  rotate([0,0,0]) translate([0 ,shiftY ,shiftZ]) rotate([180-116.565,0,180]) stringMaker(name1);
    color("gray") rotate([0,0,72]) translate([0 ,shiftY ,shiftZ]) rotate([180-116.565,0,180]) stringMaker(name2);
    color("gray")  rotate([0,0,72*2]) translate([0 ,shiftY ,shiftZ]) rotate([180-116.565,0,180]) stringMaker(name3);
    color("gray")  rotate([0,0,72*3]) translate([0 ,shiftY ,shiftZ]) rotate([180-116.565,0,180]) stringMaker(name4);
    color("gray")  rotate([0,0,72*4]) translate([0 ,shiftY ,shiftZ]) rotate([180-116.565,0,180])stringMaker(name5);
    color("gray")  rotate([180,0,72*0]) translate([0 ,shiftY ,shiftZ]) rotate([180-116.565,0,180])stringMaker(name6);
    color("gray")  rotate([180,0,72*1]) translate([0 ,shiftY ,shiftZ]) rotate([180-116.565,0,180])stringMaker(name7);
    color("gray")  rotate([180,0,72*2]) translate([0 ,shiftY ,shiftZ]) rotate([180-116.565,0,180])stringMaker(name8);
    color("gray")  rotate([180,0,72*3]) translate([0 ,shiftY ,shiftZ]) rotate([180-116.565,0,180])stringMaker(name9);
    color("gray")  rotate([180,0,72*4]) translate([0 ,shiftY ,shiftZ]) rotate([180-116.565,0,180])stringMaker(name10);
    color("gray")  translate([0 ,0,-xLength/2]) rotate([180,0,180])stringMaker(name11);
}

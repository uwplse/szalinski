// ----------------------------------------------------
// Polyhedron polygon designer.
// Created by Stefan Bengtsson. 2018-04-02.
// stefanb.sbg@gmail.com
// ----------------------------------------------------


// Number of sides for the tile.
sides = 3;
// Size of the tile, in mm. Through the center of the hinge.
size = 25;
// Height of tile, in mm.
height = 3.0;
// Width of side bar, in mm.
width = 3.4;
// Side rounding, in mm. Top width of bar reduction on each side.
side_round = 0.5;

// Number of hinges. A hinge is created in pairs.
hinges = 4;
// Hinge arm thinknes, in mm.
tung_thick = 0.8;
// Hinge arm extra length, in mm.
tung_exlen = 1.2;
// Hinge clearance between moving parts, in mm.
tung_gap = 0.1;

// Snap diameter, in mm. Must be smaller than the height.
dimp_size = 2.4;
// Snap height and depth, in mm.
dimp_height = 0.3;

// ----------------------------------------------------

$fn = 35;

tung_len = tung_exlen + height / 2;

hinge_len = size - 2 * sqrt(3) * tung_len;

echo("Hinge length =", hinge_len);

hinge_gap = (hinge_len - hinges * 4 * tung_thick - hinges * 2 * tung_gap) / (hinges * 2 - 1);

echo("Hinge gap =", hinge_gap);
if (hinge_gap + 0.01 < dimp_height)
{
    echo("Warning the hinge is to tight");
    assert(false);
}
else
    echo("Hinge gap is ok.");

angle = 360 / sides;

intangle = (180 - angle) / 2;

totdia = tan(intangle) * size / 2;

sideradie = height * height / (8 * side_round) + side_round / 2;

module dimp()
{
    rotate(a = 90, v = [0, 1, 0])
        translate(v = [0, 0, -0.001])
            cylinder(h = dimp_height + 0.001, d1 = dimp_size, d2 = dimp_size - dimp_height * 2.5);
}


module tung()
{
    union()
    {
        rotate(a = 90, v = [0, 1, 0])
            cylinder(h = tung_thick, d = height);
        translate(v = [0, -tung_len, -height / 2])
            cube(size = [tung_thick, tung_len, height]);
    }
}


module tungp()
{
    render()
    {
        tung();
        translate(v = [tung_thick, 0, 0])
            dimp();
    }
}


module tungn()
{
    render()
    {
        difference()
        {
            tung();
            translate(v = [tung_thick, 0, 0])
                rotate(a = 180, v = [0, 0, 1])
                    dimp();
        }
    }
}


module hinge_part(n = 0)
{
    ts = (2 * tung_thick + tung_gap + hinge_gap) * n;
    b0 = -hinge_len / 2 + ts;
    b1 = hinge_len / 2 - ts;
    if ((n % 2) == 0)
    {
        translate(v = [b0, 0, 0])
            tungp();
        translate(v = [b1 - 2 * tung_thick - tung_gap, 0, 0])
            tungn();
    }
    else
    {
        translate(v = [b0 + 2 * tung_thick + tung_gap, 0, 0])
            rotate(a = 180, v = [0, 1, 0]) tungp();
        translate(v = [b1, 0, 0])
            rotate(a = 180, v = [0, 1, 0]) tungn();
    }
}

module hinge()
{
    for(i = [0 : hinges - 1])
        hinge_part(i);
}    


module sidepart()
{
    intersection()
    {
        intersection()
        {
            cube(size = [size, width, height], center = true);
            union()
            {
                rotate(a = 90, v = [0, 1, 0])
                    translate(v = [0, sideradie - width / 2, -size / 2])
                        cylinder(h = size, r = sideradie);
                translate(v = [0, width / 2, 0])
                    cube(size = [size, width, height], center = true);
            }
        }
        union()
        {
            rotate(a = 90, v = [0, 1, 0])
                translate(v = [0, -sideradie + width / 2, -size / 2])
                    cylinder(h = size, r = sideradie);
            translate(v = [0, -width / 2, 0])
                cube(size = [size, width, height], center = true);
        }
    }
}


module part()
{
    //i = 0;
    
    for(i = [0 : sides - 1])
    {
        rotate(a = angle * i, v = [0, 0, 1])
            difference()
            {
                translate(v = [0, totdia, 0])
                {
                    hinge();
                    translate(v = [0, side_round - tung_len - width / 2, 0])
                        sidepart();
                }
                rotate(a = 90 - intangle, v = [0, 0, 1])
                    translate(v = [-size / 8, size, 0])
                        cube(size = [size / 4, size * 2, height + 0.001], center = true);
                rotate(a = -90 + intangle, v = [0, 0, 1])
                    translate(v = [size / 8, size, 0])
                        cube(size = [size / 4, size * 2, height + 0.001], center = true);
            }

    }
}

part();

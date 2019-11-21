//
// Gallaxy S5 with otterbox defender pocket protector

//dimensions (all in mm)
FN = 200;//$fn for cylinders
//FN = 34;//$fn for cylinders

L = 155;
W = 81;
H = 5.75;
THK = 2;
R = 12;
R_O = R+THK;

cover();

module cover()
{
    //translate([30,30,30])
    difference()
    {
        cover_body();
        translate([THK,THK,THK])
        S5_body([50,50,50]);
    }
}

module cover_body()
{
    difference()
    {
        cube([L+THK,W+2*THK,H+THK]);
        //union()
        {
            //subtract the first corner
            difference()
            {
                cube([R_O, R_O,(H+THK)]);
                translate([R_O,R_O,0])
                rotate([0,0,180])
                    cylinder(H+THK, r=R_O, $fn = FN);
            }
            //subtract the second corner
            translate([0,(W+2*THK)-2*R_O,0])
            difference()
            {
                translate([0,R_O,0])
                cube([R_O, R_O,(H+THK)]);
                translate([R_O,R_O,0])
                rotate([0,0,180])
                cylinder(H+THK, r=R_O, $fn = FN);
            }
        }
    }
}

module S5_body()
{
    difference()
    {
        cube([L,W,H]);
        //union()
        {
            //subtract the first corner
            difference()
            {
                cube([R, R,(H)]);
                translate([R,R,0])
                rotate([0,0,180])
                    cylinder(H, r=R, $fn = FN);
            }
            //subtract the second corner
            translate([0,(W)-2*R,0])
            difference()
            {
                translate([0,R,0])
                cube([R, R,(H)]);
                translate([R,R,0])
                rotate([0,0,180])
                cylinder(H, r=R, $fn = FN);
            }
        }
    }
}


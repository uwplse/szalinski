//
// under counter caibinet box

//dimensions (all in mm)
FN = 200;//$fn for cylinders
//FN = 34;//$fn for cylinders

THK = 1.5; //0.0787402"
L = 50.8-2*THK; //2"
W = 177.8; //7"
H = 69.85; //2.75"
H_os = 44.45; //1.75"
R = 2;
R_O = R+THK;
hole_os_h = H-9.525; //horizantal hole offset, 3/8" from top
hole_os_v = 69.85; //verticle hole offset, 2.75" from center
hole_d = 3.175; //1/8 diamter mouting holes
cover();

module cover()
{
    difference()
    {
        cover_body();
        translate([THK,THK,THK+.1])
        S5_body();
        // angled cut on top
        translate([0,0,H_os])
        rotate([0,-25,0])
        translate([-L*.135,-W*.125,0])
        cube([L*1.35,W*1.25,H]);
        // mounting hole cutouts
        translate([L*1.5,THK+W/2-hole_os_v,hole_os_h +hole_d/2])
        rotate([0,-90,0])
        cylinder(L, r=hole_d/2, $fn = FN);
        translate([L*1.5,THK+W/2+hole_os_v,hole_os_h +hole_d/2])
        rotate([0,-90,0])
        cylinder(L, r=hole_d/2, $fn = FN);
    }

}

module cover_body()
{
    difference()
    {
        cube([L+2*THK,W+2*THK,H+THK]);
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


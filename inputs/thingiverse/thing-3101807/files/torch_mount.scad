$fn = 50;
wall = 3;
torch_d = 26.5;

rotate([0,-45,0])
{
    difference()
    {
        cylinder(h=15, d=torch_d+wall+wall, center=true);
        cylinder(h=17, d=torch_d, center=true);
        translate([12,0,0]) cube(size=17, center=true);
    }
}

translate([0,25,0])
{
    difference()
    {
        cube(size=20, center=true);
        rotate([90,0,90]) cylinder(h=32, d=8, center=true);
    }
}

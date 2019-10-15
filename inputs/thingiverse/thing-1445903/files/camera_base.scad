/* 
 * 2016, bruno.keymolen@gmail.com
 */

module base1()
{
    difference()
    {
        translate([0,-1,0])
        {
            cube(size=[48, 44, 18], center=false);
        }
        translate([6,7,0])
        {
        cube(size=[36, 28, 7], center=false);
        }
        translate([4,2,7])
        {
        cube(size=[40, 38, 11], center=false);
        }
        translate([30,-5,11])
        {
        cube(size=[6,9,10], center=false);
        }
    }
}


module base2()
{
    base1();
    translate([2,2,0])
    cylinder(h=18, r1=4, r2=4);
    translate([46,2,0])
    cylinder(h=18, r1=4, r2=4);
    translate([2,40,0])
    cylinder(h=18, r1=4, r2=4);
    translate([46,40,0])
    cylinder(h=18, r1=4, r2=4);
}

module base3()
{
    difference()
    {
        base2();
        translate([2,2,0])
        cylinder(h=18, r1=2, r2=2);
        translate([46,2,0])
        cylinder(h=18, r1=2, r2=2);
        translate([2,40,0])
        cylinder(h=18, r1=2, r2=2);
        translate([46,40,0])
        cylinder(h=18, r1=2, r2=2);
    }
}

base3();
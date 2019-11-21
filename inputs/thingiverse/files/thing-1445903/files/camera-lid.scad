/* 
 * 2016, bruno.keymolen@gmail.com
 */
 
height = 5;

module base1()
{
    difference()
    {
        translate([0,-1,0])
        {
            cube(size=[48, 44, height], center=false);
        }
        translate([4,2,3])
        {
            cube(size=[40, 38, 2], center=false);
        }  
    }
}

module base2()
{
    base1();
    translate([2,2,0])
    cylinder(h=height, r1=4, r2=4);
    translate([46,2,0])
    cylinder(h=height, r1=4, r2=4);
    translate([2,40,0])
    cylinder(h=height, r1=4, r2=4);
    translate([46,40,0])
    cylinder(h=height, r1=4, r2=4);
}

module base3()
{
    difference()
    {
        base2();
        translate([2,2,0])
        cylinder(h=height, r1=2, r2=2);
        translate([46,2,0])
        cylinder(h=height, r1=2, r2=2);
        translate([2,40,0])
        cylinder(h=height, r1=2, r2=2);
        translate([46,40,0])
        cylinder(h=height, r1=2, r2=2);
    }
}

base3();
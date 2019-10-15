/* 
 * 2016, bruno.keymolen@gmail.com
 *
 * Mak 127
 * 1.25" -> 31.75mm
 *
 * Older scopes
 * 0.965" -> 24.5mm
 */

// Diameter of eyepiece
eyepieceDiameter = 31.75; // [31.65:1.25 Inch, 24.5:0.965 Inch]

// Substract a fraction from the diameter to have a smooth fit, could be 0.0
diameterDeductMillimeter = 0.1; // [0.0:0.0 mm,0.05:0.05 mm,0.1:0.10 mm,0.2:0.20 mm,0.3:0.30 mm,0.5:0.50 mm]


module ignore()
{
}

eyepiece_r = (eyepieceDiameter-diameterDeductMillimeter)/2;

height = 3;

module base1()
{
        translate([0,-1,0])
        {
            cube(size=[48, 44, height], center=false);
        }
       
    }


module base2()
{
    base1();
    translate([2,2,0])
    cylinder(h=height+2, r1=4, r2=4);
    translate([46,2,0])
    cylinder(h=height+2, r1=4, r2=4);
    translate([2,40,0])
    cylinder(h=height+2, r1=4, r2=4);
    translate([46,40,0])
    cylinder(h=height+2, r1=4, r2=4);
}

module base3()
{
    difference()
    {
        base2();
        translate([2,2,0])
        cylinder(h=height+2, r1=2, r2=2);
        translate([46,2,0])
        cylinder(h=height+2, r1=2, r2=2);
        translate([2,40,0])
        cylinder(h=height+2, r1=2, r2=2);
        translate([46,40,0])
        cylinder(h=height+2, r1=2, r2=2);
    }
}


module lens1()
{
    difference()
    {
    cylinder(h=30,r1=eyepiece_r,r2=eyepiece_r, $fn=100);
    cylinder(h=30,r1=eyepiece_r-2,r2=eyepiece_r-2, $fn=100);
    }
}

module lens2()
{
    base3();
    translate([24,21])
    {
        lens1();
    }
}

difference()
{
lens2();
    translate([24,21])
    {
        cylinder(h=height,r1=eyepiece_r-2,r2=eyepiece_r-2, $fn=100);
    }
}
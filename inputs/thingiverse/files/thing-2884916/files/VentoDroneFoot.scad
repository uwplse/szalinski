//
//  VentoDroneFoot.scad
//
//  EvilTeach
//
//  04/29/2018
//

$fn=90;

module bottom()
{
    color("white")
        cylinder(d2 = 9.5, d1 = 5.0, h = 2.5);
}

module middle()
{
    color("cyan")
        cylinder(d = 5.0, h = 2.0);
}

module top()
{
    difference()
    {
        color("yellow")
            cylinder(d1 = 6.0, d2 = 5.0, h = 0.5);
        

    }
}


module main()
{
    difference()
    {
        union()
        {
            translate([0, 0, 0])
                bottom();
            
            translate([0, 0, 2])
                middle();
            
            translate([0, 0, 4])
                top();
        }

        translate([0, 0, 3.0])
            cylinder(d = 3.5, h = 4);
    }
}


main();
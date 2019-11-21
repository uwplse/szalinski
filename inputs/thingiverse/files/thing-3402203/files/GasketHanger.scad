//
//  GasketHanger.scad
//
//  EvilTeach
//
//  1/20/2019
//
// 15% infill
//  .2 layer height
// 1   shell
// 40/40 feed rate
//
//  The pegs are used to make the holes.
//  The printed pegs are scaled to make them fit.
//  Printing the pegs separately with support is a good idea


depth  =  50;
height =  15;
width  = 140; 



module ovoid()
{
    color("yellow")
    cube([width, depth, height]);
    
    color("red")
    translate([0, depth / 2, 0])
    cylinder(d = depth, h = height, $fn=90);
    
    color("green")
    translate([width, depth / 2, 0])
    cylinder(d = depth, h = height, $fn=90);
}



hookDiameter = 3;
hookSides    = 6;

module rounded_cylinder(radius, height)
{
    tmpHeight = height - radius;
    translate([0, 0, radius])
    {
        cylinder(r=radius, tmpHeight - radius, $fn=hookSides);
        sphere(radius, $fn=hookSides);
    }
    
    translate([0, 0, tmpHeight])
        sphere(radius, $fn=hookSides);
}



module rounded_cylinder_end(radius, height)
{
    tmpHeight = height - radius;
    {
        cylinder(r=radius, tmpHeight - radius, $fn=hookSides);
        sphere(radius, $fn=hookSides);
    }
}



module hook(width, height, diameter)
{
    color("red")
        rotate([0, 90, 0])
            translate([-diameter / 2, 0, diameter / 2])
                    rounded_cylinder_end(diameter, width);

    color("cyan")
        translate([diameter / 2, 0, 0])
            rounded_cylinder(diameter, height);
}



magnetDiameter = 17.0;
magnetHeight   =  3.5;

module magnet()
{
    color("orange")
        cylinder(d = magnetDiameter, h = magnetHeight, $fn=90);
}



module pegs()
{
    s = 500 / 600;
    
    for (x =[0:2])
    {
        translate([x * 50, 0, hookDiameter / 2 + 1])
            rotate([90, 0, 0])
               scale([s, s, s])
                hook(25 + height, 20, hookDiameter);
    }
}



module body()
{
    difference()
    {
        ovoid();
        
        for (x = [0:2])
        {
            translate([hookDiameter * x * 23, depth / 2, -20])
                rotate([0, -90, 0])
                    hook(25 + height, 20, hookDiameter);
        }

        for (x = [0:1])
        {
            translate([35 + x * 70, depth / 4, height - magnetHeight])
                magnet();

            translate([35 + x * 70, depth * 3 / 4, height - magnetHeight])
                magnet();
        }
    }
}

module main()
{
    translate([-width / 2, -depth / 2, 0])
        body();
    
    translate([-width / 2, -depth / 1.5, 0])
        pegs();
}

main();

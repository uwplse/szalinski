//
//  Leveling Test Generator
//
//  EvilTeach 11/2015
//

// PrintBed Dimensions
xMax = 225;         // FlashForge Creator Dual
yMax = 145;

// Print Height
height = 0.5;



// Crosshairs are useful to see how close you are to the center of the plate
module zero_crosshairs()
{
    translate([xMax / 2.0, yMax / 2.0, 0]) 
        difference()
        {
            cylinder(r = 5.0, h = height);
            cylinder(r = 4.5, h = height);
        }
}



// Print lines to show any obvious leveling issues.
module plate_leveling_lines()
{
    // all around the outside
    translate([0, 0, 0])
        cube([xMax, height, height]);

    translate([0, yMax, 0])
       cube([xMax, height, height]);

    translate([0, 0, 0])
        cube([height, yMax, height]);

    translate([xMax, 0, 0])
        cube([height, yMax, height]);

    // This seems to cover up a defect in openscad.
    // I haven't investigated it seriously, so i is probably my bug
    translate([xMax, yMax, 0])
        cube([height, height, height]);


    // Calculate the angle to draw the diagonals
    a = xMax;
    b = yMax;
    c = sqrt(a * a + b * b);
    
    sinB = b / c;
    angleB = asin(sinB);
    
    translate([xMax, 0, 0])
        rotate(90 - angleB, 0, 0)
            cube([height, c , height]);

    translate([0, 0, 0])
        rotate(angleB - 90, 0, 0)
            cube([height, c, height]);
        
}



// Draw two small shapes with fill
module fill_some_shapes()
{
    translate([xMax / 4, yMax / 2, 0])
        cylinder(r = 5, h = height);
    
    cubeSize = 10;
    translate([xMax / 2 - cubeSize / 2, yMax / 4 - cubeSize / 2, 0])
        cube([cubeSize, cubeSize, height]);
}



// Toss a few letters into the mix 
module some_text()
{
    translate([xMax * 0.30, yMax * 0.85, 0])  
        linear_extrude(height = height)
        text("Level It");
}



module main()
{
    color("yellow") plate_leveling_lines();
    color("cyan")   zero_crosshairs();
    color("lime")   fill_some_shapes();
    color("red")    some_text();
}

main();

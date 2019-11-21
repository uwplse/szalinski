//
//  HamptonBayCeilingFanWallMount.scad
//
//  EvilTeach
//
//  1/10/2015
//



// Width of the controller at the top of the box
controlTopWidth = 53.0;

// Width of the controller at the bottom of the box
controlBotWidth = 40.0;

// Height of the box
controlDepth    = 80.0;

//Thickness of the controller
controlHeight   = 40.0;

// width of the part that the screw holes are in.
wallWidth       = 15.0;



// Make a cube big enough to hold the controller, and enough space for screwholes
cubeWidth  = wallWidth + controlTopWidth + wallWidth;
cubeDepth  = controlDepth + wallWidth;
cubeHeight =  controlHeight + 5;
module base_block()
{
    color("cyan")
        cube([cubeWidth, cubeDepth, cubeHeight]);
}


module trapezoid(width_base, width_top,height,thickness) 
{

  linear_extrude(height = thickness) 
      polygon(points=[[0,0],
                      [width_base,0],
                      [width_base-(width_base-width_top)/2,height],
                      [(width_base-width_top)/2,height]], 
              paths=[[0,1,2,3]]); 
  
}


// Make a controller bottom piece to subtract out of the cube.
module controller_insert()
{
    color("Yellow")
    translate([cubeWidth / 2.0 - controlTopWidth / 2.0, 0, 0])
            trapezoid(controlTopWidth, controlBotWidth, controlDepth, controlHeight);
}



// Make a model to cut away the extra material, and put in screw holes.
cutaway = wallWidth * .7;
module screw_holes()
{
    color("lime")
        translate([0, 0, 5])
        cube([cutaway, cubeDepth, cubeHeight - 5]);
    
    color("pink")
        translate([cubeWidth - cutaway, 0, 5])
            cube([cutaway, cubeDepth, cubeHeight - 5]);

    color("blue")
        translate([0, cubeDepth - cutaway, 5])
            cube([cubeWidth, cutaway, cubeHeight - 5]);

    color("red")
        translate([5, 10, 0])
            cylinder(r = 2.1, h = 5.0, $fn = 36);

    color("red")
        translate([cubeWidth - 5, 10, 0])
            cylinder(r = 2.1, h = 5.0, $fn = 36);

    color("red")
        translate([(cubeWidth - 5) / 2, cubeDepth - 5, 0])
            cylinder(r = 2.1, h = 5.0, $fn = 36);
}



module main()
{
    // Center it
    translate([-cubeWidth / 2, cubeDepth / 2, cubeHeight])
        // Minimize the need for support material
        rotate([180, 0, 0])
            difference()
            {
                base_block();
                controller_insert();
                screw_holes();
            }
}


main();
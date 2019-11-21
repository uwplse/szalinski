//The inner radius of the octavator.
innerRadius = 17.5; //Can be any positive number (default: 17.5)
//The inner height of the octavator.
innerHeight = 10; //Can be any positive number (default: 10)
//The wall thickness of the octavator.
wallThickness = 2; //Can be any positive number (default: 2)

difference () {
    cylinder(r=innerRadius+wallThickness, h=innerHeight+2);
        translate([0,0,2])cylinder(r=innerRadius, h=innerHeight+2);
}
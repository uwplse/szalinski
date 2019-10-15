// Blade size
thickness = 0.5;
length = 32;
width = 14; // Set 2 mm wider than actual width

// Wall thickness
wall = 1;

// Inserting the blade into the sheeth will push
// the wall out by this amount.
pressure_height = 0.2;

$fn=32;

room = 0.3;

module blade_hole()
{
    // Radius of the pressure bars
    pressure_r = 1;

    union() {
        difference() {
            cube([width, thickness+room*2, length-(thickness+room*2)/sqrt(2)/2]);
     
            translate([width*5/16, -(pressure_r-room-pressure_height), 0])
                cylinder(r=pressure_r, h=length-width/3+1);
            translate([width*11/16, -(pressure_r-room-pressure_height), 0])
                cylinder(r=pressure_r, h=length-width/3+1);
            
            translate([width/2, room+thickness-pressure_height+pressure_r, 0])
                cylinder(r=pressure_r, h=length-width/3+1);
            
        }
        translate([0, 0, length-(thickness+room*2)/sqrt(2)/2])
            rotate([-45, 0, 0])
                cube([width, (thickness+room*2)/sqrt(2), (thickness+room*2)/sqrt(2)]);
        rotate([-45, 0, 0])
            cube([width, (thickness+room*2)/sqrt(2), (thickness+room*2)/sqrt(2)]);
    }
}

module sheath()
{
    off = wall+room+thickness/2;
    difference()
    {
        union() {
            translate([off, 0, 0])
            cube([width, 2*off, length+wall]);
            translate([off, 0, 0])
                grip();
            translate([off, 2*off, 0])
                grip();
            
            translate([off, off, 0])
                cylinder(r=off, h=length+wall);
            translate([width+off, wall+room+thickness/2, 0])
                cylinder(r=off, h=length+wall);
        }
        
        translate([off, wall, 0])
            blade_hole();
    }
    
}

module grip()
{
    for(i = [3:3:length+wall-6]) {
        translate([0, 0, i])
            rotate([0, 90, 0])
                cylinder(r=0.3, h=width);
    }
}

sheath();
//blade_hole();

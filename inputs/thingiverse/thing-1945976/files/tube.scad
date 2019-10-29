HEIGHT = 85;
$fn = 50;

module Patterson_tank_tube () {
    BASE_D = 39.77;
    BASE_H = 2.33;

    RISE_OD = 35;
    RISE_ID = 30.1;
    RISE_H = 1.14;

    TUBE_ID = 22.22;
    TUBE_OD = 25.66;//INCH, basically

    BLOCK_H = 18.44; //CONSTANT
    BLOCK_W = 3;
    BLOCK_L = 40 - 18.44; //ROUGH
    BLOCK_T = 7.2;
    
    //MAIN TUBE
    difference () {
        cylinder(r = TUBE_OD / 2, h = HEIGHT, center = true);
        cylinder(r = TUBE_ID / 2, h = HEIGHT + 1, center = true);
    }
    
    //BASE
    translate([0, 0, -(HEIGHT / 2) - (BASE_H / 2)]) {
        difference () {
            union () {
                cylinder(r = BASE_D / 2, h = BASE_H, center = true);
                translate([0, 0, (BASE_H / 2) + (RISE_H / 2)]) cylinder(r = RISE_OD / 2, h = RISE_H, center = true);
            }
            translate([0, 0, - (BASE_H / 2) + (RISE_H / 2) - .1]) cylinder(r = RISE_ID / 2, h = RISE_H, center = true);
            cylinder(r = TUBE_ID / 2, h = HEIGHT + 1, center = true);
        }
    }
    
    //BLOCKS
    translate ([0, 0, (HEIGHT / 2) - (BLOCK_L / 2) - BLOCK_H]) {
        translate([0, (TUBE_ID / 2) - (BLOCK_T / 2), 0]) cube([BLOCK_W, BLOCK_T, BLOCK_L], center = true);
        translate([0, -(TUBE_ID / 2) + (BLOCK_T / 2), 0]) cube([BLOCK_W, BLOCK_T, BLOCK_L], center = true);
    }
}

Patterson_tank_tube();
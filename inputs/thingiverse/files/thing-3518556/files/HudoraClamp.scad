radius1 = 39 / 2;
radius2 = 25 / 2;
separation = 5;
height = 30;
screwHole = 4.5;

module trampclamp()
{		
    intersection() {
        difference() {
            translate([0.25*(radius1-radius2), 0, 0])
            cube([0.8*(radius1 + radius2),2*radius1 , height-1 ], center = true);
            translate([radius1+separation/2, 0, 0])
            cylinder(h = height, r = radius1, center = true);	
            translate([-(radius2+separation/2), 0, 0])
            cylinder(h = height, r = radius2, center = true);	
            rotate([90,0,90])
            cylinder(h = separation*2, r = screwHole, center = true);	
        };
    
        rotate([90,0,90]) cylinder(h = height, r = height/2+1, center = true);
    }
}

trampclamp();



gaika = 3.6;
gaika = 4.2;
   
difference(){   
    union(){   
        hull(){   
            translate([-15, 20,0]) cylinder(18.4, 7, 7,$fn=36,center = true);
            translate([15, 16+20,0]) cylinder(18.4, 7, 7,$fn=36,center = true);
            cylinder(18.4, 4, 4,$fn=36,center = true);
        };
        translate([0,10,0]) rotate([90,0,0])cylinder(36,6, 12,$fn=36,center = true);
        translate([0,-21,0]) rotate([90,0,0])cylinder(42, 7.8, 7.8,$fn=36,center = true);
    }

    translate([-15, 20,8.2]) cylinder(4, gaika, gaika,$fn=6,center = true);
    translate([-15, 20,-8.2]) cylinder(4, gaika, gaika,$fn=6,center = true);
    translate([15, 16+20,8.2]) cylinder(4, gaika, gaika,$fn=6,center = true);
    translate([15, 16+20,-8.2]) cylinder(4, gaika, gaika,$fn=6,center = true);
    
    translate([-15, 20,0]) cylinder(20, 2.2, 2.2,$fn=36,center = true);
    translate([15, 16+20,0]) cylinder(20, 2.2, 2.2,$fn=36,center = true);

    hull(){
        translate([-15, 20,0]) cylinder(10, 10, 10,$fn=36,center = true);
        translate([15, 16+20,0]) cylinder(10, 10, 10,$fn=36,center = true);
    }
}
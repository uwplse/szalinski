use <nuts_and_bolts_v1.95.scad>;

$fn=60;

cross_length=34;

leg_length=cross_length/2;
leg_height=2;

module leg(height) {
    translate([leg_length, 0, -height]) cylinder(r=4, h=height);
    translate([-leg_length, 0, -height]) cylinder(r=4, h=height);
}

module anti_leg(height) {
    translate([-leg_length, 0, -24]) cylinder(r=1.8, h=48);
    translate([leg_length, 0, -24]) cylinder(r=1.8, h=48);
    
    translate([leg_length, 0, -height-1]) scale([1,1,2]) hex_nut (height, 3, 6, 0.1, 32, 0, "metric");
    translate([-leg_length, 0, -height-1]) scale([1,1,2]) hex_nut (height, 3, 6, 0.1, 32, 0, "metric");
}

difference() {
    union() {
        cube([70,12,5], center=true);
        
        difference() {
            union() {
                translate([-35, -6, -2.5]) rotate([0,90,0]) cylinder (r=5, h=70);
                translate([-35, 6, -2.5]) rotate([0,90,0]) cylinder (r=5, h=70);
            }
            translate([0,0,-5]) cube([71,22,5], center=true);
        }
        
        translate([0,0,-2.5]) cylinder(r1=22, r2=20.5, h=5);
        color("red") translate([0,10.5,-7.5]) cube([3,23,10], center=true);
        color("red") translate([0,0,-5]) cube([3,25,5], center=true);
        
        //translate([-25,0,-10]) cylinder(r1=2, r2=2.5, h=10);
        //translate([25,0,-10]) cylinder(r1=2, r2=2.5, h=10);

        rotate([0, 0, 45]) leg(height=leg_height);
        rotate([0, 0, -45]) leg(height=leg_height);
    }

    translate([-25, -27, -15]) cube([70,10,30]);
    
    rotate([0, 0, 45]) anti_leg(height=leg_height);
    rotate([0, 0, -45]) anti_leg(height=leg_height);
    
    translate([0, -18, -10]) cylinder(r=8,h=20);
    hull() {
        translate([0, -18, -1.5]) cylinder(r=8,h=6);
        translate([0,0,-1.5]) cylinder(r=8, h=6);
    }
}
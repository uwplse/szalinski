//Bolt head diamter with clearance for tool
B=30;

// Bolt head height
h=10;

// Bolt overall length
l=69.5;

// diamter
d=15;

//radius for cone in rock
r = 12.5;

//height for cone in rock
hc = 22.5;

module bolt(){
    $fn = 100;
    union() {
		translate([0,0,l-0.1])cylinder(h=h, r=B/2); //space for head
		cylinder(h=l, r=d/2); // bolt shaft
	}
}

module rock() {
    $fn = 50; $fa = 20; $fs = 23;
    difference() {
        union() {
            hull() {
                translate([-2*r,0,0]) cylinder(h, 2*r, r, center = false);
                translate([-2*r,0,hc]) sphere(r);
                translate([0,0,1*hc/4]) cube(size = [4*r,r,3*hc/8], center = true);

            }
            hull() {
                translate([2*r,0,0]) cylinder(h, 2*r, r, center = false);
                translate([2*r,0,hc]) sphere(r);
                translate([0,0,1*hc/4]) cube(size = [4*r,r,3*hc/8], center = true);
            }
            hull() {
                translate([0,-2*r,0]) cylinder(h, 2*r, r, center = false);
                translate([0,-2*r,hc]) sphere(r);
                translate([0,0,1*hc/4]) cube(size = [r,4*r,3*hc/8], center = true);
            }
            hull() {
                translate([0,2*r,0]) cylinder(h, 2*r, r, center = false);
                translate([0,2*r,hc]) sphere(r);
                translate([0,0,1*hc/4]) cube(size = [r,4*r,3*hc/8], center = true);
            }
            translate([2*r,2*r,0]) sphere(4*r/3, center = false);
            translate([2*r,-2*r,0]) sphere(4*r/3, center = false);
            translate([-2*r,-2*r,0]) sphere(4*r/3, center = false);
            translate([-2*r,2*r,0]) sphere(4*r/3, center = false);
        }  
    
        translate([0,0,-4*r]) cube(size = 8*r, center = true);
    }
}

difference() {
    rock();
    translate([0,0,-hc/2]) bolt();
}
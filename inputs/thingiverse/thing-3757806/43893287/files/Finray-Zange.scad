$fn=50;
height = 8;
CRadius =0.25;


// translate([x,y,z]) cylinder(h = height, r1 = CRadius, r2 = CRadius, center = true/false);
difference(){

union(){
difference(){
hull(){
translate([0,0,0]) cylinder(h = height, r1 = 2, r2 = 2, center = true/false);
translate([130,10,0]) cylinder(h = height, r1 = CRadius, r2 = CRadius, center = true/false);
translate([80,20,0]) cylinder(h = height, r1 = CRadius, r2 = CRadius, center = true/false);
translate([130,-10,0]) cylinder(h = height, r1 = CRadius, r2 = CRadius, center = true/false);
translate([80,-20,0]) cylinder(h = height, r1 = CRadius, r2 = CRadius, center = true/false);
}
hull(){
translate([15,0,-0.5]) cylinder(h = height+1, r1 = .5, r2 = .5, center = true/false);

translate([131,10,-0.5]) cylinder(h = height+1, r1 = CRadius, r2 = CRadius, center = true/false);

translate([131,-10,-0.5]) cylinder(h = height+1, r1 = CRadius, r2 = CRadius, center = true/false);
}
}}

union(){
    hull(){
    translate([124,10.5,-0.5]) cylinder(h = height+1, r1 = CRadius, r2 = CRadius, center = true/false);

    translate([80,7.2,-0.5]) cylinder(h = height+1, r1 = CRadius, r2 = CRadius, center = true/false);

    translate([81,19,-0.5]) cylinder(h = height+1, r1 = CRadius, r2 = CRadius, center = true/false);
    }
    hull(){
    translate([124,-10.5,-0.5]) cylinder(h = height+1, r1 = CRadius, r2 = CRadius, center = true/false);

    translate([80,-7.2,-0.5]) cylinder(h = height+1, r1 = CRadius, r2 = CRadius, center = true/false);

    translate([81,-19,-0.5]) cylinder(h = height+1, r1 = CRadius, r2 = CRadius, center = true/false);
    }
    translate([13,0,-0.5]) cylinder(h = height+1, r1 = 2, r2 = 2, center = true/false);
 // Griffmulden
    translate([50,19,-0.5]) cylinder(h = height+12, r1 = 10, r2 = 10, center = true/false);
    translate([50,-19,-0.5]) cylinder(h = height+12, r1 = 10, r2 = 10, center = true/false);  

}
}


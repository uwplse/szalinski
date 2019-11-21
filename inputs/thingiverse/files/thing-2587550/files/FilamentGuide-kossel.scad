
height_mm = 10; // [2:100]
orientation = "vert"; // [vert,horiz]

scale(.5) {
    $fn=96;
    difference() {
        difference(){
            union() {
                sphere(20);
                translate([17.8,-5,5])
                 rotate([0,90,0])
                 minkowski($fn=32)
                 {
                  cube([10,10,height_mm*2]);
                  cylinder(r=2,h=0.0001);
                 };
                 
                translate([height_mm*2+17, orientation == "vert" ? -10 : -25, orientation == "vert" ? -25 : -10])
                 cube([4, orientation == "vert" ? 20 : 50, orientation == "vert" ? 50 : 20]);
            }
            sphere(16);
        }
        
        translate([-20,-20,10])
         cube([40,40,20]);
        translate([-20,-20,-30])
         cube([40,40,20]);
        
        translate([height_mm*2+15,orientation == "vert" ? 0 : -15, orientation == "vert" ? -15 : 0])
         rotate([0,90,0])
          cylinder(r=3,10);
        
        translate([height_mm*2+15,orientation == "vert" ? 0 : 15, orientation == "vert" ? 15 : 0])
         rotate([0,90,0])
          cylinder(r=3,10);
    };

    difference() {
        difference(){
            union() {
                sphere(15);
            }
            translate([0,0,-20])
             cylinder(r=4,40);
            
            translate([0,0,9])
             cylinder(r1=4,r2=5,2);
            
            translate([0,0,-11])
             cylinder(r1=5,r2=4,2);
        }
        
        translate([-20,-20,10])
         cube([40,40,20]);
        translate([-20,-20,-30])
         cube([40,40,20]);
    };
}
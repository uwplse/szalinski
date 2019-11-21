/// Ikea Lamp Shape- 3 Rings top - v2 - April 3, 2016


/////////  base plate variables
basePlate_d=80;
basePlate_h=7;
basePlateSub_d=28.5;    // hole for ikea type G lamp stand
basePlateSub_h=12;
//  inside tube
insideTube_d=60;
insideTube_h=90;
insideTubeSub_d=insideTube_d-2;
insideTubeSub_h=insideTube_h+2;
//  middle tube
middleTube_d=70;
middleTube_h=50;
middleTubeSub_d=middleTube_d-2;
middleTubeSub_h=middleTube_h+2;
//  outside tube
outsideTube_d=80;
outsideTube_h=20;
outsideTubeSub_d=outsideTube_d-2;
outsideTubeSub_h=outsideTube_h+2;

smallRingSub_d=12;
smallRingSub_h=82;
largeRingSub_d=20;
largeRingSub_h=82;
/////////  final assembly

basePlateAssy();
translate([0,0,basePlate_h])
    insideTube();
translate([0,0,basePlate_h])
    middleTube();
translate([0,0,basePlate_h])
    outsideTube();
    
module basePlateAssy() {
    difference() {
        translate([0,0,])
            basePlate();
        translate([0,0,-1])
            basePlateSub();
    }
}

module insideTube() {
    difference() {
            color("green")
                cylinder(d=insideTube_d, h=insideTube_h, center=false, $fn=40);
        translate([0,0,-1])
                color("red")
                    cylinder(d=insideTubeSub_d, h=insideTubeSub_h, center=false, $fn=40);
                color("orange")        
            translate([0,0,35])
                rotate([90,0,0])
                    cylinder(d=largeRingSub_d, h=largeRingSub_h, center=true, $fn=40); 
        color("orange")        
            translate([0,0,35])
                rotate([90,0,90])
                    cylinder(d=largeRingSub_d, h=largeRingSub_h, center=true, $fn=40); 
    }
}
module middleTube() {
    difference() {
        color("yellowgreen")
                cylinder(d=middleTube_d, h=middleTube_h, center=false, $fn=40);
        translate([0,0,-1])
                color("orange")
                    cylinder(d=middleTubeSub_d, h=middleTubeSub_h, center=false, $fn=40);
 // middle ring cutouts 
        color("orange")        
            translate([0,0,50])
                rotate([90,0,45])
                    cylinder(d=largeRingSub_d, h=largeRingSub_h, center=true, $fn=40); 
        color("orange")        
            translate([0,0,50])
                rotate([90,0,135])
                    cylinder(d=largeRingSub_d, h=largeRingSub_h, center=true, $fn=40);     
        }
}
module outsideTube() {
    difference() {
            color("khaki")
                cylinder(d=outsideTube_d, h=outsideTube_h, center=false, $fn=40);
        translate([0,0,-1])
            color("red")
                    cylinder(d=outsideTubeSub_d, h=outsideTubeSub_h, center=false, $fn=40);
 // outside ring cutouts       
        translate([0,0,20])
            rotate([90,0,0])
                color("orange")
                    cylinder(d=smallRingSub_d, h=smallRingSub_h, center=true, $fn=40);    
        translate([0,0,20])
            rotate([90,0,45])
                color("orange")
                    cylinder(d=smallRingSub_d, h=smallRingSub_h, center=true, $fn=40);
        translate([0,0,20])
            rotate([90,0,90])
                color("orange")
                    cylinder(d=smallRingSub_d, h=smallRingSub_h, center=true, $fn=40);    
        translate([0,0,20])
            rotate([90,0,135])
                color("orange")
                    cylinder(d=smallRingSub_d, h=smallRingSub_h, center=true, $fn=40);    }
}
////////// basic shapes
module basePlate() {
    color("blue")
    cylinder(d=basePlate_d, h=basePlate_h, center=false, $fn=40);

}

////////// Subtractions

module basePlateSub() {
    color("red")
        cylinder(d=basePlateSub_d, h=basePlateSub_h, center=false, $fn=40); 
}
module smallRingSub() {

}
module largeRingSub() {

}


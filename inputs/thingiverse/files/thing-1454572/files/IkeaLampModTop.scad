/// Ikea light mod v3 - March 25,2016


/////////  base plate variables
basePlate_d=44;
basePlate_h=14;
baseTubeSub_d=38;
baseTubeSub_h=10;
basePlateSub_d=28.5;    // hole for ikea type G lamp stand
basePlateSub_h=10;
//////////  fins variables
finShape_d=147;
finShape_h=2;
finShapeSub_d=130;
finShapeSub_h=finShape_h+2;

/////////  final assembly
rotate([180,0,0])
    bottomAssy();
module bottomAssy() {
    
    rotate([0,0,0])
        finAssy();
    rotate([0,0,22.5])
        finAssy();    
    rotate([0,0,45])
        finAssy();
    rotate([0,0,67.5])
        finAssy();
    rotate([0,0,90])
        finAssy();
    rotate([0,0,112.5])
        finAssy();    
    rotate([0,0,135])
        finAssy();
    rotate([0,0,157.5])
        finAssy();
    rotate([0,0,180])
        finAssy();
    rotate([0,0,202.5])
        finAssy();   
    rotate([0,0,225])
        finAssy();
    rotate([0,0,247.5])
        finAssy();
    rotate([0,0,270])
        finAssy();
    rotate([0,0,292.5])
        finAssy();
    rotate([0,0,315])
        finAssy();
    rotate([0,0,337.5])
        finAssy();
    translate([0,0,-5])    
    basePlateAssy();
}
module basePlateAssy() {
    difference() {
        translate([0,0,-2])
            basePlate();
        translate([0,0,2])
            basePlateSub();
        translate([0,0,-6])    
            baseTubeSub();
    }
}

module finAssy() {
        translate([-20,0,0])
    rotate([90,0,])             // rotate 90 degrees for assembly
//        translate([-20,-60,-10])
//            cubeShadow();      // width comparison
    difference() {
        translate([53,-11,0])
        finShape(); 
        translate([59,-40,0])   //  was 56,-40,0
            finShapeSub();
        translate([-22,0,-2])
            cubeSub();          // cut top
        translate([0,-100,-2])
            cubeSub();          // cut right
    }
}

////////// basic shapes
module basePlate() {
    color("blue")
    cylinder(d=basePlate_d, h=basePlate_h, center=true, $fn=40);

}
module finShape() {
    color("green")
        resize([finShape_d, finShape_d+20, finShape_h])
    cylinder(d=finShape_d, h=finShape_h, center=true, $fn=40);
    }
////////// Subtractions

module basePlateSub() {
    color("red")
        cylinder(d=basePlateSub_d, h=basePlateSub_h, center=true, $fn=40); 
}
module baseTubeSub() {
    color("orange")
       cylinder(d=baseTubeSub_d, h=baseTubeSub_h, center=true, $fn=40);
}
module finShapeSub() {
    color("yellow")
    cylinder(d=finShapeSub_d, h=finShapeSub_h, center=true, $fn=40);
}

module cubeSub() {
    color("tomato")
    cube([200,200,5]);
}
////////// shadow shapes
    module cubeShadow() {
    color("greenyellow")
    cube([20,60,1]);
}
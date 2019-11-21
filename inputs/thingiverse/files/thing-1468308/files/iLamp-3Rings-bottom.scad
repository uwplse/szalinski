// Ikea light mod v3 - 3 Rings - bottom - April 2,2016


///////// variables
basePlate_d=42;
basePlate_h=4;
basePlateSub_d=28.6;    // hole for ikea type G lamp stand
basePlateSub_h=basePlate_h+2;
//  inside tube
tube_d=42;
tube_h=40;
tubeSub_d=tube_d-2;
tubeSub_h=tube_h+2;

/////////  render

basePlateAssy();
translate([0,0,basePlate_h])
    tube();

module basePlateAssy() {
    difference() {
        color("blue")
            cylinder(d=basePlate_d, h=basePlate_h, center=false, $fn=40);
    translate([0,0,-1])
        color("red")
            cylinder(d=basePlateSub_d, h=basePlateSub_h, center=false, $fn=40); 
    }
}

module tube() {
    difference() {
            color("green")
                cylinder(d=tube_d, h=tube_h, center=false, $fn=40);
        translate([0,0,-1])
                color("red")
                    cylinder(d=tubeSub_d, h=tubeSub_h, center=false, $fn=40);
    }
}



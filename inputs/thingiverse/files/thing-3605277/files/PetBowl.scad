bowlWidth = 110;
bowlWallHeight = 20; // Total height of object
bowlWallWidth = 3;
bowlFloorThickness = 5; // Height of floor
bowlCurveExtend = 30;

$fn=150;

module bowl() {
    minkowski() {
        difference() {
            linear_extrude(bowlWallHeight)
                circle(d=bowlWidth, center=true);
        
            translate([0,0,bowlWallHeight - bowlFloorThickness])
            linear_extrude(bowlWallHeight + 5)
                circle(d=bowlWidth-bowlWallWidth, center=true);
        }
        translate([bowlWidth/2,0,0]) 
        rotate([90])
            linear_extrude(10)
                polygon(
                    [[0,0],[5,0],[0,5]],[[0,1,2]]
                );
            }
}

module bowl2() {
    difference() {
    cylinder(h=bowlWallHeight, d2=bowlWidth, d1=bowlWidth+bowlCurveExtend);
    
    translate([0,0,bowlWallHeight - (bowlWallHeight-bowlFloorThickness)])
        linear_extrude(bowlWallHeight + 5)
            circle(d=bowlWidth-bowlWallWidth);
    }
}
bowl2();
//bowl();

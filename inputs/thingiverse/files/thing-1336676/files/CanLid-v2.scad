canDiameter = 86.4;
lidWallThickness = 1;
lipThickness = 0.35;
lipHeight=2;
handleRatio = 0.25;
lidHeight = 5;
lipZAdjustment = 0;
$fn=60;

union() {
    translate([0,0,(lidWallThickness+lidHeight)/2])
    difference() {
        cylinder (h = lidWallThickness+lidHeight, d = canDiameter+lidWallThickness, center=true);
        translate([0,0,lidWallThickness/2])
        cylinder (h = lidHeight+0.1, d = canDiameter, center=true);
    }

    translate ([-canDiameter/2,0,lidWallThickness/2])
        cylinder (h = lidWallThickness, d = canDiameter*handleRatio, center=true);
    
    translate([0,0,lidWallThickness+lidHeight-2+lipZAdjustment])
    rotate_extrude(angle = 360, convexity = 2)
    polygon( points=[[canDiameter/2,2],[canDiameter/2-lipThickness,2-lipHeight/2],[canDiameter/2,2-lipHeight]] );
}

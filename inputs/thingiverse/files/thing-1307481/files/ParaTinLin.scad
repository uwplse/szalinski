lidDiameter = 69;
lidHeight = 6;

function done () =  1;
lip = 1.5;
$fn=60;

difference() {
    union() {
        rotate_extrude(convexity = 5,slices=90)
            translate([lidDiameter/2, 0, 0])
                circle(r=lip);
        translate([0,0,-lip/2])
        cylinder(h=lip, r1=lidDiameter/2, r2=lidDiameter/2, center=true);
    }
    translate([0,0,lidHeight/2])
    cylinder(h=lidHeight+0.01, r1=lidDiameter/2, r2=lidDiameter/2, center=true);
}

translate([0,0,lidHeight/2])
difference() {
    cylinder(h=lidHeight, r1=lidDiameter/2+lip, r2=lidDiameter/2+lip, center=true);
    cylinder(h=lidHeight+1, r1=lidDiameter/2, r2=lidDiameter/2, center=true);
}

translate([0,0,lidHeight])
rotate_extrude(convexity = 5,slices=90)
    translate([lidDiameter/2, 0, 0])
        circle(r=lip);

/* [Main] */
thickness = 3; //[3:10]
supportDiameter = 160;
holeDiameter = 140;

/* [WallSupport] */
roundSupport=true;
widthWallSupport = 44;
heightWallSupport = 50;
retreat = 5; //[0:10]
wallSupportThickness=3;
screwDiameter=0; //[0:5]
        
/* [Edge] */
thicknessEdge = 3; //[3:10]
heightEdge = 10;

/* [Resolution] */
$fn=200;

difference() {
    union(){
        
        color("red", 0.5)
        cylinder(d=supportDiameter + thicknessEdge*2, h=thickness);
        
        color("purple", 0.5)
        edge(thicknessEdge, heightEdge);
        
        color("green", 0.5)
        supports(roundSupport, widthWallSupport, heightEdge, retreat);
        
   }
    
    hole(holeDiameter);
}

module hole(holeDiameter) {
    translate([0, 0, -1])
    cylinder(d=holeDiameter, h=thickness+2);
}

module edge(thicknessEdge, heightEdge) {
    translate([0, 0, thickness])
    rotate_extrude(convexity = 2)
    translate([supportDiameter/2, 0, 0])
    square([thicknessEdge, heightEdge]);
}

module supports(roundSupport, width, height, retreat) {
    wallSupport(roundSupport, width, height, retreat);
    rotate([0, 0, 90])
    wallSupport(roundSupport, width, height, retreat);
}


module wallSupport(roundSupport, largeur, heightEdge, retreat) {
    translate([-largeur/2, supportDiameter/2, 0]) 
    cube([largeur, retreat, thickness+heightEdge], false);
    
    translate([0, supportDiameter/2+retreat, heightEdge+thickness])
rotate([90, 0, -90])
    linear_extrude(height = widthWallSupport, center = true, convexity = 10, twist = 0)
    polygon([[0,0],[retreat,0],[0,retreat]]);
    
    difference() {
        union () {
            translate([-largeur/2, supportDiameter/2+retreat, 0])
            cube([largeur, wallSupportThickness, heightWallSupport], false);
    
            if (roundSupport) {
                translate([0, supportDiameter/2+retreat+wallSupportThickness, heightWallSupport])
                rotate([90, 0, 0])
                cylinder(d=largeur, h=wallSupportThickness);
            }
        }
        if (roundSupport) {
            h=heightWallSupport;
            rotate([90, 0, 0])
            translate([0, h, -supportDiameter/2-retreat-wallSupportThickness-1])
            cylinder(d=screwDiameter, h=wallSupportThickness+2);
        } else {
            h=(heightWallSupport+(heightEdge+thickness+retreat))/2;
            rotate([90, 0, 0])
            translate([0, h, -supportDiameter/2-retreat-wallSupportThickness-1])
            cylinder(d=screwDiameter, h=wallSupportThickness+2);
        }
    }
}
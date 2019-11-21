hookDiameter = 1.5;
hookInnerDiameter = 1;
hookFacets = 20;

baseDiameter = 20;
baseHeight = 2;
baseFacets = 50;

difference(){
    union() {
        rotate(a = [90,0,0])
            rotate_extrude(convexity = 10, $fn = hookFacets)
                translate([hookInnerDiameter + (hookDiameter / 2), 0, 0])
                    circle(d = hookDiameter, $fn = hookFacets);
    }
    
    mirror([0,0,1])
        cylinder(d=baseDiameter,h=(hookDiameter*2)+hookInnerDiameter);
}

mirror([0,0,1])
    cylinder(d=baseDiameter,h=baseHeight);
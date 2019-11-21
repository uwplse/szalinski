radius = 16;
sides = 9;
bodyHeight = 30;
baseHeight = 1;
bodyTwist=60;
bodyFlare=1.8;
thickness = 1.5;

linear_extrude( height = baseHeight)
    polyShape(solid = "yes");

translate([0,0,baseHeight])
    linear_extrude( height = bodyHeight, twist = bodyTwist, scale = bodyFlare, slices = 2*bodyHeight)
        polyShape(solid="no");

translate([0,0,baseHeight+bodyHeight])
    rotate(-bodyTwist)
    scale(bodyFlare)
    linear_extrude(height = baseHeight)
        polyShape(solid="no");

rotate(360/sides/2)
linear_extrude( height = baseHeight)
    polyShape(solid = "yes");

rotate(360/sides/2)
translate([0,0,baseHeight])
    linear_extrude( height = bodyHeight, twist = -bodyTwist, scale = bodyFlare, slices = 2*bodyHeight)
        polyShape(solid="no");

rotate(360/sides/2)
translate([0,0,baseHeight+bodyHeight])
    rotate(bodyTwist)
    scale(bodyFlare)
    linear_extrude(height = baseHeight)
        polyShape(solid="no");       
        

module polyShape(solid){
    difference(){
        offset( r=5, $fn=48)
            circle( r=radius, $fn=sides);
        
        if( solid == "no"){
            offset( r=5-thickness, $fn=48)
                circle( r=radius,$fn = sides);
        }
    }
}




//Elevation of the joint pivot point
JointH=50; //>JointR
//Width of the inner Joint piece
JointInW=20; //<JointR
//Radius of pivot connectors
JointConnectR=5;

//Minimal angle for joint movement
JointMinAngle=60;
//Miximum angle for joint movement
JointMaxAngle=180;
//The radius of the Joint part
JointR=30;//>ConnectorR

/*[Tube connector]*/
//Inner Radius of the tubes to connect the joint to
ConnectorR=35/2;
//Height of the connector part
ConnectorH=5;
//Additional radius of the connector. Use the width of the tube walls; or (outer radius - inner radius)/2
ConnectorOverlap=2;

//Tolerance to use. If parts fit too tight increment and reprint. If too loose reduce and reprint.
t=0.5;


module part1(r1,r2){
    difference(){
        union(){
            hull(){
                translate([0,0,JointH]) sphere(r=r2);
                cylinder(r=r1+ConnectorOverlap,h=10);
            }
            translate([0,0,-ConnectorH]) cylinder(r=r1,h=ConnectorH);
        }
        
        n=3;
        translate([0,0,JointH])
        hull(){
        for (a = [JointMinAngle:JointMinAngle/n:JointMaxAngle]) {
            rotate([0,a,0])translate([0,0,-JointH]) 
                scale((JointInW+t)/JointInW) innerForm(r1,r2);
        }
        }
    
        translate([0,0,JointH]) rotate([90,0,0]) cylinder(r=JointConnectR+t,h=r2*2-4,center=true);
    }
}

module innerForm(r1,r2){
        hull(){
            translate([0,0,JointH]) rotate([90,0,0]) cylinder(r=r2,h=JointInW,center=true);
            cylinder(r=r1+ConnectorOverlap,h=10);
        }
    
}

module rectTorus(r1,h,w){
    difference(){
        cylinder(r=r1,h=h);
        cylinder(r=r1-w,h=h);
    }
}

module torus(r1,r2){
    rotate_extrude(convexity = 10)
    translate([r1, 0, 0])
    circle(r = r2); 
}

module cannel(r,w){
difference(){
    torus(r,w/2);
    translate([0,0,-w/2])pie(r+w/2, 180, w);
}
}

module part2(r1,r2){
    difference(){
    union(){
        innerForm(r1,r2);
        translate([0,0,-ConnectorH]) cylinder(r=r1,h=ConnectorH);
        translate([0,JointInW/2+4,JointH]) sphere(r=JointConnectR);
        translate([0,-JointInW/2-4,JointH]) sphere(r=JointConnectR);
    }
        //translate([0,0,2]) rectTorus(r1+8,6,8);
        translate([0,0,6]) torus(r1+4,4);
    
        
        ChannelWalls=5;
        translate([0,0,JointH]) rotate([270,0,0]) cannel(r2,JointInW-ChannelWalls);
        translate([r2,0,0.1]) cylinder(d=JointInW-ChannelWalls,h=JointH);
        translate([-r2,0,0.1]) cylinder(d=JointInW-ChannelWalls,h=JointH);
    }
    
}

module pie(radius, angle, height, spin=0) {
    // Negative angles shift direction of rotation
    clockwise = (angle < 0) ? true : false;
    // Support angles < 0 and > 360
    normalized_angle = abs((angle % 360 != 0) ? angle % 360 : angle % 360 + 360);
    // Select rotation direction
    rotation = clockwise ? [0, 180 - normalized_angle] : [180, normalized_angle];
    // Render
    if (angle != 0) {
        rotate([0,0,spin]) linear_extrude(height=height)
            difference() {
                circle(radius);
                if (normalized_angle < 180) {
                    union() for(a = rotation)
                        rotate(a) translate([-radius, 0, 0]) square(radius * 2);
                }
                else if (normalized_angle != 360) {
                    intersection_for(a = rotation)
                        rotate(a) translate([-radius, 0, 0]) square(radius * 2);
                }
            }
    }
}

part1(ConnectorR,JointR);
translate ([-JointR*2.1,0,0])part2(ConnectorR,JointR);


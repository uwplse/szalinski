//SHAFT
shaftDiameter=3;    //mm
chamfer=2.5;        //mm


//WHEEL
wheelDiameter=30;   //mm
wheelWidth=5;       //mm


circleEdges=200;




translate([-shaftDiameter/2.0,chamfer-(shaftDiameter/2.0),0]) cube([shaftDiameter,shaftDiameter-chamfer,wheelWidth]);

difference(){
    difference(){
        cylinder(d=wheelDiameter,h=wheelWidth,$fn=circleEdges);
        cylinder(d=shaftDiameter,h=wheelWidth,$fn=circleEdges);
    }
    rotate_extrude($fn=circleEdges) translate([wheelDiameter/2.0,wheelWidth/2.0,0]) circle(d=wheelWidth-1.6,$fn=circleEdges);
}
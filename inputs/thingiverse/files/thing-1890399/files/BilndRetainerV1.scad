// preview[view:south, tilt:top]

// Laying flat will print easier without supports but will not be as strong.
layFlat = "no"; // [yes,no]
// How far from the wall should the pin be?
pinDistance = 35;
// How long should the pin be?
pinLength = 5;
// Width of the pin
pinWidth = 3;
// Thickness of the part
thickness = 3;
// size of the area around the pin
pinFlange = 5;
// Size of the screw holes
holeSize = 4;
// Distance between the screw holes
holeDistance = 11;
// size of the tab
height = 15;
// width of the tab
width = 25;

/* [Hidden] */
outerCurve = (pinWidth*2) + pinFlange;

function rotationAngle(layFlat) = (layFlat) == "no" ? 90 : 0;

rotate(a=[rotationAngle(layFlat),0,0]) {
union() {
    
    translate([pinDistance+thickness,0,0]) {
        bezelRadious = 0.5;
        translate([0,0,thickness-bezelRadious]) {            
            rcylinder(r1=pinWidth/2,r2=pinWidth/2,h=pinLength+bezelRadious,b=bezelRadious,$fn=90);
        }
        cylinder(thickness,outerCurve/2,outerCurve/2,$fn=90);
    }
    
    centerPoint = [pinDistance+thickness,0];
    radius=outerCurve/2;
    
    outerPoint1=[thickness,width/2];
    dx1 = centerPoint.x - outerPoint1.x;
    dy1 = centerPoint.y - outerPoint1.y;
    dd1 = sqrt(dx1*dx1 + dy1*dy1);
    a1 = asin(radius / dd1);
    b1 = atan2(dy1, dx1);
    ta1 = b1 + a1;
    tangent1Point1 = [centerPoint.x + radius*-sin(ta1), centerPoint.y + radius*cos(ta1)];
    tb1 = b1 - a1;
    tangent1Point2 = [centerPoint.x + radius*sin(tb1), centerPoint.y + radius*-cos(tb1)];

    outerPoint2=[thickness,-width/2];
    dx2 = centerPoint.x - outerPoint2.x;
    dy2 = centerPoint.y - outerPoint2.y;
    dd2 = sqrt(dx2*dx2 + dy2*dy2);
    a2 = asin(radius / dd2);
    b2 = atan2(dy2, dx2);
    ta2 = b2 + a2;
    tangent2Point1 = [centerPoint.x + radius*-sin(ta2), centerPoint.y + radius*cos(ta2)];
    tb2 = b2 - a2;
    tangent2Point2 = [centerPoint.x + radius*sin(tb2), centerPoint.y + radius*-cos(tb2)];

    linear_extrude(height = thickness)
    polygon(points=[outerPoint1,outerPoint2,tangent2Point2,tangent1Point1]);
    
    difference() {
        translate([0,-width/2,0]) {
            cube([thickness,width,height], center=false);
        }
        
        translate([-0.5,-holeDistance/2,(height/2)-(holeSize/2)+thickness]) {
            rotate(a=[0,90,0]) {
                cylinder(thickness+1,holeSize/2,holeSize/2,$fn=90);
            }
        }
        
        translate([-0.5,holeDistance/2,(height/2)-(holeSize/2)+thickness]) {
            rotate(a=[0,90,0]) {
                cylinder(thickness+1,holeSize/2,holeSize/2,$fn=90);
            }
        }
    }
}
}
module rcylinder(r1=10,r2=10,h=10,b=2)
{hull(){rotate_extrude() translate([r1-b,b,0]) circle(r = b); rotate_extrude() translate([r2-b, h-b, 0]) circle(r = b);}}


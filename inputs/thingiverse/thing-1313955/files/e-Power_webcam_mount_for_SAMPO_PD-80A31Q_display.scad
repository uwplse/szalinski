
displayThickness = 43;
displayTop = 7;
webcamBaseMax = 25;
webcamBaseMin = 21;
webcamThickness = 3.8;

height=14;

cube([displayTop+2, 2, webcamBaseMax]);
hull() {
    translate([displayTop,0,0]) {
        cube([2, displayThickness+2+2, webcamBaseMax]);
    }
    translate([displayTop+height,(displayThickness+2)/2-2,0]) {
        cube([2, 4, webcamBaseMax]);
    }
}
translate([0,displayThickness+2,0]) {
    cube([displayTop+2, 2, webcamBaseMax]);
}
translate([displayTop+height+1,(displayThickness+2)/2-1,(webcamBaseMax-webcamBaseMin)/2]) {
    cube([webcamThickness+2,2,webcamBaseMin]);
}

translate([displayTop+webcamThickness+height+4,(displayThickness+2)/2,0]) {
    cylinder(r=2, h=webcamBaseMax, $fn=100);
}



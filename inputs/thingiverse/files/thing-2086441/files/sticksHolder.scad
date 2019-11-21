// Number of sticks to hold
numSticks = 3; // [1:10]

// Stick width
stickWidth = 20; // [1:40]

// Stick height
stickHeight = 20; // [1:40]

// Vertical spacing between sticks
heightDiff = 30; // [10:50]

// Number of drills for the support
numberDrills = 2; // [1, 2]

// Drills diameter
drillDiameter = 4; // [3:8]


/* [Hidden] */

drillWidth = drillDiameter/2;
oDepth = 20;

// Less or equall than support width
wD = 5; // [4:50] 

wSWidth = 6; // [4:50]
wallWidth = min(wSWidth, wD); 


totalSupportHeight = stickHeight + heightDiff * (numSticks - 1) + wallWidth + numberDrills * (drillWidth + 10);

drillShift = (numberDrills - 1) * (drillWidth + 10);


$fn=60;
rad = 2;
difference() {
union(){
wallSupport();
translate([wSWidth-wallWidth >=0 ?  wSWidth-wallWidth : 0, 0, drillShift])
sticksHolder();
}
union() {
translate([wSWidth+0.1, 0, totalSupportHeight-drillWidth-2])
    rotate(a=[0, -90, 0])    
drill(drillWidth, wSWidth+1, 1);

if (numberDrills == 2) {
translate([wSWidth+0.1, 0, 7])
    rotate(a=[0, -90, 0])    
drill(drillWidth, wSWidth+1, 1);
}
}
}

module wallSupport() {
dr = numberDrills * (drillWidth + 10);
translate([0, -oDepth/2, 0])
roundedCube(wSWidth, oDepth, totalSupportHeight, rad);
}

module drill(r, h, chanfer) {
cylinder (r=chanfer+r, h=r, r2=r);  
translate([0, 0, chanfer]) cylinder(r=r, h=h-chanfer); 

}

module sticksHolder() {
    w = 2*wallWidth + stickWidth;
    for (a = [1:numSticks]) {
        translate([(a-1)*(w-wallWidth), -oDepth/2, 0])
        //translate([(a-1)*(w-wallWidth), -oDepth/2, -(a-1)*heightDiff])
                stickHolder(stickWidth, oDepth, stickHeight, numSticks-a);
          
    }
}


module stickHolder(w, d, h, last) {
r=rad;
s = last > 0 ? 1 : 0;
tW = w+2*wallWidth;
tH = h+wallWidth + heightDiff * last;
    roundedCube(wallWidth, d, tH, r);
    translate([wallWidth-r, 0, 0]) cube([w+2*r, d, tH-h]);
    translate([wallWidth+w, 0, 0]) roundedCube(wallWidth, d, tH, r);
}

module roundedCube(w, d, h, r) {
hull() {
translate([r, 0, r]) rotate(a=[-90, 0, 0]) cylinder(r=r, h=d);
translate([w-r, 0, r]) rotate(a=[-90, 0, 0]) cylinder(r=r, h=d);
translate([r, 0, h]) rotate(a=[-90, 0, 0]) cylinder(r=r, h=d);
translate([w-r, 0, h]) rotate(a=[-90, 0, 0]) cylinder(r=r, h=d);    
}
}

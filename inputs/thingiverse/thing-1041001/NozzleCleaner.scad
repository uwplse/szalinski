
gridSize = 5;
gridHole = 3;
gridWidth = 12;
griddedLength = 8;
ungriddedLength = 4;
gridThickness = 0.5;

handleHeight = 45;
handleDiameter = 4;


module grid(bGrid) {
    difference() {
        cube([gridSize,gridSize,gridThickness],center=true);
        if (bGrid==true) {
            cube([gridHole,gridHole,gridThickness+0.1],center=true);
        }
    }
}
translate([-gridHole/2,-gridHole/2,0])
for (i=[1:gridWidth]) {
    for (j=[1:griddedLength]) {
        translate([(gridSize)*i-(gridSize-gridHole)/2*i,(gridSize)*j-(gridSize-gridHole)/2*j,0])
        grid(true);
    }
    if (ungriddedLength > 0) {
        for (j=[griddedLength+1:griddedLength+ungriddedLength]) {
            translate([(gridSize)*i-(gridSize-gridHole)/2*i,(gridSize)*j-(gridSize-gridHole)/2*j,0])
            grid(false);
        }
    }
}

$fn=60;
gridEdge = (gridSize-gridHole)/2;
echo(gridEdge);
modelWidth = (gridSize-(gridSize-gridHole)/2)*(gridWidth-1)+gridSize;
translate([modelWidth/2,-handleHeight/2,handleDiameter/2-handleDiameter/8-gridThickness/2])
rotate([90,90,0])
difference() {
    cylinder(d=handleDiameter, h=handleHeight, center=true);
    translate([7*handleDiameter/8,0,0])
    cube([handleDiameter,handleDiameter,handleHeight+1],center=true);
    translate([-7*handleDiameter/8,0,0])
    cube([handleDiameter,handleDiameter,handleHeight+1],center=true);
}

handleRadius = handleDiameter/2;
filletLength = 2*sqrt(pow(handleRadius,2)-pow(5*handleRadius/8,2));
filletSize = gridEdge>handleRadius?handleRadius:gridEdge;
translate([modelWidth/2,filletSize/2,filletSize/2+gridThickness/2])
difference() {
    cube([filletLength,filletSize,filletSize],center=true);
    translate([0,filletSize/2,filletSize/2])
    rotate([0,90,0])
    cylinder(h=filletLength+1,d=filletSize*2,center=true);
}
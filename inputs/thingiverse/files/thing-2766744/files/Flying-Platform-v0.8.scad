// Flying Combat Platform for Tabletop RPGs
// DMNC, Version 0.8, 14.12.2018

// Variables

_widthSquare=25;        // Square Length
_thickness=3;           // Plate Thickness
_sizeBaseX=4;           // Base platform, number of squares in a row
_sizeBaseY=4;           // Base platform, number of rows
_sizeMiddleX=3;         // Middle platform, number of squares in a row
_sizeMiddleY=3;         // Middle platform, number of rows
_sizeTopX=2;            // Top platform, number of squares in a row
_sizeTopY=2;            // Top platform, number of rows
_flippedTop=1;          // [0:false, 1:true]
_chamfer=50;            //Chamfer around Top-Side of Square
_tolerance=0.2;         // Tolerance for connecting pieces
_connectorHeight=40;    // Height of connecting pieces
_connectorPinHeight=15; // Height of pins on connecting pieces
_widthConnector=12.5;   // Width of connecting pieces
_connectorThickness=1.2;// Perimeter thickness of connecting pieces
_numberOfPieces=5;      // Number of Connecting Pieces

//Calculate Chamfer Size
_chamferSize=(_thickness*_chamfer)/100;

//Generate one Square
module oneSquare() {
    hull() {
        cube(size=[_widthSquare,_widthSquare,_thickness-_chamferSize]);
        translate([_chamferSize,_chamferSize,0])
        cube(size=[_widthSquare-2*_chamferSize,_widthSquare-2*_chamferSize,_thickness]);
    }
}

//Generate defaultConnector
module defaultConnectorTemp(w=_widthConnector,z1=_connectorHeight,z2=_connectorPinHeight,t=0,ct=_connectorThickness, bt=0) union(){
    
    cube(size=[w,w,z1-z2]);
    hull() {
        translate([ct+t,ct+t,0])
        cube(size=[w-2*(ct+t),w-2*(ct+t),z1-_chamferSize-bt]);
        translate([ct+t+_chamferSize,ct+t+_chamferSize,0])
        cube(size=[w-2*ct-2*t-2*_chamferSize,w-2*ct-2*t-2*_chamferSize,z1-bt]);
    }
}

module defaultConnector() difference() {
    defaultConnectorTemp(t=_tolerance, bt=5*_tolerance);
    translate([0,0,-_connectorHeight+_connectorPinHeight]) defaultConnectorTemp(); 
}

//Generate baseConnector
module baseConnector(w=_widthConnector,z1=_connectorHeight,z2=_connectorPinHeight,t=0,ct=_connectorThickness, bt=0) union() {
    
    /*cube(size=[w,w,z1-z2]);
    hull() {
        translate([ct+t,ct+t,0])
        cube(size=[w-2*ct-t,w-2*ct-t,z1-_chamferSize]);
        translate([ct+t+_chamferSize,ct+t+_chamferSize,0])
        cube(size=[w-2*ct-t-2*_chamferSize,w-2*ct-t-2*_chamferSize,z1]);
    }*/
    defaultConnectorTemp(w,z1,z2,t,ct,bt);
}

//Generate topConnector
module topConnector(w=_widthConnector,z1=_connectorHeight,z2=_connectorPinHeight,t=_tolerance,ct=_connectorThickness) {
    hull() {
        cube(size=[w,w,z1-z2-_chamferSize]);
        translate([_chamferSize,_chamferSize,0])
        cube(size=[w-2*_chamferSize,w-2*_chamferSize,z1-z2]);
    }
}

//Generate rows of squares
module baseOneRow(x=_sizeBaseX) {
    for(i=[1:x])
    translate((i-1)*[_widthSquare,0,0]) oneSquare();
}

module middleOneRow(x=_sizeMiddleX) {
    for(i=[1:x])
    translate((i-1)*[_widthSquare,0,0]) oneSquare();
}

module topOneRow(x=_sizeTopX) {
    for(i=[1:x])
    translate((i-1)*[_widthSquare,0,0]) oneSquare();
}

//Generate platforms
module basePlatform(y=_sizeBaseY) {
    if (_sizeBaseX == 0 || _sizeBaseY == 0) { }
    else {
    for(i=[1:y]) translate([0,(i-1)*_widthSquare,0]) baseOneRow();
    translate([0,0,0]) baseConnector(t=_tolerance, bt=5*_tolerance);
    }
}

module middlePlatformTemp(y=_sizeMiddleY) union(){
    translate([0,(_sizeBaseY+1)*_widthSquare,0])
    for(i=[1:y]) translate([0,(i-1)*_widthSquare,0]) middleOneRow();
    translate([0,(_sizeBaseY+1)*_widthSquare,0]) baseConnector(t=_tolerance, bt=5*_tolerance);
}

module middlePlatform(x=_sizeMiddleX) difference(){
    middlePlatformTemp();
    translate([0,(_sizeBaseY+1)*_widthSquare,-_connectorHeight+_connectorPinHeight]) baseConnector(); 
}

module middlePlatformCheck() {
        if (_sizeMiddleX == 0 || _sizeMiddleY == 0) { }
    else {
        middlePlatform();
    }
}

module topPlatformTemp(y=_sizeTopY) union(){
    translate([0,(_sizeBaseY+1+_sizeMiddleY+1)*_widthSquare,0])
    for(i=[1:y]) translate([0,(i-1)*_widthSquare,0]) topOneRow();
    translate([0,(_sizeBaseY+1+_sizeMiddleY+1)*_widthSquare,0]) topConnector();
}

module topPlatformFlippedTemp(y=_sizeTopY) union(){
    translate([0,(_sizeBaseY+1+_sizeMiddleY+1)*_widthSquare,0])
    for(i=[1:y]) translate([0,(i-1)*_widthSquare,0]) topOneRow();
    translate([0,(_sizeBaseY+1+_sizeMiddleY+1)*_widthSquare,-_connectorHeight+_connectorPinHeight+_thickness]) topConnector();
}

module topPlatformDefault(y=_sizeTopY) difference(){
    topPlatformTemp();
    translate([0,(_sizeBaseY+1+_sizeMiddleY+1)*_widthSquare,-_connectorHeight+_connectorPinHeight]) baseConnector();
}

module topPlatformFlipped(y=_sizeTopY) difference(){
    topPlatformFlippedTemp();
    translate([0,(_sizeBaseY+1+_sizeMiddleY+1)*_widthSquare,-_connectorHeight+_connectorPinHeight-_connectorHeight+_connectorPinHeight+_thickness]) baseConnector();
}

module topPlatformVariantPicker(y=_sizeTopY) difference(){
    
        
    if (_flippedTop)
    {
        if (_sizeTopX == 0 || _sizeTopY == 0) { }
        else {
            rotate([0,180,0])
            translate([(-(_sizeTopX)*_widthSquare),0,-_thickness])
            topPlatformFlipped();
        }
    }
    else
    {   
        if (_sizeTopX == 0 || _sizeTopY == 0) { }
        else {
            topPlatformDefault();
        }
    }
}

module connectingPieces(n=_numberOfPieces) {
    translate([-_widthConnector-_widthSquare,0,0])
    for(i=[1:n]) translate([0,(i-1)*(_widthConnector*1.5),0]) defaultConnector();
}

//Generate Elements
basePlatform();
middlePlatformCheck();
topPlatformVariantPicker();
connectingPieces();

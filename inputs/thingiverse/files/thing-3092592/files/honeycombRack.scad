//------Created by Dsphar------//
//------Hope you find it usefull, for updates, see repo below------//
//https://github.com/Dsphar/openscad_honeycomb_shelf.git

//User Entered Values
numRows = 6;
numCols = 5;
wallThickness = 2;
minDiameter = 32;
height = 35;
tiltDeg = 30;
screwDiameter = 5;
screwHoleOffset = 3;
plateThickness = 2;

//No spaces (row,col|row,col...)
mountingPlatePositions = "2,2|2,4|5,3";//string hack for Thingiverse Customizer

//Rectangle
buildCombRect(numRows,numCols);
//addMountingPlate(2, numRows, 2, numCols); //(row, numRows, col, numCols)
//addMountingPlate(2, numRows, 4, numCols); //(row, numRows, col, numCols)
//addMountingPlate(5, numRows, 3, numCols); //(row, numRows, col, numCols)

//Calculated Values
minRad = minDiameter/2;
minRadWall = minRad+wallThickness;
minDiam = minRadWall*2;
rad = 2*minRad / sqrt(3);
diam = rad*2;
evenRowBaseOffset = (minDiam-wallThickness)*cos(tiltDeg);

//modules
module buildCombRect(numRows, numColumns){
    for(col = [0:1:numColumns-1]){
        offsetCol(col)
        buildCol(numRows);
    }
}

module buildHex(){
    linear_extrude(height)
    translate([-minRad-wallThickness,rad+wallThickness,0])   
    rotate(30)
    difference(){
        circle(rad+wallThickness, $fn=6);
        circle(rad, $fn=6);
    };
}

module buildCol(size){  
    for(i = [0:1:size-1])   
        shiftObjectX(i)       
        tiltHex(tiltDeg)  
        buildHex();
}

module offsetCol(colNum){
    
    xShift = (colNum%2 == 0) ? 0 
        : (evenRowBaseOffset+(minDiam)*sin(tiltDeg)/tan(90-tiltDeg))/2;
    yShift = (colNum%2 == 0) ? colNum/2*(diam+rad+wallThickness*cos(30)*2) 
        : colNum*(diam-rad/2+wallThickness*cos(30));
        
    translate([xShift,yShift,0])
    {
        for(i=[0:$children-1])
        children(i);
    }
}

module shiftObjectX(units){
    translate([units*((minDiameter+wallThickness)*cos(tiltDeg)+(minDiameter+wallThickness)*sin(tiltDeg)/tan(90-tiltDeg)), 0, 0])
    {
        for(i=[0:$children-1])
          children(i);
    }
}

module  tiltHex(deg){
    rotate([0,deg,0]){
        for(i=[0:$children-1])
          children(i);
    }
}

module addMountingPlate(row, numRows, col,  numCols){
    place(numRows-row,numCols-col) 
    translate([-minDiam*cos(tiltDeg) - (minDiam)*sin(tiltDeg)/tan(90-tiltDeg)+wallThickness/2,(minDiameter+wallThickness)*.33,0])
    difference(){
        
        cube([minDiam*cos(tiltDeg) + (minDiam)*sin(tiltDeg)/tan(90-tiltDeg)-wallThickness/2,minRadWall+wallThickness/2,plateThickness]);
    
        translate([minDiam-screwHoleOffset, (minRadWall+wallThickness/2)/2, -1])
        cylinder(wallThickness+2, screwDiameter/2, screwDiameter/2+.5);
    }
}

module place(row,column){
    offsetCol(column)
    shiftObjectX(row)
    {
        for(i=[0:$children-1])
        children(i);
    }  
}

//Note: Everything below is a hack to allow Thingiverse Customizer
//users to add plates as they wish. I do not suggest you do it this
//way in OpenSCAD. In fact, You can delete everyting below here.
//Instead, just call addMountingPlate for every plate you want to add.
//See lines 18-20.

addMountingPlates(mountingPlatePositions);

module addMountingPlates(platesAsString){
    plates = [for(i = split("|", platesAsString)) split(",", i)];
    
    for(i = [0:len(plates)-1]){
        addMountingPlate(strToInt(plates[i][0]),numRows,strToInt(plates[i][1]),numCols);
    }
}

//courtesy of thingiverse.com/groups/openscad/forums/general/topic:10294
function substr(s, st, en, p="") =
    (st >= en || st >= len(s))
        ? p
        : substr(s, st+1, en, str(p, s[st]));
function split(h, s, p=[]) =
    let(x = search(h, s)) 
    x == []
        ? concat(p, s)
        : let(i=x[0], l=substr(s, 0, i), r=substr(s, i+1, len(s)))
                split(h, r, concat(p, l));

//courtesy of thingiverse.com/thing:202724/files    
function strToInt(str, base=10, i=0, nb=0) = (str[0] == "-") ? -1*_strToInt(str, base, 1) : _strToInt(str, base);
function _strToInt(str, base, i=0, nb=0) = (i == len(str)) ? nb : nb+_strToInt(str, base, i+1, search(str[i],"0123456789")[0]*pow(base,len(str)-i-1));

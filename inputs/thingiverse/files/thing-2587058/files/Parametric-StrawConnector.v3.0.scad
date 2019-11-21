//  SET YOUR PARAMETERS(in mm)
//  the presets below are obtimized for the straws from IKEA (Sötvatten), to be printed on Ultimaker 2, in PLA ("normal" preset, without support structures or build plate adhesion).
radiusTip    =  3.85;   // 
radiusMid    =  4.1;    // >= raduisTip, this should be slightly bigger than the straw inner radius
radiusBase   =  4.0;    //
lengthTip    =  5.0;    //
lengthMid    =  5.0;    //
lengthBase   = radiusBase; // best not to touch
wallThickness=  0.8;    //

//  tubeEndHoleRadius sets the size of the hole in the end of the tube. Choose 0 for completely closed, or "radiusTip-wallThickness" for completely open. Partially closing up the ends helps with keeping the round shape of the tube without having support structures. 
tubeEndHoleRadius = 1.2; // in mm

//  holeTroughBack can be used to string a fishing-wire trough the connector if your construction needs extra tensile strength to stay together (e.g long horizontal spans).
holeTroughBack = true; // true|false

//  FlattenedSides make it easier and cleaner to print without support structures and create beter print bed adhesion. If true, the circomference of the tube will be slightly smaller, you might have to tweak the radii.
flattenSides = true;  // true|false

//  buildPlateAdhesionGrid creates a "1 layer" thick grid of strips underneath the connectors, connection them together and creating a larger surface area to stick to the buildPlate. If you enable this option, you should turn of adhesion in your slicing software. 
buildPlateAdhesionGrid        = true; // true|false
buildPlateAdhesionStripWidth  = 1.5;  // in mm
buildPlateAdhesionStripHeight = 0.2;  // should be bigger than the layerheight set in your slicer software

//  Set number of faces of tubes and spheres. 26 seems to work best to let tubes connect to center spheres, but play with this if you want
$fn = 26; 

//  EXAMPLE CONFIGURATIONS
//  X,Y,Z are positive axis directions
//  x,y,z are negative axis directions
//  Example Connector Definitions:
//  [X];           // test piece to try the fitting
//  [X,x];         // Straight ─
//  [X,Y];         // 2D Corner ┘
//  [X,x,Y];       // 2D T-Junction ┴ 
//  [X,x,Y,y];     // 2D Cross-Junction ┼
//  [X,Y,Z];       // 3D Corner ╜
//  [X,x,Y,Z];     // 3D T-Junction ╨
//  [X,x,Y,y,Z];   // 3D T-Cross-Junction ╫ 
//  [X,x,Y,y,Z,z]; // 3D Cross-Cross-Junction ╬
//  [X,Y,Q];       // 3D Corner with 60º angle
//  [X,x,Y,Q];     // 3D T-Junction with 60º angle


// DEFINE CUSTOM CONNECTOR
grid(
    connectorDefinition=[X,x,Y,Z], 
    cols=2, 
    rows=2
);

//  OR, SELECT COMMON PRESETS
//  (remove * to select):
*!grid([X,Y,Z],      1,1); //  1 3D Corners
*!grid([X,Y,Z],      4,2); //  8 3D Corners
*!grid([X,x,Y,Z],    4,4); // 16 3D T-junctions
*!grid([X,x,Y,y,Z],  4,2); //  8 3D T-Cross-junctions
*!grid([X,x,Y,y,Z,z],2,2); //  4 3D Cross-Cross junctions






/////////////////////////////////////////////////////
// Don't touch beyond this line
// Unless you want to create different orrientations
/////////////////////////////////////////////////////

// Define tube orientations
X = ["X",[ 90,  0, 90]];
x = ["x",[-90,  0, 90]];
Y = ["Y",[-90,  0,  0]];
y = ["y",[ 90,  0,  0]];
Z = ["Z",[  0,  0,  0]];
z = ["z",[  0,180,  0]];
Y60X = ["Y",[-90, 0, -30]]; // replaces Y with a 60 degree angle from X
Y60x = ["Y",[-90, 0, 30]]; // replaces Y with a 60 degree angle from x
Z60Y = ["Y",[-30, 0, 0]]; // replaces Y with a 60 degree angle from X


// MODULES

module grid(connectorDefinition, cols=1, rows=1, spacing=2){

    // shorthand
    conDef = connectorDefinition;
    
    unitWidth = unitSize("x",conDef)+unitSize("X",conDef);
    unitDepth = unitSize("y",conDef)+unitSize("Y",conDef);
   
    xOffset = unitWidth+spacing;
    yOffset = unitDepth+spacing;
 
    for(i=[0:cols-1]){
        for(j=[0:rows-1]){
            translate([i*xOffset,j*yOffset,0]){
                create(connectorDefinition);
            }
        }
    }
    if(buildPlateAdhesionGrid){
        buildPlateAdhesionGrid(connectorDefinition, cols, rows, spacing);
    }
}

module create(connectorDefinition){
    // move up to sit on the plain
    haszTube = hasTube("z", connectorDefinition);

    moveUp = (haszTube) ? lengthTip+lengthMid+lengthBase : tubeRadius();
    translate([0,0,moveUp]){
        Connector(connectorDefinition);
    }
}

module Connector(connectorDefinition){
    // Create the connector
    difference(){
        // we need to first create all solids and then all hollows, because the hollows will break through the center spheres of other tubes, making the whole thing truly hollow.
        //If we would create each tube separately and then join them, the center would be a solid sphere, leaving no channel through the whole object. 

        // first construct and join all solid tubes
        union(){
            for(i=[0:len(connectorDefinition)-1]){
                TubeSolid(connectorDefinition[i][1]);
            }
        }
        // then construct and join all hollow tubes, to be substracted from the solid shape
        union(){
            for(i=[0:len(connectorDefinition)-1]){
                TubeHollow(connectorDefinition[i][1]);
            }
        }
    }
}

module TubeHollow(rotation){
    // make the hollow tube smaller than the solid, by 'wallThickness'
    innerRadius=min(radiusTip,radiusMid,radiusBase) - wallThickness;
    // rotate the tube in the requested orientation
    rotate(rotation){
        // add sphere at base end
        sphere(innerRadius);
        // move cylinder slightly down to extend beyond the top/bottom of the tube
        o=0.001;
        length=tubeLength()+o-wallThickness;
        translate([0,0,-o]){
            // create inner cylinder, slightly longer than the solid tube
           cylinder(h=length,r=innerRadius);            
        }
        moveDown = (holeTroughBack)?radiusBase:0;
        translate([0,0,-moveDown]){
           cylinder(h=radiusBase+length+wallThickness+o,r=tubeEndHoleRadius);
        }
    }
}

module TubeSolid(rotation){
    // rotate the tube in the requested orientation
    rotate(rotation){
        // create tube
        tube(radiusTip,radiusMid,radiusBase,lengthTip,lengthMid,lengthBase,wallThickness);
    }
}

module tube(rTip, rMid, rBase, lTip, lMid, lBase, wall){
    // slice some flat sides off the cylinder, for easyer printing without support 
    intersection(){
        tubeCylinder(rTip, rMid, rBase, lTip, lMid, lBase, wall);
        if(flattenSides){
            tubeCube(rTip, rMid, rBase, lTip, lMid, lBase, wall);
        }
    }
}

module tubeCube(rTip, rMid, rBase, lTip, lMid, lBase, wall){
    w=min(rTip, rMid, rBase)*2;
    h=lTip+lMid+lBase+rBase;
    translate([0,0,h/2-min(rTip, rMid, rBase)]){
        cube([w,w,h], center=true);
    }
}

module tubeCylinder(rTip, rMid, rBase, lTip, lMid, lBase, wall){
    champherSize = wall/2;
    // add sphere at base end
    sphere(radiusBase);
    // Base section of the tube
    cylinder(h=lBase, r2=rBase, r1=rBase);
    // Mid section of the tube
    translate([0,0,lBase]){
        cylinder(h=lMid, r2=rMid, r1=rBase);
    }
    // Tip section of the tube
    translate([0,0,lBase+lMid]){
        cylinder(h=lTip-champherSize, r1=rMid, r2=rTip, center=false);
    }
    // Champher of the tip        
    translate([0,0,lengthBase+lengthMid+lengthTip-champherSize]){
        cylinder(h=champherSize, r1=rTip, r2=rTip-champherSize, center=false);
    }
}

module buildPlateAdhesionGrid(connectorDefinition, cols, rows, spacing){

    // shorthands
    width = buildPlateAdhesionStripWidth;
    height = buildPlateAdhesionStripHeight;
    conDef = connectorDefinition;

    hasxTube = hasTube("x", conDef);
    hasXTube = hasTube("X", conDef);
    hasyTube = hasTube("y", conDef);
    hasYTube = hasTube("Y", conDef);
    
    unitSizeX = unitSize("X", conDef);
    unitSizex = unitSize("x", conDef);
    unitSizeY = unitSize("Y", conDef);
    unitSizey = unitSize("y", conDef);
    
    unitWidth = unitSizex+unitSizeX;
    unitDepth = unitSizey+unitSizeY;
   
    // strip lengths
    lengthX = cols*(unitWidth+spacing)+spacing+2*width;
    lengthY = rows*(unitDepth+spacing)+spacing+2*width;

    // Draw x-direction strips
    for(j = [0:rows-1]){
        Strip("x", width, height, lengthX, spacing, hasxTube, offset=j*(unitDepth+spacing));
    }

    // Draw y-direction strips
    for(i = [0:cols-1]){
        Strip("y", width, height, lengthY, spacing, hasyTube, offset=i*(unitWidth+spacing));
    }

    // Draw bounding box - x-direction
    offsetX1 = (hasyTube)? -unitSizey-spacing-0.5*width : -tubeRadius()-spacing-0.5*width;
    Strip("x",width, height, lengthX, spacing, hasxTube, offsetX1);

    offsetX2 = (rows-1)*(unitDepth+spacing)+unitSizeY+spacing+0.5*width;
    Strip("x",width, height, lengthX, spacing, hasxTube, offsetX2);
    
    // Draw bounding box - y-direction
    offsetY1 = (hasxTube)? -unitSizex-spacing-0.5*width : -tubeRadius()-spacing-0.5*width;
    Strip("y",width, height, lengthY, spacing, hasyTube, offsetY1);
  
    offsetY2 = (cols-1)*(unitWidth+spacing)+unitSizeX+spacing+0.5*width;
    Strip("y",width, height, lengthY, spacing, hasyTube, offsetY2);

}

module Strip(xOryAxis, width, height, length, spacing, hasxOryTube, offset=0){

    recenterWidth = -0.5*width;

    recenterLength = (hasxOryTube)? -lengthTip-lengthMid-lengthBase-spacing-width : -tubeRadius()-spacing-width;

    translation = (xOryAxis=="x")? [recenterLength,recenterWidth+offset,0] : [recenterWidth+offset,recenterLength,0];

    dimension = (xOryAxis=="x")? [length,width,height] : [width,length,height];

    translate(translation){
        #cube(dimension);
    }
}


// FUNCTIONS

function hasTube(axis, conDef) = 
    (len(search(axis, conDef))>0)?true:false;

function tubeRadius() = (flattenSides)? min(radiusTip,radiusMid,radiusBase) : max(radiusTip,radiusMid,radiusBase);
    
function tubeLength() = lengthTip+lengthMid+lengthBase;

function unitSize(axis,conDef) = (hasTube(axis, conDef))? tubeLength():tubeRadius();

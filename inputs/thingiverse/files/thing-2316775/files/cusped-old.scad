// cusped parameters

//radius to inside points of flower
radius = 40; // [0:100]
//number of cusps/petals
cusps = 16; // [2:30]
//angle (in deg) each cusp arc traces
cuspAngle = 170; // [1:240]

//Use backing grid (slow)?
grid = "false"; // [false,true]
Bgrid = (grid == "true");
//Round edges of cutter?
rounded = "true"; // [false,true]
Brounded = (rounded == "true");
//width of cookie cutter body (mm)
width = 1.5;
//total height of the cookie cutter (mm)
height = 12.0;
//width of bottom flange (mm)
flangeWidth = 4.0;
//height of bottom border (mm)
flangeHeight = 1.2;
//arc segments/precision
$fn = 40; // [1:100]

/// Grid parameters
//width of grid lines
meshSolid=1.2;
//space between grid lines
meshSpace=8.0; 
gridThickness=flangeHeight; //thickness of grid
moveGridX=0*1;    //Grid x shift
moveGridY=0*1;    //Grid y shift
rotateGridZ=45.0*1;  //Rotate grid direction (deg)

function crd(theta) = 2*sin(theta/2); //chord trig function
function rectCoords(r, theta) = [r*cos(theta), r*sin(theta)];
function addPoints(p1, p2) = [p1[0] + p2[0], p1[1] + p2[1]];

biga = 360/cusps; //angle per cusp
centerA = 180 - cuspAngle/2; //angle from large angle to start of cusp
lawOfSines = radius/sin(centerA);
centerDist = lawOfSines*sin(180 - biga/2 - centerA);
smallR = lawOfSines*sin(biga/2);
gridX=2*(centerDist+smallR+flangeWidth); //max possible grid needed
gridY=gridX;

points = [ for (segment = [ 0 : cusps-1 ])
	         let (center = rectCoords(centerDist, biga*segment), startA = biga*segment + centerA - 180)
	         for (point = [ 0 : $fn-1])
				 addPoints(center, rectCoords(smallR, startA + cuspAngle*point/$fn))
		 ];

module shape() {
    polygon(points);
}

/// Module grid have been imported from the Openscad grid creator by Glyn
/// Orininaly published on http://www.thingiverse.com/thing:29211
/// Under the terms of Creative Commons By-Sa (08.26.2012)
module grid(meshSolid, meshSpace, gridThickness, gridX, gridY) {
    meshX=gridX;
    meshY=gridY;
    nX=meshX/(meshSolid+meshSpace);
    nY=meshY/(meshSolid+meshSpace);

    for (i=[0:nX]) {
        translate([-(meshX/2)+i*(meshSolid+meshSpace),-meshY/2,-gridThickness/2]) cube(size=[meshSolid,meshY,gridThickness],center=false);
    }

    for (i=[0:nY]) {
        translate([-meshX/2,-(meshY/2)+i*(meshSolid+meshSpace),-gridThickness/2]) cube(size=[meshX,meshSolid,gridThickness],center=false);
    }
}

module innerCutout() { //inner edge of cutter, exaggerated to subtract well
    translate([0,0,-0.1]) linear_extrude(height+0.2) shape();
}
module addGrid() {
    if (Bgrid) {
        intersection(){ //portion of grid that is inside cutter
            translate([moveGridX,moveGridY,(0.5*gridThickness)]) rotate([0,0,rotateGridZ]) grid(meshSolid, meshSpace, gridThickness, gridX, gridY);
            innerCutout();
        };
    }
	children();
}

addGrid() difference(){
    if (Brounded) { //which offset style to use?
        linear_extrude(flangeHeight) offset(flangeWidth) shape(); //flange on top
        linear_extrude(height) offset(width) shape();             //outer edge of cutter
    } else {
        linear_extrude(flangeHeight) offset(delta=flangeWidth) shape(); //flange on top
        linear_extrude(height) offset(delta=width) shape();             //outer edge of cutter
    }
    innerCutout();
}
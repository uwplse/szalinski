//Final diameter (mm)
diam = 50; // [0:100]
//number of cusps/petals
cusps = 18; // [2:30]
//bulge factor
bulge = 3; //[0.01:0.01:4]

//Use backing grid (slow)?
grid = "false"; // [false,true]
Bgrid = (grid == "true");
//width of cookie cutter body (mm)
width = 1.5;
//total height of the cookie cutter (mm)
height = 10.0;
//width of bottom flange (mm)
flangeWidth = 4.0;
//height of bottom border (mm)
flangeHeight = 1.2;
//line segment size (mm)
$fs = 0.5; // [0.05:0.05:2]

/// Grid parameters
//width of grid lines
gridWidth = 1.2;
//space between grid lines
gridSpace = 8.0;
gridThick = flangeHeight;

function crd(theta) = 2*sin(theta/2); //chord trig function
function rectCoords(r, theta) = [r*cos(theta), r*sin(theta)];
function addPoints(p1, p2) = [p1[0] + p2[0], p1[1] + p2[1]];

biga = 360/cusps; //angle per cusp
radius = diam/2/(cos(biga/2)+bulge/cusps); //radius to inside of cusps
chord = radius*crd(biga); //length of chord spanning each cusp
sag = radius*bulge/cusps;
smallR = sag/2 + chord*chord/8/sag; //radius needed for given sagitta
cuspAngle = 2*acos(1 - sag/smallR);
//centerA = 180 - cuspAngle/2; //angle from large angle to start of cusp
centerDist = diam/2-smallR; //dist from center of cusp to center of circle
gridX=diam*1.1; //max possible grid needed
gridY=gridX;

assert(cuspAngle <= 360);

$fn = ceil((smallR*cuspAngle*3.1415926/180)/$fs);
points = [ for (segment = [ 0 : cusps-1 ])
	         let (center = rectCoords(centerDist, biga*segment), startA = biga*segment - cuspAngle/2)
	         for (point = [ 0 : $fn])
				 center + rectCoords(smallR, startA + cuspAngle*point/$fn)
		 ];
module shape() {
    polygon(points);
}

module grid(width, spacing, thickness, xsize, ysize) {
	period = width + spacing;
	nX = floor(xsize/2/period);
	nY = floor(ysize/2/period);
	
	for (i=[-nX:nX]) {
		translate([period*i,0,thickness/2]) cube([width, ysize, thickness], true);
	}
	for (i=[-nY:nY]) {
		translate([0, period*i, thickness/2]) cube([xsize, width, thickness], true);
	}
}

module innerCutout() { //inner edge of cutter, exaggerated to subtract well
    translate([0,0,-0.1]) linear_extrude(height+0.2) shape();
}
module addGrid() {
    if (Bgrid) {
        intersection(){ //portion of grid that is inside cutter
            rotate(45) grid(gridWidth, gridSpace, gridThick, gridX, gridY);
            innerCutout();
        };
    }
	children();
}

addGrid() render(2) difference(){
    union() {
        linear_extrude(flangeHeight) offset(flangeWidth) shape(); //flange on top
        linear_extrude(height) offset(width) shape();             //outer edge of cutter
    }
    innerCutout();
}
baseheight = 1;
wallheight = 2.5;
wallwidth = 1;
crosslength = 20;
tileside = 46;
floorwidth = 5;
totalwidth = 3*tileside+2*wallwidth;
firstdividecenter = tileside+wallwidth/2;
seconddividecenter = tileside*2+wallwidth+wallwidth/2;
centerfirsttile = tileside/2;
centersecondtile = tileside+wallwidth+tileside/2;
centerthirdtile = tileside*2+wallwidth*2+tileside/2;
dovewidth = 17.2;
negdovewidth = 18;
cornerradius = 8; //4;

module centercross (xpos, ypos, zpos) {
	translate( [xpos, ypos, zpos]) 
		translate ([-crosslength/2,-wallwidth/2, 0]) cube ([crosslength, wallwidth, wallheight]);
	translate ( [xpos, ypos, zpos])
		translate ([-wallwidth/2,-crosslength/2, 0]) cube ([wallwidth, crosslength, wallheight]);
} // module

module centerT (xpos, ypos, zpos, rotation) {
    translate( [xpos, ypos, zpos]) rotate([0, 0, rotation]) 
        translate ([-crosslength/2,-wallwidth/2, 0]) cube ([crosslength, wallwidth, wallheight]);
    translate ( [xpos, ypos, zpos]) rotate([0, 0, rotation]) 
        translate ([-wallwidth/2,0, 0]) cube ([wallwidth, crosslength/2, wallheight]);
} // module

module corner (xpos, ypos, zpos) {
	translate ( [xpos, ypos, zpos]) 
	difference () {
		cube ([floorwidth+cornerradius, floorwidth+cornerradius, baseheight]);
		translate ([floorwidth+cornerradius, floorwidth+cornerradius, 0]) cylinder (3, r=cornerradius, $fn=20);
	} // difference
} // module corner

// y-direction floorbeams - translate to near edge of beam, then draw
cube ([floorwidth, totalwidth, baseheight]);
translate ([firstdividecenter-floorwidth/2, 0, 0]) cube ([floorwidth, totalwidth, baseheight]);
translate ([tileside+wallwidth+tileside+wallwidth/2-floorwidth/2, 0, 0]) cube ([floorwidth, totalwidth, baseheight]);

difference () {
    //wall fill for dovetail
    translate ([totalwidth-floorwidth, 0, 0]) cube ([floorwidth, totalwidth, baseheight]);

    //negative dovetail far y axis
    translate([totalwidth+wallwidth, tileside+wallwidth+tileside/2, 0])  
        polyhedron  (
        points = [[0, -negdovewidth/2 ,0], [0, -negdovewidth/2, wallheight], [0,negdovewidth/2,wallheight], [0,negdovewidth/2,0], 
            [-wallwidth*2, negdovewidth/2+2, 0], [-wallwidth*2, negdovewidth/2+2, wallheight], 
            [-wallwidth*2, -negdovewidth/2-2, wallheight], [-wallwidth*2, -negdovewidth/2-2, 0]],
        faces = [[0,1,2], [2,3,0], [4,5,6], [6,7,4],
             [0,7,6], [6,1,0], [3,2,5], [5,4,3],
            [1,6,5], [5,2,1], [0,3,4], [4,7,0],  ]);
} // difference

// x-direction floorbeams - translate to near edge of beam, then draw

difference () {
cube([totalwidth,floorwidth,baseheight]);

// negative dovetail near x axis
translate ([tileside+wallwidth+tileside/2, -wallwidth,0])  
	polyhedron  (
	points = [[-negdovewidth/2, 0, 0], [-negdovewidth/2, 0, wallheight], 
		[negdovewidth/2,0, wallheight], [negdovewidth/2, 0, 0], 
		[negdovewidth/2+2, wallwidth*2,0], [negdovewidth/2+2, wallwidth*2, wallheight], 
		[-negdovewidth/2-2, wallwidth*2, wallheight], [-dovewidth/2-2, wallwidth*2, 0]],
	faces = [[0, 1, 2], [2, 3, 0], [4, 5, 6], [6, 7, 4],
		 [0, 7, 6], [6, 1, 0], [3, 2, 5], [5, 4, 3],
		[1, 6, 5], [5, 2, 1], [0, 3, 4], [4, 7, 0],  ]);
} // difference

translate ([0, firstdividecenter-floorwidth/2, 0]) cube ([totalwidth, floorwidth, baseheight]);
translate ([0, tileside+wallwidth+tileside+wallwidth/2-floorwidth/2, 0]) cube ([totalwidth, floorwidth, baseheight]);
translate ([0, totalwidth-floorwidth,0]) cube ([totalwidth, floorwidth, baseheight]);

// four center crosses - translate to center of cross, then translate back and draw
// centercross (firstdividecenter, firstdividecenter, 0);
centerT (firstdividecenter, seconddividecenter, 0);
// centerT (seconddividecenter, firstdividecenter, 0, 270);
centerT (seconddividecenter, seconddividecenter, 0);

//walls on x-axis
 translate ([0, -wallwidth, 0]) cube ([crosslength/2, wallwidth, wallheight]);
 translate ([tileside+wallwidth/2-crosslength/2, -wallwidth,0]) cube ([crosslength, wallwidth, wallheight]);
translate ([tileside*2+wallwidth+wallwidth/2-wallwidth/2, -wallwidth, 0]) cube ([crosslength/2+wallwidth/2, wallwidth, wallheight]);

difference () {
    translate ([totalwidth-crosslength/2, -wallwidth, 0]) cube ([crosslength/2, wallwidth, wallheight]);
    translate ([totalwidth+2*wallwidth, -2.3*wallwidth-floorwidth/2, 0]) rotate (45) cube (floorwidth, floorwidth, wallheight);
} // difference

// walls on y-axis, far side

difference () {
translate ([totalwidth, -wallwidth,0]) cube ([wallwidth, crosslength/2+wallwidth, wallheight]);
translate ([totalwidth+2*wallwidth, -2.3*wallwidth-floorwidth/2, 0]) rotate (45) cube (floorwidth, floorwidth, wallheight);
} // difference

translate ([totalwidth, tileside+wallwidth/2-crosslength/2,0]) cube([wallwidth,crosslength,wallheight]);
translate ([totalwidth, tileside*2+wallwidth+wallwidth/2-crosslength/2,0]) cube ([wallwidth, crosslength, wallheight]);
translate ([totalwidth, totalwidth-crosslength/2, 0]) cube ([wallwidth, crosslength/2, wallheight]);

// walls on x-axis, far side
translate ([centerfirsttile - crosslength/4, totalwidth, 0]) cube ([crosslength/2, wallwidth, wallheight]);
 translate ([centersecondtile - crosslength/4, totalwidth, 0]) cube ([crosslength/2, wallwidth, wallheight]);
translate ([centerthirdtile - crosslength/4, totalwidth, 0]) cube ([crosslength/2, wallwidth, wallheight]);

// walls on y-axis, near side
 translate ([-wallwidth, centerfirsttile - crosslength/4, 0]) cube ([wallwidth, crosslength/2, wallheight]);
 translate ([-wallwidth, centersecondtile - crosslength/4, 0]) cube ([wallwidth, crosslength/2, wallheight]);
translate ([-wallwidth, centerthirdtile - crosslength/4, 0]) cube ([wallwidth, crosslength/2, wallheight]);

// "t's" off of walls, x-axis near
// translate ([firstdividecenter - wallwidth/2, 0, 0]) cube ([wallwidth, crosslength/2, wallheight]);
// translate ([seconddividecenter - wallwidth/2, 0, 0]) cube ([wallwidth, crosslength/2, wallheight]);
// "t's" off of walls, x-axis far
translate ([firstdividecenter - wallwidth/2,  totalwidth - crosslength/2, 0]) cube ([wallwidth, crosslength/2, wallheight]);
translate ([seconddividecenter - wallwidth/2,  totalwidth - crosslength/2, 0]) cube ([wallwidth, crosslength/2, wallheight]);
// "t's" off of walls, y-axis near
// translate ([0, firstdividecenter - wallwidth/2, 0]) cube ([crosslength/2,  wallwidth,  wallheight]);
translate ([0, seconddividecenter - wallwidth/2, 0]) cube ([crosslength/2,  wallwidth,  wallheight]);
// "t's" off of walls, y-axis far
// translate ([totalwidth - crosslength/2,  firstdividecenter - wallwidth/2, 0]) cube ([crosslength/2, wallwidth, wallheight]);
translate ([totalwidth - crosslength/2,  seconddividecenter - wallwidth/2, 0]) cube ([crosslength/2, wallwidth, wallheight]);

// solid divider sections for dovetail
// translate ([totalwidth/2 - tileside/2,  -wallwidth, 0]) cube ([tileside, wallwidth, wallheight]);
// translate ([totalwidth, totalwidth/2 - tileside/2, 0]) cube ([wallwidth, tileside, wallheight]);
//dovetail near y axis
difference () {
translate ([0, tileside + wallwidth + tileside/2, 0])  {
	polyhedron  (
	points = [[0, -dovewidth/2, 0], [0, -dovewidth/2, wallheight], [0, dovewidth/2, wallheight], 
		[0, dovewidth/2,  0],  [-wallwidth, dovewidth/2 + 1, 0], [-wallwidth, dovewidth/2 + 1, wallheight], 
		[-wallwidth, -dovewidth/2-1, wallheight],  [-wallwidth, -dovewidth/2-1,  0]], 
	faces = [[0, 1, 2], [2, 3, 0], [4, 5, 6], [6, 7, 4], 
		 [0, 7, 6], [6, 1,  0], [3, 2, 5], [5, 4, 3], 
		[1, 6, 5], [5, 2, 1], [0, 3, 4], [4, 7, 0],  ]);
	polyhedron  (
	points = [[0,  -dovewidth/2,  0],  [0,  -dovewidth/2,  baseheight],  [0,  dovewidth/2,  baseheight],  
		[0,  dovewidth/2,  0],  [-wallwidth*2,  dovewidth/2 + 2,  0],  
		[-wallwidth*2,  dovewidth/2 + 2,  baseheight],  [-wallwidth*2,  -dovewidth/2 - 2,  baseheight],  
		[-wallwidth*2,  -dovewidth/2 - 2,  0]], 
	faces = [[0, 1, 2], [2, 3, 0], [4, 5, 6], [6, 7, 4], 
		 [0, 7, 6], [6, 1, 0], [3, 2, 5],  [5, 4, 3], 
		[1, 6, 5], [5, 2, 1], [0, 3, 4], [4, 7, 0], ]);
}  //translate
translate ([-.5, totalwidth/2, 1]) cylinder (h = 5, r=1, $fn = 30);
}

//dovetail far x axis
difference () {
translate ([tileside + wallwidth + tileside/2, totalwidth, 0]) { 
	polyhedron  (
	points = [[-dovewidth/2, 0, 0],  [-dovewidth/2, 0, wallheight],  [dovewidth/2, 0, wallheight],  
		[dovewidth/2, 0, 0],  [dovewidth/2 + 1, wallwidth, 0],  [dovewidth/2 + 1, wallwidth, wallheight],  
		[-dovewidth/2 - 1, wallwidth, wallheight],  	[-dovewidth/2 - 1, wallwidth, 0]], 
	faces = [[0, 1, 2],  [2, 3, 0],  [4, 5, 6],  [6, 7, 4], 
		 [0, 7, 6],  [6, 1, 0],  [3, 2, 5],  [5, 4, 3], 
		[1, 6, 5],  [5, 2, 1],  [0, 3, 4],  [4, 7, 0],   ]);
	polyhedron  (
	points = [[-dovewidth/2, 0, 0],  [-dovewidth/2, 0, baseheight],  [dovewidth/2, 0, baseheight],  
		[dovewidth/2, 0, 0],  [dovewidth/2 + 2, wallwidth*2, 0],  [dovewidth/2 + 2, wallwidth*2, baseheight],  
		[-dovewidth/2 - 2, wallwidth*2, baseheight],  [-dovewidth/2 - 2, wallwidth*2, 0]], 
	faces = [[0, 1, 2],  [2, 3, 0],  [4, 5, 6],  [6, 7, 4], 
		 [0, 7, 6],  [6, 1, 0],  [3, 2, 5],  [5, 4, 3], 
		[1, 6, 5],  [5, 2, 1],  [0, 3, 4],  [4, 7, 0],   ]);
} // translate
translate ([totalwidth/2, totalwidth+.6, 1]) cylinder (h = 5, r=1, $fn = 30);
}

//added base width near dovetail cutouts
translate ([firstdividecenter, floorwidth, 0]) cube([tileside + wallwidth*2,  wallwidth, baseheight]);
translate ([totalwidth - floorwidth - wallwidth, firstdividecenter, 0]) cube([wallwidth, tileside + wallwidth*2, baseheight]);

difference() {
//wall fill for dovetail
translate ([totalwidth/2 - tileside/2 , -wallwidth, 0]) cube([tileside, wallwidth, wallheight]);

//negative dovetail near x axis
translate ([tileside + wallwidth + tileside/2, -wallwidth, 0])  
	polyhedron  (
	points = [[-negdovewidth/2, 0, 0],  [-negdovewidth/2, 0, wallheight],  
		[negdovewidth/2, 0, wallheight],  [negdovewidth/2, 0, 0],  
		[negdovewidth/2 + 2, wallwidth*2, 0],  [negdovewidth/2 + 2, wallwidth*2, wallheight],  
		[-negdovewidth/2 - 2, wallwidth*2, wallheight],  [-dovewidth/2-2, wallwidth*2, 0]], 
	faces = [[0, 1, 2],  [2, 3, 0],  [4, 5, 6],  [6, 7, 4], 
		 [0, 7, 6],  [6, 1, 0],  [3, 2, 5],  [5, 4, 3], 
		[1, 6, 5],  [5, 2, 1],  [0, 3, 4],  [4, 7, 0],   ]);
	} // polyhedron

difference() {
//wall fill for dovetail
translate ([totalwidth, totalwidth/2-tileside/2, 0]) cube([wallwidth, tileside, wallheight]);

//negative dovetail far y axis
translate ([totalwidth + wallwidth, tileside + wallwidth + tileside/2, 0])  
	polyhedron  (
	points = [[0, -negdovewidth/2, 0],  [0, -negdovewidth/2, wallheight],  [0, negdovewidth/2, wallheight],  
		[0, negdovewidth/2, 0],  [-wallwidth*2, negdovewidth/2 + 2, 0],  
		[-wallwidth*2, negdovewidth/2 + 2, wallheight],  [-wallwidth*2, -negdovewidth/2-2, wallheight],  
		[-wallwidth*2, -negdovewidth/2 - 2, 0]], 
	faces = [[0, 1, 2],  [2, 3, 0],  [4, 5, 6],  [6, 7, 4], 
		 [0, 7, 6],  [6, 1, 0],  [3, 2, 5],  [5, 4, 3], 
		[1, 6, 5],  [5, 2, 1],  [0, 3, 4],  [4, 7, 0],   ]);
} // difference

corner (0, 0, 0);
corner (firstdividecenter + floorwidth/2 - floorwidth, wallwidth, 0);
corner (seconddividecenter + floorwidth/2 - floorwidth, 0, 0);
corner (0, firstdividecenter + floorwidth/2 - floorwidth, 0);
corner (firstdividecenter + floorwidth/2 - floorwidth, firstdividecenter + floorwidth/2 - floorwidth, 0);
corner (seconddividecenter + floorwidth/2 - floorwidth, firstdividecenter + floorwidth/2 - floorwidth, 0);
corner (0, seconddividecenter + floorwidth/2 - floorwidth, 0);
corner (firstdividecenter + floorwidth/2 - floorwidth, seconddividecenter + floorwidth/2 - floorwidth, 0);
corner (seconddividecenter + floorwidth/2 - floorwidth, seconddividecenter + floorwidth/2 - floorwidth, 0);

translate ([firstdividecenter + floorwidth/2, 0, 0])  { rotate (a = 90, v = [0, 0, 1]) { corner (0, 0, 0); }}
translate ([seconddividecenter + floorwidth/2, wallwidth, 0])  { rotate (a = 90, v = [0, 0, 1]) { corner (0, 0, 0); }}
translate ([totalwidth, 0, 0])  { rotate (a = 90, v = [0, 0, 1]) { corner (0, 0, 0); }}
translate ([firstdividecenter + floorwidth/2, firstdividecenter - floorwidth/2, 0])  { rotate (a = 90, v = [0, 0, 1]) { corner (0, 0, 0); }}
translate ([seconddividecenter + floorwidth/2, firstdividecenter - floorwidth/2, 0])  { rotate (a = 90, v = [0, 0, 1]) { corner (0, 0, 0); }}
translate ([totalwidth-wallwidth, firstdividecenter - floorwidth/2, 0])  { rotate (a = 90, v = [0, 0, 1]) { corner (0, 0, 0); }}
translate ([firstdividecenter + floorwidth/2, seconddividecenter - floorwidth/2, 0])  { rotate (a = 90, v = [0, 0, 1]) { corner (0, 0, 0); }}
translate ([seconddividecenter + floorwidth/2, seconddividecenter - floorwidth/2, 0])  { rotate (a = 90, v = [0, 0, 1]) { corner (0, 0, 0); }}
translate ([totalwidth, seconddividecenter - floorwidth/2, 0])  { rotate (a = 90, v = [0, 0, 1]) { corner (0, 0, 0); }}

translate ([firstdividecenter + floorwidth/2, firstdividecenter + floorwidth/2, 0])  { rotate (a = 180, v = [0, 0, 1]) { corner (0, 0, 0); }}
translate ([seconddividecenter + floorwidth/2, firstdividecenter + floorwidth/2, 0])  { rotate (a = 180, v = [0, 0, 1]) { corner (0, 0, 0); }}
translate ([totalwidth, firstdividecenter + floorwidth/2, 0])  { rotate (a = 180, v = [0, 0, 1]) { corner (0, 0, 0); }}
translate ([firstdividecenter + floorwidth/2, seconddividecenter + floorwidth/2, 0])  { rotate (a = 180, v = [0, 0, 1]) { corner (0, 0, 0); }}
translate ([seconddividecenter + floorwidth/2, seconddividecenter + floorwidth/2, 0])  { rotate (a = 180, v = [0, 0, 1]) { corner (0, 0, 0); }}
translate ([totalwidth-wallwidth, seconddividecenter + floorwidth/2, 0])  { rotate (a = 180, v = [0, 0, 1]) { corner (0, 0, 0); }}
translate ([firstdividecenter + floorwidth/2, totalwidth, 0])  { rotate (a = 180, v = [0, 0, 1]) { corner (0, 0, 0); }}
translate ([seconddividecenter + floorwidth/2, totalwidth, 0])  { rotate (a = 180, v = [0, 0, 1]) { corner (0, 0, 0); }}
translate ([totalwidth, totalwidth, 0])  { rotate (a = 180, v = [0, 0, 1]) { corner (0, 0, 0); }}

translate ([0, firstdividecenter + floorwidth/2, 0])  { rotate (a = 270, v = [0, 0, 1]) { corner (0, 0, 0); }}
translate ([firstdividecenter - floorwidth/2, firstdividecenter + floorwidth/2, 0])  { rotate (a = 270, v = [0, 0, 1]) { corner (0, 0, 0); }}
translate ([seconddividecenter - floorwidth/2, firstdividecenter + floorwidth/2, 0])  { rotate (a = 270, v = [0, 0, 1]) { corner (0, 0, 0); }}

translate ([0, seconddividecenter + floorwidth/2, 0])  { rotate (a = 270, v = [0, 0, 1]) { corner (0, 0, 0); }}
translate ([firstdividecenter - floorwidth/2, seconddividecenter + floorwidth/2, 0])  { rotate (a = 270, v = [0, 0, 1]) { corner (0, 0, 0); }}
translate ([seconddividecenter - floorwidth/2, seconddividecenter + floorwidth/2, 0])  { rotate (a = 270, v = [0, 0, 1]) { corner (0, 0, 0); }}

translate ([0, totalwidth, 0])  { rotate (a = 270, v = [0, 0, 1]) { corner (0, 0, 0); }}
translate ([firstdividecenter - floorwidth/2, totalwidth, 0])  { rotate (a = 270, v = [0, 0, 1]) { corner (0, 0, 0); }}
translate ([seconddividecenter - floorwidth/2, totalwidth, 0])  { rotate (a = 270, v = [0, 0, 1]) { corner (0, 0, 0); }}



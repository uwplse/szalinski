// Inner box width
boxWidth = 50; //[5:200]

// Inner box depth
boxDepth = 25; //[5:200]

// Inner box total height
boxHeight = 80; //[15:200]

// Inner lid height
lidHeight = 20; //[10:190]

// Text to include
text_to_include = "Text";

// Text size
textSize = 5; //[0:100]

// Text direction
textDirection = 0; // [0:Vertical, 1:Horizontal]

// Parts to show
showParts = 0; // [0:All, 1:Base, 2:Lid]



/* [Hidden] */

$fn=60;
// Wall thickness
wt=2.4;

//Corner radius
cr=3;

//Insert lenght
il=10;

//Insert width
iw=1;

textX = textDirection == 0 ? boxWidth/2-textSize-2 : -boxWidth/2+2;
textY = textDirection == 0 ? -boxDepth/2 : -boxDepth/2;
textZ = textDirection == 0 ? (boxHeight-lidHeight-2) : (boxHeight-lidHeight-textSize-5) ;
textA = textDirection == 0 ? 90 : 90;
textB = textDirection == 0 ? 90 : 0;
textC = textDirection == 0 ? 0 : 0;

if (showParts != 2) {
    translate ([-boxWidth/2-wt-2, 0, 0])
        union (){
            box_base(boxWidth, boxDepth, boxHeight-lidHeight);
            translate([textX, textY-wt, textZ]) rotate(a=[textA, textB, textC]) linear_extrude(height=1) text(text_to_include, size=textSize);
        }
}

if (showParts != 1) {
    translate ([boxWidth/2+wt+2, 0, 0]) box_lid(boxWidth, boxDepth, lidHeight);
}

module rounded_cube(xsize, ysize, zsize, sradius, bradius, tradius)
{
    xpos = xsize/2-sradius;
    ypos = ysize/2-sradius;
    
    hull() {
        translate([-xpos, -ypos, bradius]) cylinder(r=sradius, h=zsize-bradius-tradius);
        translate([xpos, ypos, bradius]) cylinder(r=sradius, h=zsize-bradius-tradius);
        translate([-xpos, ypos, bradius]) cylinder(r=sradius, h=zsize-bradius-tradius);
        translate([xpos, -ypos, bradius]) cylinder(r=sradius, h=zsize-bradius-tradius);
        
        translate([-xpos, -ypos, bradius]) sphere(r=bradius);
        translate([xpos, ypos, bradius]) sphere(r=bradius);
        translate([-xpos, ypos, bradius]) sphere(r=bradius);
        translate([xpos, -ypos, bradius]) sphere(r=bradius);
        
        translate([-xpos, -ypos, zsize-tradius]) sphere(r=tradius);
        translate([xpos, ypos, zsize-tradius]) sphere(r=tradius);
        translate([-xpos, ypos, zsize-tradius]) sphere(r=tradius);
        translate([xpos, -ypos, zsize-tradius]) sphere(r=tradius);
    }
}

module box_base(width, depth, height)
{
    difference(){
        union() {
            rounded_cube(width+2*wt, depth+2*wt, height+wt, cr, cr, 0);
            translate([0, 0, height+wt]) rounded_cube(width+iw, depth+iw, il, cr, 0, 0);
        }
        translate([0, 0, wt]) rounded_cube(width, depth, height+il+wt, cr, cr, 0);
    }    
}

module box_lid(width, depth, lid_height)
{
    difference() {
        rounded_cube(width+2*wt, depth+2*wt, lid_height+wt, cr, cr, 0);
        union(){
            translate([0, 0, wt]) rounded_cube(width, depth, lid_height, cr, cr, 0);
            translate([0, 0, lid_height-il]) rounded_cube(width+2*iw, depth+2*iw, lid_height, cr, 0, 0);
        }
    }
    
}





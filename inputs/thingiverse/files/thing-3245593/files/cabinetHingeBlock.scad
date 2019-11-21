// Brian Palmer and Clara Paternostro 2019
// Cabinet Hinge Block
/* [Hinge Block] */
// V 0.91 fixed bug with height of brace.
// V 0.92 added a bunch of parameter checking

hingeBlockY=23.62; // width
hingeBlockX=52; // length
hingeBlockZ=30; // height

/* [Hinge mount holes] */
hingeMountHoleDiam=5; // diam of holes in hinge block
hingMountHoleDepth=12.5; // depth of holes in hinge block

/* [Support Legs] */
legWidth=20.74; // support leg width
legHeight=4.64; // support leg height
legLength=25.25; // support leg length
legHoleDiam=5.87; //diam of holes in legs

/* [Corner Support Brace] */
legBraceWidth=13; // corner leg brace width. limited to length of support leg.
legBraceHeight=hingeBlockZ; // corner leg brace height. limited to height of hinge block..
legBraceThickness=1.75; // corner leg brace thickness. limited to width of support leg.

/* [Alignment pegs] */
alignmentPegDiam=4.6; // bottom alignment pin diameter
alignmentPegDepth=7.4; //  bottom alignment pin depth. Entering 0 turns off peg generation.

/* [Hidden] */
// some parameter validation/limiting
// ensure legs dont overlap each other.
lw = legWidth > (hingeBlockX /2) ? hingeBlockX /2 : legWidth;
// ensure legHoleDiam isnt wider then leg
lhd = legHoleDiam > lw-10 ? lw-10 : legHoleDiam;
// ensure corner support leg isnt covering the hole.
lbw = legLength-lhd > legBraceWidth ? legBraceWidth : (legLength-lhd);
// ensure corner bracket isnt hight than hinge block
lbh = legBraceHeight > (hingeBlockZ-legHeight) ? hingeBlockZ-legHeight : legBraceHeight;
// ensure corner bracket isnt wider than the leg its on.
lbt = legBraceThickness > lw ? lw : legBraceThickness;
// ensure hinge mount holes fit on the hinge block.
hmhd = hingeMountHoleDiam > hingeBlockY-10 ? hingeBlockY-10 : hingeMountHoleDiam;

echo("hole spacing is ", (hingeBlockX-lw));
//  Create it!
rotate(180,0,0)
difference() {
    union() {
       cube([hingeBlockX,hingeBlockY,hingeBlockZ]); // main cube
       createpegleg(alignmentPegDepth,alignmentPegDiam, -alignmentPegDepth); // 1st alignment peg
       translate([(hingeBlockX)-(lw),0,0]) createpegleg(alignmentPegDepth, alignmentPegDiam, -alignmentPegDepth); // 2nd alignment peg

       createleg(); // first cabinet leg mount
       translate([(hingeBlockX)-(lw),0,0]) createleg(); // 2nd cabinet leg mount
    }
    // 1st top hole
    translate([lw/2,hingeBlockY/2,hingeBlockZ-hingMountHoleDepth]) 
    cylinder(h=hingMountHoleDepth, r=hmhd/2, center=false,$fn=100);
    // 2nd top hole
    translate([hingeBlockX-lw/2,hingeBlockY/2,hingeBlockZ-hingMountHoleDepth]) 
    cylinder(h=hingMountHoleDepth, r=hmhd/2, center=false,$fn=100);
    
}

module createleg() {

   difference(){
       union(){
           hull() {
                translate([0,hingeBlockY,0]) cube([lw,1,legHeight]);
                translate([lw/2,hingeBlockY+legLength,0]) cylinder(h=legHeight, r=lw/2, center=false,$fn=100);
           }
       }
       translate([lw/2,hingeBlockY+legLength,0]) cylinder(h=legHeight, r=lhd/2, center=false,$fn=100);
    }
    // add the corner brace
    translate([lw/2,hingeBlockY,legHeight]) createBrace(lbh, lbw, lbt); 
    
}

module createBrace(height, width, thickness) {
    triangle = [[0, 0],[height, 0],[0, width]];
    rotate([0,-90,0]) 
    linear_extrude(height = thickness, center = true, convexity = 10, twist = 0, slices = 20, scale = 1.0, $fn = 16) 
    { 
        polygon(triangle);
    }
}

module createpegleg(length, diam, depth){
    //create small cylinder centered under leg
    translate([lw/2,hingeBlockY/2,depth]) 
    cylinder(h=length, r=diam/2, center=false,$fn=100);
}
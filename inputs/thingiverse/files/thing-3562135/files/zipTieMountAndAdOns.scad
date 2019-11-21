// Amy and Brian Palmer 2019. Some Customizer usage ideas from nick finger (http://www.thingiverse.com/thing:1340624)
/* [Zip Tie Down holder ] */
// V2.0 4/11/19 added mounting hole hole
// V2.1 4/12/19 added options for closed/open top, screw sizes, and improved hole bevel placement.
// V2.2 4/12/19 - modified the customizer settingd mostly
// V2.3 Removed scaling feature. That was stupid. Added first circle fixture.

//Choose which part to create. 
part = 1; //[ 1:Base, 2: Circle Fixture, 3: Square Fixture, 4: Pipe Fixture]  
//Enable to preview all parts together!  KEEP THIS OFF in order to create individual printable parts.
previewMode = 0; //[0:Print Mode, 1:Preview Mode (dont print!)]
// preview[view:south, tilt:top diagonal]
//Select Exploded Mode to view your selected part and the base seperated. Or connected to see how they looked when snapped together.  Only relevant when in Preview Mode.
explodedView = 0; //[0:Exploded View,1:Connected View] 
/* [mounting Hole Options] */

mountingHole=1;     // [0:no, 1:helz ya!]
screwSize=1;        // [0:small,1:medium,2:large]
screwType=1;        // [1:beveled,0:flat]
screwBevelAngle=90; // [50:degrees,90:90 degrees,80:80 degrees,100:100 degrees]


/* [Even More Options] */
// Always open when Mounting Hole option is Yes.
openORClosedTop=0;  // [1:open, 0:closed] 
// Width of zip tie plus a little clearance.
zipTieWidth=5;     // [1:40]
// Width of the base mounting pad.
baseWidth=25;       // [5:100]

// Overall Height of mount
overallHeight=8.6;       // [3:90]
// Height of the zip tie plus a little clearance.
zipTieHeight=3;    // [0:80]
// Thickness of base mounting pad.
baseHeight=2;       // [1:88]


/* [Hidden] */
$fn=100;

bw=baseWidth;
bHeight=baseHeight;
ztWidth=zipTieWidth;
oHeight=overallHeight;
ztHeight=zipTieHeight;
//ztHeightAdj= ztHeight < oHeight-bHeight ?  c:oHeight-bHeight-1;
ztHeightAdj = ztHeight;

// apply contraints
oHeightAdj = oHeight < ztHeightAdj + bHeight ? ztHeightAdj + bHeight + 4: oHeight;
bHeightAdj = bHeight < ztHeight + 4 ? bHeight : ztHeight + 4;

hubHeight=oHeightAdj-(ztHeightAdj+bHeight);
lHeight=oHeightAdj-bHeight;

totalHeight = bHeight+lHeight;
hHeight = hubHeight > totalHeight ? totalHeight : hubHeight;
// hole settings
scrwHeadDiam  = screwSize==0 ? 4 : screwSize==1 ? 8 : 10;
scrwShaftDiam = screwSize==0 ? 2 : screwSize==1 ? 4 : 5;
screwHeadDiam = scrwHeadDiam;
screwShaftDiam = scrwShaftDiam;
holeBevelAngle = screwBevelAngle/2;

// go Amy go
octDiam = (1 + sqrt(2))*ztWidth;
bWidth = bw < octDiam ? octDiam : bw; 
legLen = (sqrt(2)*bWidth-octDiam)/2;
hypotenuse = sqrt(pow((ztWidth/2),2)+pow(legLen,2));
rotateAngle = asin((ztWidth/2)/hypotenuse);
holeDiam = screwHeadDiam > octDiam ? octDiam : screwHeadDiam;
holeBevelConeHeight = tan(holeBevelAngle)*(holeDiam/2);

main();

module main(){
    
    if(previewMode == 1){
		generate_preview();
	} else { //PRINT MODE!
		
		// Base section
		if (part == 1){
            make_base();
        } else {
        rotate([180,0,0]){ 
            make_Fixture();
        }
        }
    }

}

module make_Fixture() {
    // Circle Fixture
    if (part == 2){
        make_circleFixture(octDiam, hHeight, bWidth);
    }
    
    // Square Fixture
    if (part == 3){
        make_SquareFixture(octDiam, hHeight, bWidth);
    }
    
    // Pipe Fixture
    if (part == 4){
        make_PipeFixture(octDiam, hHeight, bWidth);
    }
}

module generate_preview() {
    make_base();
    zAdj = explodedView == 0 ? totalHeight + 10 : totalHeight;
    translate([0,0,zAdj]) {
        rotate([180,0,0]){ 
            make_Fixture();          
        }
    }
}


module make_base(){
    // base
    rotate(45)
    {
        difference() 
        {
            // base
            cube([bWidth,bWidth,bHeight], true);
            
            // mounting hole
            union() {
                if (mountingHole == 1)
                {
                    // screw hole
                    cylinder(h=bHeight, d1=screwShaftDiam, d2=screwShaftDiam, center=true);
                    if (screwType==1) { // beveled
                        // move to bottom of base and up a tad
                        n=holeBevelConeHeight*.65;
                        centerOfHoleBevelHole=-((bHeight/2)+(holeBevelConeHeight/2)-(n));
                        translate([0,0,centerOfHoleBevelHole]) 
                        {
                            cylinder(h=holeBevelConeHeight, d1=0, d2=holeDiam, center=true);
                        }
             
                        translate([0,0,n]) 
                        {
                            // access hole
                            cylinder(h=bHeight, d1=holeDiam, d2=holeDiam, center=true);
                        }
                    }
                }
            }
        }
    }
    
    // hub
    translate([0,0,(bHeight/2) + lHeight - (hHeight/2)])
    {
        difference() 
        {
            octogon(octDiam, hHeight);
            if (mountingHole == 1 || openORClosedTop == 1)
            {
                octogon(octDiam-(octDiam*.20), hHeight);
            }
        }
    }
    
    // make 4 legs
    for (a =[1:4]) 
        { 
            rotate(90*a) { 
            leg(ztWidth);
        }
    }
}

module leg(width) {
    hull() 
    {
       legSide(width-.099,rotateAngle);
       legSide(-width+.099,-rotateAngle);
//       legSide(width,rotateAngle);
//       legSide(-width,-rotateAngle);
    }
}

module legSide(hw,ra) {
    translate([hw/2,octDiam/2,bHeight/2]) {
        rotate(ra) {
            createBrace(lHeight,hypotenuse,.1);
        }
    }
}

module createBrace(height, width, thickness) {
    triangle = [[0, 0],[height, 0],[0, width]]; 
    rotate([0,-90,0])
    {
        linear_extrude(height = thickness, center = true, convexity = 10, twist = 0, slices = 1, scale = 1, $fn = 20) 
        { 
            polygon(triangle);
        }
        
    }
}

module octogon(diameter, height) {
    
    difference() 
    {
         cube([diameter,diameter,height], true);
         difference() 
         {
            cube([diameter,diameter,height], true);
            rotate(45)
            {
                cube([diameter,diameter,height], true);
            }
        }
    }
}

module make_circleFixture(diam, height, baseDiam) {
    partClearance=.01;
    plateHeight=2;

    difference() {
        // plate
        cylinder(h=plateHeight, d1=baseDiam, d2=baseDiam, center=true);
        rotate(45){
        zipTieHoles();
        }
    }
    
    // stem
    translate([0,0, (height/2)+(plateHeight/2)]) {
        octogon(diam-(diam*(.20 + partClearance)), height);
    }
}

module make_SquareFixture(diam, height, baseDiam) {
    heightAdj = height < 4 ? height : 4;
    partClearance=.01;
    plateHeight=2;
    holeOffset=octDiam/2+ztHeight/2;
    plateDiam=(octDiam+ztHeight)*1.8;
 
    rotate(45) {
        difference() {
            // base plate
            cube([plateDiam,plateDiam,plateHeight], true);
            union() {
                zipTieHoles();
                rotate(90) {
                    zipTieHoles();
                }
            }
        }
    }
    
    // stem;       
    translate([0,0, (heightAdj/2)+(plateHeight/2)]) {
        octogon(diam-(diam*(.20 + partClearance)), heightAdj);
    }
}  



module make_PipeFixture(diam, height, baseDiam) {
    heightAdj = height < 4 ? height : 4;
    partClearance=.01;
    plateHeight=2;
    holeOffset=octDiam/2+ztHeight/2;
    plateDiam=(octDiam+ztHeight)*1.8;
 
    rotate(45) {
        difference() {
            // base plate
            cube([plateDiam,plateDiam,plateHeight], true);
            union() {
                zipTieHoles();
            }
        }
        translate([0,0,-(plateHeight/2)-2.5]) {
            difference() {
                cube([15,plateDiam,5], true);
                translate([0,0,-8]) {
                    rotate([90,90]){
                        cylinder(h=100, d1=18, d2=18, center=true);
                    }
                }
            }
        }
    }
    
    // stem;       
    translate([0,0, (heightAdj/2)+(plateHeight/2)]) {
        octogon(diam-(diam*(.20 + partClearance)), heightAdj);
    }
}  

module zipTieHoles() {
    // zip tie holes
    union(){
        holeOffsetOffset=2; // to allow room fo ziptie to bend around corner
        holeOffset=(octDiam/2+ztHeight/2)+holeOffsetOffset;
        translate([holeOffset,0,0]) {
          cube([ztHeight,ztWidth,10], true);
        }
        translate([-holeOffset,0,0]) {
          cube([ztHeight,ztWidth,2], true);
        } 
    }   
}               
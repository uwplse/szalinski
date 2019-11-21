// mathgrrl piecemaker
// uses embedded list-comprehension-demos and scad-utils

// print with .3mm if no coins are used
// print with .2mm for best coin fit

//////////////////////////////////////////////////////////////////////////////////////
// GLOBAL PARAMETERS 

layerHeight = 1*1;
fudge = 0*1;

//////////////////////////////////////////////////////////////////////////////////////
/* [Base] */

// (Width of the bottom segement, which determines width of the entire piece. Changes in this tab may make things look weird until you go through all the tabs...)
diameterOfBase = 26; // 26 to approximate penny default

// (Height of the bottom segment of the piece)
heightOfBase = 8; // 8 to approximate penny default

// (Degrees that the bottom segment will slant in or out)
baseFlare = -15;

// (Best between 0 and 2)
rimStrength = 1;
    
echo("BASE",diameterOfBase,heightOfBase,rimStrength,baseFlare);

//////////////////////////////////////////////////////////////////////////////////////
/* [Stem] */

// (This is the tall segment of the piece)
stemHeight = 50;

stemType = 0; //[0:Taper,1:Twist]

// (Applies only if "Taper" stem type chosen) 
taperPinch = 3.5;

// (Applies only if "Taper" stem type chosen) 
taperShape = 1.5;  

// (Applies only if "Twist" stem type chosen)
twistType = 2; //[1:Closed and Straight,2:Closed and Pinched,3:Open and Straight,4:Open and Pinched]

//CUT //NOT USING NOW
//CUT taperCut = "yes"; // if yes then preview will look funny in customizer 

echo("STEM",stemHeight,stemType,taperPinch,taperShape,twistType);

//////////////////////////////////////////////////////////////////////////////////////
/* [Shoulder] */

// (Height of top rim section)
shoulderHeight = 6;

// (Positive or negative degrees of flare)
shoulderFlare = 20;

// (Choose whether or not to add a third top rim)
extraRim = 1; //[0:No,1:Yes]

echo("SHOULDER",shoulderHeight,shoulderFlare,extraRim);

//////////////////////////////////////////////////////////////////////////////////////
/* [Top] */

// POSSIBLE NEXT STEPS FOR TOPS:  
// ADD CROWN AND TEARDROP, CREATE ROOK/FORTRESS, CAT HEAD, DRAGON HEAD?

topType = 0; //[0:Sphere,1:Polygon,2:Cross,3:Star,4:Wave Star,5:Double Wave Star,6:Spade,7:Heart,8:Club,9:Diamond]

// (Height of the top part of the piece)
topHeight = 12;

// (Twist the top design)
topRotation = 0;

// (Experiment and see!)
designNumber = 8;

// (Experiment and see!)
designStrength = 1; // this is sometimes also interesting when negative

// (Positive or negative degrees of flare)
topFlare = 15;

// (Angled top)
topSlant = 0; 

echo("TOP",topHeight,topType,topRotation,designNumber,designStrength,topFlare,topSlant);

//////////////////////////////////////////////////////////////////////////////////////
/* [Advanced] */

// (Go low-poly by decreasing this number, or make it smoother with a higher number)
resolution = 32;
res = resolution*1;

// (Keep Number of Coins at 0 unless you wish to embed coins inside your print. Coin hole is not visible in preview. If Coins are used, then on the first tab be sure that Seat Flare is between -30 and 0.)
numberOfCoins = 0; // [0:No Coins,1:1 Coin,2:2 Coins,3:3 Coins,4:4 Coins,5:5 Coins]

// (Overrides base diameter if Coins are used)
coinDiameter = 19.05; 

// (Overrides base height if Coins are used)
coinHeight = 1.52; 

echo("ADVANCE",numberOfCoins,coinDiameter,coinHeight, res);

//////////////////////////////////////////////////////////////////////////////////////
/* [Decoration] */

// ..... add this later?

//////////////////////////////////////////////////////////////////////////////////////
// CALCULATED PARAMETERS

coinRadius = coinDiameter/2; 
thickness = 1.3*1;
base = 1.2*1;
extraHorizontal = .4*1; 
extraVertical = .5*1;
binRadius = coinRadius + extraHorizontal + thickness;
binHeight = base + numberOfCoins*coinHeight + extraVertical;
lipHeight = 1*1;

baseHeight = (numberOfCoins == 0) ?
    heightOfBase : binHeight+3;

baseBottomRadius = (numberOfCoins == 0) ? 
    diameterOfBase/2 : binRadius - (binHeight+3)*tan(baseFlare); 

baseTopRadius = (numberOfCoins == 0) ?
    baseBottomRadius + baseHeight*tan(baseFlare) : binRadius; 

stemStart = baseHeight*1; 
shoulderStart = baseHeight+stemHeight; 
topStart = baseHeight + stemHeight + shoulderHeight; 

twistPinch = (twistType==1 || twistType==3) ? 1 : 2; // 1 if straight, 2 if pinched
twistOpen = (twistType==1 || twistType==2) ? 1 : 2; // 1 if closed, 2 if open

stemRadius = (stemType==0) ? // computed from the above with ternary choice function
    stem(1) : baseTopRadius*(1/twistPinch)*(.5*(twistPinch-1)+1);

shoulderRadius = stemRadius + shoulderHeight*tan(shoulderFlare); 
topRadius = shoulderRadius + topHeight*tan(topFlare); 

//////////////////////////////////////////////////////////////////////////////////////
// RENDERS

//difference(){
//    union(){
        translate([0,0,topStart]) top();
        translate([0,0,shoulderStart])shoulder(); 
        translate([0,0,0]) stem();
        base(); // 14 second render with coinHole on first run
        coinHole(); 
//    }
//    cube(50);
//}

//////////////////////////////////////////////////////////////////////////////////////
// COIN HOLE

coinHoleSketch = [
	[[binRadius,0],
	 [binRadius,binHeight],
	 [binRadius,binHeight+lipHeight],
	 [.92*binRadius-thickness,binHeight+lipHeight],
	 [binRadius-thickness,binHeight],
	 [binRadius-thickness,0]
	],
	[[0,1,2,3,4,5]]
];

module coinHole(){
    
    cylinder(r=baseBottomRadius, h=base);
    
    if (numberOfCoins > 0){
        rotate_extrude($fn=96)
            polygon(points=coinHoleSketch[0], paths=coinHoleSketch[1]); 
    }
}

//////////////////////////////////////////////////////////////////////////////////////
// BASE

module base(){
    
    difference(){
        
        union(){
            
            // base
            cylinder(r1=baseBottomRadius,r2=baseTopRadius,h=baseHeight,$fn=res);
            
            // bottom rim
            rim(rimRadius=1.2*rimStrength,rimPosition=baseBottomRadius);
                
            // lower middle rim
            translate([0,0,2.2*rimStrength])
            rim(rimRadius=.8*rimStrength,rimPosition=baseBottomRadius+rimStrength*tan(2.2*rimStrength*baseFlare));
            
            // top rim
            translate([0,0,baseHeight])
            rim(rimRadius=.8*rimStrength,rimPosition=baseTopRadius);
        }
        
        // leave a hole for the coin module
        if (numberOfCoins > 0) cylinder(r=binRadius,h=binHeight+lipHeight);
        
    }          
}

//////////////////////////////////////////////////////////////////////////////////////
// STEM

// functions for taper and cut 
// modified from sweep-drop
// https://github.com/openscad/list-comprehension-demos/blob/master/sweep-drop.scad

function stem(t) = -taperPinch*sin(180*pow(t,taperShape)-30)+(baseTopRadius)-taperPinch/2; 
function stemPath(t) = [0, 0, t];
function stemRotate(t) = 180 * pow((1 - t), 1);
function stemShape() = circle(1,$fn=res);
function cutShape() = square(.3);

stemStep = 1/stemHeight;
stemPath_transforms = [for (t=[stemStep:stemStep:1+stemStep]) 
    translation(stemHeight*stemPath(t)) * rotation([0,0,stemRotate(t)]) 
    * scaling([stem(t), stem(t), 1])];
cut_transforms = [for (t=[0:stemStep:1+stemStep]) 
    translation(stemHeight*stemPath(t)) * rotation([0,0,2.5*stemRotate(t)]) 
    * translation([stem(t),0,0]) * scaling([stem(t), stem(t), 1])];

module stem(){
    
    translate([0,0,stemStart])
    union(){
    
        // TAPER
        if (stemType == 0){
            
            //CUT difference(){
                
                //CUT union(){
                    
                    // this first rim is needed to subsitute for t=0 and avoid a negpow problem
                    //DON'T NEED THIS ANYMORE
                    //translate([0,0,2.5]) cylinder(r=baseTopRadius,h=layerHeight,$fn=res);
                    
                    // the taper stem
                    rotate(-stemRotate(stemStep),[0,0,1])
                        sweep(stemShape(), stemPath_transforms);
                //CUT }
                
                //CUT //NOT USING THIS NOW because of bad preview render
                //CUT if (taperCut=="yes") sweep(cutShape(), cut_transforms);
           //CUT }
        }
        
        // TWIST
        if (stemType == 1){
            for (i=[0:3]) {rotate(i*90,[0,0,1]) rope();}
        
            // cone at top to transition the ropes
            translate([0,0,stemHeight-2])
                cylinder(r1=stemRadius/2,r2=stemRadius,h=2,$fn=res);
        
            // cone at bottom to transition the ropes
            translate([0,0,0])
                cylinder(r1=baseTopRadius-1,r2=baseTopRadius/2,h=2,$fn=res);
            
        }
    }
}

// module for individual ropes
module rope(){
    
    ropeRadius = baseTopRadius/(1+sqrt(2)); 
    pinchFactor = (twistPinch-1)*0.2+1; 
    
    // bottom half, tapers in by twistPinch
    linear_extrude( height=0.5*stemHeight, center=false, convexity=10, 
                    twist=stemHeight*pinchFactor*360/60, scale=1/twistPinch, $fn=stemHeight)
        translate([0, sqrt(2)*(ropeRadius+.3*(twistOpen-1)), 0])
        circle( r=ropeRadius-1.5*(twistOpen-1), $fn=res );  
    
    // middle quarter, constant diameter
    translate([0,0,0.5*stemHeight])
    linear_extrude( height=0.25*stemHeight, center=false, convexity=10, 
                    twist=stemHeight*pinchFactor*180/60, scale=1, $fn=stemHeight)
        rotate(-stemHeight*pinchFactor*360/60,[0,0,1])
        translate([0, sqrt(2)*(ropeRadius+.3*(twistOpen-1))*1/twistPinch, 0])
        circle( r=(ropeRadius-1.5*(twistOpen-1))*(1/twistPinch), $fn=res );
    
    // top quarter, whatever we pinched by, now unpinch by 50% as much
    translate([0,0,0.75*stemHeight])
    linear_extrude( height=0.25*stemHeight, center=false, convexity=10, 
                    twist=stemHeight*pinchFactor*180/60, scale=.5*(twistPinch-1)+1, $fn=stemHeight)
        rotate(-stemHeight*pinchFactor*540/60,[0,0,1])
        translate([0, sqrt(2)*(ropeRadius+.3*(twistOpen-1))*1/twistPinch, 0])
        circle( r=(ropeRadius-1.5*(twistOpen-1))*(1/twistPinch), $fn=res );
}

//////////////////////////////////////////////////////////////////////////////////////
// SHOULDER

module shoulder(){
    
    cylinder(r1=stemRadius,r2=shoulderRadius,h=shoulderHeight,$fn=res);
    
    // largest rim 
    // on bottom if flare is negative or 0, on top if flare is positive
    bigRimStart = (shoulderFlare <= 0) ? 
        0 : shoulderHeight;
    bigRimPosition = (shoulderFlare <= 0) ? 
        stemRadius : stemRadius+shoulderHeight*tan(shoulderFlare);
    // those two lines that just happened were ternary oprations
    // https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/The_OpenSCAD_Language#If_Statement
    translate([0,0,bigRimStart])    
    rim(rimRadius=rimStrength,rimPosition=bigRimPosition);
        
    // top rim 
    // on top if flare is negative or 0, on bottom if flare is positive
    littleRimStart = shoulderFlare <= 0 ? 
        bigRimStart+shoulderHeight : 0;
    littleRimPosition = shoulderFlare <= 0 ? 
        stemRadius+shoulderHeight*tan(shoulderFlare) : stemRadius;
    translate([0,0,littleRimStart])
    rim(rimRadius=.6*rimStrength,rimPosition=littleRimPosition);
        
    // middle rim is third to appear
    // over big rim if flare is negative or 0, under big rim if flare is positive
    medRimStart = shoulderFlare <= 0 ? 
        bigRimStart+1.8*rimStrength : bigRimStart-1.5*rimStrength;
    medRimPosition = shoulderFlare <= 0 ? 
        stemRadius+rimStrength*tan(shoulderFlare) : stemRadius+(shoulderHeight-rimStrength)*tan(shoulderFlare);
    if (extraRim == 1){
        translate([0,0,medRimStart])
        rim(rimRadius=.8*rimStrength,rimPosition=medRimPosition);
    }
            
}

module rim(rimRadius=1,rimPosition=10){
    rimHeight = 1.8*rimRadius;
    
    // inside of the rim (through the piece)
    cylinder(r=rimPosition,h=rimHeight);
    
    // visible part of the rim
    rotate_extrude($fn=res)    
    translate([rimPosition, 0, 0]) 
        polygon(points=[
            // bottom up the outside
            [0,0],[.63*rimRadius,.3*rimHeight],[rimRadius,.62*rimHeight],[rimRadius,.75*rimHeight],
            [.87*rimRadius,.875*rimHeight],[.63*rimRadius,.94*rimHeight],[.25*rimRadius,rimHeight],
            // top down the inside
            [-.25*rimRadius,rimHeight],[-.63*rimRadius,.94*rimHeight],[-.87*rimRadius,.875*rimHeight],
            [-rimRadius,.75*rimHeight],[-.63*rimRadius,0]
        ]);
}


//////////////////////////////////////////////////////////////////////////////////////
// TOP

module top(){ 
    
    // sphere
    // number is diabled, strength stretches the supporting cone, height det'd by topheight
    // this is actually not very sensible but there it is
    if (topType == 0){
    cylinder(r=shoulderRadius,h=rimStrength*1.2,$fn=res);
    skin(morph(
        profile1 = 
            circle($fn=res,r=shoulderRadius),
        profile2 = 
            transform(translation([0,0,.25*designStrength*topHeight]),
            circle($fn=res,r=topRadius*.3)),
        slices = floor(topHeight/layerHeight)
    ));
    translate([0,0,.25*designStrength*topHeight+topHeight/2-topHeight/15]) 
            sphere(r=topHeight/2,$fn=res);
    }
    
    // polygon
    // number is bottom resoultion/sides, strength is diabled for now
    if (topType == 1)
    difference(){
        skin(morph(
            profile1 = 
                circle(r=shoulderRadius,$fn=designNumber),
            profile2 = 
                transform(translation([0,0,topHeight])*rotation([topSlant,0,topRotation]),
                circle(r=topRadius,$fn=designNumber)),
            slices = floor(topHeight/layerHeight)
        ));
        if (designStrength > 0){
        translate([0,0,1+topHeight/10])
        skin(morph(
            profile1 = 
                circle(r=designStrength,$fn=designNumber),
            profile2 = 
                transform(translation([0,0,topHeight])*rotation([topSlant,0,topRotation]),
                circle(r=designStrength + topHeight*tan(topFlare),$fn=designNumber)),
            slices = floor(topHeight/layerHeight)
        ));
        }
    }
    
    // cross
    // number is disabled, strength=thickness
    if (topType == 2)
    skin(morph(
        profile1 = 
            circle($fn=res,r=shoulderRadius),
        profile2 = 
            transform(translation([0,0,topHeight])*rotation([topSlant,0,topRotation]), 
            cross_profile(size=topRadius,thickness=designStrength)),
        slices = floor(topHeight/layerHeight)
    ));
  
    // star
    // number = points, strength = stellate (> 1 out, < 1 in)
    if (topType == 3)
    skin(morph(
        profile1 = 
            circle($fn=res,r=shoulderRadius),
        profile2 = 
            transform(translation([0,0,topHeight])*rotation([topSlant,0,topRotation]), 
            star_profile(size=topRadius,points=designNumber,stellate=designStrength)),
        slices = floor(topHeight/layerHeight)
    ));
    
    // wave star
    // number = frequency, strength = amplitude (pos out, neg in)
    if (topType == 4)
    skin(morph(
        profile1 = 
            circle($fn=res,r=shoulderRadius),
        profile2 = 
            transform(translation([0,0,topHeight])*rotation([topSlant,0,topRotation]), 
            wavestar_profile(size=topRadius,frequency=designNumber,amplitude=designStrength)),
        slices = floor(topHeight/layerHeight)
    ));
    
    // double wave star
    // number = frequency, strength = amplitude (pos out, neg in)
    if (topType == 5)
    skin(morph(
        profile1 = 
            circle($fn=res,r=shoulderRadius),
        profile2 = 
            transform(translation([0,0,topHeight])*rotation([topSlant,0,topRotation]), 
            powerstar_profile(size=topRadius,frequency=designNumber,amplitude=designStrength)),
        slices = floor(topHeight/layerHeight)
    ));
    
    // spade
    // number and strength are diabled
    if (topType == 6)
    skin(morph(
        profile1 = 
            transform(rotation([0,0,-90]), circle($fn=res,r=shoulderRadius)),
        profile2 = 
            transform(rotation([0,0,-90])*translation([0,0,topHeight])*rotation([topSlant,0,topRotation]), 
            spade_profile(size=topRadius)),
        slices = floor(topHeight/layerHeight)
    ));
    
    // heart
    // number and strength are diabled
    if (topType == 7)
    skin(morph(
        profile1 = 
            transform(rotation([0,0,-90]), circle($fn=res,r=shoulderRadius)),
        profile2 = 
            transform(rotation([0,0,-90])*translation([0,0,topHeight])*rotation([topSlant,0,topRotation]), 
            heart_profile(size=topRadius)),
        slices = floor(topHeight/layerHeight)
    ));
    
    // club
    // number and strength are diabled
    if (topType == 8)
    skin(morph(
        profile1 = 
            transform(rotation([0,0,-90]), circle($fn=res,r=shoulderRadius)),
        profile2 = 
            transform(rotation([0,0,-90])*translation([0,0,topHeight])*rotation([topSlant,0,topRotation]), 
            club_profile(size=topRadius)),
        slices = floor(topHeight/layerHeight)
    ));

    // diamond
    // number and strength are diabled
    if (topType == 9)
    skin(morph(
        profile1 = 
            transform(rotation([0,0,-90]), circle($fn=res,r=shoulderRadius)),
        profile2 = 
            transform(rotation([0,0,-90])*translation([0,0,topHeight])*rotation([topSlant,0,topRotation]), 
            diamond_profile(size=topRadius)),
        slices = floor(topHeight/layerHeight)
    ));

}

//////////////////////////////////////////////////////////////////////////////////////
// profiles

function star_profile(size=1,points=4,stellate=2) = [	
	// The first point is the anchor point, put it on the point corresponding to [cos(0),sin(0)]
    for (i=[0 : 2*points-1])
        size*((pow(-1,i+1)+1)*(stellate-1)+1)*[cos(i*180/points), sin(i*180/points)]
];
    
function wavestar_profile(size=1,frequency=4,amplitude=1) = [	
	// The first point is the anchor point, put it on the point corresponding to [cos(0),sin(0)]
    for (i=[0 : 180-1])
        (size+amplitude*(1+sin(frequency*2*i)))*[cos(2*i), sin(2*i)]
];  
  
function powerstar_profile(size=1,frequency=4,amplitude=1) = [	
	// The first point is the anchor point, put it on the point corresponding to [cos(0),sin(0)]
    for (i=[0 : 180-1])
        (size+amplitude*(1+sin(frequency*2*i)*(cos(2*frequency*2*i))))*[cos(2*i), sin(2*i)]
];  

// parametric heart equation modified from http://mathworld.wolfram.com/HeartCurve.html
//function heartx(t) = pow(sin(t),3);
//function hearty(t) = 0.0625*(13*cos(t)-5*cos(2*t)-2*cos(3*t)-.6*cos(4*t))+0.08;
//function heart_profile(size=1) = [	
//    for (i=[0 : 180-1])
//        size*1.5*[heartx(90-2*i),hearty(90-2*i)]
//];

// club suit coordinates obtained manually from Shutterstock picture
// using http://www.mobilefish.com/services/record_mouse_coordinates/record_mouse_coordinates.php
clubRight = transform(scaling([0.04,0.04,0])*rotation([0,180,180])*translation([-221,-221,0]),[	
	[221,398],[273,398],[264,380],[253,352],[245,326],[240,308],[238,294],[245,306],[258,323],[275,335],[298,342],[324,344],[347,338],[366,326],[379,312],[391,291],[396,265],[394,241],[384,216],[373,203],[355,189],[341,183],[317,179],[301,179],[289,183],[297,171],[305,152],[307,133],[306,116],[300,95],[288,77],[271,62],[251,52],[233,49],[221,48]
    ]);
clubLeft = transform(scaling([0.04,0.04,0])*rotation([0,0,180])*translation([-221,-221,0]),[	
	[221,398],[273,398],[264,380],[253,352],[245,326],[240,308],[238,294],[245,306],[258,323],[275,335],[298,342],[324,344],[347,338],[366,326],[379,312],[391,291],[396,265],[394,241],[384,216],[373,203],[355,189],[341,183],[317,179],[301,179],[289,183],[297,171],[305,152],[307,133],[306,116],[300,95],[288,77],[271,62],[251,52],[233,49],[221,48]
    ]);
clubLeftRev = [for (i=[0:len(clubLeft)-1]) clubLeft[len(clubLeft)-1-i]];
function club_profile(size=1) = 
    transform(scaling([size/6,size/6,0]) * rotation([0,0,90]), concat(clubRight,clubLeftRev));

// spade suit coordinates obtained manually from Shutterstock picture
// using http://www.mobilefish.com/services/record_mouse_coordinates/record_mouse_coordinates.php
spadeRight = transform(scaling([0.04,0.04,0])*rotation([0,180,180])*translation([-221,-221,0]),[	
	[221,400],[274,400],[267,385],[259,367],[251,344],[245,325],[242,313],[241,306],[251,316],[269,326],[288,330],[313,330],[333,325],[348,316],[364,297],[370,282],[375,264],[376,248],[375,228],[370,205],[359,185],[347,169],[332,153],[320,141],[301,125],[287,112],[270,97],[253,79],[238,64],[221,49]
    ]);
spadeLeft = transform(scaling([0.04,0.04,0])*rotation([0,0,180])*translation([-221,-221,0]),[	
	[221,400],[274,400],[267,385],[259,367],[251,344],[245,325],[242,313],[241,306],[251,316],[269,326],[288,330],[313,330],[333,325],[348,316],[364,297],[370,282],[375,264],[376,248],[375,228],[370,205],[359,185],[347,169],[332,153],[320,141],[301,125],[287,112],[270,97],[253,79],[238,64],[221,49]
    ]);
spadeLeftRev = [for (i=[0:len(spadeLeft)-1]) spadeLeft[len(spadeLeft)-1-i]];
function spade_profile(size=1) = 
    transform(scaling([size/6,size/6,0]) * rotation([0,0,90]), concat(spadeRight,spadeLeftRev));

// diamond suit coordinates obtained manually from Shutterstock picture
// using http://www.mobilefish.com/services/record_mouse_coordinates/record_mouse_coordinates.php
diamondRight = transform(scaling([0.043,0.043,0])*rotation([0,180,180])*translation([-225,-225,0]),[	
	// The first point is the anchor point, put it on the point corresponding to [cos(0),sin(0)]
	[225,399],[233,384],[244,367],[257,344],[276,318],[294,295],[310,276],[328,256],[342,242],[352,233],[361,224],[351,215],[336,201],[319,182],[305,167],[289,147],[273,127],[258,105],[244,84],[235,67],[228,57],[225,50]
    ]);
diamondLeft = transform(scaling([0.043,0.043,0])*rotation([0,0,180])*translation([-225,-225,0]),[	
	// The first point is the anchor point, put it on the point corresponding to [cos(0),sin(0)]
	[225,399],[233,384],[244,367],[257,344],[276,318],[294,295],[310,276],[328,256],[342,242],[352,233],[361,224],[351,215],[336,201],[319,182],[305,167],[289,147],[273,127],[258,105],[244,84],[235,67],[228,57],[225,50]
    ]);
diamondLeftRev = [for (i=[0:len(diamondLeft)-1]) diamondLeft[len(diamondLeft)-1-i]];
function diamond_profile(size=1) = 
    transform(scaling([size/6,size/6,0]) * rotation([0,0,90]), concat(diamondRight,diamondLeftRev));

// heart suit coordinates obtained manually from Shutterstock picture
// using http://www.mobilefish.com/services/record_mouse_coordinates/record_mouse_coordinates.php
heartRight = transform(scaling([0.04,0.04,0])*rotation([0,180,180])*translation([-225,-225,0]),[	
	// The first point is the anchor point, put it on the point corresponding to [cos(0),sin(0)]
    [225,380],[244,367],[267,350],[291,331],[318,309],[341,287],[361,262],[378,237],[394,204],[398,182],[400,161],[396,139],[388,119],[379,104],[360,86],[340,75],[316,69],[289,69],[270,76],[251,87],[237,99],[230,108],[225,113]
    ]);
heartLeft = transform(scaling([0.04,0.04,0])*rotation([0,0,180])*translation([-225,-225,0]),[	
	// The first point is the anchor point, put it on the point corresponding to [cos(0),sin(0)]
    [225,380],[244,367],[267,350],[291,331],[318,309],[341,287],[361,262],[378,237],[394,204],[398,182],[400,161],[396,139],[388,119],[379,104],[360,86],[340,75],[316,69],[289,69],[270,76],[251,87],[237,99],[230,108],[225,113]
    ]);
heartLeftRev = [for (i=[0:len(heartLeft)-1]) heartLeft[len(heartLeft)-1-i]];
function heart_profile(size=1) = 
    transform(scaling([size/6,size/6,0]) * rotation([0,0,90]), concat(heartRight,heartLeftRev));

function cross_profile(size=1,thickness=.2) = [
    [size, 0],
    [size, thickness],
    [thickness, thickness],
    [thickness, size],
    [-thickness, size],
    [-thickness, thickness],
    [-size, thickness],
    [-size, -thickness],
    [-thickness, -thickness],
    [-thickness, -size],
    [thickness, -size],
    [thickness, -thickness],
    [size, -thickness]
];


//////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////
// list-comprehension-demos/sweep.scad

function rotation_from_axis(x,y,z) = [[x[0],y[0],z[0]],[x[1],y[1],z[1]],[x[2],y[2],z[2]]]; 

function rotate_from_to(a,b,_axis=[]) = 
        len(_axis) == 0 
        ? rotate_from_to(a,b,unit(cross(a,b))) 
        : _axis*_axis >= 0.99 ? rotation_from_axis(unit(b),_axis,cross(_axis,unit(b))) * 
    transpose_3(rotation_from_axis(unit(a),_axis,cross(_axis,unit(a)))) : identity3(); 

function make_orthogonal(u,v) = unit(u - unit(v) * (unit(v) * u)); 

// Prevent creeping nonorthogonality 
function coerce(m) = [unit(m[0]), make_orthogonal(m[1],m[0]), make_orthogonal(make_orthogonal(m[2],m[0]),m[1])]; 

function tangent_path(path, i) =
i == 0 ?
  unit(path[1] - path[0]) :
  (i == len(path)-1 ?
      unit(path[i] - path[i-1]) :
    unit(path[i+1]-path[i-1]));

function construct_rt(r,t) = [concat(r[0],t[0]),concat(r[1],t[1]),concat(r[2],t[2]),[0,0,0,1]]; 

function construct_torsion_minimizing_rotations(tangents) = [ 
        for (i = [0:len(tangents)-2]) 
                rotate_from_to(tangents[i],tangents[i+1]) 
]; 

function accumulate_rotations(rotations,acc_=[]) = let(i = len(acc_)) 
        i ==  len(rotations) ? acc_ : 
        accumulate_rotations(rotations, 
                i == 0 ? [rotations[0]] : concat(acc_, [ rotations[i] * acc_[i-1] ]) 
        ); 

// Calculates the relative torsion along the Z axis for two transformations 
function calculate_twist(A,B) = let( 
        D = transpose_3(B) * A 
) atan2(D[1][0], D[0][0]); 
        
function construct_transform_path(path, closed=false) = let( 
        l = len(path), 
        tangents = [ for (i=[0:l-1]) tangent_path(path, i)], 
        local_rotations = construct_torsion_minimizing_rotations(concat([[0,0,1]],tangents)), 
        rotations = accumulate_rotations(local_rotations), 
        twist = closed ? calculate_twist(rotations[0], rotations[l-1]) : 0 
)  [ for (i = [0:l-1]) construct_rt(rotations[i], path[i]) * rotation([0,0,twist*i/(l-1)])]; 

module sweep(shape, path_transforms, closed=false) {

    pathlen = len(path_transforms);
    segments = pathlen + (closed ? 0 : -1);
    shape3d = to_3d(shape);

    function sweep_points() =
      flatten([for (i=[0:pathlen]) transform(path_transforms[i], shape3d)]);

    function loop_faces() = [let (facets=len(shape3d))
        for(s=[0:segments-1], i=[0:facets-1])
          [(s%pathlen) * facets + i, 
           (s%pathlen) * facets + (i + 1) % facets, 
           ((s + 1) % pathlen) * facets + (i + 1) % facets, 
           ((s + 1) % pathlen) * facets + i]];

    bottom_cap = closed ? [] : [[for (i=[len(shape3d)-1:-1:0]) i]];
    top_cap = closed ? [] : [[for (i=[0:len(shape3d)-1]) i+len(shape3d)*(pathlen-1)]];
    polyhedron(points = sweep_points(), faces = concat(loop_faces(), bottom_cap, top_cap), convexity=5);
}

//////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////
// list-comprehension-demos/skin.scad

// Skin a set of profiles with a polyhedral mesh
module skin(profiles, loop=false /* unimplemented */) {
	P = max_len(profiles);
	N = len(profiles);

	profiles = [ 
		for (p = profiles)
			for (pp = augment_profile(to_3d(p),P))
				pp
	];

	function quad(i,P,o) = [[o+i, o+i+P, o+i%P+P+1], [o+i, o+i%P+P+1, o+i%P+1]];

	function profile_triangles(tindex) = [
		for (index = [0:P-1]) 
			let (qs = quad(index+1, P, P*(tindex-1)-1)) 
				for (q = qs) q
	];

    triangles = [ 
		for(index = [1:N-1])
        	for(t = profile_triangles(index)) 
				t
	];
	
	start_cap = [range([0:P-1])];
	end_cap   = [range([P*N-1 : -1 : P*(N-1)])];

	polyhedron(convexity=2, points=profiles, faces=concat(start_cap, triangles, end_cap));
}

// Augments the profile with steiner points making the total number of vertices n 
function augment_profile(profile, n) = 
	subdivide(profile,insert_extra_vertices_0([profile_lengths(profile),dup(0,len(profile))],n-len(profile))[1]);

function subdivide(profile,subdivisions) = let (N=len(profile)) [
	for (i = [0:N-1])
		let(n = len(subdivisions)>0 ? subdivisions[i] : subdivisions)
			for (p = interpolate(profile[i],profile[(i+1)%N],n+1))
				p
];

function interpolate(a,b,subdivisions) = [
	for (index = [0:subdivisions-1])
		let(t = index/subdivisions)
			a*(1-t)+b*t
];

function distribute_extra_vertex(lengths_count,ma_=-1) = ma_<0 ? distribute_extra_vertex(lengths_count, max_element(lengths_count[0])) :
	concat([set(lengths_count[0],ma_,lengths_count[0][ma_] * (lengths_count[1][ma_]+1) / (lengths_count[1][ma_]+2))], [increment(lengths_count[1],max_element(lengths_count[0]),1)]);

function insert_extra_vertices_0(lengths_count,n_extra) = n_extra <= 0 ? lengths_count : 
	insert_extra_vertices_0(distribute_extra_vertex(lengths_count),n_extra-1);

// Find the index of the maximum element of arr
function max_element(arr,ma_,ma_i_=-1,i_=0) = i_ >= len(arr) ? ma_i_ :
	i_ == 0 || arr[i_] > ma_ ? max_element(arr,arr[i_],i_,i_+1) : max_element(arr,ma_,ma_i_,i_+1);

function max_len(arr) = max([for (i=arr) len(i)]);

function increment(arr,i,x=1) = set(arr,i,arr[i]+x);

function profile_lengths(profile) = [ 
	for (i = [0:len(profile)-1])
		profile_segment_length(profile,i)
];

function profile_segment_length(profile,i) = norm(profile[(i+1)%len(profile)] - profile[i]);

// Generates an array with n copies of value (default 0)
function dup(value=0,n) = [for (i = [1:n]) value];

//////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////
// list-comprehension-demos/extrusion.scad

function rectangle_profile(size=[1,1]) = [	
	// The first point is the anchor point, put it on the point corresponding to [cos(0),sin(0)]
	[ size[0]/2,  0], 
	[ size[0]/2,  size[1]/2],
	[-size[0]/2,  size[1]/2],
	[-size[0]/2, -size[1]/2],
	[ size[0]/2, -size[1]/2],
];

function rounded_rectangle_profile(size=[1,1],r=1,fn=32) = [
	for (index = [0:fn-1])
		let(a = index/fn*360) 
			r * [cos(a), sin(a)] 
			+ sign_x(index, fn) * [size[0]/2-r,0]
			+ sign_y(index, fn) * [0,size[1]/2-r]
];

function sign_x(i,n) = 
	i < n/4 || i > n-n/4  ?  1 :
	i > n/4 && i < n-n/4  ? -1 :
	0;

function sign_y(i,n) = 
	i > 0 && i < n/2  ?  1 :
	i > n/2 ? -1 :
	0;

function interpolate_profile(profile1, profile2, t) = (1-t) * profile1 + t * profile2;

// Morph two profile
function morph(profile1, profile2, slices=1, fn=0) = morph0(
	augment_profile(to_3d(profile1),max(len(profile1),len(profile2),fn)),
	augment_profile(to_3d(profile2),max(len(profile1),len(profile2),fn)),
	slices
);

function morph0(profile1, profile2, slices=1) = [
	for(index = [0:slices-1])
		interpolate_profile(profile1, profile2, index/(slices-1))
];


// The area of a profile
//function area(p, index_=0) = index_ >= len(p) ? 0 :
function pseudo_centroid(p,index_=0) = index_ >= len(p) ? [0,0,0] :
	p[index_]/len(p) + pseudo_centroid(p,index_+1);


//// Nongeneric helper functions

function profile_distance(p1,p2) = norm(pseudo_centroid(p1) - pseudo_centroid(p2));

function rate(profiles) = [ 
	for (index = [0:len(profiles)-2]) [
		profile_length(profiles[index+1]) - profile_length(profiles[index]), 
     	profile_distance(profiles[index], profiles[index+1])
    ]
];

function profiles_lengths(profiles) = [ for (p = profiles) profile_length(p) ];

function profile_length(profile,i=0) = i >= len(profile) ? 0 :
	 profile_segment_length(profile, i) + profile_length(profile, i+1);

function expand_profile_vertices(profile,n=32) = len(profile) >= n ? profile : expand_profile_vertices_0(profile,profile_length(profile),n);

//////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////
// scad_utils/shapes.scad

function square(size) = [[-size,-size], [-size,size], [size,size], [size,-size]] / 2;

function circle(r) = [for (i=[0:$fn-1]) let (a=i*360/$fn) r * [cos(a), sin(a)]];

function regular(r, n) = circle(r, $fn=n);

function rectangle_profile(size=[1,1]) = [	
	// The first point is the anchor point, put it on the point corresponding to [cos(0),sin(0)]
	[ size[0]/2,  0], 
	[ size[0]/2,  size[1]/2],
	[-size[0]/2,  size[1]/2],
	[-size[0]/2, -size[1]/2],
	[ size[0]/2, -size[1]/2],
];

// FIXME: Move rectangle and rounded rectangle from extrusion

//////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////
// scad-utils/trajectory.scad

function val(a=undef,default=undef) = a == undef ? default : a;
function vec_is_undef(x,index_=0) = index_ >= len(x) ? true :
is_undef(x[index_]) && vec_is_undef(x,index_+1);

function is_undef(x) = len(x) > 0 ? vec_is_undef(x) : x == undef;
// Either a or b, but not both
function either(a,b,default=undef) = is_undef(a) ? (is_undef(b) ? default : b) : is_undef(b) ? a : undef;

function translationv(left=undef,right=undef,up=undef,down=undef,forward=undef,backward=undef,translation=undef) = 
translationv_2(
	x = either(up,-down),
	y = either(right,-left),
	z = either(forward,-backward),
	translation = translation);

function translationv_2(x,y,z,translation) =
	x == undef && y == undef && z == undef ? translation :
	is_undef(translation) ? [val(x,0),val(y,0),val(z,0)]
	: undef;

function rotationv(pitch=undef,yaw=undef,roll=undef,rotation=undef) = 
	rotation == undef ? [val(yaw,0),val(pitch,0),val(roll,0)] :
	pitch == undef && yaw == undef && roll == undef ? rotation :
	undef;

function trajectory(
	left=undef,    right=undef,
	up=undef,      down=undef,
	forward=undef, backward=undef,
	translation=undef,

    pitch=undef,
    yaw=undef,
    roll=undef,
    rotation=undef
) = concat(
	translationv(left=left,right=right,up=up,down=down,forward=forward,backward=backward,translation=translation),
	rotationv(pitch=pitch,yaw=yaw,roll=roll,rotation=rotation)
);

function rotationm(rotation=undef,pitch=undef,yaw=undef,roll=undef) = so3_exp(rotationv(rotation=rotation,pitch=pitch,yaw=yaw,roll=roll));

//////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////
// scad-utils/trajectory_path.scad

function left_multiply(a,bs,i_=0) = i_ >= len(bs) ? [] :
	concat([
		a * bs[i_]
	], left_multiply(a,bs,i_+1));

function right_multiply(as,b,i_=0) = i_ >= len(as) ? [] :
	concat([
		as[i_] * b
	], right_multiply(as,b,i_+1));

function quantize_trajectory(trajectory,step=undef,start_position=0,steps=undef,i_=0,length_=undef) =
	length_ == undef ? quantize_trajectory(
		trajectory=trajectory,
		start_position=(step==undef?norm(take3(trajectory))/steps*start_position:start_position),
		length_=norm(take3(trajectory)),
		step=step,steps=steps,i_=i_) :
	(steps==undef?start_position > length_:i_>=steps) ? [] :
	concat([
	// if steps is defined, ignore start_position
		se3_exp(trajectory*(steps==undef ? start_position/length_
                                         : i_/(steps>1?steps-1:1)))
	], quantize_trajectory(trajectory=trajectory,step=step,start_position=(steps==undef?start_position+step:start_position),steps=steps,i_=i_+1,length_=length_));

function close_trajectory_loop(trajectories) = concat(trajectories,[se3_ln(invert_rt(trajectories_end_position(trajectories)))]);

function quantize_trajectories(trajectories,step=undef,start_position=0,steps=undef,loop=false,last_=identity4(),i_=0,current_length_=undef,j_=0) =
		// due to quantization differences, the last step may be missed. In that case, add it:
	loop==true ? quantize_trajectories(
		trajectories=close_trajectory_loop(trajectories),
		step=step,
		start_position = start_position,
		steps=steps,
		loop=false,
		last_=last_,
		i_=i_,
		current_length_=current_length_,
		j_=j_) :
	i_ >= len(trajectories) ? (j_ < steps ? [last_] : []) :
	current_length_ == undef ? 
	quantize_trajectories(
		trajectories=trajectories,
		step = (step == undef ? trajectories_length(trajectories) / steps : step),
		start_position = (step == undef ? start_position * trajectories_length(trajectories) / steps : start_position),
		steps=steps,
		loop=loop,
		last_=last_,
		i_=i_,
		current_length_=norm(take3(trajectories[i_])),
		j_=j_) :
	concat(
		left_multiply(last_,quantize_trajectory(
			trajectory=trajectories[i_],
			start_position=start_position,
			step=step)),
	quantize_trajectories(
		trajectories=trajectories,
		step=step,
		start_position = start_position > current_length_
			? start_position - current_length_
			: step - ((current_length_-start_position) % step),
		steps=steps,
		loop=loop,
	    last_=last_ * se3_exp(trajectories[i_]),
	    i_=i_+1,
		current_length_ = undef,
		j_=j_+len(

		quantize_trajectory(
			trajectory=trajectories[i_],
			start_position=start_position,
			step=step	

		))
	))
;

function trajectories_length(trajectories, i_=0) = i_ >= len(trajectories) ? 0 
	: norm(take3(trajectories[i_])) + trajectories_length(trajectories,i_+1);


function trajectories_end_position(rt,i_=0,last_=identity4()) = 
	i_ >= len(rt) ? last_ :
	trajectories_end_position(rt, i_+1, last_ * se3_exp(rt[i_]));

//////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////
// scad_utils/linalg.scad

// very minimal set of linalg functions needed by so3, se3 etc.

// cross and norm are builtins
//function cross(x,y) = [x[1]*y[2]-x[2]*y[1], x[2]*y[0]-x[0]*y[2], x[0]*y[1]-x[1]*y[0]];
//function norm(v) = sqrt(v*v);

function vec3(p) = len(p) < 3 ? concat(p,0) : p;
function vec4(p) = let (v3=vec3(p)) len(v3) < 4 ? concat(v3,1) : v3;
function unit(v) = v/norm(v);

function identity3()=[[1,0,0],[0,1,0],[0,0,1]]; 
function identity4()=[[1,0,0,0],[0,1,0,0],[0,0,1,0],[0,0,0,1]];


function take3(v) = [v[0],v[1],v[2]];
function tail3(v) = [v[3],v[4],v[5]];
function rotation_part(m) = [take3(m[0]),take3(m[1]),take3(m[2])];
function rot_trace(m) = m[0][0] + m[1][1] + m[2][2];
function rot_cos_angle(m) = (rot_trace(m)-1)/2;

function rotation_part(m) = [take3(m[0]),take3(m[1]),take3(m[2])];
function translation_part(m) = [m[0][3],m[1][3],m[2][3]];
function transpose_3(m) = [[m[0][0],m[1][0],m[2][0]],[m[0][1],m[1][1],m[2][1]],[m[0][2],m[1][2],m[2][2]]];
function transpose_4(m) = [[m[0][0],m[1][0],m[2][0],m[3][0]],
                           [m[0][1],m[1][1],m[2][1],m[3][1]],
                           [m[0][2],m[1][2],m[2][2],m[3][2]],
                           [m[0][3],m[1][3],m[2][3],m[3][3]]]; 
function invert_rt(m) = construct_Rt(transpose_3(rotation_part(m)), -(transpose_3(rotation_part(m)) * translation_part(m)));
function construct_Rt(R,t) = [concat(R[0],t[0]),concat(R[1],t[1]),concat(R[2],t[2]),[0,0,0,1]];

// Hadamard product of n-dimensional arrays
function hadamard(a,b) = !(len(a)>0) ? a*b : [ for(i = [0:len(a)-1]) hadamard(a[i],b[i]) ];

//////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////
// scad_utils/lists.scad

// List helpers

/*!
  Flattens a list one level:

  flatten([[0,1],[2,3]]) => [0,1,2,3]
*/
function flatten(list) = [ for (i = list, v = i) v ];


/*!
  Creates a list from a range:

  range([0:2:6]) => [0,2,4,6]
*/
function range(r) = [ for(x=r) x ];

/*!
  Reverses a list:

  reverse([1,2,3]) => [3,2,1]
*/
function reverse(list) = [for (i = [len(list)-1:-1:0]) list[i]];

/*!
  Extracts a subarray from index begin (inclusive) to end (exclusive)
  FIXME: Change name to use list instead of array?

  subarray([1,2,3,4], 1, 2) => [2,3]
*/
function subarray(list,begin=0,end=-1) = [
    let(end = end < 0 ? len(list) : end)
      for (i = [begin : 1 : end-1])
        list[i]
];

/*!
  Returns a copy of a list with the element at index i set to x

  set([1,2,3,4], 2, 5) => [1,2,5,4]
*/
function set(list, i, x) = [for (i_=[0:len(list)-1]) i == i_ ? x : list[i_]];

//////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////
// scad_utils/so3.scad 

function rodrigues_so3_exp(w, A, B) = [
[1.0 - B*(w[1]*w[1] + w[2]*w[2]), B*(w[0]*w[1]) - A*w[2],          B*(w[0]*w[2]) + A*w[1]],
[B*(w[0]*w[1]) + A*w[2],          1.0 - B*(w[0]*w[0] + w[2]*w[2]), B*(w[1]*w[2]) - A*w[0]],
[B*(w[0]*w[2]) - A*w[1],          B*(w[1]*w[2]) + A*w[0],          1.0 - B*(w[0]*w[0] + w[1]*w[1])]
];

function so3_exp(w) = so3_exp_rad(w/180*PI);
function so3_exp_rad(w) =
combine_so3_exp(w,
	w*w < 1e-8 
	? so3_exp_1(w*w)
	: w*w < 1e-6
	  ? so3_exp_2(w*w)
	  : so3_exp_3(w*w));

function combine_so3_exp(w,AB) = rodrigues_so3_exp(w,AB[0],AB[1]);

// Taylor series expansions close to 0
function so3_exp_1(theta_sq) = [
	1 - 1/6*theta_sq, 
	0.5
];

function so3_exp_2(theta_sq) = [
	1.0 - theta_sq * (1.0 - theta_sq/20) / 6,
	0.5 - 0.25/6 * theta_sq
];

function so3_exp_3_0(theta_deg, inv_theta) = [
	sin(theta_deg) * inv_theta,
	(1 - cos(theta_deg)) * (inv_theta * inv_theta)
];

function so3_exp_3(theta_sq) = so3_exp_3_0(sqrt(theta_sq)*180/PI, 1/sqrt(theta_sq));


function rot_axis_part(m) = [m[2][1] - m[1][2], m[0][2] - m[2][0], m[1][0] - m[0][1]]*0.5;

function so3_ln(m) = 180/PI*so3_ln_rad(m);
function so3_ln_rad(m) = so3_ln_0(m,
	cos_angle = rot_cos_angle(m),
	preliminary_result = rot_axis_part(m));

function so3_ln_0(m, cos_angle, preliminary_result) = 
so3_ln_1(m, cos_angle, preliminary_result, 
	sin_angle_abs = sqrt(preliminary_result*preliminary_result));

function so3_ln_1(m, cos_angle, preliminary_result, sin_angle_abs) = 
	cos_angle > sqrt(1/2)
	? sin_angle_abs > 0
	  ? preliminary_result * asin(sin_angle_abs)*PI/180 / sin_angle_abs
	  : preliminary_result
	: cos_angle > -sqrt(1/2)
	  ? preliminary_result * acos(cos_angle)*PI/180 / sin_angle_abs
	  : so3_get_symmetric_part_rotation(
	      preliminary_result,
	      m,
	      angle = PI - asin(sin_angle_abs)*PI/180,
	      d0 = m[0][0] - cos_angle,
	      d1 = m[1][1] - cos_angle,
	      d2 = m[2][2] - cos_angle
			);

function so3_get_symmetric_part_rotation(preliminary_result, m, angle, d0, d1, d2) =
so3_get_symmetric_part_rotation_0(preliminary_result,angle,so3_largest_column(m, d0, d1, d2));

function so3_get_symmetric_part_rotation_0(preliminary_result, angle, c_max) =
	angle * unit(c_max * preliminary_result < 0 ? -c_max : c_max);

function so3_largest_column(m, d0, d1, d2) =
		d0*d0 > d1*d1 && d0*d0 > d2*d2
		?	[d0, (m[1][0]+m[0][1])/2, (m[0][2]+m[2][0])/2]
		: d1*d1 > d2*d2
		  ? [(m[1][0]+m[0][1])/2, d1, (m[2][1]+m[1][2])/2]
		  : [(m[0][2]+m[2][0])/2, (m[2][1]+m[1][2])/2, d2];

//////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////
// scad_utils/se3.scad

function combine_se3_exp(w, ABt) = construct_Rt(rodrigues_so3_exp(w, ABt[0], ABt[1]), ABt[2]);

// [A,B,t]
function se3_exp_1(t,w) = concat(
	so3_exp_1(w*w),
	[t + 0.5 * cross(w,t)]
);

function se3_exp_2(t,w) = se3_exp_2_0(t,w,w*w);
function se3_exp_2_0(t,w,theta_sq) = 
se3_exp_23(
	so3_exp_2(theta_sq), 
	C = (1.0 - theta_sq/20) / 6,
	t=t,w=w);

function se3_exp_3(t,w) = se3_exp_3_0(t,w,sqrt(w*w)*180/PI,1/sqrt(w*w));

function se3_exp_3_0(t,w,theta_deg,inv_theta) = 
se3_exp_23(
	so3_exp_3_0(theta_deg = theta_deg, inv_theta = inv_theta),
	C = (1 - sin(theta_deg) * inv_theta) * (inv_theta * inv_theta),
	t=t,w=w);

function se3_exp_23(AB,C,t,w) = 
[AB[0], AB[1], t + AB[1] * cross(w,t) + C * cross(w,cross(w,t)) ];

function se3_exp(mu) = se3_exp_0(t=take3(mu),w=tail3(mu)/180*PI);

function se3_exp_0(t,w) =
combine_se3_exp(w,
// Evaluate by Taylor expansion when near 0
	w*w < 1e-8 
	? se3_exp_1(t,w)
	: w*w < 1e-6
	  ? se3_exp_2(t,w)
	  : se3_exp_3(t,w)
);

function se3_ln(m) = se3_ln_to_deg(se3_ln_rad(m));
function se3_ln_to_deg(v) = concat(take3(v),tail3(v)*180/PI);

function se3_ln_rad(m) = se3_ln_0(m, 
	rot = so3_ln_rad(rotation_part(m)));
function se3_ln_0(m,rot) = se3_ln_1(m,rot,
	theta = sqrt(rot*rot));
function se3_ln_1(m,rot,theta) = se3_ln_2(m,rot,theta,
	shtot = theta > 0.00001 ? sin(theta/2*180/PI)/theta : 0.5,
	halfrotator = so3_exp_rad(rot * -.5));
function se3_ln_2(m,rot,theta,shtot,halfrotator) =
concat( (halfrotator * translation_part(m) - 
	(theta > 0.001 
	? rot * ((translation_part(m) * rot) * (1-2*shtot) / (rot*rot))
	: rot * ((translation_part(m) * rot)/24)
	)) / (2 * shtot), rot);

//////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////
// scad_utils/transformations.scad

/*!
  Creates a rotation matrix

  xyz = euler angles = rz * ry * rx
  axis = rotation_axis * rotation_angle
*/
function rotation(xyz=undef, axis=undef) = 
	xyz != undef && axis != undef ? undef :
	xyz == undef  ? se3_exp([0,0,0,axis[0],axis[1],axis[2]]) :
	len(xyz) == undef ? rotation(axis=[0,0,xyz]) :
	(len(xyz) >= 3 ? rotation(axis=[0,0,xyz[2]]) : identity4()) *
	(len(xyz) >= 2 ? rotation(axis=[0,xyz[1],0]) : identity4()) *
	(len(xyz) >= 1 ? rotation(axis=[xyz[0],0,0]) : identity4());

/*!
  Creates a scaling matrix
*/
function scaling(v) = [
	[v[0],0,0,0],
	[0,v[1],0,0],
	[0,0,v[2],0],
	[0,0,0,1],
];

/*!
  Creates a translation matrix
*/
function translation(v) = [
	[1,0,0,v[0]],
	[0,1,0,v[1]],
	[0,0,1,v[2]],
	[0,0,0,1],
];

// Convert between cartesian and homogenous coordinates
function project(x) = subarray(x,end=len(x)-1) / x[len(x)-1];

function transform(m, list) = [for (p=list) project(m * vec4(p))];
function to_3d(list) = [ for(v = list) vec3(v) ];
    
//////////////////////////////////////////////////////////////////////////////////////
// TO DO LATER

// ADD KNURLED SURFACE?  MAYBE IT IS EASY
// http://www.thingiverse.com/thing:9095/#files

// maybe allow the spiral cut even though the preview is bad?  or multiple cuts?

// add decoration sometimes? on top of the top (or indentations)

// allow components to be left out - could combine this with above to make snap-togethers

// it would be nice to allow second resolution parameter related to stemStep

//////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////
// PIECEMAKER LIBRARY

// BLOCKER - a squat pawn
// base 20, 6, 1, -15
// stem 25, 0, -1, -1, 1
// shoulder 3, 2, 0
// top 15, 0, 0, 3, 4, 0, 0
// coins 0, 19.05, 1.52

// PILLAR - a tall twisty pawn
// base 22, 6, 0.5, -15
// stem 65, 1, 3, 1, 2
// shoulder 5, 8, 0
// top 14, 0, 0, 3, 2, 0, 0
// coins 0, 19.05, 1.52

// MEDIC - a straight ridged healer
// base 20, 8, -15, 1
// stem 45, taper, 0.5, -3, C&P
// shoulder 5, 5, 0
// top 12, cross, 0, 3, 3, 5, 0
// coins 0, 19.05, 1.52

// LADYSPADE - a curvy spade suit
// base 20, 6, 1, 10
// stem 45, 0, 5, 2, 2
// shoulder 5, 4, 1
// top 11, 5, 0, 3, 2, 15, 0
// coins 0, 19.05, 1.52

// LADYHEART - a curvy heart suit
// ditto with
// top 11, 6, 0, 3, 2, 15, 0

// LADYCLUB - a curvy club suit
// ditto with
// top 11, 7, 0, 3, 2, 15, 0

// LADYDIAMOND - a curvy diamond suit
// ditto with
// top 11, 8, 0, 3, 2, 15, 0

// STOOL - a short rounded riser
// base 20, 5, 0.5, -30
// stem 15, 0, -3, 2, 2
// shoulder 3, -15, 1
// top 1, 2, 0, 18, 1, 35, 0 (the 1 causes an error in the log but it's okay)
// coins 0, 19.05, 1.52

// TWIST CROSS - short piece with tall twisty X
// "BASE", 15, 5, 0.5, -15
// "STEM", 8, 0, 0, 2, 2
// "SHOULDER", 3, -15, 1
// "TOP", 25, 1, 60, 18, 0.8, 15, 0
// "COINS", 0, 19.05, 1.52

// TWIST CROSS 2 - medium sized
// ditto with 
// "STEM", 22, 0, 0, 2, 2

// TWIST CROSS 3 - tall sized
// ditto with 
// "STEM", 36, 0, 0, 2, 2

// DISCO PAWN - low poly sphere
// "BASE", 26, 8, 1, -20
// "STEM", 50, 0, 3.5, 1.5, 2
// "SHOULDER", 6, 20, 1
// "TOP", 18, 0, 120, 4, 1, -15, 0
// "ADVANCE", 0, 19.05, 1.52, 8

// GOBLET - octagon hollow top
// "BASE", 26, 8, 1, -20
// "STEM", 50, 0, 3.5, 1.5, 2
// "SHOULDER", 6, 20, 1
// "TOP", 12, 1, 0, 8, 2, 15, 0
// "ADVANCE", 0, 19.05, 1.52, 16
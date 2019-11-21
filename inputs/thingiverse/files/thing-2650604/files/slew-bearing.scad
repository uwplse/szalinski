/* [Main] */
// which parts to render - use one at a time to generate printable stl files (sadly OpenSCAD cannot generate multiple stl files at once)
SHOW_PART="ALL"; // [ALL,INNER_BOTTOM,INNER_TOP,OUTER_BOTTOM,OUTER_TOP,OUTER_BOTH,ROLLER]
// larger values increase calculation time considerably, choose small values for rapid prototyping
quality=90; // [30:20:150]
// print width, as configured in your slicer (use nozzle width if not configurable)
nozzle=0.42;
// outer diameter of bearing
outerDiameter=49;
// inner diameter of bearing, may be 0
innerDiameter=8;
// height of bearing, will indirectly define roller diameter and heigth
height=15;

// space between outer and inner, not very critical, will be limited to half roller height; 0=automatic
config_opening_between_inner_outer=0; // [0:0.5:10]

/* [Tolerances] */
// main tolerance setting
tolerance=0.2;
// tolerance for roller diameter, critical to optimize this for quality of bearing
toleranceRollerDiameter=0.03;
// tolerance of the threading
threadTolerance=0.35;

/* [Roller] */
// chamfer factor in percent of roller height, 100=completely chamfer top and bottom half
rollerChamferFactorPercent=30; // [10:5:100]
// how much chamfer is applied, in percent of diameter, 100=chamfer down to 0
rollerChamferAmountFactorPercent=20; 
// the roller position, larger values can fit more rollers, extreme values limit thickness of outer/inner walls to a minimum; 0=as close as possible to inner bearing diameter, 100=as close as possible to outer bearing diameter
rollerPositionPercent=80; // [0:5:100]

/* [Threads ]*/
// thread thickness, must be at least nozzle width; 0=automatic
config_threadThickness=0; // [0:0.1:5]
// if the outer ring should have threads, if false you have to print the outer ring as one piece or glue it togehter. Saves space for threads so outer bearing diameter can be smaller.
createThreadsForOuterRing=true; // [true,false]
// position of inner thread; 0=as close as possible to inner hole, 100=as close as possible to rollers
posInnerThread=80; // [0:10:100]
// position of outer thread; 0=as close as possible to rollers, 100=as close as possible to outer bearing diameter
posOuterThread=80; // [0:10:100]

/* [Hidden] */
$fn=quality;

rollerChamferFactor=rollerChamferFactorPercent/100/2;
chamferAmountFactor=rollerChamferAmountFactorPercent/100;

threadThickness=max(config_threadThickness,nozzle);

c=sqrt(2*height/2*height/2); // pythagoras triangle

rollerHeight=c-2*tolerance;

threadWallThickness=2*nozzle+2*threadThickness;
singleThreadSpace=4*nozzle+2*threadThickness+2*threadTolerance;
numThreads=createThreadsForOuterRing ? 2 : 1;
totalThreadSpace=numThreads*singleThreadSpace+(createThreadsForOuterRing?0:2*nozzle);

tmp_opening_between_inner_outer=config_opening_between_inner_outer==0 ? rollerHeight/4 : min(config_opening_between_inner_outer,rollerHeight/2);
opening_between_inner_outer=max(tmp_opening_between_inner_outer,2*tolerance);

// available horizontal space to wiggle with
horizontalRollerSpace=sqrt(2*c*c); // pythagoras triangle, will currently always result in value of variable 'height'
availableHorizontalWiggleSpace=outerDiameter-2*horizontalRollerSpace-totalThreadSpace-innerDiameter;
echo("availableHorizontalWiggleSpace",availableHorizontalWiggleSpace);
innerExtraWallWiggleRoom=availableHorizontalWiggleSpace*(rollerPositionPercent/100);
innerExtraWall=singleThreadSpace/2+innerExtraWallWiggleRoom/2;
outerExtraWallWiggleRoom=availableHorizontalWiggleSpace*(1-(rollerPositionPercent/100));
outerExtraWall=(outerDiameter-innerDiameter)/2-innerExtraWall-horizontalRollerSpace;
echo("outerExtraWall",outerExtraWall);

// --- BEGIN roller calculation ---
middleRollerCircleDiameter=innerDiameter+2*innerExtraWall+height;
middleRollerCircleCircumference = 3.141592*middleRollerCircleDiameter;

middleRollerDiameter=c-toleranceRollerDiameter;
innerRollerDiameter=middleRollerDiameter;
outerRollerDiameter=middleRollerDiameter;
rollerDiameterDifference=outerRollerDiameter-innerRollerDiameter;

spaceAtInnerWallForRollers=3.141592*(middleRollerCircleDiameter-(c/4));
spaceForNumRollers=spaceAtInnerWallForRollers/middleRollerDiameter;
// --- END roller calculation ---

innerThreadDiameter=innerDiameter+threadWallThickness+(innerExtraWallWiggleRoom*(posInnerThread/100));
outerThreadDiameter=outerDiameter-threadWallThickness-(outerExtraWallWiggleRoom*(1-(posOuterThread/100)));

OVERLAP=0.001;

echo("rollerHeight", rollerHeight);
echo("middleRollerDiameter",middleRollerDiameter);
echo("spaceForNumRollers",spaceForNumRollers);


// top parts must be rotated so large side is on bottom
rotate_top_to_make_printable=(len(search("_TOP",SHOW_PART))>=4) ? 180 : 0;

color([0.5,0.5,0.5])
rotate([rotate_top_to_make_printable,0,0])
{
    if (showpart("OUTER_BOTTOM") || SHOW_PART=="OUTER_BOTH"){
        outer0();
    }
    if (showpart("OUTER_TOP") || SHOW_PART=="OUTER_BOTH"){
        outer1();
    }
    if (showpart("INNER_BOTTOM")){
        inner0();
    }
    if (showpart("INNER_TOP")){
        inner1();
    }
}
color([0.3,0.4,1])
{
    if (showpart("ROLLER")){
        if (SHOW_PART=="ALL"){
            renderRollerInBearing();
        } else {
            roller();
        }
    }
}


function showpart(partId) = SHOW_PART=="ALL" ||  SHOW_PART==partId;

module renderRollerInBearing(){
    numRollers=floor(spaceForNumRollers);
    
    for (i=[0:numRollers-1]){
        rotationDirection=(i%2==0) ? 1 : -1;
        
        degrees_per_roller=360/numRollers;
        maxPosFromCenter=middleRollerCircleDiameter/2;
        translate([cos(i*degrees_per_roller)*maxPosFromCenter,sin(i*degrees_per_roller)*maxPosFromCenter,height/2])
        rotate([rotationDirection*-sin(i*degrees_per_roller)*45,rotationDirection*cos(i*degrees_per_roller)*45,0])
        translate([0,0,-rollerHeight/2])
        roller();
    }
    
}

module outer0(){
    difference(){
        half(false,outerExtraWall);
        
        if (createThreadsForOuterRing){
            translate([0,0,-OVERLAP/2])
            difference(){        
                cylinder(d=outerDiameter+1,h=height/2+OVERLAP);
                translate([0,0,-OVERLAP/2])
                cylinder(d=outerThreadDiameter-2*threadThickness-0.3,h=height/2+2*OVERLAP);
            }
        }
    }
    
    if (createThreadsForOuterRing){
        translate([0,0,+OVERLAP/2])
        thread(height/2-OVERLAP,outerThreadDiameter,threadThickness,1.6,true,false);
    }
}

module outer1(){
    difference(){
        translate([0,0,height])
        rotate([180,0,0])
        half(false,outerExtraWall);
    }
    
    if (createThreadsForOuterRing){
        union(){
            translate([0,0,+OVERLAP/2])
            thread(height/2-OVERLAP,outerThreadDiameter+2*threadTolerance,threadThickness,1.6,false);
            
            translate([0,0,-OVERLAP/2])
            difference(){
                cylinder(d=outerDiameter,h=height/2+OVERLAP);
                translate([0,0,-OVERLAP/2])
                cylinder(d=outerThreadDiameter+2*threadThickness+0.3,h=height/2+2*OVERLAP);
            }
        }
    }
}

module inner0(){
    difference(){
        union(){
            hull(){
                half(true,innerExtraWall);
            }
            translate([0,0,height/2-OVERLAP])
            thread(height/2,innerThreadDiameter,threadThickness,1.6,true);
        }
        
        cylinder(d=innerDiameter+OVERLAP/2,h=2*height+1);
    }
}

module inner1(){
    difference(){
        union(){
            difference(){
                translate([0,0,height])
                rotate([180,0,0])
                hull(){
                    half(true,innerExtraWall);
                }
                
                translate([0,0,height/2-0.5])
                cylinder(d=innerThreadDiameter+2*threadThickness,h=height/2+1);
            }
            
            translate([0,0,height/2-OVERLAP/2])
            thread(height/2-OVERLAP,innerThreadDiameter+2*threadTolerance,threadThickness,1.6,false);
        }
//        cylinder(d=innerDiameter+OVERLAP/2,h=2*height+1);
    }
}

module roller(){
    chamferHeight=rollerHeight*rollerChamferFactor;
    chamferDiameterDifference=rollerChamferFactor*rollerDiameterDifference;
    chamferAmount=chamferAmountFactor*outerRollerDiameter+rollerChamferFactor*rollerDiameterDifference;

    difference(){
        cylinder(d1=outerRollerDiameter,d2=innerRollerDiameter,h=rollerHeight);

        translate([0,0,-OVERLAP])
        cylinder(d=outerRollerDiameter+1,h=chamferHeight+OVERLAP);
        
        translate([0,0,rollerHeight-chamferHeight])
        cylinder(d=outerRollerDiameter+1,h=chamferHeight+OVERLAP);
    }
    
    d2=outerRollerDiameter-chamferDiameterDifference;
    cylinder(d1=d2-chamferAmount,d2=d2,h=chamferHeight);
    
    d1=innerRollerDiameter+rollerChamferFactor*rollerDiameterDifference;
    translate([0,0,rollerHeight-chamferHeight])
    cylinder(d1=innerRollerDiameter+rollerChamferFactor*rollerDiameterDifference,d2=d1-chamferAmount,h=chamferHeight);
}


module half(inner=false, extraWall){
    xTranslate=inner ? -height/2-innerDiameter/2-innerExtraWall : innerDiameter/2+innerExtraWall+height/2;
    rotate_extrude()    
    translate([xTranslate,0,0])
    difference(){
        union(){
            translate([0,+OVERLAP/2,0])
            square(height/2+OVERLAP);
            translate([height/2,0,0])
            square([extraWall,height/2]);
        }
        
        translate([0,height/2,0])
        rotate([0,0,-45])
        square(c, center=true);
        
        square([opening_between_inner_outer/2,height/2]);
    }
}

module thread(height,diameter,threadThickness,pitch, outer=true, full=true){
    // 20 mm produces 0.95mm thread thickness at pitch 1.6
    scaleFactor=(1/threadThickness)*(pitch/1.6);
    generateDiameter=scaleFactor*diameter;
        
    difference(){
        scale([1/scaleFactor,1/scaleFactor,1])
        rotate([0,0,360/(2*$fn)])
        translate([0,0,-pitch])
        {
         if (outer){
            threading(pitch=pitch, d=generateDiameter, windings = 1.5+height/pitch, angle = 40, full=full);
         } else {
             Threading(pitch=pitch, d=generateDiameter, windings = 2.5+height/pitch, angle = 40, full=full);
         }
        }
        
        translate([0,0,-(pitch+OVERLAP)/2-1/2])
        cylinder(d=diameter*2,h=pitch+OVERLAP+1,center=true);
        
        translate([0,0,height+pitch/2+OVERLAP/2+1/2])
        cylinder(d=diameter*2,h=pitch+OVERLAP+1,center=true);
    }
        
}


// =============================================
// copied from libraries Threading.scad and Naca_sweep.sad
// https://www.thingiverse.com/thing:1659079/
// created by Rudolf Huttary
// =============================================

module Threading(D = 0, pitch = 1, d = 12, windings = 10, helices = 1, angle = 60, steps=$fn)
{
  R = D==0?d/2+2*pitch/PI:D/2; 
  translate([0,0,-pitch])
  difference()
  { 
    translate([0,0,pitch]) 
    cylinder (r=R, h =pitch*(windings-helices)); 
    threading(pitch, d, windings, helices, angle, steps, true); 
  }
}

module threading(pitch = 1, d = 12, windings = 10, helices = 1, angle = 60, steps=$fn, full = false)
{  // tricky: glue two 180° pieces together to get a proper manifold  
  r = d/2;
  Steps = steps/2; 
  Pitch = pitch*helices; 
  if(full) cylinder(r = r-.5-pitch/PI, h=pitch*(windings+helices), $fn=steps); 
  sweep(gen_dat());   // half screw
  rotate([0, 0, 180]) translate([0, 0, Pitch/2])
  sweep(gen_dat());   // half screw

  function gen_dat() = let(ang = 180, bar = R_(180, -90, 0, Ty_(-r+.5, vec3D(pitch/PI*Rack(windings, angle)))))
        [for (i=[0:Steps]) Tz_(i/2/Steps*Pitch, Rz_(i*ang/Steps, bar))]; 

  function Rack(w, angle) = 
     concat([[0, 2]], [for (i=[0:windings-1], j=[0:3])
     let(t = [ [0, 1], [2*tan(angle/2), -1], [PI/2, -1], [2*tan(angle/2)+PI/2, 1]])
        [t[j][0]+i*PI, t[j][1]]], [[w*PI, 1], [w*PI, 2]]);
}


// generate polyhedron from multiple airfoil_datasets
// dat - vec of vec1, with vec1 = simple polygon like airfoil_data, > 3 points per dataset expected
module sweep(dat, convexity = 5, showslices = false, plaincaps = true) 
{
  n = len(dat);     // # datasets
  l = len(dat[0]);  // points per dataset 
  if(l<=3) 
    echo("ERROR: sweep() expects more than 3 points per dataset"); 
  else
  {
    if(n==1) 
      polyhedron(points = dat[0], faces = [count(l-1, 0)]);
    else{
    first = plaincaps?[count(l-1, 0)]: 
            faces_polygon(l, true);  // triangulate first dataset
    last = plaincaps?[count((n-1)*l,(n)*l-1)]: 
            faces_shift((n-2)*l, faces_polygon(l, false)); // triangulate last dataset
    if (showslices)
      for(i=[0:n-1])
        sweep([dat[i]]); 
    else
      if (n<2)  // this case is also used recursively for showslices
        polyhedron(points = flat(), faces  = last, convexity = 5); 
      else
      {
        polyhedron(points = flat(), 
                   faces  = concat(first, last, faces_sweep(l,n)), convexity = 5); 
      }
    }
  }
  function count(a, b) = let(st = (a<b?1:-1))[for (i=[a:st:b]) i]; 
  function faces_shift(d, dat) = [for (i=[0:len(dat)-1]) dat[i] + [d, d, d]]; 
  function flat() = [for (i=[0:n-1], j=[0:l-1]) dat[i][j]]; 
}

function del(A, n) = [for(i=[0:len(A)-1]) if (n!=i)A[i]]; 

//// composition stuff for polyhedron
  function faces_sweep(l, n=1) = let(M = n*l) 
      concat([[0,l,l-1]],   // first face
      [for (i=[0:l*(n-1)-2], j = [0,1])
        j==0? [i, i+1, (i+l)] : [i+1, (i+l+1), i+l]], 
      [[n*l-1, (n-1)*l-1, (n-1)*l]]) // last face
      ;
    
  function faces_polygon(l, first = true) = let(odd = (l%2==1), d=first?0:l)
    let(res = odd?concat([[d,d+1,d+l-1]],
      [for (i=[1:(l-3)/2], j=[0,1])(j==0)?[d+i,d+i+1,d+l-i]:[d+i+1,d+l-i-1, d+l-i]]):
      [for (i=[0:(l-4)/2], j=[0,1])(j==0)?[d+i,d+i+1,d+l-i-1]:[d+i+1,d+l-i-2, d+l-i-1]])
    first?facerev(res):res;
    
  function facerev(dat) = [for (i=[0:len(dat)-1]) [dat[i][0],dat[i][2],dat[i][1]]]; 



//// vector and vector set operation stuff ///////////////////////
//// Expand 2D vector into 3D
function vec3D(v, z=0) = [for(i = [0:len(v)-1]) 
  len(v[i])==2?[v[i][0], v[i][1], z]:v[i]+[0, 0, z]]; 

// Translation - 1D, 2D, 3D point vector //////////////////////////
// vector along all axes
function T_(x=0, y=0, z=0, v) = let(x_ = (len(x)==3)?x:[x, y, z])
  [for (i=[0:len(v)-1]) T__(x_[0], x_[1], x_[2], p=v[i])]; 
/// vector along one axis
function Tx_(x=0, v) = T_(x=x, v=v); 
function Ty_(y=0, v) = T_(y=y, v=v); 
function Tz_(z=0, v) = T_(z=z, v=v); 
/// point along all axes 1D, 2D, 3D allowed
function T__(x=0, y=0, z=0, p) = len(p)==3?p+[x, y, z]:len(p)==2?p+[x, y]:p+x; 

//// Rotation - 2D, 3D point vector ///////////////////////////////////
// vector around all axes 
function R_(x=0, y=0, z=0, v) =             // 2D vectors allowed 
  let(x_ = (len(x)==3)?x:[x, y, z])
  len(v[0])==3?Rx_(x_[0], Ry_(x_[1], Rz_(x_[2], v))):
  [for(i = [0:len(v)-1]) rot(x_[2], v[i])];  
// vector around one axis
function Rx_(w, A) = A*[[1, 0, 0], [0, cos(w), sin(w)], [0, -sin(w), cos(w)]]; 
function Ry_(w, A) = A*[[cos(w), 0, sin(w)], [0, 1, 0], [-sin(w), 0, cos(w)]]; 
function Rz_(w, A) = A*[[cos(w), sin(w), 0], [-sin(w), cos(w), 0], [0, 0, 1]]; 


//// Scale - 2D, 3D point vector ///////////////////////////////////
// vector along all axes 
function S_(x=1, y=1, z=1, v) = 
  [for (i=[0:len(v)-1]) S__(x,y,z, v[i])]; 
// vector along one axis
function Sx_(x=0, v) = S_(x=x, v=v); 
function Sy_(y=0, v) = S_(y=y, v=v); 
function Sz_(z=0, v) = S_(z=z, v=v); 
// single point in 2D
function S__(x=1, y=1, z=1, p) = 
  len(p)==3?[p[0]*x, p[1]*y, p[2]*z]:len(p)==2?[p[0]*x+p[1]*y]:[p[0]*x];
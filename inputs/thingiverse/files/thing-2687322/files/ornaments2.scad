// Created in 2017 by David H. Brown.
// This work is released with CC0 into the public domain.
// https://creativecommons.org/publicdomain/zero/1.0/
// Attribution/credit would be nice, but I couldn't have done 
// it without Ryan Colyer's code which he made Public Domain, 
// so I figure I should do the same :-)

/* [Units] */

// What units would you like to use? Defaults are in inches. Changing this does NOT change values already entered; defaults are in inches. 
0_Units=25.4;//[1:mm,10:cm,25.4:inches]

/* [Shape] */

// How tall [Units] should the main shape be (exclusive of base/neck 
1_Shape_Height=2;
// How wide [Units] should the main shape be at its widest point? 
2_Shape_Width=1.5;
// Do you want the shape to be more round (0.5) or more tapered (2)? Extremes are more challenging to print because the flatter areas are not well-supported. 
3_Shape_Control=1; // [0.5:0.1:2]

/* [Cap] */

// This is the diameter [Units] of your ornament cap; mine are 1/2", so 0.5 
1_Cap_Diameter=0.5;
// This is the height [Units] of a cylinder to attach the ornament cap (and also a base for printing). the caps I found are about 3/8" but 1/8" of that is decoration, so 0.25 worked for me.
2_Cap_Height=0.25;
// The cylinder base must gently transition to the desired shape over this distance [Units] to ensure they connect (value > 0 required). Larger values look weird with ripples.
3_Cap_Shape_Transition=.25;


/* [Ripples] */

// How many ripples would you like on your shape? 0=none; 36 becomes more of a texture 
1_Ripple_Count=14;//[0:36]
// How far [% of width] in *and* out should the ripples extend? Small values are more easily printed. The more ripples you have, the smaller this should probably be.
2_Ripple_Height=10;//[1:0.5:30]

// Should the ripples twist as they move around the shape? How many degrees (360=one full rotation)? Negative values twist the other way. Remember that this will be hanging upside-down relative to the preview!
3_Ripple_Twist=60;

/* [Dimples] */

// Would you like "dimples" in the ornament? How many? 
1_Dimples=0;//[0:12]

// How big [Units] should these spheres be?
2_Dimple_Size = 1;
// How far should the spheres be from the shape? 0 places the sphere right on the edge cuts out an entire hemisphere; 0.95 moves away and barely nicks it
3_Dimple_Distance=0.1;//[0.0:0.05:0.95]
// Do you need to shift them around the shape? (E.g., to line up with ripples.) How many degrees?  
4_Dimple_Shift=0;
// Would you like to show those spheres so you can see what you're doing with these parameters? (Just a preview; won't be part of the .stl.)
5_preview_dimples=0; // [0:Hide,1:Show]
/* [Advanced Tweaks] */
// Increase the Cap Shape Easing value to slow down the transition at the beginning and end. 1=linear, 2=quadratic, etc.
Cap_Shape_Easing=3; // [1:1:4]

// Tapered shapes look good if their profile calculation begins within the base/neck (0.0-0.5) while round shapes can look better if the base/neck is separate (1.0). What position within the cap looks good to you? Leave at -0.1 and the point at which the shape is as wide as the cap will be calculated automatically for you.
Shape_Start=-0.1; // [-0.1:0.1:1.0]
// Should the ripples be smoothed out (strength=0.0) or always be full strength (strength=1.0)? Strong ripple near the cap can improve layer adhesion. 
Ripple_Strength_Cap=1; // [0.0:0.1:1]
// Smoothing the ripples near the tip can avoid discontinuities that can make the slicer drop out of vase mode and leave odd-looking pillars of material.
Ripple_Strength_Tip=0; // [0.0:0.1:1]
// Very high ripple strengths result in fins, like fan or propeller blades. Select fins to multiply the ripple strength x10.
Ripple_Fins=1; //[1:Ripples,10:Fins]
// By default (0), OpenSCAD will build the sphere with a number of "fragments in 360 degrees" based on the sphere size which I found gave it a slightly faceted appearance. You can force a low number (12) to exaggerate the facets or raise it to smooth it out (72). Very high values will greatly slow the build time for the stl file.
Dimple_Fragments=0;//[0:12:180]
// What rendering quality do you need? Try the default (0.4mm layers, 180 radial steps), then reduce if it can't render; increase if you need more detail.
Quality_Factor=1;//[0.5:0.5:2]
/*  1=0.4mm layers, 180 radial slices; 2=0.2mm/360; 0.5=0.8/90 */

/* [Hidden] */


function easing(t,p)=t<.5 ? abs(pow(2*t,p))/2 : 1-abs(pow(2*t-2,p))/2;
function positionWithinTransition(z)=max(0,min(1,(z-baseHeight)/baseTransition)); /* 0..1 */
function blend(value1, value2, mix) = (1-mix)*value1 + mix*value2;
function ripple(z,angle)=sin((((z-zMin)/height)*rippleTwist+angle)*rippleCount);
function rippleStrength(z)=((z-zMin)/height)<0.5 ? blend(Ripple_Strength_Cap,1,max(0,(z-zMin)/height)*2) : blend(1,Ripple_Strength_Tip,2*(max(0,(z-zMin)/height-0.5)));
function shapeRadius(z)=maxRadius*pow(sin(z*degreesPerZ),sinPower);
function shapeZ(radius)=asin(pow(radius/maxRadius,1/sinPower)/degreesPerZ);
function shapeRadiusRippled(z,angle)=blend(0,ripple(z,angle)*maxRadius*ripplePercent,rippleStrength(z)) + blend(1+ripplePercent*ripple(z,angle),1,rippleStrength(z))*shapeRadius(z);
function AxialFunc1(z, angle) = blend(baseRadius, shapeRadiusRippled(max(0,z-zMin),angle), easing(positionWithinTransition(z),Cap_Shape_Easing));

height=1_Shape_Height*0_Units;
degreesPerZ=180/height; /* for calculating radius of main shape as sin function */
maxRadius=2_Shape_Width/2*0_Units;
sinPower=3_Shape_Control;

baseHeight=2_Cap_Height*0_Units;
baseRadius=1_Cap_Diameter*0_Units/2;
baseTransition=3_Cap_Shape_Transition*0_Units;
zMin = (Shape_Start < 0) ? baseHeight-shapeZ(baseRadius) : Shape_Start*baseHeight;
zMax=height+zMin;

rippleCount=1_Ripple_Count;
ripplePercent=2_Ripple_Height/100*Ripple_Fins;
rippleTwist = 3_Ripple_Twist; /* degrees */

dimples=1_Dimples;
dimpleRadius=0_Units*2_Dimple_Size/2;
dimpleDistance=maxRadius+dimpleRadius*3_Dimple_Distance;//[1.0:0.05:1.9]
dimpleShift=4_Dimple_Shift;

layerThickness=0.4/Quality_Factor; /*in mm; match to layer height?*/
radialSteps=180/Quality_Factor; /* switch to 360 for better smoothness */


/* * / // Check inverse function
for(z=[0:1:height/2]) {
    sr=maxRadius*pow(sin(z*degreesPerZ),sinPower); 
    sz=asin(pow(sr/maxRadius,1/sinPower))/degreesPerZ;
    echo("z=",z,"sr(z)=",sr, "sz(sr)=",sz) ;
}/**/


/* Test transition function: * /
echo ("Cap radius = ",baseRadius);
for (z=[0:layerThickness:baseHeight+baseTransition*1.25]) echo("z=",z,"; positionWithinTransition(z)=",positionWithinTransition(z), "blend=",blend(0,1,positionWithinTransition(z)),"radius=",shapeRadius(z-zMin,0),"AxialFunc=",AxialFunc1(z,0)); 
    /**/


difference() {
    PlotAxialFunction(1, [0, layerThickness, zMax], radialSteps);
    if(dimples>0)  drawDimples();
    }

module drawDimples() {
    if (5_preview_dimples==1) {
    for(dimple=[1:dimples])  rotate(a=[0,0,360/dimples*dimple+dimpleShift]) translate([0,dimpleDistance,height/2+zMin]) sphere(r=dimpleRadius, $fn=Dimple_Fragments); %for(dimple=[1:dimples])  rotate(a=[0,0,360/dimples*dimple+dimpleShift]) translate([0,dimpleDistance,height/2+zMin]) sphere(r=dimpleRadius,$fn=Dimple_Fragments);
  } else {
    for(dimple=[1:dimples])  rotate(a=[0,0,360/dimples*dimple+dimpleShift]) translate([0,dimpleDistance,height/2+zMin]) sphere(r=dimpleRadius, $fn=Dimple_Fragments);
  }
}


/********************\
** PLOTTING CODE    **
** Thank you, Ryan! **
\********************/

/* include <plot_function.scad>; 
// if running on your own computer with the real library available,
// uncomment the include above and delete the following partial code 
//*/

// Created in 2017 by Ryan A. Colyer.
// This work is released with CC0 into the public domain.
// https://creativecommons.org/publicdomain/zero/1.0/
//
// https://www.thingiverse.com/thing:2391851


// Plots the numbered function AxialFunc1 through AxialFunc9, where
// AxialFuncN is 1 through 9.  Each function is a function of z-height and
// angle, and returns the radius outward in the xy-plane.
// max_r is the outer radius, and min_step is the smallest step size between
// points.
// minz_stepz_maxz should be [minz, stepz, maxz], and likewise for y,
// specifying the domain to be plotted.
// To guarantee a properly manifold shape, the routine will only render
// strictly positive values (r>0) of the defined function.  Add an offset if
// needed to achieve this.
module PlotAxialFunction(AxialFuncN, minz_stepz_maxz, num_circle_steps=360) {
  ang_step = 360 / num_circle_steps;
  minz = minz_stepz_maxz[0];
  stepz = minz_stepz_maxz[1];
  maxz = minz_stepz_maxz[2] + 0.001*stepz;
  minplot = 0.001*stepz;

  pointarrays = [
    for (z = [minz:stepz:maxz])
      [ for (ai = [0:num_circle_steps-1]) let(
            a = ai * ang_step,
            r = AxialFunc1(z, a),
            rchecked = r < minplot ? minplot : r
          )
          [rchecked * cos(a), rchecked * sin(a), z]
      ]
   
  ];

  PlotClosePoints(pointarrays);
}




function isfinite(x) = (!(x!=x)) && (x<(1/0)) && (x>(-1/0));


// This generates a closed polyhedron from an array of arrays of points,
// with each inner array tracing out one loop outlining the polyhedron.
// pointarrays should contain an array of N arrays each of size P outlining a
// closed manifold.  The points must obey the right-hand rule.  For example,
// looking down, the P points in the inner arrays are counter-clockwise in a
// loop, while the N point arrays increase in height.  Points in each inner
// array do not need to be equal height, but they usually should not meet or
// cross the line segments from the adjacent points in the other arrays.
// (N>=2, P>=3)
// Core triangles:
//   [j][i], [j+1][i], [j+1][(i+1)%P]
//   [j][i], [j+1][(i+1)%P], [j][(i+1)%P]
//   Then triangles are formed in a loop with the middle point of the first
//   and last array.
module PlotClosePoints(pointarrays) {
  function recurse_avg(arr, n=0, p=[0,0,0]) = (n>=len(arr)) ? p :
    recurse_avg(arr, n+1, p+(arr[n]-p)/(n+1));

  N = len(pointarrays);
  P = len(pointarrays[0]);
  NP = N*P;
  lastarr = pointarrays[N-1];
  midbot = recurse_avg(pointarrays[0]);
  midtop = recurse_avg(pointarrays[N-1]);

  faces_bot = [
    for (i=[0:P-1])
      [0,i+1,1+(i+1)%len(pointarrays[0])]
  ];

  loop_offset = 1;
  bot_len = loop_offset + P;

  faces_loop = [
    for (j=[0:N-2], i=[0:P-1], t=[0:1])
      [loop_offset, loop_offset, loop_offset] + (t==0 ?
      [j*P+i, (j+1)*P+i, (j+1)*P+(i+1)%P] :
      [j*P+i, (j+1)*P+(i+1)%P, j*P+(i+1)%P])
  ];

  top_offset = loop_offset + NP - P;
  midtop_offset = top_offset + P;

  faces_top = [
    for (i=[0:P-1])
      [midtop_offset,top_offset+(i+1)%P,top_offset+i]
  ];

  points = [
    for (i=[-1:NP])
      (i<0) ? midbot :
      ((i==NP) ? midtop :
      pointarrays[floor(i/P)][i%P])
  ];
  faces = concat(faces_bot, faces_loop, faces_top);

  polyhedron(points=points, faces=faces, convexity=8);
}



//Easter Egg Maker 2016 from Richard Swika'
//Rev: 1.3.28.0 - centered abssin function for more even pieces
//Rev: 1.3.27.0 - first version
//2014-2016 Richard Swika -  Creative Commons - Attribution - Non-Commercial license.

/* [EggOMatic] */
//use 1 for draft; turn up to 5 for best quality but slower regenerate
Quality=1; //[1:5]

//number of pieces cut across long axis of egg
AxleSliceCount=2; //[1:10]

//type of wave used for cutter (does not apply for flat cutter)
Shape="sin"; //[sin,abssin,tri,saw,square]

//type of cutter used on long axis of egg
Cutter="radial"; //[flat,linear,radial]

//Number of cycles for cutter wave
Cycles=3; //[1:16]

//Relative amplitude of cutter wave (normally keep this at 1 or 2, depending on slice count)
Amp=2; //[0:9]

//number of rotary slices (normally keep this at 2; use caution with values greater than 2)
RotarySliceCount=2; //[2:12]

Samples=Quality*10*Cycles;

/* [Size and Shape] */

//Length of the egg (mm)?.
egg_length=60; //[30:200]

//What shape egg? (use 7 for a hen egg; 0 for a sphere; 100 for a blimp)
egg_shape=7; //[0:100]

/* [Hidden] */
// preview[view:top, tilt:top]
tiny=0.001;
space=2; //2 mm between parts on build plate

//set true to turn off the demo egg so you can use the modules instead
moduleMode=false; //[false,true];

//when false the egg will have quads where possible instead of all trigons
//this can lead to problems with non-plannar surfaces when using csg
//so only use it true if when not using a base
allTrigon=true; //[false,true]
ucount=30*Quality;
vcount=15*Quality;

function ud(ui) = ui*360/ucount;
function vd(vi) = vi*180/vcount;

//egg equation adapted from http://www16.ocn.ne.jp/~akiko-y/Egg
//(y^2 + z^2)^2=4z^3 + (4-4c)zy^2
// c=0.7 produces an almost perfect hen egg outline+
// c=0 produces a perfect sphere
// c>1 produces an elongated egg shape
//z ranges from 0 to 1
function egg_outline(c,z)= z >=1 ? 0 : (sqrt(4-4*c-8*z+sqrt(64*c*z+pow(4-4*c,2)))*sqrt(4*z)/sqrt(2))/4;

//map the egg's surface from uv to xyz with these functions
//function x(ui,r) = r * sin(ui*360/(ucount-1));
function x(ui,r) = r * sin(ud(ui));
function y(ui,r) = r * cos(ud(ui));
function z(vi,r) = r * cos(vd(vi));	
function n(vi,r) = r * sin(vd(vi));	
function zi(vi) = (1+cos(vd(vi)))/2;	
center = 0.5; //set to 1 to center at small end; 0 to center on fat end

//to avoid degenerate geometry at the poles we can not use quads 
//so we will generate phantom points as if we were using quads, but use tris instead 
//just to simplify indexing, but will only link faces to a single point at each pole
//but we will use the phantom points to calculate average displacement at each pole
//lets make an egg
points = [ for (vi=[0:vcount]) 
    for (ui = [0 : ucount-1]) 
        let (r=egg_outline(egg_shape/10,1-zi(vi))) 
                    [x(ui,r), y(ui,r),(zi(vi))-center]];
//echo(points=points);
faces =  (allTrigon)     
 ? [ for (vi=[0:vcount-1]) for (ui = [0:ucount-1])  for (p=[0:1])
    (vi==0)&&(p==0) ? [vi*ucount,ui+(vi+1)*ucount,(ui+1) % ucount+(vi+1)*ucount]
    : (vi==vcount-1)&&(p==0) ? [(ui+1) % ucount+vi*ucount,ui+vi*ucount,(vi+1)*ucount]
    : (p==0) ? [(ui+1) % ucount+vi*ucount,ui+vi*ucount,ui+(vi+1)*ucount]
    :[(ui+1) % ucount+vi*ucount,ui+(vi+1)*ucount,(ui+1)%ucount+(vi+1)*ucount]] 
: [ for (vi=[0:vcount-1]) for (ui = [0:ucount-1])  
    (vi==0) ? [vi*ucount,ui+(vi+1)*ucount,(ui+1) % ucount+(vi+1)*ucount]
    : (vi==vcount-1) ? [(ui+1) % ucount+vi*ucount,ui+vi*ucount,(vi+1)*ucount]
    : [(ui+1) % ucount+vi*ucount,ui+vi*ucount,ui+(vi+1)*ucount,(ui+1)%ucount+(vi+1)*ucount]] ;
//echo(faces=faces);

//an adjustable Egg
module Egg(egg_length=egg_length,egg_shape=egg_shape){
     scale (egg_length) rotate([0,0,-90]) polyhedron(points=points,faces=faces);
}    

//2016 "Egg-O-Matic" Code follows
function frac(x)=x-floor(x);
//All "fancy" cuts are done with these wave functions
function wave(kind,x) = kind=="sin" ? sin(x*180) : 
                                      kind=="abssin" ? 2*abs(sin(x*180))-1:
                                      kind=="square" ? (frac(x)<0.5?1:-1): 
                                      kind=="saw" ? (2*frac(x)-1): 
                                      kind=="tri" ? (frac(x)<0.5?-1+frac(x)*4 : 3-frac(x)*4) : x-floor(x);

//Declare a blade to make fancy linear cuts
module linearCutter(Shape="tri",Cycles=1,Amp=1,Samples=100){
    bottom=[for (x=[-1.05:1/Samples:1.05]) [x,1+(Amp+Amp*wave(Shape,x*Cycles))/10]];
    top = [[1.05,-1],[-1.05,-1]];
    color("red")
    rotate([-90,0,0]) 
    translate([0,0,-1])
        linear_extrude(height = 2)
            polygon(points=concat(bottom,top));
}
//Declare a blade to make fancy radial cuts
module radialCutter(Shape="abssin",Cycles=3,Amp=1,Samples=160){
    lowerpoints = concat([[0,0,-1-Amp/10]],
                        [ for (i=[0:1/Samples:1-1/Samples+tiny])[sin(i*360),
                            cos(i*360),-1-(Amp+Amp*wave(Shape,i*2*Cycles))/10]]);
    upperpoints = concat([[0,0,1]],
                        [ for (i=[0:1/Samples:1-1/Samples+tiny])[sin(i*360),cos(i*360),1]]);
   cutterpoints = concat(lowerpoints,upperpoints);
   //echo (cutterpoints);
   lowerfaces = [ for (i=[1:Samples])  [0,i==Samples ? 1 : i+1,i]]; //normals reversed
   upperfaces = [ for (i=[Samples+2:2*Samples+1])  [Samples+1,i,i==Samples*2+1 ? Samples+2 : i+1]];
   endfacesquad= [for (i=[1:Samples-1])  [i,i+1,i+Samples+2,i+Samples+1]];
   cutterfaces = concat(lowerfaces,upperfaces,endfacesquad,[[Samples,1,Samples+2,Samples*2+1]]);    
   //echo("faces:",upperfaces);
    color("red")
    polyhedron(cutterpoints,cutterfaces);
}

//allow the various cutters to be selected 
module multiCutter(Cutter="flat",Shape="sin",Cycles=3,Amp=1,Samples=160){
    if (Cutter=="radial")
       radialCutter(Shape,Cycles,Amp,Samples);
    else if (Cutter=="linear")
       linearCutter(Shape,Cycles,Amp,Samples);
    else //Flat cutter uses a cube
       cube(2,center=true);
}

module subSlice(z,deltaZ,n) //part, cutter
{
    //slice off a section
    translate([0,0,z/10])
    difference(){
        children(0); //Part
        children(1); //Cutter
    }
    //continue slicing up the remainder 
    if (n>1) {
        subSlice(z+deltaZ,deltaZ,n-1) {
            intersection(){//Part advanced one step (section above removed)
                children(0); //Part
                children(1); //Cutter           
            }
        translate([0,0,deltaZ]) children(1); //Advanced cutter one step
        }
    }
}

//declare an operator to recursively slice a part into N sections
//it operates on two children, the part to be sliced and the cutter
//the part and cutter must be at the origin
//the cutter must be positioned surrounding the part with the cutting edge on
//the negative Z axis not touching the part
//Scale is 1 for a bounding box of radius 1
module sliceOmatic(N=1,Scale=1,Amp=1) //part cutter
{
   deltaZ= (Cutter=="flat") ? Scale*2/N : Scale*(2+Amp/5)/N;
   subSlice(0,deltaZ,N) {
       children(0); //Part(s)
       translate([0,0,deltaZ]) children(1); //Advance cutter one step
   }
}

//rotary-slice a section from the part from A0 to A1 and align it for printing
module rotarySlice(A0=90,A1=120,Scale=1) //part
{
    rotate([0,0,-A0])
    intersection(){
        children();
        difference() {
            rotate([0,0,A0]) translate([0,Scale,0]) cube(2*Scale,center=true);
            rotate([0,0,A1]) translate([0,Scale,0]) cube(2*Scale,center=true);
        }
    }
}
//slice the part into N sections by rotating a straight cutter about the Z axis
module rotarySlicer(N=2,Scale=1) //part
{
    //figure out where to place the first section and the spacing between them
    spacefactor = N==2 ? 2 : 1.5; //pack sections without overlapping
    spacedelta=spacefactor*(space+Scale*egg_outline(egg_shape/10,0.5));
    spaceoffset = -spacedelta*((N/2)-1/2);
    if (N<2) children();
        else {
            delta=360/N;
            for (n=[0:N-1]) {
                translate([spaceoffset+spacedelta*n ,0,0]) rotarySlice(n*delta,(n+1)*delta,Scale) children();
            }
        }  
}

//this generates the main object
if (!moduleMode) {
     rotate([90,0,0]) //flat on build plate
      rotarySlicer(RotarySliceCount,Scale=egg_length)
         sliceOmatic(AxleSliceCount,egg_length/2,Amp) 
    {
                   Egg();
//                   translate([egg_length/2,0,0])
                        scale(egg_length/2) multiCutter(Cutter,Shape,Cycles,Amp,Samples);
    }
 }




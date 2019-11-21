
// A slice through a bolt has the shape of a shallow heart.
// If we look at it radially from zero to 180 degrees 
// it increases linearly from the minor to the major radius.
//     At zero degrees it will have the radius of the minor radius of the threads
//       at 90 degrees it will be at the pitch radius 
// then at 180 degrees it will be at the major radius. 
// It's the same on the other side of the heart just mirrored across the X axis.

// This shape is made in module MaleThread using a polygon 
// with a point on the X axis at radius [MinorTR+j/180*TH,0]]
// this simple equation just progresses from the minor radius 
// to the major radius as j (the angle) goes from 0 to 180
// Then this polygon is rotated j degrees to the proper position on the heart.
// This is hulled and then mirrored to the create the other half of the heart.

// some thread specs
// http://www.amesweb.info/Screws/AsmeUnifiedInchScrewThread.aspx
// http://www.amesweb.info/Screws/MetricTrapezoidalScrewThreads.aspx
// http://www.amesweb.info/Screws/NPT_National_Taper_Pipe_Threads.aspx

$fn=360;                   // resolution  try 90 to 360 

// ==================================================================  .5 inch NPT Pipe/Plug  
THeight=14;                   // total threaded portion, length
TPitch=25.4/14;              // distance between successive threads 25.4mm/inch  14 TPI  
PitchR=9.632;               // Pitch RADIUS not diameter   beginning pitch radius 9.632
TScale=1+THeight/256;      // NPT pipe taper 16*16=256    expands as it goes up at 1/16 slope

MaleThread(THeight,TPitch,PitchR,TScale);
translate([0,0,THeight]) cylinder(h=6,r=10.668,$fn=4);        // put some pipe here or a square to grab


// ======================================  .5 inch bolt  13TPI 
translate([20,20,0]) MaleThread(20,25.4/13,.222*25.4,1);    //TScale is 1 no change in bolt diameter 
translate([20,20,0]) cylinder(h=8,r=10.8,$fn=6);           // a bolt head


// =========================================  big threads so you can see the heart
translate([-20,20,0]) MaleThread(20,20,5,.5);   // just for looks


module MaleThread(THeight,TPitch,PitchR,TScale)  // make some male threads ====================================
{
TH=sin(60)*TPitch;           // Triangle Height for 60 deg threads, sharp creast top to bottom of triangle sin(60)=.866
MinorTR=PitchR-TH/2;        // Minor Triangle Radius, smallest radius of sharp threads MajorTR-TH       
MajorTR=PitchR+TH/2;       // Major Triangle Radius, largest radius of sharp threads MinorTR+TH  TH=height of sharp V threads
echo(TPitch, TH, MinorTR, PitchR, MajorTR);    
    
linear_extrude(height=THeight, twist=-360*THeight/TPitch, scale=TScale, slices=$fn){       
mirror([0,1,0])  { hull() {for (j=[0:180/$fn:180]) { rotate(j) polygon(points=[[0,0],[0,.002],[MinorTR+j/180*TH,0]]); }}}   // the mirror
                   hull() {for (j=[0:180/$fn:180]) { rotate(j) polygon(points=[[0,0],[0,.002],[MinorTR+j/180*TH,0]]); }}   // the first half
}}



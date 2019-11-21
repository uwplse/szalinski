DrumSize = [100,50];
WallThick = 1.6;
finCnt = 8;
lidTol = 0.2;
$fn=60;

//Body of drum
module Drum(){
    difference(){
        cylinder(h=DrumSize[0],r=DrumSize[1],center=true);
        translate([0,0,WallThick])cylinder(h=DrumSize[0],r=DrumSize[1]-(WallThick),center=true);
}}

module fin(){
    union(){
        for (i = [0:finCnt-1]) {
            translate([sin(360*i/finCnt)*(DrumSize[1]-WallThick)*.95, cos(360*i/finCnt)*(DrumSize[1]-WallThick)*.95, 0 ])
            rotate([0,0,-(360/finCnt)*i])cube([DrumSize[1]*.05,DrumSize[1]*.1,DrumSize[0]],center=true);
}}}

module lid(){
    difference(){
        cylinder(h=(DrumSize[0]*.1)+WallThick,r=DrumSize[1]+(WallThick+lidTol),center=true);
        translate([0,0,WallThick])cylinder(h=(DrumSize[0]*.1)+WallThick,r=DrumSize[1]+lidTol,center=true);
}}
module CompDrum(){
    union(){
        Drum();
        fin();
    }
}
render(convexity=20){
    CompDrum();
    translate([DrumSize[0]+20,0,0])lid();
}
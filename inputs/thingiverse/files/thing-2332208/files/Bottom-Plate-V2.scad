//$fn=50;
L = 100; //Length of the plate, original = 100
W = 75; //Width of the plate, original = 75
H = 5.5; //Total Height, original = 5.5
wt = 2; //Wall thickness, original = 2

module base_outer(){
    translate([0,0,H/4]){
        minkowski(){
            cube([W-2*10,L-2*10,H/2],center=true);//75mmx105mm
            cylinder(r=10, h=H/2);
        }
    }
}
module base_inner(){
    translate([0,0,H/4+1.5]){
        minkowski(){
            cube([W-2*wt-2*8,L-2*wt-2*8,H/2],center=true);
            cylinder(r=8, h=H/2);
        }
    }
}
module baseplate(){ //Subtract inner from outer base
difference(){
    base_outer();
    base_inner();
}
}
module track_outer(){  
translate([0,0,1.5]){
union(){
cube([34.25+12,11.5,2]);
translate([0,11.5/2,0]){
    cylinder(r=11.5/2,h=2);
}
translate([34.25+12,11.5/2,0]){
    cylinder(r=11.5/2,h=2);
}
}
}
}
module track_inner(){  
translate([0,1.5,1.5]){
union(){
cube([34.25+12,8.5,2.5]);
translate([0,8.5/2,0]){
    cylinder(r=8.5/2,h=2.5);
}
translate([34.25+12,8.5/2,0]){
    cylinder(r=8.5/2,h=2.5);
}
}
}
}
module track(x,y){  //Subtract inner from outer track
    translate([x,y,0]){
difference(){
track_outer();
track_inner();
}
}
}
module tracks(){    //Combine 7 tracks
    
    union(){
    track(0,0);
    track(0,11.5-1.5);
    track(0,11.5*2-1.5*2);
    track(0,11.5*3-1.5*3);
    track(0,11.5*4-1.5*4);
    track(0,11.5*5-1.5*5);
    track(0,11.5*6-1.5*6);
    }
}
module track_sub(){ //Open left end of all tracks
    translate([-8.5,0,0]){
    cube([8.5,75,5]);
}
}
module tracks_final(x,y){ //Position all tracks
    translate([x,y,0]){
        difference(){
        tracks();
        track_sub();
    }
}
}
module base_tracks(){   //Combine tracks to baseplate
    union(){
        baseplate();
        tracks_final(W/2-46.25-13,-L/2+6.5);
    }
}

module tab(angle){  //Create triangular tabs    
rotate(a=angle, v=[0,0,1]){
rotate(a=-90, v=[0,1,0]){
rotate(a=90, v=[1,0,0]){
 linear_extrude(height = 10.5, center = true, convexity = 10, twist = 0, slices = 100, scale = 1.0) {
 polygon(points=[[0,0],[1.75/2,1.5],[1.75,0]]);
 }
 }
 }
 }
 }
module tabs(){      //Position all tabs
     
 translate([-W/2+wt,0,H-2.2]){
 tab(0);
 }
 
translate([W/2-wt,0,H-2.2]){
    tab(180);
}
translate([0,-L/2+wt+0.06,H-2.2]){
    tab(90);
}

translate([0,L/2-wt-0.06,H-2.2]){
    tab(270);
}
}
module final(){     //Subtract tabs from baseplate
difference(){
base_tracks();
tabs();
}
}
final();
    
    
    
    
    
    
    
    
    
    
    

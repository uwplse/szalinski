////////////////////////////////////
////////////Visitenharry/////////
///////////////////////////////////


/////Visitenkarte/////


T=15/1;

W=1.6/1;
WB=1.6/1; //Wand Bogen

Lange=85.5/1;
L=Lange+2*W;

Breite=55.5/1;
B=Breite+2*W;

T=15/1;


Text1=" Your Name & bla";
Text2="3dk.berlin";

difference(){

union(){
difference(){
cube([T,B,L],center=true);
translate([0,0,2*W])
cube([T+W,B-2*W,L], center=true);
}


union(){
intersection() {
    translate([0,0,2*W+0.2])
cube([T,B-2*W,L], center=true);
//union(){    
translate([B+2*W+0.2,0,-L/4]){
difference(){
    cylinder(L,B+2*W,B+2*W,center=true);
    cylinder(L+W,B-WB+2*W,B-WB+2*W,center=true);
}
}
}
intersection() {
    translate([0,0,2*W+0.2])
cube([T,B-2*W,L], center=true);
    
difference(){
difference() {
union(){
    translate([B+2*W+0.2,0,L/4])
sphere(B+2*W);
translate([T/2,0,L/4])
cube( [WB,B,B],center=true);
}    
translate([B+2*W+0.2,0,L/4])
    sphere(B+2*W-WB);
}
translate([0,0,L/4-B/2])
cube([B,B,B],center=true);
}
}

}


rotate(a=180,v=[0,0,1])
union(){
intersection() {
    translate([0,0,2*W+0.2])
cube([T,B-2*W,L], center=true);
//union(){    
translate([B+2*W+0.2,0,-L/4]){
difference(){
    cylinder(L,B+2*W,B+2*W,center=true);
    cylinder(L+W,B-WB+2*W,B-WB+2*W,center=true);
}
}
}
intersection() {
    translate([0,0,2*W+0.2])
cube([T,B-2*W,L], center=true);
    
difference(){
difference() {
union(){
    translate([B+2*W+0.2,0,L/4])
sphere(B+2*W);
translate([T/2,0,L/4])
cube( [WB,B,B],center=true);
}    
translate([B+2*W+0.2,0,L/4])
    sphere(B+2*W-WB);
}
translate([0,0,L/4-B/2])
cube([B,B,B],center=true);
}
}

}
rotate(a=90, v=[0,1,0])
rotate(a=90, v=[1,0,0])
translate([-L/2+2,-T/2+4,B/2])
linear_extrude(0,0,0.5) 
text(Text1, size=T-7.5);

rotate(a=90, v=[0,1,0])
rotate(a=-90, v=[1,0,0])
rotate(a=180, v=[0,0,1])
translate([-L/2+2,-T/2+4,B/2])

linear_extrude(0,0,0.5) 
text(Text2, size=T-7.5);

}
translate([0,0,L/2])
rotate(a=90,v=[0,1,0])
cylinder(20,8,8, center=true);

translate([0,0,L/2+B/2])
cube([B,B,B],center=true);
  // rotate(a=90,v=[0,1,0])
  //  translate([-T/2+5,0,10])
//rotate(a=45,v=[1,0,0])


 //cube([5,8,8],center=true);


//translate([-T/2+5,0,-12])
//rotate(a=45,v=[1,0,0])

 //cube([5,8,8],center=true);
//translate([-T/2+5,0,-1])
//cube([5,11,22],center=true);
}

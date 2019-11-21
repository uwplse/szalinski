Xsize=5;
Ysize=5;
Open=0;//[-1:0.01:1]
/*[hidden]*/

for(y=[1:Ysize]){
for(x=[1:Xsize]){
translate([x*100,y*100,0])make(x,y);
}}



module make(x,y){

W=[y==1?true:false,x==Xsize?true:false,y==Ysize?true:false,x==1?true:false];
G=[dice(),dice(),dice(),dice()];
I=[dice(),dice(),dice(),dice()];





 
color(rndc()) piece(W,G,I);
 
}
 


module piece(W,G,I){
rotate([0,0,0]) quart(G[0],I[0],W[1],W[2]);
rotate([0,0,90]) quart(G[1 ],I[1],W[2],W[3]);
rotate([0,0,180]) quart(G[2],I[2],W[3],W[0]);
rotate([0,0,270]) quart(G[3],I[3],W[0],W[1]);
cylinder(45,5,5);
translate([0,0,44])sphere(6,center=true);
if(W[0]==true){
rotate([0,0,-90])
translate([41.5,-47.225,0])cube([5,89.5,45]);
}
if(W[1]==true){
rotate([0,0,0])
translate([41.5,-47.225 ,0])cube([5,89.5,45]);
}
if(W[2]==true){
rotate([0,0,90])
translate([41.5,-47.225,0])cube([5,89.5,45]);
}
if(W[3]==true){
rotate([0,0,180])
translate([41.5,-47.225,0])cube([5,89.5,45]);
}
if(W[0]==true&&W[1]==true){
rotate([0,0,0])
{
translate([40,-40,0])translate([4,-4,0]){cylinder(51,5,5);
translate([0,0,51])sphere(7,center=true);}
}}
if(W[1]==true&&W[2]==true){
rotate([0,0,90])
{
translate([40,-40,0])translate([4,-4,0]){cylinder(51,5,5);
translate([0,0,51])sphere(7,center=true);}
}}
if(W[2]==true&&W[3]==true){
rotate([0,0,180])
{
translate([40,-40,0])translate([4,-4,0]){cylinder(51,5,5);
translate([0,0,51])sphere(7,center=true);}
}}
if(W[3]==true&&W[0]==true){
rotate([0,0,270])
{
translate([40,-40,0])translate([4,-4,0]){cylinder(51,5,5);
translate([0,0,51])sphere(7,center=true);}
}}

}


module quart(g,i,w,w2){
$fn=15;
translate([22.5,22.5]){
linear_extrude(5, convexity = 5){
offset(r=1.9)offset(r=-6)offset(r=4){ difference(){
translate([1,-1.25,-0])square([42.5,42],center=true);
if(w2==false){rotate([0,0,90])translate([15,0,0]) circle(5);}

}translate([-1,-22.5,-0])square([42.5,5],center=true);

if(w==false){hull(){
translate([30,0,0]) circle(4.65);
*translate([20,0,0]) circle(1);}}
}}
translate([-0.25,0.25,0]){

if(w==false){
if(g==false){intersection(){
linear_extrude(50, convexity = 5){
polygon([[20,-20],[20,19.5],[22.5,22],[25,19.5],[25,-20],[22.5,-22.5]]); }
 union() {
translate([10,-25,0])cube([25+20,25+25,25+5]);
translate([25,0,25+5])scale([1,1.5,1])rotate([0,90,0])cylinder(30,12.5+3,12.5+3,center=true,$fn=40);}
}}
else {difference(){

intersection(){linear_extrude(50, convexity = 5){
polygon([[20,-20],[20,19.5],[22.5,22],[25,19.5],[25,-20],[22.5,-22.5]]); }
 union() {
translate([10,-25,0])cube([25+20,25+25,25+5]);
translate([25,0,25+5])scale([1,1.5,1])rotate([0,90,0])cylinder(30,12.5+3,12.5+3,center=true,$fn=40);}}

union() {
translate([10,-12.5,5])cube([25,25,25]);
translate([25,0,25])rotate([0,90,0])cylinder(30,12.5,12.5,center=true);
}
}}}


if(i==false){
intersection(){
linear_extrude(50, convexity = 5)rotate([0,0,-90])
polygon([[20,-20],[20,20],[22.5,22.5],[25,20],[25,-20],[22.5,-22.5]]); union() {
 translate([-25,-30,0])cube([50,25,35]);
translate([0,-25,25+5])scale([1.5,1,1])rotate([90,0,0])cylinder(30,12.5+3,12.5+3,center=true,$fn=40);}

}}
else {difference(){

intersection(){
linear_extrude(50, convexity = 5)rotate([0,0,-90])
polygon([[20,-20],[20,20],[22.5,22.5],[25,20],[25,-20],[22.5,-22.5]]); union() {
 translate([-25,-30,0])cube([50,25,35]);
translate([0,-25,25+5])scale([1.5,1,1])rotate([90,0,0])cylinder(30,12.5+3,12.5+3,center=true,$fn=40);}

}
rotate([0,0,-90])union(){
translate([10,-12.5,5])cube([25,25,25]);
translate([25,0,25])rotate([0,90,0])cylinder(30,12.5,12.5,center=true);}
}}
}}}
function rnd(a = 0, b = 1) = (rands(min(a, b), max(a, b), 1)[0]);
function dice()=round (rnd(2+Open))==1?false:true;
function rndc() = [rands(0, 1, 1)[0], rands(0, 1, 1)[0], rands(0, 1, 1)[0]];
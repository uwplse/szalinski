insideRadius=8;
outsideRadius=10;
lengthOfArm=50;

// number of sides
shape=30; //[3:Triangle, 4:Square, 5:Pentagon, 6:Hexagon, 8:Octogon, 30:Circle]
$fn=shape;


x1angle=90;
x2angle=0;
x3angle=0;
x4angle=0;
x5angle=0;
x6angle=0;
x7angle=0;
x8angle=0;
x9angle=0;
x10angle=0;

y1angle=90;
y2angle=45;
y3angle=0;
y4angle=0;
y5angle=0;
y6angle=0;
y7angle=0;
y8angle=0;
y9angle=0;
y10angle=0;

z1angle=0;
z2angle=90;
z3angle=0;
z4angle=0;
z5angle=0;
z6angle=0;
z7angle=0;
x8angle=0;
z9angle=0;
z10angle=0;



// x arm tests

if (x1angle>0){
 rotate([x1angle,0,0])
arm();}

if (x2angle>0){
 rotate([x2angle,0,0])
arm();}

if (x3angle>0){
 rotate([x3angle,0,0])
arm();}

if (x4angle>0){
 rotate([x4angle,0,0])
arm();}

if (x5angle>0){
 rotate([x5angle,0,0])
arm();}

if (x6angle>0){
 rotate([x6angle,0,0])
arm();}

if (x7angle>0){
 rotate([x7angle,0,0])
arm();}

if (x8angle>0){
 rotate([x8angle,0,0])
arm();}

if (x9angle>0){
 rotate([x9angle,0,0])
arm();}

if (x10angle>0){
 rotate([x10angle,0,0])
arm();}

// y arm tests

if (y1angle>0){
 rotate([0,y1angle,0])
arm();}

if (y2angle>0){
 rotate([0,y2angle,0])
arm();}

if (y3angle>0){
 rotate([0,y3angle,0])
arm();}

if (y4angle>0){
 rotate([0,y4angle,0])
arm();}

if (y5angle>0){
 rotate([0,y5angle,0])
arm();}

if (y6angle>0){
 rotate([0,y6angle,0])
arm();}

if (y7angle>0){
 rotate([0,y7angle,0])
arm();}

if (y8angle>0){
 rotate([0,y8angle,0])
arm();}

if (y9angle>0){
 rotate([0,y9angle,0])
arm();}

if (y10angle>0){
 rotate([0,y10angle,0])
arm();}

//z arm tests

if (z1angle>0){
 rotate([0,0,z1angle])
arm();}

if (z2angle>0){
 rotate([0,0,z2angle])
arm();}

if (z3angle>0){
 rotate([0,0,z3angle])
arm();}

if (z4angle>0){
 rotate([0,0,z4angle])
arm();}

if (z5angle>0){
 rotate([0,0,z5angle])
arm();}

if (z6angle>0){
 rotate([0,0,z6angle])
arm();}

if (z7angle>0){
 rotate([0,0,z7angle])
arm();}

if (z8angle>0){
 rotate([0,0,z8angle])
arm();}

if (z9angle>0){
 rotate([0,0,z9angle])
arm();}

if (z10angle>0){
 rotate([0,0,z10angle])
arm();}

//call heel
heel();

module arm(){

difference(){
cylinder (lengthOfArm,outsideRadius,outsideRadius);
cylinder (lengthOfArm+1,insideRadius,insideRadius);}

}
//end module

module heel(){
sphere(outsideRadius);
$fn=50;}//end module



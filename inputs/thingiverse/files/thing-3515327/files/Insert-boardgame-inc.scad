//number of division, the total length is the sum of all n division
n=3 ;//[1:1,2:2,3:3,4:4,5:5,6:6,7:7]
// Width
L=48;
//Height
H=45;
// Space between division wall
e=10; 
// Length of the 1st division
x1=50;
// Length of the 2nd division
x2=40;
// Length of the 3rd division
x3=60;
// Length of the 4th division
x4=30;
// Length of the 5th division
x5=50;
// Length of the 6th division
x6=10;
// Length of the 7th division
x7=25;

if (n==1)
{
   total=x1; 
difference() {
    cube([total,L,H]);
}
}
if (n==2)
{
   total=x1+x2; 
difference() {
    cube([total,L,H]);
    
    translate([x1,0,1]) {
    cube([1.5,(L-e)/2,H]);
    }
    translate([x1,(L+e)/2,1]) {
    cube([1.5,(L-e)/2,H]);
    }
}
}
if (n==3)
{
   total=x1+x2+x3; 
difference() {
    cube([total,L,H]);
    
    translate([x1,0,1]) {
    cube([1.5,(L-e)/2,H]);
    }
    translate([x1,(L+e)/2,1]) {
    cube([1.5,(L-e)/2,H]);
    }
    translate([x1+x2,0,1]) {
    cube([1.5,(L-e)/2,H]);
    }
    translate([x1+x2,(L+e)/2,1]) {
    cube([1.5,(L-e)/2,H]);
    }
}}  
 if (n==4)
{
   total=x1+x2+x3+x4; 
difference() {
    cube([total,L,H]);
    
    translate([x1,0,1]) {
    cube([1.5,(L-e)/2,H]);
    }
    translate([x1,(L+e)/2,1]) {
    cube([1.5,(L-e)/2,H]);
    }
    translate([x1+x2,0,1]) {
    cube([1.5,(L-e)/2,H]);
    }
    translate([x1+x2,(L+e)/2,1]) {
    cube([1.5,(L-e)/2,H]);
    }
    translate([x1+x2+x3,0,1]) {
    cube([1.5,(L-e)/2,H]);
    }
    translate([x1+x2+x3,(L+e)/2,1]) {
    cube([1.5,(L-e)/2,H]);
    }
}}   
 if (n==5)
{
   total=x1+x2+x3+x4+x5; 
difference() {
    cube([total,L,H]);
    
    translate([x1,0,1]) {
    cube([1.5,(L-e)/2,H]);
    }
    translate([x1,(L+e)/2,1]) {
    cube([1.5,(L-e)/2,H]);
    }
    translate([x1+x2,0,1]) {
    cube([1.5,(L-e)/2,H]);
    }
    translate([x1+x2,(L+e)/2,1]) {
    cube([1.5,(L-e)/2,H]);
    }
    translate([x1+x2+x3,0,1]) {
    cube([1.5,(L-e)/2,H]);
    }
    translate([x1+x2+x3,(L+e)/2,1]) {
    cube([1.5,(L-e)/2,H]);
    }
    translate([x1+x2+x3+x4,0,1]) {
    cube([1.5,(L-e)/2,H]);
    }
    translate([x1+x2+x3+x4,(L+e)/2,1]) {
    cube([1.5,(L-e)/2,H]);
    }
}}       
 if (n==6)
{
   total=x1+x2+x3+x4+x5+x6; 
difference() {
    cube([total,L,H]);
    
    translate([x1,0,1]) {
    cube([1.5,(L-e)/2,H]);
    }
    translate([x1,(L+e)/2,1]) {
    cube([1.5,(L-e)/2,H]);
    }
    translate([x1+x2,0,1]) {
    cube([1.5,(L-e)/2,H]);
    }
    translate([x1+x2,(L+e)/2,1]) {
    cube([1.5,(L-e)/2,H]);
    }
    translate([x1+x2+x3,0,1]) {
    cube([1.5,(L-e)/2,H]);
    }
    translate([x1+x2+x3,(L+e)/2,1]) {
    cube([1.5,(L-e)/2,H]);
    }
    translate([x1+x2+x3+x4,0,1]) {
    cube([1.5,(L-e)/2,H]);
    }
    translate([x1+x2+x3+x4,(L+e)/2,1]) {
    cube([1.5,(L-e)/2,H]);
    }
    translate([x1+x2+x3+x4+x5,0,1]) {
    cube([1.5,(L-e)/2,H]);
    }
    translate([x1+x2+x3+x4+x5,(L+e)/2,1]) {
    cube([1.5,(L-e)/2,H]);
    }
}}
 if (n==7)
{
   total=x1+x2+x3+x4+x5+x6+x7; 
difference() {
    cube([total,L,H]);
    
    translate([x1,0,1]) {
    cube([1.5,(L-e)/2,H]);
    }
    translate([x1,(L+e)/2,1]) {
    cube([1.5,(L-e)/2,H]);
    }
    translate([x1+x2,0,1]) {
    cube([1.5,(L-e)/2,H]);
    }
    translate([x1+x2,(L+e)/2,1]) {
    cube([1.5,(L-e)/2,H]);
    }
    translate([x1+x2+x3,0,1]) {
    cube([1.5,(L-e)/2,H]);
    }
    translate([x1+x2+x3,(L+e)/2,1]) {
    cube([1.5,(L-e)/2,H]);
    }
    translate([x1+x2+x3+x4,0,1]) {
    cube([1.5,(L-e)/2,H]);
    }
    translate([x1+x2+x3+x4,(L+e)/2,1]) {
    cube([1.5,(L-e)/2,H]);
    }
    translate([x1+x2+x3+x4+x5,0,1]) {
    cube([1.5,(L-e)/2,H]);
    }
    translate([x1+x2+x3+x4+x5,(L+e)/2,1]) {
    cube([1.5,(L-e)/2,H]);
    }
    translate([x1+x2+x3+x4+x5+x6,0,1]) {
    cube([1.5,(L-e)/2,H]);
    }
    translate([x1+x2+x3+x4+x5+x6,(L+e)/2,1]) {
    cube([1.5,(L-e)/2,H]);
    }
}}          


//Towers of Hanoi Puzzle

//By: Matt from 

//More info here
//https://en.wikipedia.org/wiki/Tower_of_Hanoi

//Number of disks
N= 6;

//Thickness of disks and half thickness of base
t= .375;

//Clearance amount (I use my nozzle diameter here)
tol = .4/25.4;

//Disk hole diameter
d= .375 + (2*tol);

//****** CHANGE FOR ROD DIAMETER AND AUTOMATICALLY ADD THE TOLERANCES ********
dbase = .375 + tol;

Eng=exp(ln(2)*N)-1;
echo(Eng);

DN= 2;
D0= 1;

Step=(DN-D0)/(N-1);

echo(Step);

Even=0;
Odd=DN + .25;

translate([0,DN/2,t/2]){
for(i=[2:N-1])
    if(i%2==0){
        translate([Even,(Odd) + ((i-2)*(Odd/2)),0]){
            difference(){
                cylinder(t,(D0+(Step*(i-1)))/2,(D0+(Step*(i-1)))/2,center = true,$fn=100);
                cylinder(2*t,d/2,d/2,center = true,$fn=100);
    }}}
    else{
        translate([Odd,(Odd) + (((i-2)-1)*(Odd/2)),0]){
            difference(){
                cylinder(t,(D0+(Step*(i-1)))/2,(D0+(Step*(i-1)))/2,center = true,$fn=100);
                cylinder(2*t,d/2,d/2,center = true,$fn=100);
    }}}

translate([Odd,0,0]){
difference(){
    cylinder(t,D0/2,D0/2,center = true,$fn=100);
    cylinder(2*t,d/2,d/2,center = true,$fn=100);
    }}

 
difference(){
    cylinder(t,DN/2,DN/2,center = true,$fn=100);
    cylinder(2*t,d/2,d/2,center = true,$fn=100);
    }}

translate([-Odd*1.25,((3*DN)+1)/2,t]){
    difference(){
        cube([DN+.5,(3*DN)+1,2*t],center=true);
rotate([0,0,90]){
    translate([0,-(DN/2)+.25,t-.0625]){
        linear_extrude(.125,center=true){
text(str(Eng), font = "Liberation Sans", size = .75,halign="center",valign="center");
}}}
cylinder(2*t,dbase/2,dbase/2,center=true,$fn=1000);
translate([0,DN+.25,0]){
    cylinder(2*t,dbase/2,dbase/2,center=true,$fn=1000);
}
translate([0,-(DN+.25),0]){
    cylinder(2*t,dbase/2,dbase/2,center=true,$fn=1000);
}
}
}
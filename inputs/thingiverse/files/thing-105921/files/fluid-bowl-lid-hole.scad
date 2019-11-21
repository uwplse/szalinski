//This script makes a lid with an injection hole for a half sphere depression in a cube - to be used for reactionware testing
// volume sphere is 4/3*pi*r^3 so volume of half sphere=(3*x/(4*3.14))^(1/3)
// area is 4*pi*r^2
//fluid in mL , 1mL=1000mm^3

//Defines the mL of fluid
x=10; 

//Defines the injection hole diameter
i=1;

a=10*pow(3/4*x/3.14, 0.3333);

module reactor()
{
difference (){
#translate([-a-1,-a-1,-1])cube([2*a+2,2*a+2,a+2]);
sphere(r=a, $fn=100);
}
}

module revreactor(){
rotate([0,180,00])reactor();
}


module lid(){ //simple square lid
difference(){
#translate([-a-2,-a-2,0])cube([2*a+4,2*a+4,4]);
revreactor();
}
}

module lidhole(){
difference(){
lid();
cylinder(a,i,i, center=true, $f=100);
}}

rotate([180,0,0])translate([0,0,-a/4-1])lidhole();

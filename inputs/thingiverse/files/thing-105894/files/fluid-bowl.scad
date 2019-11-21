//This script puts a half sphere depression in a cube - to be used for reactionware testing
// volume sphere is 4/3*pi*r^3 so volume of half sphere=(3*x/(4*3.14))^(1/3)
// area is 4*pi*r^2
//fluid in mL , 1mL=1000mm^3

//Defines the mL of fluid
x=10; 


a=10*pow(3/4*x/3.14, 0.3333);

module reactor()
{
difference (){
#translate([-a-1,-a-1,-1])cube([2*a+2,2*a+2,a+2]);
sphere(r=a, $fn=100);
}
}

rotate([180,0,0])translate([0,0,-a-1]) reactor(); //place on platform to print

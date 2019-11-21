//smaller width of the stick in mm
width_a=18;
//larger width of the stick in mm
width_b=28;
//height you want your handle (height of your hand)
height=100;

////calculations////
width_c=(width_a/2)-2;
diameter=sqrt(pow(width_a,2)+pow(width_b,2));

module base(){
union(){
cylinder(d=diameter+10,h=4);
cylinder(d=diameter+6,h=height);
}}

difference(){
base();
cylinder(d=diameter,h=height);
translate([-width_c,diameter/2-3,0])cube([width_a-4,width_a-4,height]);
}


//to see how it fits on your stick un comment the following code
//cube([width_a,width_b,height],center=true);
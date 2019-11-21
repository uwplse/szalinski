
//height ring
h1=1.6;  
//height protector
h2=30;   
//inner diameter ring
d1=17.7; 
//outer diameter ring
d2=23.4;
//thickness cylinder
x=1.4;  
//gradient of conus (upper side is slightly wider)
c=1.0; 
//x-dimension of nipple
a=4.0;   
//y-dimension of nipple
b=3.3; 


// Ring
difference() {
	cylinder(h1,d2/2,d2/2, $fn=60 );
	rotate ([0,0,0]) cylinder(h1,d1/2,d1/2,$fn=60 );
}
//Nipple
translate([d1/2-a,-b/2,0])  cube([a,b,h1]);   //change x-transformation  for left/right

//protector-cylinder
difference() {
	cylinder(h2,d2/2,d2/2+c, $fn=60 );
	rotate ([0,0,0]) cylinder(h2,d2/2-x,d2/2+c-x/2, $fn=60 );
    translate([-50,+3,0])  cube([100,100,100]);
}

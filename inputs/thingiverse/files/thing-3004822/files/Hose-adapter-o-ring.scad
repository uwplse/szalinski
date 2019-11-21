
// Length
h1=50; // [10:500]
h2=50; // [10:500]  
// Length cone
cone_length=10; // [1:200] 
//Radius
r1=19; 
r2=16;  
//wall thickness
th=3; 
//ring radius
ring=1.5; //[0.2:0.1:10]

//distance of the ring from end
dt=30; //[0:1:250]

/* [Hidden]*/

$fn=360;



difference(){
union(){
	translate([0,0,0])      cylinder(h=h1,r1=r1,r2=r1);
        translate([0,0,h1])	cylinder(h=cone_length,r1=r1,r2=r2);
	translate([0,0,h1+cone_length])	cylinder(h=h2,r1=r2,r2=r2);
        
        


	
}
//lower rings
	translate([0,0,dt]) rotate_extrude(convexity = 10)
        translate([r1, 0, 0])
        circle(r = ring);

	

//upper rings
	translate([0,0,h1+cone_length+h2-dt]) rotate_extrude(convexity = 10)
        translate([r2, 0, 0])
        circle(r = ring);

	translate([0,0,0])      cylinder(h=h1,r1=r1-th,r2=r1-th);
        translate([0,0,h1])	cylinder(h=cone_length,r1=r1-th,r2=r2-th);
	translate([0,0,h1+cone_length])	cylinder(h=h2,r1=r2-th,r2=r2-th);
 
}



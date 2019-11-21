
// Length
h1=40; // [10:500]
h2=40; // [10:500]  
// Length cone
cone_length=10; // [1:200] 
//Radius
r1=19; 
r2=16;  
//wall thickness
th=3; 
//teeth heigth
teeth=1.5; //[0.2:0.1:10]
//wide of the teeths
wt=5; //[0.2:0.1:10]
//distance of the teeths
dt=6; //[0.3:0.1:11]

/* [Hidden]*/

$fn=360;



difference(){
union(){
	translate([0,0,0])      cylinder(h=h1,r1=r1,r2=r1);
        translate([0,0,h1])	cylinder(h=cone_length,r1=r1,r2=r2);
	translate([0,0,h1+cone_length])	cylinder(h=h2,r1=r2,r2=r2);
        
        

//lower rings
	translate([0,0,dt]) cylinder(h=wt,r1=r1,r2=r1+teeth);
	translate([0,0,2*dt]) cylinder(h=wt,r1=r1,r2=r1+teeth);
	translate([0,0,3*dt]) cylinder(h=wt,r1=r1,r2=r1+teeth);
//upper rings
	translate([0,0,h1+cone_length+h2-wt-dt]) cylinder(h=wt,r1=r2+teeth,r2=r2);
	translate([0,0,h1+cone_length+h2-wt-2*dt]) cylinder(h=wt,r1=r2+teeth,r2=r2);
	translate([0,0,h1+cone_length+h2-wt-3*dt]) cylinder(h=wt,r1=r2+teeth,r2=r2);
}
	translate([0,0,0])      cylinder(h=h1,r1=r1-th,r2=r1-th);
        translate([0,0,h1])	cylinder(h=cone_length,r1=r1-th,r2=r2-th);
	translate([0,0,h1+cone_length])	cylinder(h=h2,r1=r2-th,r2=r2-th);
 
}



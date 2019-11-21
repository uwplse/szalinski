$fn=100;
l1 = 415;
l2 = 495;
screwSpan = 283;

screwD = 4.5;
wall=2;
h1=10;
h2=18;
w1=19.7;
w2=36;
r1=2;


difference(){
	union(){
		//front
		translate([(l2-l1)/2,0,0]) cubeRounded([l1,wall,h1],r=wall/2);
		//bottom
		translate([(l2-l1)/2,0,0]) cubeRounded([l1,w2,wall],r=wall/2);
		translate([0,w2-w1,0]) cubeRounded([l2,w1,wall],r=wall/2);
		//back
		translate([0,w2-wall,0]) cubeRounded([l2,wall,h2],r=wall/2);
	}
	//screws
	translate([l2/2-screwSpan/2,w2,h2/2]) rotate([90,0,0]) cylinder(d1=screwD+wall,d2=0,h=screwD+wall);
	translate([l2/2+screwSpan/2,w2,h2/2]) rotate([90,0,0]) cylinder(d1=screwD+wall,d2=0,h=screwD+wall);
}


module cubeRounded(size = [9,9,9], r = 1){
	if(r<=0)
		cube(size);
	else {
		hull(){
			translate([r,r,r]) sphere(r=r);
			translate([size[0]-r,r,r]) sphere(r=r);
			translate([r,size[1]-r,r]) sphere(r=r);
			translate([size[0]-r,size[1]-r,r]) sphere(r=r);

			translate([r,r,size[2]-r]) sphere(r=r);
			translate([size[0]-r,r,size[2]-r]) sphere(r=r);
			translate([r,size[1]-r,size[2]-r]) sphere(r=r);
			translate([size[0]-r,size[1]-r,size[2]-r]) sphere(r=r);
		}
	}
}

//module cubeRounded(size = [9,9,9], r = [1,1,1]){
//	if(r<=0)
//		cube(size);
//	else {
//		hull(){
//			translate([(r[0])*r[1]/r[0],r[0],r[0]]) scale([r[1]/r[0],1,1]) rotate([90,0,0]) torusQuart(r1=r[1],r2=r[0]);
//		
//			translate([size[0]-(r[0]+r[1])*r[1]/r[0],r[0],r[1]+r[0]]) scale([r[1]/r[0],1,1]) rotate([90,0,0]) torusQuart(r1=r[1],r2=r[0]);
//			
//			translate([(r[0]+r[1])*r[1]/r[0],size[1]-r[0],r[1]+r[0]]) scale([r[1]/r[0],1,1]) rotate([-90,0,0]) torusQuart(r1=r[1],r2=r[0]);
//			
//			translate([size[0]-(r[0]+r[1])*r[1]/r[0],size[1]-r[0],r[1]+r[0]]) scale([r[1]/r[0],1,1]) rotate([-90,0,0]) torusQuart(r1=r[1],r2=r[0]);
//
//
//
//			translate([(r[0]+r[1])*r[1]/r[0],0,size[2]-2*(r[1]+r[0])]) translate([0,r[0],r[1]+r[0]]) scale([r[1]/r[0],1,1]) rotate([90,0,0]) torusQuart(r1=r[1],r2=r[0]);
//			
//			translate([size[0]-(r[0]+r[1])*r[1]/r[0],r[0],size[2]-r[1]-r[0]]) scale([r[1]/r[0],1,1]) rotate([90,0,0]) torusQuart(r1=r[1],r2=r[0]);
//
//			translate([(r[0]+r[1])*r[1]/r[0],size[1]-r[0],size[2]-r[1]-r[0]]) scale([r[1]/r[0],1,1]) rotate([-90,0,0]) torusQuart(r1=r[1],r2=r[0]);
//			
//			translate([size[0]-(r[0]+r[1])*r[1]/r[0],size[1]-r[0],size[2]-r[1]-r[0]]) scale([r[1]/r[0],1,1]) rotate([-90,0,0]) torusQuart(r1=r[1],r2=r[0]);
//		}
//	}
//}

//module torusQuart(r1=10,r2=1){
//	rotate_extrude(convexity = 10)
//	intersection(){
//		translate([r1-r2, 0, 0]) circle(r = r2);
//		translate([r1-r2, 0, 0]) square([2*r2,2*r2]);
//	}
//}
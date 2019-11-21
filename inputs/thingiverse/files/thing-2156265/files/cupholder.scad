walld=1.2;
lowerR=49/2+walld;
upperR=67/2+walld;
height=97;

$fn=50;
module henkel(){
he=height/2-2;
rad=4;
 difference(){
	translate([30,-30,he]) rotate([135,90,0]) scale([2.0,1.0,2.0])
		rotate_extrude(convexity = 10)
		translate([height/5, 0, 0])
 		circle(r = rad); 
translate([30,-30,he]) rotate([135,90,0]) scale([2.0,1.0,2.0])
		rotate_extrude(convexity = 10)
		translate([height/5, 0, 0])
 		circle(r = rad-walld); 
	}
}

difference(){
	union(){
	cylinder(height,lowerR+walld*2,upperR+walld*2);
	henkel();
	
}
	translate([0,0,walld]) cylinder(height,lowerR,upperR);
	translate([0,0,50]) scale([3.0,1.0,2.0]) sphere(r=height/5.5); //sideholes
	translate([0,0,50]) scale([1.0,3.0,2.0]) sphere(r=height/5.5);  //sideholes
	translate([-60,-60,-20]) cube([120,120,20]);// cut bottom at 0
	translate([0,0,height]) rotate([0,0,45]) scale([5.0,2.0,1.3]) sphere(r=upperR/3);
	translate([-40,40,height]) rotate([0,0,-45]) scale([4.0,2.0,1.0]) sphere(r=height/7);
	translate([0,0,-walld]) cylinder(r=lowerR/1.5,h=3*walld);
}



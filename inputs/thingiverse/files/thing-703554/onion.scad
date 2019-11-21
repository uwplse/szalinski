//$fn=200;

//Container Radius
radius = 70 ;//[50:200]
//Container Thickness
thickness = 2 ; //[1:3]


//space between holes
hole_space = 5; //[4:10]
//the radius of holes
hole_radius = 8; //[6:10]

//the radius of the slot
slot_radius=30; //[30:40]
//the radius of the holes on the slot
slot_hole_radius = 3; //[3:5]

//the height of the base
base_height=5; //[5:10]



module half_ball(size){
	difference(){
		sphere(r=size);
		translate([0,0,-size/0.6])
			cube(size=size*2,center=true);
	}
}

module hat(){
	difference(){
		half_ball(radius);
		half_ball(radius-thickness*2);
		for(r=[hole_space+hole_radius:hole_space+hole_radius*2: radius-hole_radius])
			for(a=[0:90/((r-hole_space-hole_radius)/(hole_space+hole_radius*2)+1):360])
				linear_extrude([0,0,radius]) translate([r*sin(a),r*cos(a)]) circle(hole_radius);
	}	
}

module middle_slot(){
	difference(){
		translate([0,0,slot_radius])
		rotate_extrude(convexity = 10)
			translate([radius-0.5,0,0]) 
				rotate([90,0,0]) 
					difference(){
						circle(slot_radius);
						circle(slot_radius-thickness*2);
						translate([-slot_radius,0,0]) square(slot_radius*2);
						translate([0,-slot_radius,0]) square(slot_radius*2);	
					}
		for(a=[0:18:360])		
			translate([(radius-slot_radius/2)*sin(a),(radius-slot_radius/2)*cos(a),0]) cylinder(h=20,r=slot_radius/7);	
		cube(radius);
		translate([-radius,-radius,0]) cube(radius);
	}	
}


module base(){
	rotate_extrude()
	rotate([90,0,0]){
		square([radius,base_height]);
		translate([radius,base_height/2,0]) circle(base_height/2);
	}
	
}

translate([0,0,radius/0.6-radius]){
	hat();
	middle_slot();
}
base();



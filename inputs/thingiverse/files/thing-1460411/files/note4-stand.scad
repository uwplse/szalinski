
module top(){
    rotate([0,-20,0]){
        difference(){
            cube([20,89,100]);
            translate([6,2,12]){  //move top hole
                color([1,0,0]) cube([14.5,85,100]);//top hole
            }
            translate([6,2,2]){
                cube([12.5,85,11]);//botton hole
            }
        }
    }
}

module base_shell(){
    	    polyhedron (	
	    		points = [[-20, 0, 60], [-20, 89, 60], [0, 89, 0], [0, 0, 0], [-40, 0, 0], [-40, 89, 0]],
			faces = [[0,3,2], [0,2,1], [3,0,4], [1,2,5], [0,5,4], [0,1,5],  [5,2,4], [4,2,3], ]);
}
module base_hole(){
    	    polyhedron (	
	    		points = [[-122, 2, 58], [-122, 87, 58], [-100, 87, 12], [-100, 2, 12], [-140, 2, 12], [-140, 87, 12]],
			faces = [[0,3,2], [0,2,1], [3,0,4], [1,2,5], [0,5,4], [0,1,5],  [5,2,4], [4,2,3], ]);
}

module base(){
    difference(){
    base_shell();
        translate([100,0,0]){
            base_hole();  
        }
    }
}

module hole(){
     translate([-26,35,65]) rotate([0,70,0]){
        cylinder(h=6,r1=27,r2=27);
    }
}
module channel(){
    translate([-2.65,30,2])rotate([0,-20.5,0]){
        cube([6,3,45]);
    }
}

difference(){
union(){
    top();
    base();
}
hole();
channel();
}








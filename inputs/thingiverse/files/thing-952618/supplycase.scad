// Antenna tube End
// (c) g3org

//wall
wall=2.5;

//Power Supply height
supply_h=51.4;
//Power Supply width
supply_w=99.5;

//case depth
case_depth=60;

// screw diameter
case_screw=3;

//bananaplug diameter
bananaplugdia=3;

//screw hole on one side
screw_hole_a=8;

/* [Hidden] */
$fn=25;

module basecase(){
    difference(){
        cube([supply_h+(2*wall),supply_w+(2*wall),case_depth],center=true);
        translate([0,0,wall]){
            cube([supply_h,supply_w,case_depth],center=true);
        }
        translate([0,-supply_w/6,0]){
        switchsocket(); 
        }
            
        rotate([90,0,0]){
            translate([supply_h/2-12.5,case_depth/2-5,0]){
                screwhole();
            }
            
        }
        
        rotate([90,0,0]){
            translate([supply_h/2-25,case_depth/2-5,0]){
                screwhole();
            }
            
        }
        rotate([90,0,0]){
            translate([supply_h/2-33,case_depth/2-21.5,0]){
                screwhole_big();
            }
            
        } 
        
//bananaplug black
        rotate([90,0,90]){
            translate([supply_w/2-10,-case_depth/2+10,-supply_h/2]){
                bananaplug();
            }
            
        }
//bananaplug red
        rotate([90,0,90]){
            translate([supply_w/2-25,-case_depth/2+10,-supply_h/2]){
                bananaplug();
            }
            
        }        
    }
 
}


module switchsocket(){
    
    cube([27.5,47,case_depth+wall],center=true);
	 translate([0,-15,2.5]){
	 	cube([31.0,17,case_depth+wall],center=true);
	 }
	 translate([0,15,2.5]){
	 	cube([31.0,17,case_depth+wall],center=true);
	 }
	
}

module screwhole(){
    cylinder(h=supply_w+(wall*3),r=screw_hole/2,center=true);
}

module screwhole_big(){
    cylinder(h=supply_w+(wall*3),r=screw_hole_a/2,center=true);
}

module bananaplug(){
    cylinder(bananaplugdia+(wall*2),screw_hole/2,center=true);
}




basecase();

    
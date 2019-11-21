// size up or down with scale, 1.0 is good for ice tongs. 
// 0.5 is about as small as I've tested. 
scale=0.5;

// controls the pitch of the teeth in the y axis
tooth_pitch = 0.15;

$fn=24;

module cap(){
    translate([0,0,2]){
        resize([20,12])
            minkowski(){
                cylinder(r1=12, r2=9, h=6);
                sphere(r=2,$fn=24);
            }
    }
}    


module teeth(){
    translate([0,-10,12]){
        // controls the pitch of the teeth in the y axis
        M = [ [ 1  , tooth_pitch  , 0  , 0   ],
          [ 0  , 1  , 0, 0   ],  
          [ 0  , 0  , 1  , 0   ],
          [ 0  , 0  , 0  , 1   ] ] ;

        multmatrix(M) {
            rotate([0,90,90])
                linear_extrude(height=10)
                    polygon([[12,12],[-12,12],[-12,8], 
                            [-10,4],[-8,8], [-6,4],[-4,8], 
                            [-2,4],[0,8], [2,4],[4,8], 
                            [6,4],[8,8], [10,4],[12,8]
                    ]);
        }
        
    }
}


module jaw_t(){
    translate([0,0,-2])
        difference(){
            union(){
                teeth();
                mirror([0,1,0])
                teeth();
                translate([0,20,0]){
                    teeth();
                }
                translate([0,-20,0]){
                    mirror([0,1,0])
                    teeth();
                }
            }
            cube([40,60,4],center=true);
        }
}


module side(side_1=true){
    translate([0,0,12])
        rotate([0,-90,0])
            if(side_1){
                jaw_t();
            }else{
                translate([0,0,22])
                    rotate([180,0,0])
                        jaw_t();
            }
    translate([38,0,2]){
        difference(){
            cube([120,40,4], center=true);
            for(a=[-30:15:35]){
                translate([a,0,-2.1])
                    cylinder(r=5,h=5);
            }
            translate([51,0,-2.1])
                scale([1.2,2,1])
                    cylinder(r=6,h=5);
        }
    }
}

module band(){

    difference(){
        translate([0,0,8])
        minkowski(){
            cube([22,12,7], center=true);
            sphere(r=3);
        }
        cube([20,10,60], center=true);
    }
    
}

module end_cap(){
    difference(){
        translate([0,0,13])
        minkowski(){
            difference(){
                cube([20,10,20], center=true);
                translate([0,20,2])
            rotate([90,0,0])
                cylinder(r=7,h=50);
            }
            sphere(r=3);
        }
        
     translate([0,-3,16])
            rotate([4,0,0])
                cube([20,4,28], center=true);
        
        translate([0,3,16])
            rotate([-4,0,0])
                cube([20,4,28], center=true);
        
    }
}


scale([scale,scale,scale]){
    scale([1,0.5,1]){
        side();

        translate([0,-60,0])
        side(false);
    }
    translate([-50,-20,0])
    end_cap();
    
    translate([-50,20,0])
    band();
}

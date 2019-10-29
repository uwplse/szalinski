// The vial radius
VialR = 6;

// The height of holder
VialH = 20;

//Number of vials
VialN = 5;

difference(){
    union(){
        // slabs
        translate([VialH/2-1,0,1.35*VialR])cube(size = [2,VialN*2.8*VialR,2.7*VialR], center = true);
        translate([-VialH/2,0,1.35*VialR]) cube(size = [4,VialN*2.8*VialR,2.7*VialR], center = true);
        
        // posts
            for ( i = [-1.5*VialR*(VialN-2) : 3*VialR :1.5*VialR*(VialN-1)] ){
                translate([0,i,0])
                hull(){
                   translate([0,0,0.4])cube(size = [VialH,VialR,0.8], center = true);
                   translate([0,0,0.5*VialR])cube(size = [VialH,VialR/3,0.1], center = true);
                   }; 
            }
    }
   

    // holes
    for ( i = [-1.4*VialR*(VialN-1) : 2.8*VialR :1.5*VialR*VialN ] ){
        translate([0,i,1.35*VialR]) rotate([0,90,0]) cylinder (h = 1.01*VialH, r=VialR, center = true, $fn=50);
    }
}
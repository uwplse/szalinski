$fn = 12;

cot_cub = 200;





ray_sph = cot_cub/2*3;
ray_cyl = cot_cub/2;
ray_trou = cot_cub/50;
haut_trou = cot_cub/10;
ep_bor = 3;


translate([0,0,0])
union() {
    difference() {
        union() {
            translate([0,0,ray_sph-cot_cub/20])
            rotate([180,0,0])
            intersection() {
                difference () {
                    sphere(r = ray_sph);
                    sphere(r = ray_sph-ep_bor);
                    
                }
                translate([0,0,ray_sph])
                cube([cot_cub,cot_cub,ray_cyl/2],center = true);

            }



            translate([0,0,ep_bor/4+ep_bor/4+cot_cub/200])
            cylinder(r=ray_cyl/3*2,h=ep_bor,center = true);
        }
        cylinder(r=ray_trou,h=haut_trou,center = true);
        
        translate([ray_cyl/3,0,0])
        cylinder(r=ray_trou,h=haut_trou,center = true);
        
        translate([0,ray_cyl/3,0])
        cylinder(r=ray_trou,h=haut_trou,center = true);
        
        translate([-ray_cyl/3,0,0])
        cylinder(r=ray_trou,h=haut_trou,center = true);
        
        translate([0,-ray_cyl/3,0])
        cylinder(r=ray_trou,h=haut_trou,center = true);
        
        rotate([0,0,45]) {
            
        cylinder(r=ray_trou,h=haut_trou,center = true);
        
        translate([ray_cyl/3,0,0])
        cylinder(r=ray_trou,h=haut_trou,center = true);
        
        translate([0,ray_cyl/3,0])
        cylinder(r=ray_trou,h=haut_trou,center = true);
        
        translate([-ray_cyl/3,0,0])
        cylinder(r=ray_trou,h=haut_trou,center = true);
        
        translate([0,-ray_cyl/3,0])
        cylinder(r=ray_trou,h=haut_trou,center = true);            
        }
        
        
        
        translate([ray_cyl/2,0,0])
        cylinder(r=ray_trou,h=haut_trou,center = true);
        
        translate([0,ray_cyl/2,0])
        cylinder(r=ray_trou,h=haut_trou,center = true);
        
        translate([-ray_cyl/2,0,0])
        cylinder(r=ray_trou,h=haut_trou,center = true);
        
        translate([0,-ray_cyl/2,0])
        cylinder(r=ray_trou,h=haut_trou,center = true);
        
        rotate([0,0,22.5]) {
            
        cylinder(r=ray_trou,h=haut_trou,center = true);
        
        translate([ray_cyl/2,0,0])
        cylinder(r=ray_trou,h=haut_trou,center = true);
        
        translate([0,ray_cyl/2,0])
        cylinder(r=ray_trou,h=haut_trou,center = true);
        
        translate([-ray_cyl/2,0,0])
        cylinder(r=ray_trou,h=haut_trou,center = true);
        
        translate([0,-ray_cyl/2,0])
        cylinder(r=ray_trou,h=haut_trou,center = true);            
        }        

        rotate([0,0,45]) {
            
        cylinder(r=ray_trou,h=haut_trou,center = true);
        
        translate([ray_cyl/2,0,0])
        cylinder(r=ray_trou,h=haut_trou,center = true);
        
        translate([0,ray_cyl/2,0])
        cylinder(r=ray_trou,h=haut_trou,center = true);
        
        translate([-ray_cyl/2,0,0])
        cylinder(r=ray_trou,h=haut_trou,center = true);
        
        translate([0,-ray_cyl/2,0])
        cylinder(r=ray_trou,h=haut_trou,center = true);            
        }             

        rotate([0,0,-22.5]) {
            
        cylinder(r=ray_trou,h=haut_trou,center = true);
        
        translate([ray_cyl/2,0,0])
        cylinder(r=ray_trou,h=haut_trou,center = true);
        
        translate([0,ray_cyl/2,0])
        cylinder(r=ray_trou,h=haut_trou,center = true);
        
        translate([-ray_cyl/2,0,0])
        cylinder(r=ray_trou,h=haut_trou,center = true);
        
        translate([0,-ray_cyl/2,0])
        cylinder(r=ray_trou,h=haut_trou,center = true);            
        }        
        translate([ray_cyl/5,0,0])
        cylinder(r=ray_trou,h=haut_trou,center = true);
        
        translate([0,ray_cyl/5,0])
        cylinder(r=ray_trou,h=haut_trou,center = true);
        
        translate([-ray_cyl/5,0,0])
        cylinder(r=ray_trou,h=haut_trou,center = true);
        
        translate([0,-ray_cyl/5,0])
        cylinder(r=ray_trou,h=haut_trou,center = true);


}

}



































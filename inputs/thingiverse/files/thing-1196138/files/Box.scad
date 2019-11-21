
figure = "sphere";      //[sphere,cube,pyramide,triangles,pyramide2,diamond,pyramide3]
//Secret compartment
Secret = "false";   //[true,false]
//Cover
Cover = "true";     //[true,false]
//Box length
long_boit = 100;
//Box width
larg_boit = 100;
//Box height
haut_boit = 100;




module toto() {
}

$fn = 24;


haut_bo_s = haut_boit/2;
ray_sph = long_boit/10;
ray1_cyl = larg_boit/5.5;
ray2_cyl = 0;
haut_cyl = haut_boit/3;
cote_cub = long_boit/6;
ray_cyl_t = ray_sph;
haut_cyl_t = ray_cyl_t;
haut_t = ray_sph*2;
cot_tr = cote_cub*1.5;


teta = 2;
ep_bort = 1.5;
ep_bort_s = 2.25;
ep_fond = 1.5;
sec_haut = 5;
sec = 2;
haut_couv_av_hul = 2;   //hauteur du couvercle avant que l'on fasse le hull
haut_bord = haut_couv_av_hul;
long_boit_int = long_boit - ep_bort*teta;
larg_boit_int = larg_boit - ep_bort*teta;
haut_boit_int = haut_boit - ep_fond;
haut_couv = haut_boit/teta;
ray_cyl_mink = 1;
haut_cyl_mink = 1;
tolerance=0.5;


boite();
if(Secret == "false") {
    translate([0,larg_boit+10,0])
    if(Cover == "true") {
        couvercle();
    }
}
if(Secret == "true") {
    if(Cover == "true") {
        translate([0,larg_boit*2+10*2,0])
        couvercle();
    }
}




module boite() {
    if(Secret == "true") {
        translate([0,larg_boit+10,0]){
            union() {
                difference() {
                translate ([ray_cyl_mink, ray_cyl_mink, 0])
                    minkowski() {
                        cube([long_boit-2*ray_cyl_mink, larg_boit-2*ray_cyl_mink, haut_boit-haut_cyl_mink]);
                        cylinder(r = ray_cyl_mink, h = haut_cyl_mink);
                    }
                    translate([ep_bort_s/3*2, ep_bort_s/3*2, ep_fond])
                        cube([long_boit-ep_bort_s/3*2*2, larg_boit-ep_bort_s/3*2*2, haut_boit_int + sec_haut]);
        //            translate([ep_bort/teta,ep_bort/teta,haut_boit-haut_bord])
        	//			cube([long_boit-ep_bort, larg_boit-ep_bort, haut_bord + sec]);
                    translate([ep_bort_s/3,ep_bort_s/3,haut_bo_s-haut_couv_av_hul])
                    cube([long_boit-ep_bort_s/3*2,larg_boit-ep_bort_s/3*2,haut_boit]);
                }
            }
        }
                        difference() {
                    cube([long_boit_int+ep_bort_s/3,larg_boit_int+ep_bort_s/3,haut_boit_int-haut_bo_s]);
                    translate([ep_bort_s/2,ep_bort_s/2,ep_fond])
                    cube([long_boit_int-ep_bort_s/3*2,larg_boit_int-ep_bort_s/3*2,haut_boit_int]);
            }
        }
                    
                    
    if(Secret == "false") {        
        union() {
            difference() {
                translate ([ray_cyl_mink, ray_cyl_mink, 0])
                    minkowski() {
                        cube([long_boit-2*ray_cyl_mink, larg_boit-2*ray_cyl_mink, haut_boit-haut_cyl_mink]);
                        cylinder(r = ray_cyl_mink, h = haut_cyl_mink);
                    }
                    translate([ep_bort, ep_bort, ep_fond])
                        cube([long_boit_int, larg_boit_int, haut_boit_int + sec_haut]);
                    translate([ep_bort/teta,ep_bort/teta,haut_boit-haut_bord])
                        cube([long_boit-ep_bort, larg_boit-ep_bort, haut_bord + sec]);
                    
    
    
        
            }
        }
        
    }    

    }

module couvercle() {
    union () {
        hull() {
			translate ([ray_cyl_mink, ray_cyl_mink, 0])
				minkowski() {
					cube([long_boit - ep_bort - ray_cyl_mink*2 - tolerance, larg_boit - ep_bort - ray_cyl_mink*2 - tolerance, haut_couv_av_hul]);
					cylinder(r = ray_cyl_mink, h = haut_cyl_mink);
				}
            if(figure == "sphere")
                translate([long_boit/teta - ep_bort - tolerance/2,  larg_boit/teta - ep_bort - tolerance/2, haut_couv+ray_sph])
					sphere(r=ray_sph);
            if(figure == "cube")
                translate([long_boit/teta -cote_cub/teta - tolerance/2, larg_boit/teta -cote_cub/teta - tolerance/2, haut_couv])
					cube(cote_cub);
            if(figure == "pyramide")
                translate([long_boit/teta - ep_bort - tolerance/2,  larg_boit/teta - ep_bort - tolerance/2, haut_couv+ray_sph])
					sphere(r=ray_sph);
            if(figure == "triangles")
                translate([long_boit/teta - ep_bort - tolerance/2,  larg_boit/teta - ep_bort - tolerance/2, haut_couv+ray_sph])
					sphere(r=ray_sph);
            if(figure == "pyramide2")
                translate([long_boit/teta - ep_bort - tolerance/2,  larg_boit/teta - ep_bort - tolerance/2, haut_couv+ray_sph])
					sphere(r=ray_sph);
            if(figure == "diamond")
                translate([long_boit/teta - ep_bort - tolerance/2,  larg_boit/teta - ep_bort - tolerance/2, haut_couv+ray_sph])
					sphere(r=ray_sph);
            if(figure == "sphere2")
                translate([long_boit/teta - ep_bort - tolerance/2,  larg_boit/teta - ep_bort - tolerance/2, haut_couv+ray_sph])
					sphere(r=ray_sph);
            if(figure == "pyramide3")
                translate([long_boit/teta - ep_bort - tolerance/2,  larg_boit/teta - ep_bort - tolerance/2, haut_couv+ray_sph])
					sphere(r=ray_sph);
        
        
        }
            if(figure == "sphere")
                translate([long_boit/teta - ep_bort - tolerance/2,  larg_boit/teta - ep_bort - tolerance/2,  haut_couv+ray_sph*teta+ray_sph*0.7])
                sphere(r=ray_sph);
            if(figure == "cube")
                translate([long_boit/teta - tolerance/2, larg_boit/teta - tolerance/2, haut_couv+cote_cub*1.5])
                cube(cote_cub,center=true);
            if(figure == "pyramide")
                translate([long_boit/teta - ep_bort - tolerance/2,  larg_boit/teta - ep_bort - tolerance/2 ,haut_couv+haut_cyl+haut_cyl/1.2])
                rotate([180,0,0])
                cylinder(r1 = ray1_cyl, r2 = ray2_cyl, h = haut_cyl);
            if(figure == "triangles")
                translate([long_boit/2-haut_cyl_t*3.15,larg_boit/2-haut_cyl_t/1.2,0])
                union() {
                    translate([haut_t-ray_sph/6,0,haut_t+ray_cyl_t+haut_couv+ray_sph])    
                    couv_t();
    }
            if(figure == "pyramide2")
                translate([long_boit_int/2-cote_cub/2,larg_boit_int/2-cote_cub/2,haut_couv+ray_sph*2])
                rotate([0,180,0])
                translate([-cote_cub+ray_sph/16,-ray_sph/16,-haut_cyl+1])
                hull() {
                    cube([cote_cub,cote_cub,1]);
                    translate([cote_cub/2-0.5,cote_cub/2-0.5,haut_cyl])
                    cube([1,1,1]);
                }
            if(figure == "diamond")
                translate([long_boit_int/2-cote_cub/2,larg_boit_int/2-cote_cub/2,haut_couv+ray_sph*2])
                rotate([0,180,0])
                translate([-cote_cub+ray_sph/16,-ray_sph/16,-haut_cyl+1])
                hull() {
                    cube([cote_cub,cote_cub,1]);
                    translate([cote_cub/2-0.5,cote_cub/2-0.5,haut_cyl])
                    cube([1,1,1]);
                    translate([cote_cub/2-0.5,cote_cub/2-0.5,-haut_cyl])
                    cube([1,1,1]);
                }
            if(figure == "pyramide3")
                translate([-cot_tr/2,-(sqrt(cot_tr*cot_tr-(cot_tr/2*cot_tr/2)))/3,0])
                translate([long_boit/2-ray_cyl_mink*2,larg_boit/2-ray_cyl_mink*2,haut_couv+ray_sph*2+cot_tr/1.5])
            mirror([0,0,1]){ 
                    tri_equ();
            }
            
}

}



module couv_t() {
    rotate([-90,0,0])
        hull () {
            translate([0,0,0]) 
                cylinder(r=ray_cyl_t,h=haut_cyl_t);
            translate([haut_t,0,0]) 
                cylinder(r=ray_cyl_t,h=haut_cyl_t);
            translate([haut_t/2,haut_t,0]) 
                cylinder(r=ray_cyl_t,h=haut_cyl_t);
    }
        translate([haut_cyl_t+ray_cyl_t/2,-ray_cyl_t/2,0])
        rotate([-90,0,90])
        hull () {
            translate([0,0,0]) 
                cylinder(r=ray_cyl_t,h=haut_cyl_t);
            translate([haut_t,0,0]) 
                cylinder(r=ray_cyl_t,h=haut_cyl_t);
            translate([haut_t/2,haut_t,0]) 
                cylinder(r=ray_cyl_t,h=haut_cyl_t);  
}
    }
      

module tri_equ() {
    polyhedron(points = [[0,0,0],[cot_tr,0,0],[cot_tr/2,sqrt(cot_tr*cot_tr-(cot_tr/2*cot_tr/2)),0],[cot_tr/2,(sqrt(cot_tr*cot_tr-(cot_tr/2*cot_tr/2)))/3,sqrt(cot_tr*cot_tr-(cot_tr/2*cot_tr/2))]],faces=[ [0,1,4],[1,2,4],[2,3,4],[3,0,4],[1,0,3],[2,1,3],[0,1,2],[0,2,3]]);
    
}
    





























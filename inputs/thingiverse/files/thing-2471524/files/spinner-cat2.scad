$fn = 20;

dz608 = 22 + 0.5;
espessura = 4;
radio = dz608 + 1.1*espessura;
altura = 7;
suave = 1;


module corpo(){
            union() {
                anel();
                for(i=[0:120:300])
                        rotate([0,0,i]) translate([radio,0,0])cat(); 
                }
}

module orelha(suave){
    hull(){
        cylinder (altura - suave,d=10);
        translate([8,0,0]) cylinder (altura-suave,d=3-suave);
    }
}

module cat(){
    difference(){
        minkowski(){
            union(){
                translate([dz608/2 + espessura -7 ,-8,0])rotate([0,0,-15])orelha(suave);
                translate([dz608/2 + espessura -7,8,0])rotate([0,0,15])orelha(suave);
                cylinder (altura - suave ,d=dz608+2*espessura - suave);
            }
            sphere(suave);
        }
        translate([0,0,-5]) cylinder (20,d=dz608,$fn = 100);
    }
}

module anel(){
    difference(){
            minkowski() {
                cylinder (altura-suave,d=dz608+2*espessura - suave);
                sphere(suave);
            }
            translate([0,0,-1-suave])cylinder (20,d=dz608,$fn = 100);
            }

}


corpo();



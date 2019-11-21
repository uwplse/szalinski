r_tip_pillar=2.7;
r_base_pillar=3.7;
r_pillar=17;
n_pillar=4;
clearance=0.4;


function scaleF(dim, clearance) = (dim+clearance)/dim;

module clearXY(dim, clearance) { 
    scale([scaleF(dim, clearance), scaleF(dim, clearance), 1]) children();
}

module pillar(h=40, r= 2.5, base_r=3.5, base_h=10){
    cylinder(h=h, r=r);
    cylinder(r2=r, r1=base_r, h=base_h);
}




$fn=50;
//pillar();

module pusher_plate(h=5, r=25, r_pillar=20, n_pillar=4){
    cylinder(h=h, r= r);
    translate([0,0,h])
        for(angle=[0: 360/n_pillar: 360]){
            rotate([0,0,1], a=angle)
                translate([r_pillar,0,0])
                    children();
        }
    
}

module base_plate(h=5, r= 25, r_pillar=20, r_base_pillar=2.5, n_pillar=4, clearance=0.5){
    difference(){
        union(){
            cylinder(h=h, r=r);
            translate([0,0, h])
                for(angle=[0: 360/n_pillar: 360]){
                    rotate([0,0,1], a=angle)
                        translate([r_pillar,0,0])
                        children();
                }
        }
        
        for(angle=[0: 360/n_pillar: 360]){
            rotate([0,0,1], a=angle)
                translate([r_pillar,0,0])
                    clearXY(dim=r_base_pillar, clearance=clearance) 
                        cylinder(h=h*20, r=r_base_pillar);
        }
    }
    
}

union() translate([0,0,-50])
    pusher_plate(r_pillar=r_pillar, n_pillar=n_pillar)
        pillar(r=r_tip_pillar, base_r=r_base_pillar);

union() base_plate(r_pillar=r_pillar, r_base_pillar=r_tip_pillar, n_pillar=n_pillar, clearance=clearance)
    pillar(r=r_tip_pillar*1.7, base_r=r_base_pillar*1.5, h=20);
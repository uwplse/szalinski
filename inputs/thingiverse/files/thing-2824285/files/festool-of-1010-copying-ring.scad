/*$fn=180;*/
height=2.5;
nozzle_height=3.7;
router_diam=75;
outer_diam=17;
inner_diam=12;
stegbreite=10;


difference(){
    cylinder(d=router_diam, h=height);
    cylinder(d=router_diam-stegbreite*2, h=height);
    // screw holes
    translate([1,0,0]*(router_diam/2-stegbreite/2)){
        cylinder(d1=4.5, d2=8.5, h=height);
    }
    translate([-1,0,0]*(router_diam/2-stegbreite/2)){
        cylinder(d1=4.5, d2=8.5, h=height);
    }
}

// stege
difference(){
    union(){
        hull(){
            translate([1,0,0]*(router_diam/2-stegbreite-4.5)){
                translate([0,0,height/2])
                    cube([stegbreite, stegbreite/1.8, height], true);
            }
            translate([-1,0,0]*(router_diam/2-stegbreite-4.5)){
                translate([0,0,height/2])
                    cube([stegbreite, stegbreite/1.8, height], true);
            }
        }
        hull(){
            translate([0,1,0]*(router_diam/2-stegbreite-4.5)){
                translate([0,0,height/2])
                    cube([stegbreite/1.8, stegbreite, height], true);
            }
            translate([0,-1,0]*(router_diam/2-stegbreite-4.5)){
                translate([0,0,height/2])
                    cube([stegbreite/1.8, stegbreite, height], true);
            }
        }
    }
    cylinder(d=inner_diam, h=height);
}
// innerer cirecles
difference(){
    cylinder(d=outer_diam+stegbreite*1, h=height);
    cylinder(d=inner_diam, h=height);
}
// nozzle
difference(){
    cylinder(d=outer_diam, h=height+nozzle_height);
    cylinder(d=inner_diam, h=height+nozzle_height);
}


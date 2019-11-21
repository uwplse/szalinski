$fa=1; // default minimum facet angle is now 0.5
$fs=1; // default minimum facet size is now 0.5 mm

tolx=0.5; // tolerance for mating parts.

radius_can=3.125*12.7; // radius of can in mm
feeder_wall=25.4;
wall=3;

module can_base(internal_radius,height,wall){
    difference(){
        cylinder(r2=internal_radius+wall,r1=internal_radius+3*wall,h=height*2+wall*3);
        translate([0,0,wall]){
            cylinder(r=internal_radius+tolx,h=height*2+2*wall+tolx);}
        translate([internal_radius,0,height/2+wall]){
            sphere(r=height/2);}
        }
}

module feed_cup(height,wall){
    translate([radius_can,0,height]){
        difference(){
            union(){
                translate([0,0,-height]){
                cylinder(r1=height+1*wall,r2=height-wall,h=height);}
                sphere(r=height);}
            union(){
                sphere(r=height-wall);}
            translate([0,-height/2,0]){
                cube([2*height,height,radius_can]);}
            translate([-radius_can,0,-height+tolx]){
                cylinder(r=radius_can+tolx,h=height*3);}
            }
        }
   }

module ramp_insert(internal_radius,height,wall){
    difference(){
        cylinder(r=internal_radius+tolx,h=height*2-wall+tolx);
        translate([-internal_radius-wall-tolx,-internal_radius-tolx,height*2+wall]){
            rotate([0,atan(height/internal_radius),0]){
                cube(internal_radius*3);}}
    }
    for(i=[0:120:360]){
        rotate([0,0,i]){
            translate([-internal_radius+wall,0,0]){
            cylinder(r=wall*2,h=height*2);
            translate([wall-1,0,height*2]){
                cylinder(r=1.5*wall,h=3*wall);}
                }}}
}


can_base(radius_can,feeder_wall,wall);
feed_cup(feeder_wall,wall);
ramp_insert(radius_can,feeder_wall,wall);

//    cap(25.4,30,radius_can,wall);

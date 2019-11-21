thickness = 3;

$fn=64;

diam = 166;
diam_bottom = 132;

pole_diam_top = 30;
pole_diam_bottom = 20;
pole_height = 45;

pole_hole = 5;

poles_center = 2/3;

diff = 0.1;

hole = 5;


//inner dimensions
watering_tube_top = 21;
watering_tube_bottom = 19.5;
watering_tube_height = 20;
watering_tube_position = 3/4;

module pole(cent = 0) {
    translate([diam/2*poles_center*(1-cent),0, thickness-diff]) cylinder(r1= pole_diam_top/2, r2= pole_diam_bottom/2, h= pole_height+diff);
}

module pole_in(cent = 0){
    translate([diam/2*poles_center*(1-cent),0, -diff]) cylinder(r1= pole_diam_top/2-thickness/2, r2= pole_diam_bottom/2-thickness/2, h= pole_height+diff);
    translate([diam/2*poles_center*(1-cent),0,pole_height-3]) rotate([0,90,0]) translate([0,0,-pole_diam_top/2]) cylinder(r = pole_hole/2, h = pole_diam_top);
    translate([diam/2*poles_center*(1-cent),0,pole_height-3]) rotate([90,0,0]) translate([0,0,-pole_diam_top/2]) cylinder(r = pole_hole/2, h = pole_diam_top);
}

difference(){
    union(){
        cylinder(r=diam/2, h = thickness);
        pole(cent = 1);
        
        for(i=[-1:1])
            rotate([0,0,i*120])
                pole();
        
                
        translate([-diam/2*watering_tube_position, 0, 0]) cylinder(r1=(watering_tube_top+thickness)/2, r2=(watering_tube_bottom+thickness)/2, h=watering_tube_height);
        
    }
    
    pole_in(cent = 1);
    for(i=[-1:1])
        rotate([0,0,i*120])
            pole_in();
    
    for(i=[-2:3])
        for(j=[1:2])
            rotate([0,0,i*60]) 
                translate([-j*diam/3.5*poles_center,0, -diff]) 
                    cylinder(r = hole/2, h= thickness + 2*diff);
            
    translate([-diam/2*watering_tube_position, 0, -diff]) cylinder(r1=(watering_tube_top)/2, r2=(watering_tube_bottom)/2, h=watering_tube_height+2*diff);
}
n_teeth=44;
d_gear=40;
d_hole=22;
h_gear=8.5;
w_teeth=2;
l_teeth=2;





difference(){
    cylinder(d=d_gear,h=h_gear,$fn=50);
    translate([0,0,-1]) cylinder(d=d_hole,h=h_gear+2,$fn=50);
    
    }
    
    for(i=[0:n_teeth-1]){
        rotate([0,0,i*(360/n_teeth)]) translate([d_gear/2,0,0]) hull(){ 
            translate([l_teeth,0,0]) cylinder(d=0.5,h=h_gear,$fn=50);
            translate([-0.1,-w_teeth/2,0]) cube([0.1,w_teeth,h_gear]);
    
        }
    }   
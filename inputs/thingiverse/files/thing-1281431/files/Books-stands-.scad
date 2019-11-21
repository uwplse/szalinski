$fn = 12;


//lenght
l = 100;     
//width
w = 100;        
//height
h = 100;

module toto() {
}

ep_bord = 2;
ep_fon = 0.5;



translate([l,0,0])
    right(l,w,h,0);

translate([0,w,0])
    rotate([0,0,180])
        left(l,w,h,0);




module right (length,width,height) {
    
    difference() {
        cube([length,width,height]);
        translate([ep_bord/2,0,ep_fon])
        cube([width+5,length-ep_bord+5,height - ep_fon]);
    }
    
    
}

module left (length,width,height) {
    
        difference() {
        cube([length,width,height]);
        translate([ep_bord/2,0,ep_fon])
        cube([width+5,length-ep_bord+5,height - ep_fon]);
    }
    
    
}









































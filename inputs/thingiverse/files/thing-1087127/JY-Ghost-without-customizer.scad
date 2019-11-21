// James Yang 
// Ghost 

$fn = 60;

module eyes(){
    scale([1.5,1,1])sphere(8,center = true);
}  
// eyes for the ghost

module body(){
    union(){
        translate([0,0,75])sphere(30,center = true);
        difference(){
            translate([0,0,75])translate([0,0,-37.5])cylinder(r1=30,r2=30,h=75, center = true);
            scale([1,1,0.8])sphere(30,center = true);
        }

    }
} 
// the body for the ghost 

module hand(){
    union(){
        sphere(5,center = true);
        translate([0,0,-15])cylinder(r1=10,r2=5,h=30,center = true);
    }
} 
// the hand for the ghost

module mouth() {
      cube([23,40,10]);
}  

module teeth() {
     cylinder(r1 = 1, r2 = 3,h = 10,center = true);
}
    
union(){
    difference(){
        scale([1.1,1.1,0.9])body();
        translate([25,18,75])rotate([0,0,90])eyes();
        translate([25,-18,75])rotate([0,0,90])scale([1.5,1.5,1.5])eyes();
        
        for(d = [0:45:360]){
            rotate([0,0,d])translate([33,0,0])rotate([0,90,0])scale([1,1,0.5])cylinder(r1=8,r2=8,h=30,center = true);
           
        // make it looks like floating 
        
        translate([10,-20,45])mouth();  

    }
}
    for(d = [0:45:360]){
     rotate([0,0,d + 22.5])translate([ 32,0,1]) cylinder(r = 8,h = 2, center = true);
    }
    translate([28,-10,50]) teeth();
    translate([28,10,50]) teeth();
    translate([5,40,50])rotate([-55,0,0])hand();  
    translate([5,-40,50])rotate([55,0,0])hand();
    // make everything union together 
 
} 


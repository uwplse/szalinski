thickness=5;
length=60;
height=10;
depth=30;
circ=8;
extr=15;


//color("red")
linear_extrude(height = extr) {
    union() {
        square([length,thickness], center =false);
        translate([-thickness,-depth+thickness,0]){
            square([thickness, depth], center =false);
        }
    }

    intersection() {
        translate([length,thickness,0]){
            circle(r=thickness);
        }
        color("blue")
        translate([length,0,0]){
        square([thickness,thickness],center = false);
        }
    }
    
    difference() {
        translate([length-thickness,thickness,0]){
            color("red")
            square([thickness,thickness],center = false);
        }
        translate([length-thickness,thickness*2,0]){
            circle(r=thickness);
        }
    }
    
        translate([length,thickness,0]){
            square([thickness,height],center = false);
        }
        translate([length+thickness/2,thickness+height,0]){
            circle(r=thickness/2);
        }
        translate([-thickness/2,-depth+thickness,0]){
            circle(r=thickness/2);
        }
        
        
        
        difference() {
       
            circle(r=circ);
 
            color("blue")
            translate([0,-circ,0]){
                square([circ,circ],center = false);
            }
        }
        
    
}
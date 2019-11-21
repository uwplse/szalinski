angle = 30;


// Kinesis Corporation KB800PB-US The Kinesis Freestyle2 
// Keyboard Holder

mm=1;

ins_width=190*mm;
ins_depth=185*mm;
ins_height=15*mm;
top_support_width=100*mm;
thk=2*mm;

out_width=ins_width+thk;
out_depth=ins_depth+thk;
out_height=ins_height+thk;

sup_height=sin(angle)*out_width;
sup_width=cos(angle)*out_width;
sup_depth=out_depth;
   
penny_dia=21*mm;


module ramp(){
    translate([0, 10*mm, 0])
    difference(){
    union(){
        
        rotate([0, angle, 0]){
            translate([-out_width,0,0]){
                difference(){
                    color("red")
                    cube([out_width, out_depth, out_height]);
                    translate([0,thk,thk])
                        cube([ins_width, ins_depth, ins_height]);
                }
                translate([50*mm, out_depth-thk, 0])
                    cube([top_support_width, thk, out_height]);
            }
        }
        
    
        
        difference(){
            translate([-sup_width,0,0])
                cube([sup_width, sup_depth, sup_height]);
                
            rotate([0, -(90-angle), 0])
               cube([sup_width, sup_depth, sup_height*2]);
        
        }
        

    }
    
     //translate([30-sup_width, 20-sup_depth, -10])
     translate([37-sup_width, 35, -10])
        cube([sup_width-50, sup_depth-70, sup_height*2]);
  
    } //difference
    
} // module ramp()



ramp();
mirror([0, 1, 0])
    ramp();
$fn=30;

part = "first"; // [first:Carousel Base,second:Carousel Top,third:Carousel Fan,fourth:Shaft,Fifth:Snowflakes]

// Radius of the protecive glass. Default: The size of a standard 2 liter soda bottle.
glass_radius=54.6;
// Height of the protecive glass. Default: The size of a standard 2 liter soda bottle after you cut away the parts that are not tapered or rounded.
glass_height=120;
// Radius of the candle holder base.
candle_radius=20;
// Height or depth of the candle holder base.
candle_height=10;
// Design pattern of the trim.
design_pattern=true; // [true:Squares, false:Circles]

print_part();

module print_part() {
    if (part == "first") {
            carousel_base();
    } else if (part == "second") {
            carousel_top();
    } else if (part == "third") {
            carousel_fan();
    } else if (part == "fourth") {
            carousel_shaft();    
    } else {
            carousel_snowflake();
    }
}

module carousel_base() {
    base_ring();
    candle_holder();
    base_lip();
}

module carousel_top() {
    top_ring();
    top_lip();
}

module carousel_fan() {
    fan();  
}

module carousel_shaft() {
    rotate([90,0,0]) union() {
        shaft();
        translate([-candle_radius/4,0,glass_height/2]) hook();
        translate([-candle_radius+(candle_radius/4),0,glass_height/2]) rotate([180,0,0]) hook();
        translate([-candle_radius,0,glass_height/2+10])cylinder(h=20,r1=2,r2=.5,center=true);
    } 
}
 
module carousel_snowflake() {
    snowflake();
}

module candle_holder() {
    difference() {
        union() {
            translate([0,0,candle_height/2+2]) cylinder(r=candle_radius+3, h=candle_height,  center=true);
            translate([0,candle_radius+3+3,candle_height/2+2]) cylinder(r=3, h=candle_height,  center=true);
            translate([0,0,1]) cylinder(r=candle_radius+3, h=2,center=true);
            translate([0,0,1]) cube([glass_radius*2+5,5,2],center=true);
            translate([0,0,1]) cube([5,glass_radius*2+5,2],center=true);
        }
        union() {
            translate([0,0,candle_height/2+2])cylinder(r=candle_radius+1,h=candle_height,  center=true);
            translate([0,candle_radius+3+3,candle_height/2+2]) cylinder(r=2, h=candle_height,  center=true);
        }
    }
}

module base_ring() {
    difference() {
        union(){
         translate([0,0,11]) cylinder(r=glass_radius+3, h=22, center=true);   
        }
        union(){
         translate([0,0,12]) cylinder(r=glass_radius+1, h=20, center=true);
         translate([0,0,10]) cylinder(r=glass_radius-1, h=20, center=true);
         for(j= [0:4] ) {
            for(i= [0:10:180]){
                if(design_pattern) {
                    translate([0,0,5*j+2]) rotate([45,0,i+(j*5)]) cube([glass_radius*2+10,5,5], center=true);
                }else {
                    translate([0,0,5*j+2]) rotate([90,0,i+(j*5)])cylinder(r=3,h=glass_radius*2+10, center=true);
                }     
            }
          }  
        } 
    }
}

module base_lip() {
    difference() {
        union(){
         translate([0,0,1]) cylinder(r=glass_radius+3, h=2, center=true);   
        }
        union(){
         translate([0,0,1]) cylinder(r=glass_radius-1, h=2, center=true);
        }  
    }
}
module top_ring() {
    difference() {
        union(){
         translate([0,0,11]) cylinder(r=glass_radius+3, h=22, center=true);   
        }
        union(){
         translate([0,0,12]) cylinder(r=glass_radius+1, h=20, center=true);
         translate([0,0,10]) cylinder(r=glass_radius-1, h=20, center=true);
         for(j= [0:4] ) {
            for(i= [0:10:180]){
                if(design_pattern) {
                    translate([0,0,5*j+2]) rotate([45,0,i+(j*5)]) cube([glass_radius*2+10,5,5], center=true);
                }else {
                    translate([0,0,5*j+2]) rotate([90,0,i+(j*5)])cylinder(r=3,h=glass_radius*2+10, center=true);
                }
            }
          }  
        }      
    }
}

module top_lip() {
     difference() {
        union(){
         translate([0,0,1]) cylinder(r=glass_radius+3, h=2, center=true);   
        }
        union(){
         translate([0,0,1]) cylinder(r=glass_radius-1, h=2, center=true);
        }  
    }
}

module fan() {
    difference() {
        union() {
            cylinder(r=3, h=5, center=true);
            for( i = [0:30:360] ) {
                rotate([0,0,i]) fan_blade();
            }
        }
        union() {
            translate([0,0,-1]) cylinder(h=4,r1=3,r2=1, center=true);
        }
    }
}

module fan_blade() {
    rotate([30,0,0]) linear_extrude(height=2)
    difference() {
        union() {
            circle(30);
            rotate([0,0,15]) translate([30,0,0]) circle(4);
            translate([30,0,0]) circle(4);
            rotate([0,0,-15]) translate([30,0,0]) circle(4);
        }
        union() {
            rotate([0,0,15])   translate([-50,0,0]) square(100);
            rotate([0,0,-195]) translate([-50,0,0]) square(100);
            translate([30,0,0]) circle(2);
        }
    }
}

module shaft() {
    difference() {
        union(){
         cylinder(r=2, h=glass_height, center=true);              
        }
        union(){
        } 
    }
}

module hook() {
     difference() {
                union(){
                    rotate([90,0,0])
                    rotate_extrude (convexity=10)
                     translate([candle_radius/4,0,0])circle(2);   
                }
                union(){
                 translate([0,0,-20]) cube([40,40,40],center=true);
                }
                
        }
}

module snowflake(){
    
rotate([0,0,0]) cube([25,2,2],center=true);
rotate([0,0,60]) cube([25,2,2],center=true);
rotate([0,0,120]) cube([25,2,2],center=true);

union() {
translate([9,2,0]) rotate([0,0,60]) cube([5,2,2],center=true);
translate([9,-2,0]) rotate([0,0,-60]) cube([5,2,2],center=true);
}

rotate([0,0,60]) union() {
translate([9,2,0]) rotate([0,0,60]) cube([5,2,2],center=true);
translate([9,-2,0]) rotate([0,0,-60]) cube([5,2,2],center=true);
}

rotate([0,0,120]) union() {
translate([9,2,0]) rotate([0,0,60]) cube([5,2,2],center=true);
translate([9,-2,0]) rotate([0,0,-60]) cube([5,2,2],center=true);
}

rotate([0,0,180]) union() {
translate([9,2,0]) rotate([0,0,60]) cube([5,2,2],center=true);
translate([9,-2,0]) rotate([0,0,-60]) cube([5,2,2],center=true);
}

rotate([0,0,240]) union() {
translate([9,2,0]) rotate([0,0,60]) cube([5,2,2],center=true);
translate([9,-2,0]) rotate([0,0,-60]) cube([5,2,2],center=true);
}

rotate([0,0,300]) union() {
translate([9,2,0]) rotate([0,0,60]) cube([5,2,2],center=true);
translate([9,-2,0]) rotate([0,0,-60]) cube([5,2,2],center=true);
}

translate([25/2+1,0,0])difference() {
cylinder(h=2,r=2);
cylinder(h=2,r=1);
}
}
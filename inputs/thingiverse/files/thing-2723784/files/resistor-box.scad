inch=25.4;
kerf=0.0035*inch;

void_length=9/8*inch;
void_width=2.25+2/32*inch+kerf*2;//1/4*inch;
void_depth=3;//1/4*inch;
bevel_width=3/16*inch;
wall_thickness=3/32*inch;
holder_width=1/16*inch;

resister_width=3.7;
connector_width=1/8*inch;
wire_width=2.25;
lock_size=.9;
post_width=4/32*inch;
support_clearance=0.2;
connector_clearance=0.1;

module shell(){
    translate([bevel_width,bevel_width,bevel_width])
    minkowski(){
        cube([void_length,void_width,void_depth]);
        sphere(bevel_width,$fn=100);
    }
}

module hollow(){
    translate([bevel_width,bevel_width,bevel_width])
    minkowski(){
        cube([void_length,void_width,void_depth]);
        sphere(bevel_width-wall_thickness,$fn=100);
    }
}

module half(){
    difference(){
        shell();
        hollow();
        translate([-0.001,-0.001,void_depth/2+bevel_width+connector_width/2-connector_clearance])
        cube([void_length+bevel_width*2+0.002,void_width+bevel_width*2+0.002,void_depth+bevel_width*2+0.001+connector_clearance]);
        
        translate([-0.003,void_width/2+bevel_width,void_depth/2+bevel_width])
        rotate([0,90,0]){
            cylinder(wall_thickness+0.006,wire_width/2,wire_width/2,$fn=100);
            translate([-connector_width,-wire_width/2,0])
            cube([connector_width,wire_width,wall_thickness+0.006]);
        }
        
        translate([void_length+bevel_width*2-wall_thickness-0.003,void_width/2+bevel_width,void_depth/2+bevel_width])
        rotate([0,90,0]){
            cylinder(wall_thickness+0.006,wire_width/2,wire_width/2,$fn=100);
            translate([-connector_width,-wire_width/2,0])
            cube([connector_width,wire_width,wall_thickness+0.006]);
        }
        
        
    }
}

module lock_outset(){
    //translate([1/8*inch,1/8*inch,1/4*inch])
    translate([0,0,-lock_size/2])
    minkowski(){
        cube([void_length,void_width,lock_size/6]);
        cylinder(lock_size/6,bevel_width-wall_thickness/2-kerf/2,bevel_width-wall_thickness/2-kerf/2,$fn=100);
        hull(){
            cylinder(lock_size/3,0,kerf*2,$fn=16);
            translate([0,0,lock_size/3])
            cylinder(lock_size/3,kerf*2,0,$fn=16);
        }
    }
}

module lock_inset(){
    //translate([1/8*inch,1/8*inch,1/4*inch])
    translate([0,0,-lock_size/2-kerf*2])
    minkowski(){
        cube([void_length,void_width,lock_size/6+kerf*4]);
        cylinder(lock_size/6,bevel_width-wall_thickness/2+kerf/2,bevel_width-wall_thickness/2+kerf/2,$fn=100);
        hull(){
            cylinder(lock_size/3,0,kerf*2,$fn=16);
            translate([0,0,lock_size/3])
            cylinder(lock_size/3,kerf*2,0,$fn=16);
        }
    }
}

module bottom_half(){
    difference(){
        
        half();
        translate([bevel_width,bevel_width,(void_depth+bevel_width*2)/2-connector_width/2]){
            minkowski(){
                cube([void_length,void_width,connector_width/2]);
                cylinder(connector_width/2+0.002,(bevel_width-wall_thickness/2)+kerf/2,(bevel_width-wall_thickness/2)+kerf/2,$fn=100);
            }
            translate([0,0,connector_width/2])
            lock_inset();
        }
    }
    holders();
    
    
    short_two_posts();
    translate([void_length+bevel_width*2,void_width+bevel_width*2,0])
    rotate([0,0,180])
    short_two_posts();
}

module top_half(){
    difference(){
        
        half();
        translate([bevel_width,bevel_width,(void_depth+bevel_width*2)/2-connector_width/2])
        difference(){
            minkowski(){
                cube([void_length,void_width,connector_width/2]);
                cylinder(connector_width/2+0.002,bevel_width+0.001,bevel_width+0.001,$fn=100);
            }
            
                minkowski(){
                    cube([void_length,void_width,connector_width/2]);
                    cylinder(connector_width/2+0.003,(bevel_width-wall_thickness/2)-kerf/2,(bevel_width-wall_thickness/2)-kerf/2,$fn=100);
                }
                
                translate([-bevel_width,void_width/2-wire_width/2+kerf,0])
                cube([wall_thickness+0.002,wire_width-kerf*2,connector_width+0.002]);
                
                translate([void_length+bevel_width-wall_thickness,void_width/2-wire_width/2+kerf,0])
                cube([wall_thickness+0.002,wire_width-kerf*2,connector_width+0.002]);
                translate([0,0,connector_width/2])
                lock_outset();
                
        }
                
        
    }
    holders();
    
    
    long_two_posts();
    translate([void_length+bevel_width*2,void_width+bevel_width*2,0])
    rotate([0,0,180])
    long_two_posts();
}

module short_post(){
    cylinder((void_depth+bevel_width*2-wall_thickness*2)/2-wire_width/2-support_clearance,post_width/2,post_width/2,$fn=100);
}

module long_post(){
    cylinder((void_depth+bevel_width*2-wall_thickness*2)/2+wire_width/2-support_clearance,post_width/2,post_width/2,$fn=100);
}


// TWO POSTS


module short_two_posts(){
    translate([0,0,wall_thickness]){
        translate([post_width/2+wall_thickness+wire_width+cos(30)*(post_width+wire_width)*0.25,(void_width+bevel_width*2)/2-wire_width/2-post_width/2+sin(30)*(post_width+wire_width),0])
        short_post();
    }
    translate([0,0,wall_thickness]){
        translate([post_width/2+wall_thickness+wire_width+cos(30)*(post_width+wire_width)*1.25,(void_width+bevel_width*2)/2-post_width/2-wire_width/2,0])
        short_post();
    }
}


module long_two_posts(){
    translate([0,0,wall_thickness]){
        translate([post_width/2+wall_thickness+wire_width+cos(30)*(post_width+wire_width)*0.25,(void_width+bevel_width*2)/2-post_width/2-wire_width/2+sin(30)*(post_width+wire_width),0])
        long_post();
    }
     translate([0,0,wall_thickness]){
        translate([post_width/2+wall_thickness+wire_width+cos(30)*(post_width+wire_width)*1.25,(void_width+bevel_width*2)/2+post_width/2+wire_width/2,0])
        long_post();
    }
}

// THREE POSTS

module short_three_posts(){
     translate([0,0,wall_thickness]){
        translate([post_width/2+wall_thickness+wire_width,(void_width+bevel_width*2)/2-post_width/2-wire_width/2,0])
        short_post();
    }
    
    translate([0,0,wall_thickness]){
        translate([post_width/2+wall_thickness+wire_width+2*cos(30)*(post_width+wire_width),(void_width+bevel_width*2)/2-post_width/2-wire_width/2,0])
        short_post();
    }
    
    translate([0,0,wall_thickness]){
        translate([post_width/2+wall_thickness+wire_width+cos(30)*(post_width+wire_width),(void_width+bevel_width*2)/2-wire_width/2-post_width/2+sin(30)*(post_width+wire_width),0])
        short_post();
    }
}


module long_three_posts(){
     translate([0,0,wall_thickness]){
        translate([post_width/2+wall_thickness+wire_width+2*cos(30)*(post_width+wire_width),(void_width+bevel_width*2)/2+post_width/2+wire_width/2,0])
        long_post();
    }
    
    translate([0,0,wall_thickness]){
        translate([post_width/2+wall_thickness+wire_width,(void_width+bevel_width*2)/2+post_width/2+wire_width/2,0])
        long_post();
    }
    
    translate([0,0,wall_thickness]){
        translate([post_width/2+wall_thickness+wire_width+cos(30)*(post_width+wire_width),(void_width+bevel_width*2)/2-post_width/2-wire_width/2+sin(30)*(post_width+wire_width),0])
        long_post();
    }
}


module holder(){
    difference(){
        if (resister_width+holder_width*2+kerf*2 > void_width+bevel_width*2-wall_thickness*2){
            
            cube([holder_width,resister_width+holder_width*2-kerf*2,(void_depth+bevel_width*2)/2-wall_thickness+0.001-support_clearance]);
        }else{
            cube([holder_width,resister_width+holder_width*2,(void_depth+bevel_width*2)/2-wall_thickness+0.001-support_clearance]);
        }
        translate([-0.002,(resister_width+holder_width*2)/2,(void_depth+bevel_width*2)/2-wall_thickness+0.001])
        rotate([0,90,0])
        cylinder(1/16*inch+0.004,resister_width/2,resister_width/2,$fn=100);
    }
}

module holders(){
    
    translate([(void_length+bevel_width*2-5)/2,(void_width+bevel_width*2-resister_width-holder_width*2)/2+((resister_width+holder_width*2+kerf*2 > void_width+bevel_width*2-wall_thickness*2)?kerf:0)
            ,wall_thickness-0.001])
    holder();
    
    translate([(void_length+bevel_width*2+5)/2-holder_width,(void_width+bevel_width*2-resister_width-holder_width*2)/2+((resister_width+holder_width*2+kerf*2 > void_width+bevel_width*2-wall_thickness*2)?kerf:0),wall_thickness-0.001])
    holder();
    
}

module box_open(){
    bottom_half();

    translate([0,void_width+bevel_width*3,0])
    top_half();
}

module box_close(){
    bottom_half();

    translate([0,void_width+bevel_width*2,void_depth+bevel_width*2])
    rotate([180,0,0])
    top_half();
}

module box_close_test(){
    bottom_half();

    translate([0,void_width+bevel_width*2,void_depth+bevel_width*2+connector_width])
    rotate([180,0,0])
    top_half();
}

//bottom_half();
//top_half();

//box_open();  
//box_close();


difference(){    
    box_close();
    cube([(void_length+bevel_width*2)/2,void_width+bevel_width*2,void_depth+bevel_width*2]);
}


//box_close_test();
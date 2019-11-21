inch=25.4;

ounces=640;

body_fineness=128;

hole_fineness=32;

ring_fineness=64;

bucket_height=14.25*inch;

bucket_base_outer_width=(10+17/32)*inch/2;

bucket_top_outer_width=(11+9/16)*inch/2;

bucket_top_rim_width=(11+15/16)*inch/2;

bucket_base_inner_width=bucket_base_outer_width-.125*inch;
bucket_top_inner_width=bucket_top_outer_width-0.125*inch;

rim_height=3/16*inch;

ring_width=3/16*inch;
ring_height=1/16*inch;

floor_height=1/4*inch;

shell_thickness=1/8*inch;

theta=atan((bucket_top_outer_width-bucket_base_outer_width)/bucket_height);

ring_first_height=bucket_height-(1+3/4)*inch;

ring_first_width=bucket_base_outer_width+sin(theta)*(ring_width+ring_first_height)+ring_width;

ring_second_height=bucket_height-(3+7/16)*inch;

ring_second_width=bucket_base_outer_width+sin(theta)*(ring_width+ring_second_height)+ring_width;

handle_length=bucket_top_rim_width*2+1/4*inch;
handle_width=(1+5/16)*inch;
handle_height=(1+3/4)*inch;

scale_by_ounces=1/pow(640/ounces,1/3);

module bucket_shape(){
    cylinder(bucket_height,bucket_base_outer_width,bucket_top_outer_width,$fn=body_fineness);
}

module bucket(){
    difference(){
        bucket_shape();
        
        // Bucket cavity
        
        difference(){
            translate([0,0,-0.01])
            cylinder(bucket_height+0.02,bucket_base_inner_width,bucket_top_inner_width,$fn=body_fineness);
            
            translate([0,0,floor_height])
            cylinder(shell_thickness,bucket_top_inner_width,bucket_top_inner_width,$fn=body_fineness);
        }
    }
    
    // Bucket Rim
   
    translate([0,0,bucket_height-rim_height])
    difference(){
        cylinder(rim_height,bucket_top_rim_width,bucket_top_rim_width,$fn=ring_fineness);
        translate([0,0,-0.1])
        cylinder(rim_height+0.2,bucket_top_inner_width,bucket_top_inner_width,$fn=ring_fineness);
    }
    
    // Bucket First Ring
    
    difference(){
        translate([0,0,ring_first_height])
        cylinder(ring_height,ring_first_width,ring_first_width,$fn=ring_fineness);
        
        bucket_shape();
    }
    
    // Bucket Second Ring
    
    difference(){
        translate([0,0,ring_second_height])
        cylinder(ring_height,ring_second_width,ring_second_width,$fn=ring_fineness);
        
        bucket_shape();
    }
    
    // Bucket Handle Attachment Right
    
    
    difference(){
        translate([-handle_length/2,-handle_width/2,ring_second_height])
        cube(size=[handle_length,handle_width,handle_height]);
        
        translate([-handle_length/2+1/16*inch,-handle_width/2+1/16*inch,ring_second_height+1/16*inch])
        cube(size=[handle_length-1/8*inch,handle_width-1/8*inch,handle_height-1/8*inch]);

        translate([0,0,ring_second_height+5/32*inch+15/16*inch])
        union(){
            translate([0,0,1/32*inch])
            rotate([0,90,0])
            cylinder(handle_length/2+0.1,1/8*inch,1/8*inch,$fn=hole_fineness);


            translate([0,0,-1/32*inch])
            rotate([0,90,0])
            cylinder(handle_length/2+0.1,1/8*inch,1/8*inch,$fn=hole_fineness);

            translate([0,-1/8*inch,-1/32*inch])
            cube(size=[handle_length/2+0.1,1/4*inch,1/16*inch]);
        }        
        
        translate([0,0,ring_second_height+1/8*inch+inch])
        rotate([0,-90,0])
        cylinder(handle_length/2+0.1,1/8*inch,1/8*inch,$fn=hole_fineness);

        bucket_shape();
    }
    
    
    hole_reinforcement=(1/8+3/64)*inch;

    // Hole Reinforcement Right
    translate([handle_length/2-3/32*inch,0,ring_second_height+5/32*inch+15/16*inch])
    rotate([0,90,0])
    difference(){
        union(){
            translate([1/32*inch,0,0])
            cylinder(1/8*inch,hole_reinforcement,hole_reinforcement,$fn=hole_fineness);
            
            translate([-1/32*inch,0,0])
            cylinder(1/8*inch,hole_reinforcement,hole_reinforcement,$fn=hole_fineness);
            
            translate([-1/32*inch,-hole_reinforcement,0])
            cube(size=[1/16*inch,hole_reinforcement*2,1/8*inch]);
            
        }
        
        translate([1/32*inch,0,-0.1])
     cylinder(1/8*inch+0.2,1/8*inch,1/8*inch,$fn=hole_fineness);   
        
        translate([-1/32*inch,0,-0.1])
     cylinder(1/8*inch+0.2,1/8*inch,1/8*inch,$fn=hole_fineness);   
        
        translate([-1/32*inch,-1/8*inch,-0.1])
        cube(size=[1/16*inch,1/4*inch,1/8*inch+0.2]);
    }
    
    // Hole Reinforcement Left

    translate([-handle_length/2+3/32*inch,0,ring_second_height+(1/8)*inch+inch])
    rotate([0,-90,0])
    difference(){
     cylinder(1/8*inch,hole_reinforcement,hole_reinforcement,$fn=hole_fineness);
        translate([0,0,0.1])
     cylinder(1/8*inch+0.2,1/8*inch,1/8*inch,$fn=hole_fineness);   
    }
}

scale(scale_by_ounces)
union()
bucket();

    
// Speed Square Holster
// By Jay Littlefield
// August 27, 2016

// Base Parameters
width = 42;
//length=26;
height=165;
basethickness=8;
cornerradius=5;
// Length, Width computed below

// Square Dimensions
// 0.886 inches
square_width=23;

//0.193 inches
square_thick=5;

//1 mm total clearance around
square_clear=1;

//Belt Clip
clip_height=70;
clip_width=23;
clip_thickness=1;
clip_clearance=0.5;
bolt_hole_dist_from_top = 60;
//bolt_hole_dist_from_top = 7.5;


// Nut Dimensions
nut_s = 10.58;
nut_d = 5.05;
nut_m = 3.20;

nut_width_clearance = 0.5;
nut_depth_clearance = 1;

// Bolt dimensions
bolt_clearance_diam = 5.61;
bolt_depth = 15.74;
bolt_depth_clearance = 1;

// Computed width / length of base
length = clip_width + 2*cornerradius;

length_square_ratio = 2/3;
width_ratio = 4/8;


CHX = 4*clip_thickness + clip_clearance;
CHY = (length - clip_width - clip_clearance)/2;


$fn=100;



module roundedcube(xdim ,ydim ,zdim,rdim){
hull(){
translate([rdim,rdim,0])cylinder(h=zdim,r=rdim);
translate([xdim-rdim,rdim,0])cylinder(h=zdim,r=rdim);

translate([rdim,ydim-rdim,0])cylinder(h=zdim,r=rdim);
translate([xdim-rdim,ydim-rdim,0])cylinder(h=zdim,r=rdim);
}
}



module nutandbolt(nut_width,nut_depth,bolt_dia,bolt_depth, nut_spacer_depth) {
    
    // Nut
    linear_extrude(height=nut_depth) {
        circle(nut_width,$fn=6);
    }

    // Bolt
    linear_extrude(height=bolt_depth) {
        circle(bolt_dia,$fn=100);
    }

    // Front clearance hole
    linear_extrude(height=nut_spacer_depth) {
        circle(nut_width+0.5,$fn=100);
    }  
    
    // Taper for 3D printing
    //translate([-nut_width/2,0,0])
    //linear_extrude(height=nut_spacer_depth) {
    //    circle(nut_width+1,$fn=4);
    //}   
}



difference() {
    
    // Base 
    roundedcube(width,length,height,cornerradius);
    //cube([width,length,height]);
  
    // Square Base
    translate([width*width_ratio - square_width/2,length*length_square_ratio,basethickness]) cube([square_width,     square_thick+square_clear,height]);
       
    
    // Square Arm
    translate([width*width_ratio -(square_thick + square_clear)/2,0,basethickness]) {
       
        cube([square_thick+square_clear,length*length_square_ratio,height]);
    }


      // Clip Holder
    translate([CHX,CHY,height-clip_height - 2]) {
            cube([clip_thickness+clip_clearance,clip_width+clip_clearance,clip_height+3]);
    }

           
    // Nut and bolt hole
    translate([-0.5,length/2,height-    bolt_hole_dist_from_top]) {
        rotate([90,90,90]) {
            nutandbolt((nut_s+nut_width_clearance)/2,nut_m+nut_depth_clearance+CHX+clip_thickness+clip_clearance,bolt_clearance_diam/2, bolt_depth + bolt_depth_clearance +   nut_depth_clearance,CHX+1.5);
        }
    }
  
    // Cutaway
   translate([width*width_ratio,0,height-5]) {
        rotate([270,90,0]) {
            linear_extrude(height=length*           length_square_ratio+square_thick            +square_clear) {
                circle(square_width,$fn=3);
            }   
        }
    }
     
    
}


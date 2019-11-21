//Bottom Lipo Plate for the T4bee Frame
//Designed so the screws will go in flush
//Print in TPU for extra protection and anti slip properties
//Frame: https://www.thingiverse.com/thing:1783281


mount_d=28;
size=35;
height=3.2;
mount_hole=3;
mount_hole_head=5.7;
mount_hole_head_depth=2.2;

ridge_width=size*0.6;
ridge_height=0.6;
ridge_depth=1;
ridge_spacing=3;

lipo_slit_size=15;
lipo_slit_width=1.5;

minimal_width=27; //only relevant if you print without sides

n=0.1;
$fn=30;


option_no_sides=true;   //false to make it full size

//Add ridges 
//if you print in tpu on a glass bed print it inverted, that way the lipo will stick to the smooth side
option_ridges=false;    


module holes(width,h,z) {
    //Holes    
    translate([mount_d*0.5,0,z])
        cylinder(d=width,h=h+n,center=true);
    translate([-mount_d*0.5,0,z])
        cylinder(d=width,h=h+n,center=true);
    translate([0,mount_d*0.5,z])
        cylinder(d=width,h=h+n,center=true);
    translate([0,-mount_d*0.5,z])
        cylinder(d=width,h=h+n,center=true);

    translate([mount_d*0.5,mount_d*0.5,z])
        cylinder(d=width,h=h+n,center=true);
    translate([-mount_d*0.5,mount_d*0.5,z])
        cylinder(d=width,h=h+n,center=true);
    translate([-mount_d*0.5,-mount_d*0.5,z])
        cylinder(d=width,h=h+n,center=true);
    translate([mount_d*0.5,-mount_d*0.5,z])
        cylinder(d=width,h=h+n,center=true);    
    
}

union() {
    intersection() {
        difference() {
            intersection() {
                cube([size,size,height],center=true);                        
                 cylinder(d=size+mount_hole_head*2,h=height*2,center=true);
             }
            //Holes    
            holes(mount_hole,height,0);
            holes(mount_hole_head,height,height-mount_hole_head_depth);

            //lipo slit
            rotate([0,0,-45])
            {
                translate([0,(mount_d+3.9)*0.5,z])
                    cube([lipo_slit_size,lipo_slit_width,height+n],center=true);
                translate([0,-(mount_d+3.9)*0.5,z])
                    cube([lipo_slit_size,lipo_slit_width,height+n],center=true);
                /*translate([(mount_d+0.4)*0.5,0,z])
                    cube([lipo_slit_width,lipo_slit_size,height+n],center=true);
                translate([-(mount_d+0.4)*0.5,0,z])
                    cube([lipo_slit_width,lipo_slit_size,height+n],center=true);*/
            }    
            
            //translate([-mount_d*0.5,-mount_d*0.5,z])
            //lipo_slip_size
        }

        if(option_no_sides) {
            rotate([0,0,45])
            cube([minimal_width,100,height],center=true);
        } else {
            //hack to avoid any cutting
            cube([1000,1000,1000],center=true);
        }
    }

    //ridges

if(option_ridges) {
    ridge_area=(size-2);

    intersection() {
        //ridges
        rotate([0,0,45])
            for(i=[1:(ridge_area/(ridge_depth*ridge_spacing))]) {   
                translate([0,-(ridge_area*0.5)+i*ridge_spacing,height*0.5+ridge_height*0.5])
                    cube([ridge_width,ridge_depth,ridge_height],center=true);
            }
            
        //cut into shape
        cube([size*0.6,size*0.6,100],center=true);
     }
 }
 }    
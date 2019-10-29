//Stack Cover for T4bee Frame 
//Frame: https://www.thingiverse.com/thing:1783281

mmt_distance=40; //mount to mount distance, sides would be ~ side=28.28;
cutout_r=37;     //radius for cutting the curved walls (estimate)
height=14.7;

wall_size=1;
wall_size_standoffs=1;
standoff_width=6.5; //=hole size

cutout_side_height=7.5;  //height for the arm cutouts to accomodate ESCs
cutout_side_width=13.5;  //width of the arm cutouts to accomodate ESCs
cutout_rear_height=height*0.4;  //Cutout on the rear for the battery cable

//Options
option_cutout_sides=true;
option_cutout_rear=true;
//@TODO cutout for usb? My USB Port is covered by one of the standoffs so I didn't bother with that

//Helper/Misc
n=0.1;  //little additional space for substracting
$fn=50; //Level of detail on the rounding

module body(factor,height) {
    r=cutout_r+factor;
    h=height+n;
    
    difference() {
        //Body
        cube([mmt_distance,mmt_distance,height],center=true);
        
        //Curves
        union() {
            translate([-r,-r,0])
                cylinder(r=r,h=h,center=true);
            translate([-r,r,0])
            
                cylinder(r=r,h=h,center=true);
            translate([r,-r,0])
                cylinder(r=r,h=h,center=true);
            translate([r,r,0])
                cylinder(r=r,h=h,center=true);
        }
    }    
}

difference() {    
    union() {
        difference() {
            //Main Body solid
            body(0,height);
            
            //Remove inside for walls
            translate([0,0,3])
                body(-wall_size*2,height+10);
            
            //Cutouts side (arms and esc)
            if(option_cutout_sides) {
                translate([0,0,-(cutout_side_height*0.5)])
                rotate([0,0,45]) {                
                    cube([cutout_side_width,mmt_distance,cutout_side_height],center=true);
                        rotate([0,0,90])
                            cube([cutout_side_width,mmt_distance,cutout_side_height],center=true);
                }
            }
        }
        
        //Standoffs
        translate([0,mmt_distance*0.5,0])
            cylinder(d=standoff_width+wall_size_standoffs*2,h=height,center=true);
        translate([mmt_distance*0.5,,0])
            cylinder(d=standoff_width+wall_size_standoffs*2,h=height,center=true);
        translate([0,-mmt_distance*0.5,0])
            cylinder(d=standoff_width+wall_size_standoffs*2,h=height,center=true);
        translate([-mmt_distance*0.5,0,0])
            cylinder(d=standoff_width+wall_size_standoffs*2,h=height,center=true);        
    }
    
    
    //Standoff holes
    translate([0,mmt_distance*0.5,0])
        cylinder(d=standoff_width,h=height+n,center=true);
    translate([mmt_distance*0.5,0,0])
        cylinder(d=standoff_width,h=height+n,center=true);
    translate([0,-mmt_distance*0.5,0])
        cylinder(d=standoff_width,h=height+n,center=true);
    translate([-mmt_distance*0.5,0,0])
        cylinder(d=standoff_width,h=height+n,center=true);
    
    //Cutout on the back to let the battery cable out - I made it half the size
    if(option_cutout_rear) {        
        translate([0,mmt_distance*0.5,-(height-cutout_rear_height)*0.5-n])
            cylinder(d=standoff_width*3,h=cutout_rear_height,center=true);
    }
}
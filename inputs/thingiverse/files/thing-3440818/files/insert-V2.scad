// Size of the holder
length = 73;
width = 24;
height = 12;

//size of the tab
tab_height = 4;
tab_width = 4;
tab_length = 11.5;

//size of the lock
lock_length = 18.5;
lock_height = 13;
lock_width = 4;
cut_length = 13;
cut_width = 2;

// bit fudge factor
fudge = 1.02;

//inches to mm conversion
in_to_mm = 25.4;

//bit size
bit_dia_points =.288*in_to_mm*fudge;
bit_dia_flats = .25*in_to_mm*fudge;

//number of slots for bits
num_slots= 9;

keeper_length = 10;
keeper_dia = 0.5;
    
difference(){
    union(){
        // main body
        cube([length,width, height],center=true);
        
        //tab
        difference(){
            translate([-(length+tab_width)/2, 0, -(height-tab_height)/2]) cube([tab_width,tab_length,tab_height],center=true);
            
            translate([-(length+tab_width+4)/2, 0,-(height/2-tab_height)]) rotate([0,-30,0]) cube([tab_width,tab_length,2],center=true);
            
            translate([-(length+tab_width+4)/2, 0,-height/2]) rotate([0,30,0]) cube([tab_width,tab_length,2],center=true);
    
        }
        //lock
        translate([(length+lock_width)/2, 0, -(height-lock_height)/2])
        difference(){
            cube([lock_width, lock_length, lock_height],center=true);
            translate([(lock_width-cut_width)/2, 0, 0]) cube([cut_width, cut_length, lock_height],center=true);
        }
    }

    min_edge = 1;
    width2= length - 2 * min_edge;
    step = width2 /(num_slots);
    start = -width2/2+step/2;
    end = width2/2;     
    for (x=[start:step:end]){
        translate([x,0,0])SingleBitHolder();
    }
}
module SingleBitHolder(){
    difference(){
    union(){
    // horizontal hole
    translate([0,1,height/2-5])rotate([90,30,0])cylinder(d=bit_dia_points, h=width, center=true,$fn=6);
    translate([0,10,height/2-2])rotate([90,0,0])cube([bit_dia_flats,bit_dia_flats,width], center=true);
    }
    
    //bit keepers
    translate([bit_dia_flats/2,6,height/2-3])rotate([90,0,0])cylinder(d=keeper_dia,h=keeper_length, center=true,$fn=20);
    translate([-bit_dia_flats/2,6,height/2-3])rotate([90,0,0])cylinder(d=keeper_dia,h=keeper_length, center=true,$fn=20);
    }
    // vertical hole
    translate([0,-3,0])rotate([0,0,30])cylinder(d=bit_dia_points, h=height, center=true,$fn=6);
    translate([0,-8,-4])cube([bit_dia_flats,bit_dia_flats,height], center=true);
}

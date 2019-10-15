//Lipo Strap Plate for T4bee Frame
//Frame: https://www.thingiverse.com/thing:1783281

//Aproximate sizes for reference
//Nanotech 3s 1000mah - 33x72
//Nanotech 3s 1300mah 34x72
//LiHV 850mah 34x78
//LiHV 1000mah 34x72
//Nanotech 3s 850 30x34
//3s 11100 34x77
//Nanotech 4s 30x55.5

width=38;
length=70;
thickness=3;
slot_distance=34;
slot_size=2;
slot_width=17;

middle_cutout_width=34;
middle_cutout_length=length;
middle_cutout_height=1;

n=0.1;

difference() {
    
    //Plate
    cube([width,length,thickness],center=true);
    
    //Slots
    translate([slot_distance*0.5,0,0])
        cube([slot_size,slot_width,thickness+n],center=true);
    
    translate([-slot_distance*0.5,0,0])
        cube([slot_size,slot_width,thickness+n],center=true);
    
    //Middle cutout for tape/lipo etc.
    translate([0,0,thickness*0.5-middle_cutout_height*0.5])
        cube([middle_cutout_width,middle_cutout_length+n,middle_cutout_height+n],center=true);
    
}
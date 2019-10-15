slots_stone=9;
slots_diamant=3;
slot_width=11;
box_Z=11;

slots=(slots_stone+slots_diamant);
difference(){
    cube([slot_width*slots+4,155+5+6,box_Z+2+2]);
    //translate([2,2+2.5,2])cube([12*slots,156,22+2]);
    for(i=[0:1:slots_stone-1]){
        translate([2+(i*slot_width),2,2])brousek(161);
    }
    for(i=[0:1:slots_diamant-1]){
        translate([2+((i+slots_stone)*slot_width),2,2])brousek(163);
    }
    
};
translate([0,30,2])rotate([0,90,0])cylinder(d=4,h=slot_width*slots+4,$fn=10);
translate([0,155+5+4-30,2])rotate([0,90,0])cylinder(d=4,h=slot_width*slots+4,$fn=10);



module brousek(length){
    zet=25;//original=23
    difference(){
        cube([slot_width,length,zet]);
        cube([slot_width-4,4,zet]);
        translate([slot_width-3,-3,0])rotate([0,0,45])cube([4,6,zet]);
        translate([0,length-4,0]){
            cube([slot_width-4,4,zet]);
            translate([slot_width-4,1,0])rotate([0,0,45])cube([6,6,zet]);
        }
        
    }
}
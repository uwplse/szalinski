// This is the first try to make a parametric battery case.
//Please be patient if it is not working as expected.
//gobo38, 2018/11/18

battery_length=70;         // typical 70 for 21700 or 65 for 18765
battery_diameter=21;    // typical 21 for 21700 or 18 for 18650
battery_count=4;           // number of tubes you want to make PER ROW! 
rows=2;                         // number of rows
                                      
$fn=50;
module tube(){
    difference(){
        cylinder(h=battery_length+4, d=battery_diameter+4);
        translate([0,0,2])cylinder(h=battery_length+4, d=battery_diameter+1);
    }
}
module cap(){
    translate([0,-80,0])
    difference(){
        for (i=[0:battery_count-1], s=[0:rows-1])
        translate([i*(battery_diameter+3),s*(battery_diameter+3),0])
        cylinder(h=10, d=battery_diameter+6);
        for (i=[0:battery_count-1], s=[0:rows-1])
        translate([i*(battery_diameter+3),s*(battery_diameter+3),0])
        translate([0,0,2])cylinder(h=18,d=battery_diameter+4);
    }
}
for (i=[0:battery_count-1], s=[0:rows-1])
   translate([i*(battery_diameter+3),s*(battery_diameter+3),0])
tube();
cap();
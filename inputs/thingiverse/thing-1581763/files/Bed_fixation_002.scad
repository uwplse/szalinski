//Set height : distance between the plate and the center of the 8mm rod
height=29.5;//[10:0.5:50]

//Set width 
width=17;//[10:0.5:45]

//Screw spacing
Screw_spacing=30;//[20:0.5:35]

//What kind of bearing? or bearing mount?
bearing_option=1;//[0:printed bearing,1:15mm bearing no gap,2:15mm bearing with gap,3:15mm bearing hold with filament]
//Offset bearing position
bearing_shift_position=0;//[0:0.1:1]

//printer accuracy, positive value will add some space for bearings plug
tolerance=0;//[-0.3:0.05:1]
//definition
$fn=40;//[40:low,60:medium,100:high]

//////////////////////////////////////////////
module dent(angle) {
rotate([0,0,angle]) translate([tolerance,0,0]) hull() {
translate([4.3,-0.4,0]) cylinder(d=0.5,h=width+4,center=true);
translate([4.325,0.1,0]) cylinder(d=0.5,h=width+4,center=true);
translate([6.5,0.2,0]) cylinder(d=0.5,h=width+4,center=true);
translate([6.2,2.55,0]) cylinder(d=0.5,h=width+4,center=true);
}
}
module bearing(a) {
    if(a==0) {
        difference() {
            cylinder(d=13,h=width+2,center=true);
            for (i=[0:360/9:360-360/9]) dent(i);
        }
    }
    
    else if(a==1) {
        cylinder(d=15+2*tolerance,h=width+2,center=true);
    }
    
    else if(a==2) {
        difference() {
            cylinder(d=15+2*tolerance+2,h=width+2,center=true);
            for (i=[45:90:315]) rotate([0,0,i]) translate([7.5+tolerance+1.75/2,0,0]) cylinder(d=1.75,h=width+2+2,center=true);
            }
    }
    
    else if(a==3) {
        cylinder(d=15+2*tolerance+1,h=width+2,center=true);
        for (i=[45:90:315]) rotate([0,0,i]) translate([7.5+tolerance+1.25/2,0,0]) cylinder(d=1.75,h=width+2+2,center=true);
    }
}

module Common_part() {
    difference() {
        union() {
            difference() {
                translate([0,10,0]) cylinder(d=41,h=width,center=true);
                translate([0,43/2+10,0]) cube([43,43,width+2],center=true);
            }
            translate([0,5+height/2,0]) cube([41,height-10,width],center=true);
        }
        hull() {
            for (i=[17.75,17.75+height]) translate([0,i,0]) scale([1,0.9,1]) cylinder(d=15,h=width+2,center=true);}
    
        for(i=[Screw_spacing/2,-Screw_spacing/2]) translate([i,-2.5,0]) rotate([90,0,0]) rotate([0,0,0]) cylinder(d=6.5,h=14,$fn=6,center=true);
        for(i=[Screw_spacing/2,-Screw_spacing/2]) translate([i,-2.5,0]) rotate([-90,0,0]) cylinder(d=3.4,h=height+5);
    
    }    
    
}



difference() {
    Common_part();
    translate([bearing_shift_position,0,0]) bearing(bearing_option);
}



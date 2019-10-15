hotbed_diam = 220;
hotbed_thickness = 3.1;
s_thickness = 15;
s_lenght = 50;
s_widht = 20;
zplate_diam = 220;
zplate_thickness = 4.24;
back_support = 30;
support_widht = 10;
support_length = 15;

$fn = 80;
union(){
difference(){
union(){
difference(){
    translate([-s_lenght/2,0,0]) cube([s_lenght,s_widht,s_thickness]);
   
    translate([0,hotbed_diam/2+s_widht-5,(s_thickness-hotbed_thickness-zplate_thickness)]) cylinder(r=hotbed_diam/2,h=10);
    }
difference(){
    translate([s_lenght/2,0,0]) cube([support_length,back_support,5]);
    hull() {
        translate([s_lenght/2+8,5,0]) cylinder(r=2.1,h=5,center=false);
        translate([s_lenght/2+8,back_support-6,0]) cylinder(r=2.1,h=5,center=false);
    }
    hull() {
        translate([s_lenght/2+8,5,3]) cylinder(r=4,h=5,center=false);
        translate([s_lenght/2+8,back_support-6,3]) cylinder(r=4,h=5,center=false);}
}    

difference(){
    translate([(-s_lenght/2)-support_length,0,0]) cube([support_length,back_support,5]);
    hull() {
        translate([-s_lenght/2-8,5,3]) cylinder(r=4,h=5,center=false);
        translate([-s_lenght/2-8,back_support-6,3]) cylinder(r=4,h=5,center=false);
    }
    
        hull() {
        translate([-s_lenght/2-8,5,0]) cylinder(r=2.1,h=5,center=false);
        translate([-s_lenght/2-8,back_support-6,0]) cylinder(r=2.1,h=5,center=false);}
    }

}
translate([0,s_widht/2-3,0]) cylinder(r=2.1, h=s_widht);
}
translate([-s_lenght/2,0,0]) cube([s_lenght,s_widht+support_widht,(s_thickness-hotbed_thickness-zplate_thickness)]);
}

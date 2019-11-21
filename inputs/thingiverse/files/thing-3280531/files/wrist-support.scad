$fn=100;

//support_width = 130;
//support_length = 50;
//support_height = 25;

support_width = 130;
support_length = 50;
support_height = 25;

difference(){
intersection() {
    translate([0,support_length/2,0])cylinder(h=support_height,r=support_width*0.515, center=true);
    cube([support_width,support_length,support_height],true);
}

translate([0,-support_length*1.1,0])cylinder(h=support_height*1.04,r=support_length*0.86, center=true);
translate([0,support_length*1.36,0])cylinder(h=support_height*1.04,r=support_length, center=true);
translate([0,-support_height*0.8,-support_width*1.585])rotate([80,0,0])cylinder(h=support_length*1.6,r1=support_width*1.654,r2=support_width*1.5, center=true);
//translate([0,0,64])rotate([90,0,0])cylinder(h=150,r=60, center=true);
}


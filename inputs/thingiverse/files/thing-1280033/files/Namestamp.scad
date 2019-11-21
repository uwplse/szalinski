// (1 Char)
last_name = "傅";
//Firstname (1st Char)
first_name_1 = "歐";
//Firstname (2nd Char)
first_name_2 = "立";
//Stamp Size (mm)
size = 40; // [15:5:100]
// Google Fonts
font = "PingFang TC:style=Semibold";

//font = "Weibei TC:style=Bold";

height = size*1.5;
$fn = 100 * 1;

rotate([180,0,0])
union(){
difference(){
    cube([size,size,height], center = true);
    translate([0,0,-height/2])
        cube([size-2,size-2,3], center = true);
}
translate([0,0,-height/2 - 0])
    linear_extrude(height=5, scale=1)
    union(){
        translate([-size/20,size/5]) rotate([0,0,90])
            text(first_name_1, font = font, size=size/3, halign="center", spacing = 1);
        translate([size/2.4,size/5]) rotate([0,0,90])
            text(first_name_2, font = font, size=size/3, halign="center", spacing = 1);
        
        
        translate([size/3,-size/4])
            rotate([0,0,90])        
                scale([1,1.9])
                    text(last_name, font = font, size=size/3, halign="center", spacing = 1);
    }

translate([-size/2.8,0,0]) sphere(r=size/5);
}


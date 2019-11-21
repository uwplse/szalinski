
// Only listed a few fonts, others I tried didn't fit vertically without making the letters smaller. 
font="Arial Black"; //[Arial Black,Aclonica,Avenir,Avenir Next,Courier,Helvetica,Keyboard,Optima,Palatino,PingFang,Times]

text = "Bollardville.com";
text_thickness = 2;		    // [0.1:0.1:4]
offset = -54;               // [-80:1.0:5]


module tag(text)
{
    difference() {
        translate([0,0,0]) cube([194,25,1]);
        translate([16,13,-1]) cube([160,15,3]);
        translate([16,13,-1]) rotate([0,0,25]) cube([25,25,3]);
        translate([176,13,-1]) rotate([0,0,60]) cube([25,25,3]);
        translate([7,18,-1]) cylinder(r=4,3);
        translate([187,18,-1]) cylinder(r=4,3);
    }

    // Text
    translate([82+offset,.5,1]) linear_extrude(text_thickness) text(text,12, font);
}

tag(text);


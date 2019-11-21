width = 20;
length1 = 30; // Defaults to 30 for mode 1 and 20 for mode 2
length2 = length1 + 12;
height = 2;
text_height = 1;
radius = 2;
radius2 = 5;
radius_coin = 12;
line1 = "Line 1";
text_scale = 0.8; // Defaults to 0.8
text_scale_width = 0.6; // Defaults to 0.6 
font="Liberation Sans:style=bold";
mode = 1; // 1 = add, 2 = sub

difference() {
    union()
    {
        // coin
        translate([-radius_coin,width / 2,0]) cylinder(height, radius_coin, radius_coin, $fn=50);
        // body
        hull() {
            translate([-radius_coin,width / 2,0]) cylinder(height, radius, radius, $fn=20);
            translate([radius,radius,0]) cylinder(height, radius, radius, $fn=20);
            translate([radius,width-radius,0]) cylinder(height, radius, radius, $fn=20);
            translate([length1-radius,radius,0]) cylinder(height, radius, radius, $fn=20);
            translate([length1-radius,width-radius,0]) cylinder(height, radius, radius, $fn=20);
            // outer cylinder for keyring
            translate([length2,width / 2,0]) cylinder(height, radius2, radius2, $fn=20);
        }
    }
    // Cut out hole for key ring
    translate([length2,width / 2,0]) cylinder(10, radius, radius, true, $fn=20);
    if(mode == 2) {
        // Text for mode 2
        translate([-radius_coin*1.2,width/2,1]) linear_extrude(height = height+1) {
            scale([text_scale_width, text_scale, text_scale]) text(line1, valign = "center", font=font);
        }
    }
}
if(mode == 1) {
    // Text for mode 1
    translate([5,width/2,height-0.1]) linear_extrude(height = text_height) {
        scale([text_scale_width, text_scale, text_scale]) text(line1, valign = "center", font=font);
    }
}
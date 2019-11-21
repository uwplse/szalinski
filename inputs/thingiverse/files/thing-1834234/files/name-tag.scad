// Name Tag for Lanyard
// Peter Griffiths 2016

depth = 92;
width = 60;
thick = 2.5;
rad = 3; // corner radius
f_ont1 = "roboto";
f_ont2 = "roboto";
font_size_1 = 6; // Letter Size
font_size_2 = 12;
letter_space = 1.1; // Letter spacing
letter_depth = 0.8;
text1_position = 10;
text2_position = 8;
text3_position = 7;
text1 = "Uppa Creek Railway";
text2 = "Fat";
text3 = "Controller";

$fn = 40;

module tag()
    union(){
        translate([-8,depth/2-8,0])
            cube ([8,16,thick]);
        translate([0,depth/2-8,0])
            cylinder(h=thick,r=8);
        translate([0,depth/2+8,0])
            cylinder(h=thick,r=8);
        difference(){
            translate([-2,depth/2-18,0])
                cube([4,4,thick]);
            translate([-2,depth/2-17.8,-0.5])
                cylinder (r=2,h=thick+1);
        }
        difference(){
            translate([-2,depth/2+14,0])
                cube([4,4,thick]);
            translate([-2,depth/2+17.8,-0.5])
                cylinder (r=2,h=thick+1);
        }
    }

module tag_complete(){ 
    difference(){
        tag();
        translate([-5,depth/2-4,-.5])
            cube([5,8,thick+1]);
        translate([-2.5,depth/2-4,-.5])
            cylinder(h=thick+1,d=5);
        translate([-2.5,depth/2+4,-.5])
            cylinder(h=thick+1,d=5);
    }

    hull(){
        translate([rad,rad,0])
            cylinder(h=thick, r=rad);
        translate([width-rad,rad,0])
            cylinder(h=thick, r=rad);
        translate([rad,depth-rad,0])
            cylinder(h=thick, r=rad);
        translate([width-rad,depth-rad,0])
            cylinder(h=thick, r=rad);
    }
}

difference(){
    tag_complete();
// Text line 1
    rotate([0,0,90]){
        translate([depth/2,-width/2+font_size_1+text1_position, thick - letter_depth]) 
            linear_extrude(height = letter_depth)
                text(text1, font=f_ont1, size=font_size_1, halign = "center", spacing= letter_space);
// Text line 2           
        translate([ depth/2,-width+text2_position+font_size_2*1.3,thick - letter_depth])
            linear_extrude(height=letter_depth)
            text(text2, font = f_ont2, size = font_size_2, halign = "center",spacing= letter_space);
// Text line 3
        translate([depth/2,-width+text3_position,thick - letter_depth])
            linear_extrude(height=letter_depth)
            text(text3, font = f_ont2, size = font_size_2, halign = "center",spacing= letter_space);
    }
}
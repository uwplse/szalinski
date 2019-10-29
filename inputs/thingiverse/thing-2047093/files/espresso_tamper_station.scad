$fn = 50;

inner_diameter=62;
shell_thickness=3;
opening_width=26.5;
slot_width=21.5;
slot_height=6.75;
slot_depth=6.9;
depth=51.5;
handle_bottom_height=18;

difference(){
    union(){
        for(i = [0 : 1 : 2]){
            rotate([0,0,i*360/3]){
                translate([inner_diameter/2+(inner_diameter/2)*0.03,-21.5/2,0])
                cube([slot_depth,21.5,depth]);
            }
        }

        difference(){
            cylinder(h=depth+slot_height,r=inner_diameter/2+slot_depth+shell_thickness);
            translate([0,0,-1])cylinder(h=depth+slot_height+2,r=inner_diameter/2+slot_depth);
        }
    }

    translate([-inner_diameter,-opening_width/2,handle_bottom_height])
    cube([inner_diameter, opening_width,depth]);
}

translate([0,0,-3]) cylinder(h=3, r = 1.1*(slot_depth + shell_thickness+ inner_diameter/2));

// if you want to lable multiple cables approximate this
cable_diameter = 1.2;
// use this for ribbon cables
number_of_cables = 1;
// adjusts to the diameter if to small
label_width = 6;
label_length = 15;
// make this a little bit smaller than your diameter, if you use multiple cables make this smaller than a single cable diameter
opening_width = 1.1;
// creater value -> more space for the cable
inner_spacing = 0.05;
wall_thickness = 1;
floor_thickness = 1;
top_thickness = 0.4;

/* [Hidden] */
layout = "line"; // [1:Line ,pyramind:Pyramid]
radius = cable_diameter / 2;
padded_radius = radius + inner_spacing;
clamp_width = (cable_diameter - opening_width) / 2;
r_cos = radius - clamp_width;
r_sin = sqrt(radius*radius - r_cos * r_cos);
floor_end_to_top_start = (number_of_cables-1)*cable_diameter + radius + r_sin;
height = floor_thickness + floor_end_to_top_start + top_thickness;
top_width = cable_diameter + 2 * wall_thickness;

if(label_width < top_width) {
    label(top_width);
} else {
    label(label_width);
}

module label(working_label_width){
    translate([0, label_length/2, 0]){
        rotate([90,0,0]){            
            complete_label(working_label_width);
        }
    }           
}

module complete_label(working_label_width){
    difference(){
        main_body(working_label_width);
        cutouts(working_label_width);
    }
}

module main_body(working_label_width){
    a = [working_label_width/2, 0];
    b = [top_width/2, height];
    c = [0, height];
    linear_extrude(label_length){
        polygon([[0,0],a,b,c]);
        mirror([1,0,0]) polygon([[0,0],a,b,c]);
    }  
}

module cutouts(working_label_width){
    union(){
        cable_cut_outs(working_label_width);
        opening_cut_out(working_label_width);
    }
}

module cable_cut_outs(){
    if(layout == "line"){    
        for (k = [0 : number_of_cables-1]){
            y = floor_thickness + padded_radius + k*cable_diameter;
            cable_cut_out(0,y);
        }       
    }    
}

module cable_cut_out(x, y){
    translate([x, y, label_length/2]){
        cylinder(h = label_length+1, r = padded_radius, center= true, $fn=200);
    }    
}

module opening_cut_out(working_label_width){
    cutout_height = height - floor_thickness + 1;
    c1 = [0, floor_thickness];
    c2 = [opening_width/2, floor_thickness];
    c3 = [opening_width/2, height];
    c4 = [opening_width/2, height+1];
    c4 = [0, height+1];
    translate([0,0,-0.5]){
        linear_extrude(label_length+1){
            polygon([c1,c2,c3,c4]);
            mirror([1,0,0]) polygon([c1,c2,c3,c4]);
        } 
    }
}
    
    

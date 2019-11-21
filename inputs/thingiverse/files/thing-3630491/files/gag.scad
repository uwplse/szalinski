//Paramaterized spider gag
//@Cudatox, 2019

gag_thickness = 10;
gag_minor_radius = 23;
gag_major_radius = 30;

//Bar position and size
//Inner strap width will be approximately bar_width - gag_thickness
bar_width = 40;
bar_offset = 25;
bar_offset_z = 5;
bar_angle_in = 30;
//Resolution of the model. Increase this for a less jagged model.
resolution = 50;
//"Curviness" of the stap attatchments
quad_a = -0.06;

quad_z_correction = gag_thickness/4;
quad_c = bar_offset_z;
quad_b = (-quad_a*pow(bar_offset,2) - (quad_c - quad_z_correction))/bar_offset;


module base_shape(){
   // translate([0,0,gag_height/2])
   // cylinder(h=gag_height, d=gag_thickness, center=true,$fn=16);
   // translate([0,0,gag_height])
   // sphere(d=gag_thickness, center=true);
    sphere(d=gag_thickness, center=true);
}

module bar(length){
    translate([0, length/2, 0])
        sphere(d=gag_thickness, center=true);
    translate([0, -length/2, 0])
        sphere(d=gag_thickness, center=true);
}

for (a = [0 : resolution-1]){
    hull(){
        translate([gag_major_radius * cos((a/resolution) * 360), 
                    gag_minor_radius * sin((a/resolution) * 360), 0])
            base_shape();
        translate([gag_major_radius * cos(((a+1)/resolution) * 360), 
        gag_minor_radius*sin(((a+1)/resolution) * 360), 0])
            base_shape();
    }
}

//Vertical bars for straps
module bar(){
    hull(){
        translate([gag_major_radius + bar_offset, -bar_width/2, bar_offset_z])
            sphere(d=gag_thickness, center=true);
        translate([gag_major_radius + bar_offset, bar_width/2, bar_offset_z])
            sphere(d=gag_thickness, center=true);
    }
}

//endpoints x = cos(angle_in) * gag_major_radius, y = sin(angle) * gag_minor_radius
module bar_connector(){
    delta_bar_y = (bar_width/2) - (sin(bar_angle_in) * (gag_minor_radius)); 
    //distance between bar end and ring in y
    translate([bar_offset + gag_major_radius, 0, 0])
    for (i = [0:resolution]){
        //x = (i/resolution) * bar_offset
        //y = (bar_width/2) - ((bar_width/2) - (sin(bar_angle_in) * gag_minor_radius))
        hull(){
            translate([
                        -(i/resolution) * (bar_offset + gag_thickness/4), 
                
                        (bar_width/2) - (delta_bar_y * i/resolution), 
                 
                            (   quad_a * pow((i/resolution) * bar_offset,2) 
                                + quad_b * ((i/resolution) * bar_offset) 
                                + quad_c
                            )
                      ])
                      sphere(d=gag_thickness, center=true);
            
            translate([-(((i+1)/resolution) * (bar_offset + gag_thickness/4)), 
            
                        (bar_width/2) - (delta_bar_y * (i+1)/resolution), 
            
                        (   quad_a * pow((((i+1)/resolution) * bar_offset),2) 
                            + quad_b * ((((i+1)/resolution) * bar_offset)) 
                            + quad_c
                        )
                      ])
                    sphere(d=gag_thickness, center=true);
        }
    }
}

bar_connector();
mirror([0, 1, 0])
bar_connector();
mirror([1, 0, 0])
mirror([0, 1, 0])
bar_connector();
mirror([1, 0, 0])
bar_connector();

bar();
mirror([1, 0, 0])
bar();
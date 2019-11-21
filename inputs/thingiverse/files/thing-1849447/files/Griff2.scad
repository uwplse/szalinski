plate_width=160;//width
plate_depth=80; //depth
plate_thickness=10;  //plate thickness

handle_radius=15; //tube radius
handle_height=40;//handle height
handle_width=60;//handle width

text_text="GRIFF";
textscale=1.5;
textpos_x=-18;
textpos_y=-18;
textpos_z=-1;

plate();
handle();

module plate()
{
    difference() {
        translate([0,0,plate_thickness/2])
            minkowski(){
                cube([plate_width,plate_depth,plate_thickness],center=true);
                cylinder(r=5,h=1);
            }
        translate([-((plate_width-15)/2),-((plate_depth-15)/2),-1]) 
            cylinder(r=2,h=plate_thickness+3,$fn=120);
        translate([-((plate_width-15)/2)+10,-((plate_depth-15)/2),-1]) 
            cylinder(r=2,h=plate_thickness+3,$fn=120);
        translate([ ((plate_width-15)/2),-((plate_depth-15)/2),-1]) 
            cylinder(r=2,h=plate_thickness+3,$fn=120);
        translate([ ((plate_width-15)/2)-10,-((plate_depth-15)/2),-1]) 
            cylinder(r=2,h=plate_thickness+3,$fn=120);
        translate([ ((plate_width-15)/2), ((plate_depth-15)/2),-1]) 
            cylinder(r=2,h=plate_thickness+3,$fn=120);
        translate([ ((plate_width-15)/2)-10, ((plate_depth-15)/2),-1]) 
            cylinder(r=2,h=plate_thickness+3,$fn=120);
        translate([-((plate_width-15)/2), ((plate_depth-15)/2),-1]) 
            cylinder(r=2,h=plate_thickness+3,$fn=120);
        translate([-((plate_width-15)/2)+10, ((plate_depth-15)/2),-1]) 
            cylinder(r=2,h=plate_thickness+3,$fn=120);
//        translate([  0, ((d-15)/2),-1]) 
//            cylinder(r=2,h=20,$fn=120);
//        translate([  0,-((d-15)/2),-1]) 
//            cylinder(r=2,h=20,$fn=120);
    scale([textscale,textscale,1])
    translate([textpos_x,textpos_y,plate_thickness+textpos_z])
        linear_extrude(3)
        text(text_text,$fn=120);
    }
}

module handle()
{
    difference(){
        translate([0,20,handle_height])
        rotate([90,0,0])
        rotate_extrude(angle=360,convexity = 10,$fn=120)
            translate([handle_width, 20, 10])
                circle(r = handle_radius,$fn=120);
    translate([ -handle_width-handle_radius,
                -handle_radius,    
                0+handle_height-handle_width*2
        ])
        cube([(handle_width+handle_radius)*2,handle_radius*2,handle_width*2]);
    }
/*    translate([0,-20,handle_height])
    rotate([0,-90,-90])
    rotate_extrude(angle=90,convexity = 10,$fn=120)
        translate([handle_width, 20, 10])
            circle(r = handle_radius,$fn=120);
  */  
/*    translate([-handle_width/2,0,hh+rr*2])
    rotate([0,90,0])
        cylinder(r=handle_radius,h=ww,$fn=120);
*/
    translate([-(handle_width),0,0])
    rotate([0,0,0])
        cylinder(r=handle_radius,h=handle_height,$fn=120);

    translate([(handle_width),0,0])
    rotate([0,0,0])
        cylinder(r=handle_radius,h=handle_height,$fn=120);
}

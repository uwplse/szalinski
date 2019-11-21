echo(version=version());
/*[Hidden]*/
$fs = 0.1;
$fa = 5;

/*[Model]*/
//Wall height in mm (not used in middle-part)
wall_height = 40; 

//Diameter of the wires in mm
wire_thickness = 2.5;

//Distance between two Y-direction wires (back and forth) in mm
wire_yspacing = 46;
//Distance between two X-direction wires (side to side) in mm
wire_xspacing = 46;

trad_ydistance = wire_yspacing-wire_thickness;
trad_xdistance = wire_xspacing-wire_thickness;

floor_length = (trad_ydistance*2)-2;
floor_start = (trad_ydistance/2)-1;

thread_thickness_cut = (wire_thickness+0.15)/2;
thread_cut_part = thread_thickness_cut*2.4;

part = "c_right";// [top_bottom:Top and Bottom Part,side:Side-part,middle:Middle-part without walls,c_right:Top Right and Lower Left part,c_left:Top Left and Lower Right part]

module pie_slice(r=3.0,a=30){
    $fn = 64;
    linear_extrude(height=5){
        intersection(){
            circle(r=r);
            square(r);
            rotate(a-90) square(r);
        }
    }
}

translate([0,3.8,((trad_xdistance/2)-2.5)]){
    rotate(52.5) difference(){
        difference(){
            cylinder(h=5, r=thread_cut_part,center=false);
            cylinder(h=5, r=thread_thickness_cut,center=false);
        }
        union(){
            rotate(-14) pie_slice(r=thread_cut_part+0.1,a=16);
            pie_slice(r=thread_cut_part+0.1,a=90);
        }
    }
}
translate([trad_ydistance,3.8,((trad_xdistance/2)-2.5)]){
    rotate(52.5) difference(){
        difference(){
            cylinder(h=5, r=thread_cut_part,center=false);
            cylinder(h=5, r=thread_thickness_cut,center=false);
        }
        union(){
            rotate(-14) pie_slice(r=thread_cut_part+0.1,a=16);
            pie_slice(r=thread_cut_part+0.1,a=90);
        }
    }
}
translate([-floor_start,0,0]){
    cube(size=[floor_length,1.5,trad_xdistance],center=false);
}

if(part == "top_bottom"){
    translate([-floor_start,-wall_height+1.5,0]){
        cube(size=[floor_length,wall_height,1.5],center=false);
    }
}
else if(part == "side"){
    translate([floor_start+trad_ydistance-1.5,-wall_height+1.5,0]){
        cube(size=[1.5,wall_height,trad_ydistance],center=false);
    }
}
else if(part == "c_right"){
    translate([-floor_start,-wall_height+1.5,0]){
        cube(size=[1.5,wall_height,trad_xdistance],center=false);
    }
    translate([-floor_start,-wall_height+1.5,0]){
        cube(size=[floor_length,wall_height,1.5],center=false);
    }
}
else if(part == "c_left"){
    translate([floor_start+trad_ydistance-1.5,-wall_height+1.5,0]){
        cube(size=[1.5,wall_height,trad_xdistance],center=false);
    }
    translate([-floor_start,-wall_height+1.5,0]){
        cube(size=[floor_length,wall_height,1.5],center=false);
    }
}
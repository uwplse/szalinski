/*[Hole]*/
hole_length=130.0;
hole_width=25.0;
/*[Cover]*/
extend_distance=15.0;//[10.0,15.0,20.0]
cover_thickness=2.1;//[1.8,2.1,2.4,2.7]
slit_width=1.8;//[1.5,1.8,2.1]
num_slit=11;//[9,11,13,15,17,19]
/*[Frame]*/
//gap between wall and frame (mm)
gap=1.0;//[0.5,1.0,1.5,2.0,2.5]
frame_thickness=2.0;//[1.5,2.0,2.5]
frame_height=15.0;//[10.0,15.0,20.0]

module cover0(hole_length,hole_width,extend_distance,cover_thickness){
color("blue")
cube(size=[hole_length-hole_width,hole_width+2*extend_distance,cover_thickness],center=true); 

color("blue")
translate([(hole_length-hole_width)/2,0,0])
cylinder(cover_thickness,(hole_width+2*extend_distance)/2,(hole_width+2*extend_distance)/2,$fn=36,center=true);

color("blue")
translate([-(hole_length-hole_width)/2,0,0])
cylinder(cover_thickness,(hole_width+2*extend_distance)/2,(hole_width+2*extend_distance)/2,$fn=36,center=true);
}

module slits(hole_length,hole_width,extend_distance,slit_width,num_slit,cover_thickness){
color("green")
cube(size=[slit_width,hole_width+2*extend_distance,cover_thickness],center=true); 
dx=(hole_length-hole_width)/(num_slit-1);
ni=(num_slit-1)/2;

for(i=[1:ni])
color("green")
translate([i*dx,0,0])
cube(size=[slit_width,hole_width+2*extend_distance,cover_thickness],center=true); 

for(i=[1:ni])
color("green")
translate([-i*dx,0,0])
cube(size=[slit_width,hole_width+2*extend_distance,cover_thickness],center=true); 
}






module frame0(hole_length,hole_width,gap,frame_height){
color("red")
cube(size=[hole_length-hole_width,hole_width-2*gap,frame_height],center=true); 
color("red")
translate([(hole_length-hole_width)/2,0,0])
cylinder(frame_height,(hole_width-2*gap)/2,(hole_width-2*gap)/2,$fn=36,center=true);
color("red")
translate([-(hole_length-hole_width)/2,0,0])
cylinder(frame_height,(hole_width-2*gap)/2,(hole_width-2*gap)/2,$fn=36,center=true);
}



module frame1(hole_length,hole_width,gap,frame_thickness,frame_height){
color("yellow")
cube(size=[hole_length-hole_width,hole_width-2*gap-2*frame_thickness,frame_height],center=true); 
color("yellow")
translate([(hole_length-hole_width)/2,0,0])
cylinder(frame_height,(hole_width-2*gap-2*frame_thickness)/2,(hole_width-2*gap-2*frame_thickness)/2,$fn=36,center=true);
color("yellow")
translate([-(hole_length-hole_width)/2,0,0])
cylinder(frame_height,(hole_width-2*gap-2*frame_thickness)/2,(hole_width-2*gap-2*frame_thickness)/2,$fn=36,center=true);
}

module frame2(hole_length,hole_width,gap,frame_thickness,frame_height){
color("yellow")
translate([(hole_length-hole_width)/4,0,0])
cube(size=[frame_thickness,hole_width,frame_height],center=true); 
translate([-(hole_length-hole_width)/4,0,0])
cube(size=[frame_thickness,hole_width,frame_height],center=true); 

}

union(){
difference(){
cover0(hole_length,hole_width,extend_distance,cover_thickness);
slits(hole_length,hole_width,extend_distance,slit_width,num_slit,cover_thickness);
}
translate([0,0,(frame_height-cover_thickness)/2])
difference(){
frame0(hole_length,hole_width,gap,frame_height);
difference(){
frame1(hole_length,hole_width,gap,frame_thickness,frame_height);
frame2(hole_length,hole_width,gap,frame_thickness,frame_height);
}
}
}

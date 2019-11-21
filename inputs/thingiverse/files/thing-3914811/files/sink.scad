$fn=72;
/*[Hole]*/
hole_diameter=80.0;
/*[Cover]*/
extend_distance=10.0;//[10.0,15.0,20.0]
inner_diameter=30.0;
cover_thickness=2.1;//[1.8,2.1,2.4,2.7]
slit_width=1.8;//[1.5,1.8,2.1]
num_slit=10;//[8,10,12,14]
/*[Frame]*/
//gap between wall and frame (mm)
gap=1.0;//[0.5,1.0,1.5,2.0]
frame_thickness=2.0;//[1.5,2.0,2.5]
frame_height=15.0;//[10.0,15.0,20.0,25.0]

module cover0(hole_diameter,extend_distance,cover_thickness){
cylinder(cover_thickness,(hole_diameter+2*extend_distance)/2,(hole_diameter+2*extend_distance)/2,center=true);
}

module cover1(inner_diameter,cover_thickness){
cylinder(cover_thickness,inner_diameter/2,inner_diameter/2,center=true);
}

module slits(hole_diameter,extend_distance,cover_thickness,slit_width,num_slit){
    cube([slit_width,hole_diameter+2*extend_distance,cover_thickness],true);
    da=180.0/num_slit;
    for(i=[2:num_slit]){
        color("green")
        rotate([0,0,(i-1)*da])
         cube([slit_width,hole_diameter+2*extend_distance,cover_thickness],true);
        
        }
     }

module frame0(hole_diameter,frame_height,gap,frame_thickness){
difference(){
cylinder(frame_height,(hole_diameter-2*gap)/2,(hole_diameter-2*gap)/2,center=true);
cylinder(frame_height,(hole_diameter-2*gap-2*frame_thickness)/2,(hole_diameter-2*gap-2*frame_thickness)/2,center=true);    
}
}
module frame1(hole_diameter,frame_height,gap,frame_thickness){
    da=180.0/num_slit;
    rotate([0,0,0.5*da])
    cube([frame_thickness,hole_diameter-2*gap,frame_height],true);
    rotate([0,0,0.5*da+90.0])
    cube([frame_thickness,hole_diameter-2*gap,frame_height],true);
    
}


union(){ 
 union(){    
difference(){
    cover0(hole_diameter,extend_distance,cover_thickness);
    slits(hole_diameter,extend_distance,cover_thickness,slit_width,num_slit);
       
    }     
cover1(inner_diameter,cover_thickness);     
}


translate([0,0,(frame_height-cover_thickness)/2])
union(){
frame0(hole_diameter,frame_height,gap,frame_thickness);
frame1(hole_diameter,frame_height,gap,frame_thickness);
}
}
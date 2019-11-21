frames=7;
layer_step_height=0.2;
$fn=20;
frame_x = 30;
frame_y = 15;
frame_z = 2;
ring_diam = 12;
ring_height=2;
label_x=30;
label_text = "PLA";
font = "Liberation Sans"; //["Liberation Sans", "Liberation Sans:style=Bold", "Liberation Sans:style=Italic", "Liberation Mono", "Liberation Serif", "Ariel"]
letter_size=6;


union()
translate([0,ring_diam/2,0]) ring();
for (i = [1:frames]) {
translate([0,(-1*frame_y/2)*i*2+frame_y/2+0.5*i,0]) frame(i);
}
translate([0,(-1*frame_y/2)*frames*2+frame_y/2+0.5*frames,0]) bridge(frames);
j=frames+1;
translate([0,(-1*frame_y/2)*j*2+frame_y/2+0.5*j+frame_y/4,frame_z/-4]) label();
translate([0,(-1*frame_y/2)*j*2+frame_y/2+0.5*j-3,frame_z/-4]) label2();

translate([0,1,0])
cube([frame_x,2,ring_height],center=true);
translate([0,(-1*frame_y/2)*frames*2+frame_y/2+0.5*frames-frame_y/2,0]) 
cube([frame_x,2,ring_height],center=true);



module ears() {
  translate([-1*frame_x/2+0.5,(-1*frame_y/2)*frames*2+frame_y/2+0.5*frames+frame_y/2,3]) {
    rotate([45,0,0]) cube([1,1,8],center=true);
    translate([0,4,0]) rotate([-45,0,0]) cube([1,1,8],center=true); 
  }
translate([frame_x/2-0.5,(-1*frame_y/2)*frames*2+frame_y/2+0.5*frames+frame_y/2,3]) {
    rotate([45,0,0])  cube([1,1,8],center=true);  
  translate([0,4,0]) rotate([-45,0,0]) cube([1,1,8],center=true); 
}
}

module ring() {
difference() {
    cylinder(r1=ring_diam/2,r2=ring_diam/2,h=ring_height,center =true) ;
    cylinder(r1=ring_diam/2-2,r2=ring_diam/2-2,h=ring_height+1,center=true);   
}
    
}


module frame(num) {
      translate([0,0,-frame_z/2+num*(layer_step_height/2)])
    color("gray")
   cube([frame_x-0.5,frame_y-0.5,num*layer_step_height+0.01],center=true); 
   difference() {
      cube([frame_x,frame_y,frame_z],center=true);
      cube([frame_x-2.2,frame_y-1.2,frame_z+1],center=true);
   } 

}

module bridge(num) {
      translate([0,0,frame_z*3])
 cube([frame_x-1,frame_y/2,layer_step_height*2],center=true); 
    translate([0,0,frame_z*1.6]) 
   difference() {
      cube([frame_x,frame_y/2,frame_z*3+layer_step_height],center=true);
      cube([frame_x-2.2,frame_y/2+2.2,frame_z*3+layer_step_height],center=true);
   } 

}

module label() {
    union()
          cube([label_x,8,1],center=true);
    letter(label_text);    
}

module label2() {
    union()
          cube([frame_x,8,1],center=true);
    letter(str(layer_step_height,"-",layer_step_height*frames));    
}

module letter(l) {
    color("black")
  linear_extrude(height = 1.6) {
    text(l, size = letter_size, font = font, halign = "center", valign = "center", $fn = 16);
  }
}
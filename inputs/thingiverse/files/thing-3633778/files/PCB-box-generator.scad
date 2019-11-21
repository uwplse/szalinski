// preview[view:west, tilt:top diagonal]
pcb_height=31;
pcb_width=41;
pcb_thick=2;
grove=1;
walls=2.4;
bottom_offset=2;
top_offset=10;
chamfer_top=7;//[0:10]
chamfer_bottom=3;//[0:10]

chamfer_top_=chamfer_top/10;
chamfer_bottom_=chamfer_bottom/10;

difference(){
//box
translate([walls/2+0.1,0,pcb_thick/2+bottom_offset/2+top_offset/2-walls/2]){
cube([pcb_height+walls,pcb_width+walls*2,pcb_thick+walls*2+bottom_offset+top_offset-walls],center=true);
}

//pcb
color("green")
translate([0,0,pcb_thick/2+bottom_offset]){
cube([pcb_height,pcb_width,pcb_thick],center=true);
}

//grove
color("blue")
translate([-grove/2,0,bottom_offset + pcb_thick +top_offset/2]){
cube([pcb_height-grove,pcb_width-grove*2,top_offset+0.01],center=true);
}

//chamfer top
color("red")
translate([-grove/2,0,pcb_thick+walls/2+bottom_offset-0.01]){
linear_extrude(height = walls+0.1, center = true, convexity = 3, scale = chamfer_top_){
square(size = [pcb_height, pcb_width], center = true);
}
}

//bottom offset
color("Gray")
translate([-grove/2,0,bottom_offset/2]){
cube([pcb_height-grove,pcb_width-grove*2,bottom_offset+0.01],center=true);
}

//chamfer bottom
color("Purple")
translate([-grove/2,0,bottom_offset/2+0.01]){
mirror([0,0,1]) 
linear_extrude(height = bottom_offset, center = true, convexity = 3, scale = chamfer_bottom_){
square(size = [pcb_height, pcb_width], center = true);
}
}

}

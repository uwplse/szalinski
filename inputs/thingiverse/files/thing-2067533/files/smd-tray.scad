$fn = 30;

bucket_height = 2;
bucket_size = 20;
numx = 6;
numy = 2;
frame = 2;

for (i=[0:numx-1]) for (j=[0:numy-1]) {
    translate([i*(bucket_size+2*frame),j*(bucket_size+2*frame),0])difference(){
        cube([bucket_size+2*frame,bucket_size+2*frame,bucket_height]);
        translate([frame,frame,-0.5])cube([bucket_size,bucket_size,bucket_height+1]);
    }
}
translate([0,0,-1.5])cube([numx*(bucket_size+2*frame),numy*(bucket_size+2*frame),1.5]);

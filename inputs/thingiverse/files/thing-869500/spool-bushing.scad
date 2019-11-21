//the main hole at the center
center=1; // [1:Yes,0:No]
inner=21.5;
outer=52;
height=75;

//the holes surrounding the center
rings=1; // [1:Yes,0:No]
rcount=8;
rdiameter=10;
rdistance=(outer+inner)/4;
//rdistance=rdistance/1.5;

//slots for bearrings at the end of the center
bearing=0; // [1:Yes,0:No]
bheight=5;
bdiameter=6;

faces=100;


difference(){
    cylinder(h=height,d=outer, $fn=faces,center=true);
    if(center){
        cylinder(h=height,d=inner, $fn=faces,center=true);
    }
    if(rings){
        for(i=[0:rcount]){
        rotate(i*360/rcount){
            translate([rdistance,0,0]) cylinder(h=height,d=rdiameter, $fn=faces,center=true);
            }
        }
    }
    if(bearing){
        translate([0,0,height/2]) cylinder(h=bheight*2,d=bdiameter, $fn=faces,center=true);
        translate([0,0,-height/2]) cylinder(h=bheight*2,d=bdiameter, $fn=faces,center=true);
    }
}
//for(i=[0:8]){
//rotate(i*360/9){
//            translate([rrdistance,0,0]) cylinder(h=height,d=rdiameter, $fn=faces,center=true);
//        }
//    }
xwidth_slider=70; // [40:80]
xdepth_slider=30; // [22:40]
xheight_slider=15; // [10:60
plategap=19.5;

xwidth=xwidth_slider;
xdepth=xdepth_slider;
xheight=xheight_slider;

translate([0,0,xdepth]){
rotate([270,0,0]){
difference(){
// main body    
cube([xwidth,xdepth-0.1,xheight]){};
union(){
    // left
    translate([0,0,4]){
        cube([(xwidth-30)/2,xdepth,xheight-4]){};
    }
    // right
    translate([xwidth-((xwidth-30)/2),0,4]){
        cube([(xwidth-30)/2,xdepth,xheight-4]){};
    }
    // center bottom gap
    translate([(xwidth/2)-(plategap/2),0,xheight-5]){
        cube([plategap,xdepth-2,3]){};
    }
    // center top gap
    translate([(xwidth/2)-6,0,xheight-3]){
        cube([12,xdepth-4,10]){};
    }
    // left bolt hole
    translate([((xwidth-30)/2)/2,xdepth/2,0]){
        cylinder(h=xheight, r=2, $fn=50);
    }
    //right bolt hole
    translate([xwidth-(((xwidth-30)/2)/2),xdepth/2,0]){
        cylinder(h=xheight, r=2, $fn=50);
    }
};
};
};
};
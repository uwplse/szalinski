xwidth_slider=70; // [40:80]
xdepth_slider=30; // [22:40]
xheight_slider=15; // [10:60
plategap=19.5;

xwidth=xwidth_slider;
xdepth=xdepth_slider;
xheight=xheight_slider;

 translate([0,0,xwidth]){
 rotate([0,90,0]){
difference(){
// main body    
cube([xwidth,xdepth-0.1,xheight]){};
union(){
    // left
    translate([0,0,4]){
        cube([(xwidth-30)/2,xdepth,xheight]){};
    }
    // right
    translate([xwidth-((xwidth-30)/2),0,4]){
        cube([(xwidth-30)/2,xdepth,xheight]){};
    }
    // center bottom gap
    translate([9,(xdepth/2)-(plategap/2),xheight-5]){
            cube([xwidth-30,plategap,3]){};
    }
    // center top gap
    translate([(xwidth/2)+11,(xdepth/2)-6,xheight-3]){
        rotate([0,0,90]){
            cube([12,xdepth-4,10]){};
        }
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
//Width of flat part of the top
top_w1=15.5;
//Width of the top, from point to point
top_w2=17.1;
//Depth of the upper part
top_d=4.5;
//Height of the top part
top_h=2.8;
//Width of the bottom of the rail
bottom_w=12.66;
//Height of the bottom of the rail
bottom_h=3.5;
//Depth of the slot between 
slot_d=5.8;
//Maximum length, 
max_l = 98;

//extra size for plastic shrinkage
resize_factor=1.03; 

/* [Hidden] */
htop_w1=top_w1*resize_factor;
htop_w2=top_w2*resize_factor;
htop_h=top_h*resize_factor;
hbottom_w=bottom_w*resize_factor;
hbottom_h=bottom_h*resize_factor;
hrib_d=top_d*resize_factor;
hslot_d=slot_d*resize_factor;

//Sutract one "rib" then divide by rib+slot to determine the total
//number of ribs we can "fit" in the given distance (so that we
//start and end with a rib)
num_ribs = floor((max_l - hrib_d) / (hrib_d + hslot_d));
overall_l = (num_ribs) * (hrib_d + hslot_d) + hrib_d;


module rib() {
    pw = 0.5 * (htop_w2 - htop_w1);
    pts =[ [0, 0.5 * htop_h], 
           [ pw, 0], 
           [ htop_w2 - pw, 0], 
           [htop_w2, 0.5 * htop_h], 
           [htop_w2 - pw, htop_h],
           [pw, htop_h] 
         ];
    linear_extrude(height=hrib_d,convexity=2)
        polygon(points=pts, convexity=2);
}

union() {
    //note that this does an "extra" rib - the first one 
    for (i = [0 : num_ribs] ) {
        translate([0,-i* (hrib_d + hslot_d),0])
        rotate([90,0,0])
            rib();
    }
    translate([0.5 * (htop_w2 - hbottom_w),-1*(overall_l),htop_h])
    cube([hbottom_w, overall_l, hbottom_h]);
}

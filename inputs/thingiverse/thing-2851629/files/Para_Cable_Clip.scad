height1 = 40; // How far does the part stretch over the extrusion.
depth1 = 12; // The distance from the extrusion surface to the outer edge of the channel.
width = 10; // The width of the clip.
channel_gap = 14.60; // The distance between the inner edges of the channels in the extrusion.
channel_depth = 5.2; // The depth of the channels.
channel_width = 5.0; // The width of the channels.
thickness = 3; // The thickness of the clip.
clip_dist = 1.2; // The distance by which the clip extends beyond the entry width of the channel.
clip_over_t = 2; // The thickness of the narrowing of the channels.
tol01 = 0.01; // A small value to avoid coincident surfaces causing rendering problems.
snapIn = true; // If True then you can clip the part into the extrusion. If False you'll probably have to slide it into the extrusion while constructing your project

height = height1<(2*channel_width + channel_gap +clip_dist*2) ? 2*channel_width + channel_gap +clip_dist*2 : height1 ; // ensure the height is not less than required to provide a lip over the edge of each channel

depth = depth1<(2*thickness+5) ? 2*thickness+5 : depth1 ;

feature_dia = (height-channel_gap-channel_width*2)/2<(depth-thickness*2)/2 ? (height-channel_gap-channel_width*2)/2 : (depth-thickness*2)/2 ;

feature_dia_inner = (feature_dia-channel_width/2)<0 ?  0 : feature_dia-channel_width/2 ;

module holder(){
    difference(){
        cube([depth,width,height],center=true);
        translate([0,0,0]) cube([depth-thickness*2,width+tol01,height-depth],center=true);
        translate([thickness/2+tol01/2,0,0]) cube([depth-thickness+tol01,width+tol01,channel_gap],center=true);      
        translate([depth/2-feature_dia,0,height/2-feature_dia]) difference(){
            translate([(feature_dia+tol01)/2,0,+feature_dia/2+tol01/2]) cube([feature_dia+tol01,width+tol01,feature_dia+tol01],center=true);
            translate([0,0,0]) rotate([90,0,0]) cylinder(h=width+tol01*2,d=feature_dia*2,$fn=144,center=true);
        }
        scale([1,1,-1]) translate([depth/2-feature_dia,0,height/2-feature_dia]) difference(){
            translate([(feature_dia+tol01)/2,0,+feature_dia/2+tol01/2]) cube([feature_dia+tol01,width+tol01,feature_dia+tol01],center=true);
            translate([0,0,0]) rotate([90,0,0]) cylinder(h=width+tol01*2,d=feature_dia*2,$fn=144,center=true);
        }        
        scale([-1,1,-1]) translate([depth/2-feature_dia,0,height/2-feature_dia]) difference(){
            translate([(feature_dia+tol01)/2,0,+feature_dia/2+tol01/2]) cube([feature_dia+tol01,width+tol01,feature_dia+tol01],center=true);
            translate([0,0,0]) rotate([90,0,0]) cylinder(h=width+tol01*2,d=feature_dia*2,$fn=144,center=true);
        }
        scale([-1,1,1]) translate([depth/2-feature_dia,0,height/2-feature_dia]) difference(){
            translate([(feature_dia+tol01)/2,0,+feature_dia/2+tol01/2]) cube([feature_dia+tol01,width+tol01,feature_dia+tol01],center=true);
            translate([0,0,0]) rotate([90,0,0]) cylinder(h=width+tol01*2,d=feature_dia*2,$fn=144,center=true);
        }
        translate([depth/2-thickness-feature_dia_inner,0,height/2-thickness-feature_dia_inner]) rotate([90,0,0]) cylinder(h=width+tol01,d=feature_dia_inner*2,$fn=72,center=true);
        scale([1,1,-1]) translate([depth/2-thickness-feature_dia_inner,0,height/2-thickness-feature_dia_inner]) rotate([90,0,0]) cylinder(h=width+tol01,d=feature_dia_inner*2,$fn=72,center=true);
        scale([-1,1,-1]) translate([depth/2-thickness-feature_dia_inner,0,height/2-thickness-feature_dia_inner]) rotate([90,0,0]) cylinder(h=width+tol01,d=feature_dia_inner*2,$fn=72,center=true);
        scale([-1,1,1]) translate([depth/2-thickness-feature_dia_inner,0,height/2-thickness-feature_dia_inner]) rotate([90,0,0]) cylinder(h=width+tol01,d=feature_dia_inner*2,$fn=72,center=true);
        cube([depth-thickness*2,width+tol01,height-(thickness+feature_dia_inner)*2],center=true);
        cube([depth-(feature_dia_inner+thickness)*2,width+tol01,height-thickness*2],center=true);
    }
}

module clip(){
    difference(){
        union(){
            translate([-thickness/2,0,0]) cube([channel_depth+thickness,width,channel_width],center=true);
            difference(){
                translate([-channel_depth/2+clip_over_t,0,channel_width/2]) rotate([90,0,0]) scale([channel_depth-clip_over_t,clip_dist,1]) cylinder(h=width,d=2,$fn=4,center=true);
                translate([-(channel_depth-clip_over_t)/2-channel_depth/2+clip_over_t,0,channel_width/2]) cube([channel_depth-clip_over_t+tol01,width+tol01,clip_dist*2+tol01],center=true);
            }
            difference(){
                translate([-channel_depth/2+clip_over_t,0,-channel_width/2]) rotate([90,0,0]) scale([channel_depth-clip_over_t,clip_dist,1]) cylinder(h=width,d=2,$fn=4,center=true);
                translate([-(channel_depth-clip_over_t)/2-channel_depth/2+clip_over_t,0,-channel_width/2]) cube([channel_depth-clip_over_t+tol01,width+tol01,clip_dist*2+tol01],center=true);
            }
        }
        rotate([0,90,90]) cylinder(h=width+tol01,d=channel_width/2.5,$fn=72,center=true);
        translate([channel_depth/2,0,0]) cube([channel_depth+tol01,width+tol01,channel_width/2.5],center=true);
    }
}

module clip2(){
    difference(){
        union(){
            translate([-thickness/2,0,0]) cube([channel_depth+thickness,width,channel_width],center=true);
            difference(){
                translate([-channel_depth/2+clip_over_t,0,channel_width/2]) rotate([90,0,0]) scale([channel_depth-clip_over_t,clip_dist,1]) cylinder(h=width,d=2,$fn=4,center=true);
                translate([-(channel_depth-clip_over_t)/2-channel_depth/2+clip_over_t,0,channel_width/2]) cube([channel_depth-clip_over_t+tol01,width+tol01,clip_dist*2+tol01],center=true);
            }
        }
        rotate([0,90,90]) cylinder(h=width+tol01,d=channel_width/2.5,$fn=72,center=true);
        translate([channel_depth/2,0,-channel_width/3.75]) cube([channel_depth+tol01+channel_width/2.5,width+tol01,channel_width/2],center=true);
    }
}

module assembly(){
    difference(){
        union(){
            translate([depth/2+channel_depth/2,0,channel_width/2+channel_gap/2]) clip2();
            translate([depth/2+channel_depth/2,0,-channel_width/2-channel_gap/2]) rotate([180,0,0]) clip2();
            holder();
        }
    difference(){
                translate([depth/2-thickness*.5-tol01/2,0,channel_gap/2+thickness/2-tol01/2]) cube([thickness+tol01,width+tol01,thickness+tol01],center=true);
                translate([depth/2,0,channel_gap/2+thickness]) rotate([90,0,0]) cylinder(h=width+tol01*2,d=thickness*2,$fn=144,center=true);
            }
    difference(){
                translate([depth/2-thickness*.5-tol01/2,0,-channel_gap/2-thickness/2+tol01/2]) cube([thickness+tol01,width+tol01,thickness+tol01],center=true);
                translate([depth/2,0,-channel_gap/2-thickness]) rotate([90,0,0]) cylinder(h=width+tol01*2,d=thickness*2,$fn=144,center=true);
        }
    }
}

translate([0,0,width/2]) rotate([90,0,0]) assembly();
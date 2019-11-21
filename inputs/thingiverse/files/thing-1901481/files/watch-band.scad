/* [Hidden] */
$fn=30;//rozlišení
overlap=0.01;//překryv částí dílku

/* [Basic setting] */
left_link_count = 7; // [0:1:100]
right_link_count = 6; // [0:1:100]
width=22; // [5:1:40]

/* [Link dimensions] */
height=4; // [3:0.2:10]
length=9; // [3:0.2:50]
step=5; // [3:0.2:40]
pin=2; // [1:0.2:20]

/* [Connector dimensions] */
axis=2; // [0.2:0.1:5]
helper_width=1.4; // [0.1:0.1:5]
helper=2; // [0.1:0.1:5]

/* [Clip orientation] */
turned_clip = 0; // [0:No, 1:Yes]

/* [Printing limits] */
distance=0.2; // [0.0:0.05:2]

/* [Parts to render] */
right_band=1; // [0:No, 1:Yes]
connectors=1; // [0:No, 1:Yes]
clip=1; // [0:No, 1:Yes]

module pin(left=true){
    q=left?-1:1;
    rotate([0,q*90,0])
    cylinder(r1=0,r2=3*height/8,h=pin,center=true);
}

module part(r,w,l){
    hull(){
        rotate([0,90,0])
        cylinder(r1=r,r2=r,h=l,center=true);
        translate([0,w,0])
        rotate([0,90,0])
        cylinder(r1=r,r2=r,h=l,center=true);
    }
}

module connector(){
    difference(){
        union(){
            translate([+width/2-step/2+distance/2,0,0])
            part(height/2,-length+height,step-distance);
            translate([-width/2+step/2-distance/2,0,0])
            part(height/2,-length+height,step-distance);
            part(height/2,0,width);
        }
        //axis
        rotate([0,90,0])
        cylinder(r1=axis/2+distance,r2=axis/2+distance,h=width+2,center=true);
        
        //helper
        translate([-width/2-overlap,-helper_width/2,-height/2-overlap])
        cube([helper+overlap,helper_width,height/2+overlap]);
        translate([width/2-helper,-helper_width/2,-height/2-overlap])
        cube([helper+overlap,helper_width,height/2+overlap]);
    }
    //pin
    translate([width/2+pin/2-pin-step+2*distance+overlap,-length+height,0])
    pin(false);
    translate([-width/2-pin/2+pin+step-2*distance-overlap,-length+height,0])
    pin(true);
}

module link(){
    difference(){
        union(){
            translate([+width/2-step/2+distance/2,0,0])
            part(height/2,-length+height,step-distance);
            translate([-width/2+step/2-distance/2,0,0])
            part(height/2,-length+height,step-distance);
            part(height/2,0,width);
            part(height/2,length-height,width-2*step);
        }
        
        //pin hole
        translate([width/2+pin/2-pin-step+overlap,length-height,0])
        pin(false);
        translate([-width/2-pin/2+pin+step-overlap,length-height,0])
        pin(true);
    }
    //pin
    translate([width/2+pin/2-pin-step+2*distance+overlap,-length+height,0])
    pin(false);
    translate([-width/2-pin/2+pin+step-2*distance-overlap,-length+height,0])
    pin(true);
}

module clip(turned=false){
    turned=turned?-1:1;
    difference(){
        part(height/2,length,width-2*step);
        
        //helper
        translate([0,-height/2,0])
        rotate([45,0,0])
        cube([width/4,height/2,height/2],center=true);
        
        //pin hole
        translate([width/2+pin/2-pin-step+overlap,length,0])
        pin(false);
        translate([-width/2-pin/2+pin+step-overlap,length,0])
        pin(true);
        
        //lock back
        hull(){
            translate([width/2+pin/2-pin-step+overlap,0,0])
            pin(false);
            translate([width/2+pin/2-pin-step+overlap,length/2,0])
            pin(false);
        }
        hull(){
            translate([-width/2-pin/2+pin+step-overlap,0,0])
            pin(true);
            translate([-width/2-pin/2+pin+step-overlap,length/2,0])
            pin(true);
        }
        //lock down
        hull(){
            translate([width/2+pin/2-pin-step+overlap,length/2,0])
            pin(false);
            translate([width/2+pin/2-pin-step+overlap,length/2,pin*turned])
            pin(false);
        }
        hull(){
            translate([-width/2-pin/2+pin+step-overlap,length/2,0])
            pin(true);
            translate([-width/2-pin/2+pin+step-overlap,length/2,pin*turned])
            pin(true);
        }
    }
}

/*
connector();
link();
clip();
*/

module band(links=7,clip=true,connector=true,turned_clip=false){
    if(connector){
        connector();
    }
    links=links+1;
    for(i=[1:1:links-1]){
        translate([0,-(2*length-height*2)*i])
        link();
    }
    if(clip){
        translate([0,-(2*length-height*2)*(links?links:1)-height,0])
        clip(turned_clip);
    }
}

module full_band(links1,links2,turned_clip=false){
    band(links1,clip,connectors,turned_clip);
    if(right_band){
        translate([width*1.5,0,0])
        band(links2,false,connectors);
    }
}

full_band(left_link_count,right_link_count,turned_clip);
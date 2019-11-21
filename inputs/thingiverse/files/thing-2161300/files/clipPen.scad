// Diameter of the pen
diameter=10;

// Width of the piece
width = 10;

// Lenght of the clip
length=30;

//Separation of the clip arms
sep = 4;

// Wall thickness of the pen holder
wt = 1;

// Wall thickness of the clip
wt2 = 0.8;

// Text 
t = "NAME";

// Text Size
textSize = 6;

// Font type (you can use any Google Font but consider any stencil font for better results)
font = "Stencil";
/* [Hidden] */

$fn=60;
ang=40;

height=width;


penHolder();
difference() {
    clip();
    textOnClip();
}

module textOnClip() {
    translate ([diameter/2+length/2, -sep/2+1, height/2])
    rotate([90, 0, 0])
    linear_extrude(height=wt2+2)
    text(t, font=font, size=textSize, valign="center", halign="center", style="bold");
}

module penHolder() {
    difference() {
        cylinder (d=diameter+wt*2, h=height);
        translate([0, 0, -1]) cylinder (d=diameter, h=height+2);
        translate([0, 0, -1]) linear_extrude(height=height+2)
        polygon(points=[[0,0], [-cos(ang/2)*(diameter), sin(ang/2)*(diameter+1)], [-cos(ang/2)*(diameter), -sin(ang/2)*(diameter+1)]]);
    }
    translate([-cos(ang/2)*(diameter/2+wt/2), sin(ang/2)*(diameter/2+wt/2), 0]) cylinder(d=wt, h=height);
translate([-cos(ang/2)*(diameter/2+wt/2), -sin(ang/2)*(diameter/2+wt/2), 0]) cylinder(d=wt, h=height);
}

module clip() {
    
    r1 = wt2 * 0.5;
    
    difference() {
        translate([diameter/2, -sep/2-wt2, 0]) cube([length, sep+wt2*2, height]);
        translate([diameter/2+wt+sep/2, 0, -1])cylinder(d=sep, h=height+2);
        translate([diameter/2+wt+sep/2, -sep/2, -1]) cube([length, sep, height+2]);
    }
    translate([diameter/2+length-r1, sep/2, 0]) cylinder(r=r1, h=height);
    translate([diameter/2+length-r1, -sep/2, 0]) cylinder(r=r1, h=height);
    
}
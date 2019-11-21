/*
Inspired by:
* http://www.thingiverse.com/thing:1366519
* http://www.thingiverse.com/thing:75093
And using this for the pixels:
* https://img.clipartfest.com/d67569bec5b8d1f25282946c07801aa1_minecraft-paper-crafting-table-free-clipart-minecraft-crafting-table_564-457.jpeg
*/

layer_height=.22;

pixel_width=2;
panel_angle_degrees=35;

/* [Hidden] */
buffer=layer_height*2;
colors=["tan","black","white"];
height=[0,layer_height*2,layer_height*4];
pixels=16;
panel_width=pixels*pixel_width+buffer*2;

top=[
/* 01 */ [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
/* 02 */ [1,0,0,1,0,0,0,0,0,0,0,0,1,0,0,1],
/* 03 */ [1,0,1,0,0,0,0,0,0,0,0,0,0,1,0,1],
/* 04 */ [1,1,0,1,1,1,1,1,1,1,1,1,1,0,1,1],
/* 05 */ [1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1],
/* 06 */ [1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1],
/* 07 */ [1,0,0,1,1,1,1,1,1,1,1,1,1,0,0,1],
/* 08 */ [1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1],
/* 09 */ [1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1],
/* 10 */ [1,0,0,1,1,1,1,1,1,1,1,1,1,0,0,1],
/* 11 */ [1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1],
/* 12 */ [1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1],
/* 13 */ [1,1,0,1,1,1,1,1,1,1,1,1,1,0,1,1],
/* 14 */ [1,0,1,0,0,0,0,0,0,0,0,0,0,1,0,1],
/* 15 */ [1,0,0,1,0,0,0,0,0,0,0,0,1,0,0,1],
/* 16 */ [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]
];

side1=[
/* 01 */ [1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1],
/* 02 */ [1,0,0,0,0,0,1,0,0,1,0,0,0,0,0,1],
/* 03 */ [1,0,0,0,0,0,0,1,1,0,0,0,0,0,0,1],
/* 04 */ [1,0,0,0,0,0,0,1,1,0,0,0,0,0,0,1],
/* 05 */ [1,0,0,0,0,0,0,1,1,0,0,0,0,0,0,1],
/* 06 */ [1,0,0,1,0,1,0,1,1,0,0,0,0,0,0,1],
/* 07 */ [1,0,0,1,0,1,0,1,1,0,0,0,0,0,0,1],
/* 08 */ [1,0,0,0,2,0,0,1,1,0,0,0,0,0,0,1],
/* 09 */ [1,0,0,2,0,2,0,1,1,0,0,0,0,0,0,1],
/* 10 */ [1,0,0,2,0,2,0,1,1,0,0,0,0,0,0,1],
/* 11 */ [1,0,0,0,0,0,0,1,1,0,0,0,0,0,0,1],
/* 12 */ [1,0,0,0,0,0,0,1,1,0,0,0,0,0,0,1],
/* 13 */ [1,0,0,0,0,0,0,1,1,0,0,0,0,0,0,1],
/* 14 */ [1,0,0,0,0,0,0,1,1,0,0,0,0,0,0,1],
/* 15 */ [1,0,0,0,0,0,0,1,1,0,0,0,0,0,0,1],
/* 16 */ [1,0,0,0,0,0,0,1,1,0,0,0,0,0,0,1]
];

side2=[
/* 01 */ [1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1],
/* 02 */ [1,0,0,0,0,0,1,0,0,1,0,0,0,0,0,1],
/* 03 */ [1,0,0,0,0,0,0,1,1,0,0,0,0,0,0,1],
/* 04 */ [1,0,0,0,0,0,0,1,1,0,0,1,1,1,0,1],
/* 05 */ [1,0,0,0,0,0,0,1,1,0,0,1,0,1,0,1],
/* 06 */ [1,0,0,1,0,0,0,1,1,0,0,1,1,1,0,1],
/* 07 */ [1,0,0,1,0,0,0,1,1,0,0,2,2,2,0,1],
/* 08 */ [1,0,0,1,0,0,0,1,1,0,0,0,2,2,0,1],
/* 09 */ [1,0,0,1,2,0,0,1,1,0,0,0,2,2,0,1],
/* 10 */ [1,0,2,2,2,0,0,1,1,0,0,0,2,2,0,1],
/* 11 */ [1,0,0,0,2,0,0,1,1,0,0,0,2,2,0,1],
/* 12 */ [1,0,0,0,0,0,0,1,1,0,0,0,0,2,0,1],
/* 13 */ [1,0,0,0,0,0,0,1,1,0,0,0,0,2,0,1],
/* 14 */ [1,0,0,0,0,0,0,1,1,0,0,0,0,0,0,1],
/* 15 */ [1,0,0,0,0,0,0,1,1,0,0,0,0,0,0,1],
/* 16 */ [1,0,0,0,0,0,0,1,1,0,0,0,0,0,0,1]
];

module render_panel(data) {
    translate([0,pixels*pixel_width,0]) rotate(-90)
    for (y=[0:len(data)-1]) {
        row=data[y];
        for (x=[0:len(row)-1]) {
            i=data[y][x];
            h=height[i];
            if (h!=0) {
                c=colors[i];
                w=pixel_width*1.01; // slightly bigger so they overlap
                translate([y*pixel_width,x*pixel_width,0]) color(c) cube([w,w,h]);
            }
        }
    }
}

module panel_base() {
    o=pixel_width;
    // a=adjacent side
    // o=opposite side
    // therefore:
    a=o/tan(panel_angle_degrees);
        
    // using cylinder, therefore top radius is hypotenuse of right trangle where adjacent and opposite sides are 1/2 of desired panel width and bottom radius is top radius minus "a" from above
    z=panel_width/2;
    r2=sqrt(z*z+z*z);
    r1=r2-a;
    h=o;
    color(colors[0]) translate([z,z,0]) rotate(45) cylinder(h=h, r1=r1, r2=r2, $fn=4);
}

module crafting_table() {
    union() {
        p=panel_width-layer_height;
        b=buffer;
        z=pixel_width;

        panel_base();
        translate([p,0,0]) panel_base();
        translate([p*2,0,0]) panel_base();
        translate([p*3,0,0]) panel_base();
        translate([p,p,0]) panel_base();
        translate([p,-p,0]) panel_base();

        translate([p+b,p+b,z]) render_panel(top);
        translate([b,b,z]) render_panel(side1);
        translate([p+b,b,z]) render_panel(side2);
        translate([p*2+b,b,z]) render_panel(side1);
        translate([p*3+b,b,z]) render_panel(side2);
    }
}

module test() {
    s=2;
    intersection(){
        crafting_table();
        translate([panel_width,panel_width,0]) cube([panel_width/s,panel_width/s,pixel_width*4], center=true);
    }
}

crafting_table();
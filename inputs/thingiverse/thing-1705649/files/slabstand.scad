//Title: Slad Display Stand
//Author: Alex English - ProtoParadigm
//Date: 8/5/16
//License: Creative Commons - Share Alike - Attribution

//Notes: This stand is made to display slabs of finished stone.
//  While the design is parametric, it has not been tested with a wide range of values. If you want to change it dramatically you will probably need to make other edits to the code.

IN=25.4*1; //multiplication by 1 to prevent customizer from presenting this as a configurable value

//Width of the whole stand (in inches)
width=3;
w=IN*width;

//Height of the stand (in inches)
height=3;
h=IN*height; //full height

//Thickness of the walls (in mm)
thickness=3;
t = thickness;

//The height from the bottom of the shelf the slab rests on (in inches)
shelf_height = 0.625;
b=shelf_height*IN;

//The angle (degrees) of the face the slab rests against - you probably don't want to adjust this much
angle = 22;
a=angle*1;

//The distance the shelf is inset, this determines the width of the shelf the slab rests on
inset = 0.5;
s=inset*IN; //the width of the shelf on the front legs where the slab is held

//Turn the holes in the back on or off - both for aesthetics and material savings
holes=1; //[1:On, 0:Off]

module roundstand()
{
    difference()
    {
        cylinder(d=w, h=h, $fa=1); //outer cylinder
        
        translate([0, 0, -1]) cylinder(d=w-t*2, h=h+2, $fa=2); //inner cylinder cutout to hollow the main body
        
        translate([-w, s, -1]) cube([w*2,w, h+2]); //cut the front off of the cylinders
        
        translate([0, -t/2, b])  rotate([a, 0, 0])   translate([-w, 0, 0]) cube([w*2, w, h]); //front cutout for shelf
        
        //cutouts for aesthetics, to reduce material usage, and to balance the weight of the stand further towards the front
        translate([0, 0, h]) scale([1, 1, 1.5]) rotate([90, 0, 0]) cylinder(d=h/2,h=w, $fa=6); //top cutout
        if(holes) {for(r=[-45, 0, 45]) translate([0, 0, h/4/2*1.5+t*2]) scale([1, 1, 1.5]) rotate([90, 0, r]) cylinder(d=h/4, h=w, $fa=6); }//back wall cutouts
    }
}

roundstand();

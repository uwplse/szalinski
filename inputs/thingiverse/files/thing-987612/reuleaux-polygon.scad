/* [Reuleaux Polygon] */
// number of vertices (should be odd)
vertices = 3;
// constant width of the Reuleaux Polygon (mm)
width = 10;
// thickness of the extrusion (mm)
thickness = 5;

/* [Engrave] */
// engrave the number of vertices into the part
engrave = "both"; // [none:None,top:Top,bot:Bottom,both:Top and Bottom]
// size of the engrave (%)
size = 100; // [0:100]
// depth of the engrave (mm)
depth = 2;

/* [Hidden] */
$fn = 1000;

vertices_ = abs(round(vertices));
text_size = 0.75*width*size/100/len(str(vertices_));

module Reuleaux(num,r)    {
    intersection_for(angle=[0:360/num:360])  {
        translate([r*cos(angle)/2,r*sin(angle)/2])    circle(r);
    }
}
module Extrusion()  {
    if(vertices > 1)    {
    rotate([0,0,90])
        if(vertices_/2 != round(vertices/2))  {
            color("green")
                linear_extrude(height = thickness, center = false)
                    Reuleaux(vertices_,width);
        }
        else    {
            color("red")
                linear_extrude(height = thickness, center = false)
                    Reuleaux(vertices_,width);
        }
    }
    else if(vertices == 1)   {
        color("purple")
            linear_extrude(height = thickness, center = false)
                circle(width, center = false);
    }
}
module Engrave() {
    if(engrave == "top" || engrave == "both")    {
        translate([0,0,thickness-depth])
        linear_extrude(height = depth+0.01)
        text(str(vertices_), text_size, halign = "center", valign = "center");
    }
    if(engrave == "bot" || engrave == "both")    {
        translate([0,0,depth])
        mirror([0,1,0])
        mirror([0,0,1])
        linear_extrude(height = depth+0.01)
        text(str(vertices_), text_size, halign = "center", valign = "center");
    }
}
difference()    {
    Extrusion();
    Engrave();
}
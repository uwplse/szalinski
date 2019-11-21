// Book box
// Kristine Orten, 2018

/*Global*/
// number of books
_b = 2;
// name
_n = "Alexandra";
// where should the name render (x-axis)
_nd = .38;

// define box size
// bottom height (in mm, top not included)
_h = 40;
// width (in mm)
_w = 85;
// depth (in mm)
_d = 65;

// rendering
// rendering the top/lid of the box
_render_top = 1;  // [1:yes,0:no]
// rendering the bottom of the box
_render_bottom = 1;  // [1:yes,0:no]
// spacing between objects when rendering both top and bottom (in mm)
_object_spacing = 2*_d; 

/*Hidden*/
error = .01;
$fn = 150;
// bottom thickness
_t = 1.6;
// size difference, book-box
_s = 15;
// page depth
_p = .4;

// Bottom
module pages(d,w,h)
{
    difference ()
    {
        for (i = [_t:2*_p:h/_b-1.5*_t-_p])
        {
            translate([0,0,-.5*h/_b+i]) cube([d+_s+error,w+2*_s+error,_p], center=true);
        }
        cube([d+_s-_p, w+2*_s-_p,h], center=true);
    }
}

module book(d,w,h)
{
    difference ()
    {
        union ()
        {
            //spine
            translate([.5*d+.5*_s,0,-.5*_t]) rotate([90,0,0]) scale([0.8,1,1]) cylinder(d=h/_b,h=w+_s*2, center=true);
            //body
            translate([0,0,-.5*_t]) cube([d+_s,w+_s*2,h/_b], center=true);
        }
        pages(d,w,h); 
    } 
}

module box_bottom(d,w,h)
{  
    for (i = [0:h/_b:h-h/_b+error])
    {
        intersection ()
        {
            translate([0,0,i-(_b-1)*h/(2*_b)]) rotate([0,0,.25*i]) book(d,w,h);
            difference ()
            {
                cube([2*d,2*w,1.5*h], center=true);
                cube([d,w,h+error], center=true);
            }
        }
    }
}


// Top
module lid_decoration(d,w,h)
{
    //border
    translate([0,0,_t-.3]) rotate([0,0,0]) scale([.16,.162,.01]) surface("Border.png", invert=true, center=true);
    //rose
    translate([0,-.1*w,_t-.3]) rotate([0,0,180]) scale([.13,.13,.01]) surface("Rose.png", invert=true, center=true);
    //name
    translate([_nd*d,.4*w,.5*_t]) rotate([0,0,180]) linear_extrude(0.5) text(_n, size = 10, font = "Traditio AH");
}

module box_lid(d,w,h)
{
    cube([d+_s+.5*_t,w+_s*2,_t], center=true);
    translate([0,0,-_t]) cube([d-.5*_t,w-_t,_t], center=true);
    #lid_decoration(d,w,h);
}

module book_lid(d,w,h)
{
    for (i = [h/_b])
    {
        rotate([0,0,.25*i*_b]) book(d,w,h);
        #translate([0,0,.5*h/_b-_t+.3]) rotate([0,0,.25*i*_b]) lid_decoration(d,w,h);
        translate([0,0,-.5*h/_b-_t]) cube([d-.5*_t,w-_t,_t], center=true);
    }
}

module box_top(d,w,h)
{
    if(_b == 1)
    {
        box_lid(d,w,h);
    }
    else
    {
        book_lid(d,w,h);
    }
}

if(_render_top == 1 && _render_bottom == 1)
{
    translate([.5*_object_spacing,0,0]) box_bottom(_d,_w,_h);
    translate([-.5*_object_spacing,0,0]) box_top(_d,_w,_h);
}
else if(_render_top == 1)
{
    box_top(_d,_w,_h);
}
else
{
    box_bottom(_d,_w,_h);
}
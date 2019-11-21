// Magic box
// Kristine Orten, 2018

/*Global*/
// mana [1:plains,2:forest,3:island,4:mountain,5:swamp]
_m = 5;
// name
_n = "Emilie";
// name size (for the name on the back of the top/lid of the box)
_ns = 10;
// name size 2 (name on the front of the top/lid of the box)
_ns2 = 14;

// define card size
// Ex: 60 cards MTG with sleeves 93, 67, 44
// height (in mm)
_h = 93;  
// width (in mm)
_w = 67;
// depth (how thick the pile of cards is (in mm))
_d = 44;

// include cutout in the bottom (saving material & time)
_cutout = 1;  // [1:yes,0:no] 
// rendering the top/lid of the box
_render_top = 1;  // [1:yes,0:no]
// rendering the bottom of the box
_render_bottom = 1;  // [1:yes,0:no]
// spacing between objects when rendering both top and bottom (in mm)
_object_spacing = 2*_d;  

//     _____________
//    /                /|
//   /                d |
//  /____________/  |
// |                |   |
// |                |   |
// |                |   |
// |                h   |
// |                |   |
// |                |   |
// |                |  /
// |                | /
// |_____w_____ |/

/*Hidden*/
// wall thickness
_t = 1.6;
// size difference, top-bottom
_s = .15*2;

error = .01;
$fn = 150;



module box(d,w,h)
{
    difference ()
    {
        cube([d+_t*2, w+_t*2, h], center=true);
        translate([0,0,_t]) cube([d, w, h+error], center=true);
        translate([0,0,.5*h]) rotate([90,0,0]) cylinder(d=.8*d, h=w+_t*2+error, center=true);
    }
}

module cutout(h,w,d)
{
	scale([(h/2),(w/2),1]) rotate([0,0,45]) cube([1,1,5], center=true);

}

module mana_circle(d,w,h)
{
    //plains
        translate([-.5*d-_t-error, -.1*w, .2*h]) rotate([90,0,90]) linear_extrude(0.5) text("A", size = 15, font = "Planewalker Dings");
    //island
        translate([-.5*d-_t-error, -.4*w, .03*h]) rotate([90,0,90]) linear_extrude(0.5) text("B", size = 15, font = "Planewalker Dings");
    //swamp
        translate([-.5*d-_t-error, -.3*w, -.2*h]) rotate([90,0,90]) linear_extrude(0.5) text("C", size = 15, font = "Planewalker Dings");
    //mountain
        translate([-.5*d-_t-error, .1*w, -.2*h]) rotate([90,0,90]) linear_extrude(0.5) text("D", size = 15, font = "Planewalker Dings");
    //forest
        translate([-.5*d-_t-error, .2*w, .03*h]) rotate([90,0,90]) linear_extrude(0.5) text("E", size = 15, font = "Planewalker Dings");
    //#translate([-.5*d-_t-error-.5, 0*w, .05*h]) rotate([0,90,0]) cylinder(r=30, h=2, center=true);
}

module mana(d,w,h)
{
    if (_m == 1) {
                translate([-.5*d-_t*2-error-.5, 0*w+23, .1*h]) rotate([90,180,90]) linear_extrude(1) text("a", size = 50, font = "Planewalker Dings");
            }
            if (_m == 2) {
                translate([-.5*d-_t*2-error-.5, 0*w+23, .1*h]) rotate([90,180,90]) linear_extrude(1) text("e", size = 50, font = "Planewalker Dings");
            }
            if (_m == 3) {
                translate([-.5*d-_t*2-error-.5, 0*w+23, .1*h]) rotate([90,180,90]) linear_extrude(1) text("b", size = 50, font = "Planewalker Dings");
            }
            if (_m == 4) {
                translate([-.5*d-_t*2-error-.5, 0*w+23, .1*h]) rotate([90,180,90]) linear_extrude(1) text("d", size = 50, font = "Planewalker Dings");
            }
            if (_m == 5) {
                translate([-.5*d-_t*2-error-.5, 0*w+23, .1*h]) rotate([90,180,90]) linear_extrude(1) text("c", size = 50, font = "Planewalker Dings");
            }
}

module logo(d,w,h)
{
    translate([-.5*d-_t*2-error-.5, 0*w-28.25, .38*h]) rotate([-90,0,90]) scale([0.3,0.3,0.02]) surface("MagicLogo.png", invert=true, center=false);
}

module name_1(d,w,h)
{
    translate([.5*d+_t+error-.5,-.45*w,-.45*h]) rotate([90,0,90]) linear_extrude(0.5) text(_n, size = 6, font = "Satans");
}

module name_2(d,w,h)
{
    translate([.5*d+_t*2+error, 0, -.45*h]) rotate([90,180,90]) linear_extrude(0.5) text(_n, size = _ns, font = "Satans", direction="ttb");
}

module name_3(d,w,h)
{
    translate([-.5*d-_t*2-error,-.45*w,.35*h]) rotate([90,180,-90]) linear_extrude(0.5) text(_n, size = _ns2, font = "Satans");
}

module box_bottom(d,w,h)
{
    difference ()
    {
        box(d,w,h);
        //front
            name_1(d,w,h);
            if (_cutout)
            {
                translate([.525*d+error,0,.05*h]) rotate([0,90,0]) cutout(h,w,d);
            }
        //back
            mana_circle(d,w,h);
    }
}

module box_top(d,w,h)
{
    box(d+_t*2,w+_t*2,h+_t);
    //front
        #mana(d,w,h);
        //#logo(d,w,h); //or name:
        #name_3(d,w,h);
    //back
        #name_2(d,w,h);
}

if(_render_top == 1 && _render_bottom == 1)
{
    translate([.5*_object_spacing,0,0]) box_bottom(_d,_w,_h);
    translate([-.5*_object_spacing,0,0]) box_top(_d+_s,_w+_s,_h+_s/2);
}
else if(_render_top == 1)
{
    box_top(_d+_s,_w+_s,_h+_s/2);
}
else
{
    box_bottom(_d,_w,_h);
}
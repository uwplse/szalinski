$fn=144;
//Radius of the handle you will use as shaft
Handle_radius=2;
//Radius of the knob on the handle
Handle_knob_radius=5;
//Thickness and radius of the bottom
Bottom_radius=20;
Bottom_height=3;
//Thikness and radius of the conical part
Middle_radius=5;
Middle_height=5;
//0 to render the knob   1 to render the pressing part
Render_bottom=1;

if(Render_bottom==1)
difference()
    {
    union()
        {
        cylinder(r=Bottom_radius,h=Bottom_height);

        translate([0,0,Bottom_height])
        cylinder(r1=Bottom_radius,r2=Middle_radius,h=Middle_height);

        cylinder(r=Handle_radius+2,h=Bottom_height+Middle_height+7);
        }
    translate([0,0,5])
    cylinder(r=Handle_radius,h=100);
    }

if(Render_bottom==0)
difference()
    {
    union()
        {
        translate([0,0,Handle_knob_radius*2])
        scale([1,1,2])
        sphere(r=Handle_knob_radius);
        }
    translate([0,0,-1])
    cylinder(r=Handle_radius,h=100);
    }
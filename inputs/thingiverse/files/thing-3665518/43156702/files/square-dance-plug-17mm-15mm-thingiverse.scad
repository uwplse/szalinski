
// Diameter of the plug
diameter_plug = 16;  // [1:40]
// Set the hole size
diameter_hole = 14;  // [0:40]
// Set the hole size on the back
diameter_hole_back=0; // [0:40]

/* [Advance] */
// Height of plug
height=10.75; // [1:0.1:20]
// Width of the border
border_width=1; // [0:0.1:5]
//Height of the border
border_height=1; // [0:0.1:5]
// Slope length
border_side_length=1; // [0:0.1:5]
// Shape of the plug
hole_shape=200; // [3:1:200]
//Shape of the hole
plug_shape=200; // [3:1:200]
//Make a hole or not ;)
make_hole=true;

variable_plug(diameter_plug, 
                        diameter_hole,
                        diameter_hole_back,      
                        height, 
                        border_width, 
                        border_height, 
                        border_side_length,
                        hole_shape,
                        plug_shape,
                        hole_height=height+2,
                        make_hole=true
                        ); 


module variable_plug(diameter_plug, 
                    diameter_hole,
                        diameter_hole_back=undef,      
                        height=10.75, 
                        border_width=0.5, 
                        border_height=1, 
                        border_side_length=1,
                        hole_shape=5,
                        plug_shape=200,
                        hole_height=10.75+2,
                        make_hole=true
                        )
{
                              
    module plug(){
        radius = diameter_plug/2;
        plug_shape_poly = [[0,0],
                        [radius+border_height,0],
                        [radius+border_height,border_width],
                        [radius,border_width+border_side_length], //4
                        [radius,height-border_width-border_side_length],
                        [radius+border_height,height-border_width],
                        [radius+border_height,height],
                        [0,height]];
        rotate_extrude($fn=plug_shape)
        polygon(points=plug_shape_poly);
    };
    module hole(){
        radius_back = diameter_hole_back/2;
        radius_front = diameter_hole/2;
        echo(radius_back);
        // Valdiate if anohter diameter for the back is set.
        radius_back = diameter_hole_back ? diameter_hole_back/2: diameter_hole/2;
        translate([0,0,-1])
        cylinder(r1=radius_back, r2=radius_front, h=hole_height, $fn=hole_shape);
    };
    if (make_hole)
    {
        difference(){
            plug();
            hole();
        };
    }
    else
    {
        plug();
        hole();
    }
};


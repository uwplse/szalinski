tag_width  = 75;   // [50:5:150]
tag_height = 40;   // [20:1:90]
tag_base   =  1.5; // [1:0.1:3]
tag_thick  =  2.9; // [2:0.1:5]
tag_corner =  5;   // [0.1:1:10]
tag_holder = 10;   // [5:1:20]
border     =  2;   // [1:0.1:5]
cut_w      =  3;   // [1:1:5]
cut_h      = 15;   // [5:1:20]
text_size  =  6;   // [4:1:20]
font       = "Liberation Sans"; 
invert     = "false"; // [false,true]
lid        = "false"; // [false,true]

line_1 = "John Doe";
line_2 = "My Street";
line_3 = "My Zip & City";
line_4 = "My Country";


all();

module all()
{
    if(invert=="true")
    {
        difference()
        {
            translate([-(tag_holder+border),-(tag_height-border),0]) tag(false);
            lug_text(0.01);
        }
    }
    else
    {
        translate([-(tag_holder+border),-(tag_height-border),0]) tag();
        lug_text();
    }
    
    if( lid=="true" )
    {
        translate([-(tag_holder+border),3*border,0]) tag(inlay=false, thick=1.4);
    }
}

module tag(inlay=true, thick=tag_thick)
{
    $fn=tag_corner*12;
    difference()
    {
        if(tag_corner > 0)
        {
            rounded_cube([tag_width,tag_height,thick], rCorner=tag_corner, dimensions=2);
        }
        else
        {
            cube([tag_width,tag_height,thick]);
        }
        // cut for tag holder
        translate([tag_holder/2,tag_height/2-cut_h/2,-0.1]) cube([cut_w,cut_h,thick+0.2]);
        // cut for text
        if(inlay)
        {
            if(tag_corner > 0 && (tag_corner - border) > 0)
            {
                translate([tag_holder,border,tag_base]) 
                    rounded_cube([tag_width-(border+tag_holder),tag_height-2*border,thick], 
                                   rCorner=tag_corner-border, dimensions=2);
            }
            else
            {
                translate([tag_holder,border,tag_base]) 
                    cube([tag_width-(border+tag_holder),tag_height-2*border,thick]);
            }
        }
    }
}

module lug_text(add=0)
{
    translate([0,-1*(text_size+border),0]) linear_extrude(tag_thick+add) text(line_1, size = text_size, font=font);
    translate([0,-2*(text_size+border),0]) linear_extrude(tag_thick+add) text(line_2, size = text_size, font=font);
    translate([0,-3*(text_size+border),0]) linear_extrude(tag_thick+add) text(line_3, size = text_size, font=font);
    translate([0,-4*(text_size+border),0]) linear_extrude(tag_thick+add) text(line_4, size = text_size, font=font);
}

/*
 * cube with rounded edges and corners, depends on param dimensions
 * outerCube is [X,Y,Z]
 * rCorner is the radius of the edges rounding
 * dimensions 2:   4 edges rounded
 * dimensions 3: all edges rounded corners as well
 */
module rounded_cube(outerCube, rCorner, dimensions=3)
{
    hull()
    {
        for(xPos = [rCorner,outerCube[0]-rCorner])
        {
            for(yPos = [rCorner,outerCube[1]-rCorner])
            {
                if(dimensions==2)
                {
                    translate([xPos,yPos,0]) cylinder(r=rCorner, h=outerCube[2]);
                }
                if(dimensions==3)
                {
                    for(zPos = [rCorner,outerCube[2]-rCorner])
                    {
                        translate([xPos,yPos,zPos]) sphere(r=rCorner);
                    }
                }
            }
        }
    }
}

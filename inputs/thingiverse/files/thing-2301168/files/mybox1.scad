part = "both"; // [box:box only,lid:Lid Only,both:box and lid]
height = 100;
width = 200;
length = 100;
wall = 10;
tolerance = .5; // .5 for normal fit



make_part();
module make_part()
{
    if (part == "box")
    {
        box();
    }else if (part == "lid")
    {
        lid();
    }else
    {
        box();
        lid();
    }
}
    

//making the box
module box()
{
    difference()
    {
        lid =[[height - 2*(wall), wall/2], [height-wall, wall/2], [height-wall/2, wall], [height-wall/2, width -  wall], [height-wall, width-wall/2], [height - 2* wall, width - wall/2]  ];
        cube(size = [width, length, height]);
        translate([wall, 2* wall, height- wall]) cube(size = [width - 2*wall, length - 2*wall,  wall]);
        translate([wall, wall, wall]) cube(size = [width - 2*wall, length - 2*wall, height - wall]); 
        translate([width,length+1,0+1]) rotate([0,270,90]) linear_extrude(length+1 - wall) polygon(lid);
    }
}

//making the lid
module lid()
{
    union()
    {
        lid =[[height - 2*(wall), wall/2], [height-wall, wall/2], [height-wall/2, wall], [height-wall/2, width -  wall], [height-wall, width-wall/2], [height - 2* wall, width - wall/2]  ];
        translate([width,-wall ,-height +2* wall-1]) rotate([0,270,90])  linear_extrude(length - wall)  
        
        offset(r = -tolerance) 
        {
           polygon(lid);
        }
        translate([wall+1 , -2*wall  , ])cube(size = [width-2*wall-2, wall , 2*wall]);
    }
}
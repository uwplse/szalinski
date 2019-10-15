// Interlocking tile holder

// Bar type
crossbars = false;

// The size of the tile
t_width = 150;
t_length = 130;
t_height = 2;

// The size of the connectors
connect_width = 15;
connect_height = 2;
connect_length = 4;
connect_angle = 47;

// The fit factor
tile_fit = 1.01;

// The size of the tile
tile_width = t_width * tile_fit;
tile_length = t_length * tile_fit;
tile_height = t_height * tile_fit;

holder_height = tile_height * 2;
holder_thickness = holder_height;

bar_height = holder_thickness / 2;
bar_width = holder_thickness;

// Overlap factor
diff_factor = .001;

// Always have the longest/shortest edge in the same direction
if(tile_width < tile_length) {
    holder(tile_width, tile_length);
} else {
    holder(tile_length, tile_width);
}

// Create the holder
module holder(tw, tl) {
    union() {
        //Base plate
        difference() {
            cube(
                [
                    tw + 2 * holder_thickness,
                    tl + 2 * holder_thickness,
                    holder_height
                ],
                center = true);

            cube(
                [
                    tw,
                    tl,
                    holder_height + diff_factor
                ],
                center = true);
        }
        // Bars
        bar_pos = tl / 4;
   
        if(crossbars) {
            crossbar( bar_pos, tw, tl);
        } else {
            bar(bar_pos, tw, tl);
            bar(-bar_pos, tw, tl);
        }

        // Connectors
        female_horizontal(tw, tl, 0, 0, 0);
        female_vertical(tw, tl, 0, 0, 0);
        
        male_horizontal(tw, tl);
        male_vertical(tw, tl);
    }
};


module male_vertical(tw, tl)
{
    rotate([0, 0, -90])
        male_horizontal(tl, tw);
}

module male_horizontal(tw, tl)
{
    translate([1, 0, 0])
    {
        difference() {
            edge(tw, tl);
            connector(tw, tl);
        }
    }
    
    translate([-1, 0, 0]) {
        mirror([1, 0, 0]) {
            difference() {
                edge(tw, tl);
                connector(tw, tl);
            }
        }
    }
}

module connector(tw, tl)
{
    translate(
        [
            0,
            -tl - 2 * holder_thickness - connect_length,
            -diff_factor
        ])
    {
        female_horizontal(tw, tl, 0, 0, 2);
    }
}

module edge(tw, tl) {
    translate(
        [
            0,
            -tl / 2 - holder_thickness + diff_factor,
            -holder_thickness / 2 - diff_factor
        ])
    {
        rotate(180) {
            cube(
                [
                    tw / 2 - diff_factor,
                    connect_length - 2 * diff_factor,
                    connect_height + diff_factor
                ]);
        }
    }
}


module female_horizontal(tw, tl, extra_width, extra_length, extra_height)
{   
    rotate([0, 0, 90])
        vertical_corner(tl, tw, extra_width, extra_length, extra_height);

    mirror([1, 0, 0])
        rotate([0, 0, 90])
            vertical_corner(tl, tw, extra_width, extra_length, extra_height);
}

module female_vertical(tw, tl, extra_width, extra_length, extra_height)
{   
    vertical_corner(tw, tl, extra_width, extra_length, extra_height);

    mirror([0, 1, 0])
        vertical_corner(tw, tl, extra_width, extra_length, extra_height);
}

module vertical_corner(tw, tl, extra_width, extra_length, extra_height)
{
    angle_sides = connect_width + connect_length + extra_width + extra_length;

    translate(
        [
            tw / 2 + holder_thickness - diff_factor,
            -tl / 2 - holder_thickness,
            -holder_thickness / 2 - extra_height
        ])
    {
        difference() {
            cube(
                [
                    connect_length + extra_length + diff_factor,
                    connect_width - extra_width,
                    connect_height + 2 * extra_height
                ]); 

            translate(
                [
                    0,
                    connect_width - connect_length + extra_width,
                    -2 * connect_height
                ])
            {
                rotate(connect_angle)
                {
                    cube(
                        [
                            angle_sides + diff_factor,
                            angle_sides + diff_factor,
                            4 * (connect_height + extra_height)
                        ]);
                }
            }
        }
    }
}

module bar(pos, tw, tl)
{
    translate( [
        0,
        pos,
        -bar_height / 2
    ])
    {
        cube(
            [
                tw + 2 * (holder_thickness - diff_factor),
                bar_width,
                bar_height - diff_factor
            ],
            center = true);
    }
}

module crossbar(pos, tw, tl)
{
    w = tw - tw / 4 + bar_width * 2;
    l = tl - tl / 2 + bar_width * 2;

    h = sqrt(w * w + l * l);

    translate(
        [
            -tw / 4 - bar_width,
            -tl / 2 - bar_width,
            -bar_height
        ])
        rotate(atan2(l, w))
        {
            cube(
                [
                    h,
                    bar_width,
                    bar_height
                ]);
        }

    mirror([1,0,0])
        mirror([0,1,0])
            translate(
                [
                    -tw / 4 - bar_width,
                    -tl / 2 - bar_width,
                    -bar_height
                ])
                rotate(atan2(l, w))
                {
                    cube(
                        [
                            h,
                            bar_width,
                            bar_height
                        ]);
                }
}

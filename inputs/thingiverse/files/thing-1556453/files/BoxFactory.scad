width  = 30;

height = 30;

depth  = 30;

/* [Template settings] */

thickness     = 1;

// Size of pads, small values will you hard time folding them
pad_size      = 5;

// You better keep it empty to save filament
empty         = 1; //[1:yes, 0:no]

/* [Advanced] */

// Width of the beams, ignored if template is filled
beam_width    = 2.5;

// Radius of the notches to mark folding points, modify if your pen does not fit
notch_radius  = 1;

// Whether to enable support. Disabling support will save filament but your template will not be durable.
support       = 1; //[1:yes, 0:no]

/* [Hidden] */

module UnfoldedBox(width, height, depth, thickness) {
    cube([width, depth, thickness]);

    translate([width, 0])
        cube([height, depth, thickness]);
        
    translate([width+height, 0])
        cube([width, depth, thickness]);

    translate([width*2+height, 0])
        cube([height, depth, thickness]);

    translate([width+height, depth])
        cube([width, height, thickness]);
        
    translate([width+height, -height])
        cube([width, height, thickness]);
}

module UnfoldedBoxPads(width, height, depth, thickness, pad_size, beam_width=0) {
    translation = [0, width, width*2+height];
    widths      = [width, height, height];
    
    bwe=beam_width*sqrt(2)-beam_width;
    bw=beam_width;
    
    for(i = [0:2]) {
        t=translation[i];
        w=widths[i];
        linear_extrude(thickness)
        translate([t, depth])
            polygon([
                [bw             ,-bw         ],
                [bw             ,-bwe        ],
                [pad_size+bwe   , pad_size-bw],
                [w-pad_size-bwe , pad_size-bw],
                [w-bw           ,-bwe        ],
                [w-bw           ,-bw         ],
            ]);
            
        linear_extrude(thickness)
        translate([t, 0])
        mirror([0, 1])
            polygon([
                [bw             ,-bw         ],
                [bw             ,-bwe        ],
                [pad_size+bwe   , pad_size-bw],
                [w-pad_size-bwe , pad_size-bw],
                [w-bw           ,-bwe        ],
                [w-bw           ,-bw         ]
            ]);
    }
    
    linear_extrude(thickness)
    translate([width*2+height*2, 0])
        polygon([
            [-bw         , bw                ],
            [-bwe        , bw                ],
            [ pad_size-bw, pad_size+bwe      ],
            [ pad_size-bw, depth-pad_size-bwe],
            [-bwe        , depth-bw          ],
            [-bw         , depth-bw          ]
        ]);
}

difference() {
    union() {
        UnfoldedBox(width, height, depth, thickness);
        UnfoldedBoxPads(width, height, depth, thickness, pad_size);
    }
    
    if(empty) {
        if(support) {        
            translate([beam_width, beam_width, -0.005])
                cube([width-beam_width*1.5, depth-beam_width*2, thickness+0.01]);
            
            translate([width+beam_width*.5, beam_width, -0.005])
                cube([height-beam_width, depth-beam_width*2, thickness+0.01]);
            
            translate([width+height+beam_width*.5, beam_width, -0.005])
                cube([width-beam_width, depth-beam_width*2, thickness+0.01]);
            
            translate([width*2+height+beam_width*.5, beam_width, -0.005])
                cube([height-beam_width, depth-beam_width*2, thickness+0.01]);
            
            translate([beam_width+width+height, beam_width-height, -0.005])
                cube([width-beam_width*2, height-beam_width*1.5, thickness+0.01]);
            
            translate([beam_width+width+height, beam_width*.5+depth, -0.005])
                cube([width-beam_width*2, height-beam_width*1.5, thickness+0.01]);
                            
            translate([beam_width+width+height, beam_width*.5, -0.005])
                cube([width-beam_width*2, height-beam_width*1, thickness+0.01]);

        }
        else {
            translate([beam_width, beam_width, -0.005])
                cube([width*2+height*2-beam_width*2, depth-beam_width*2, thickness+0.01]);
            
            translate([beam_width+width+height, beam_width-height, -0.005])
                cube([width-beam_width*2, height*2-beam_width*2+depth, thickness+0.01]);
        }
        
        translate([0,0,-0.005])
        UnfoldedBoxPads(width, height, depth, thickness+0.01, pad_size, beam_width+0.01);
    }
    $fn=16;
    translate([0,0, -0.005])
    linear_extrude(thickness+0.01) {
        translate([0,0])
        circle(r = notch_radius);
        translate([width,0])
        circle(r = notch_radius);
        translate([width+height,0])
        circle(r = notch_radius);
        translate([width*2+height,0])
        circle(r = notch_radius);
        translate([width*2+height*2,0])
        circle(r = notch_radius);
        
        translate([0,depth]) {
            translate([0,0])
            circle(r = notch_radius);
            translate([width,0])
            circle(r = notch_radius);
            translate([width+height,0])
            circle(r = notch_radius);
            translate([width*2+height,0])
            circle(r = notch_radius);
            translate([width*2+height*2,0])
            circle(r = notch_radius);
        }
        
        circle(r = 1);
    }
    
}
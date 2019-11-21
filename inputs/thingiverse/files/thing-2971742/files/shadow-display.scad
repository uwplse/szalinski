// Width in mm. If you don't know then leave it at 0.4mm.
printer_nozzle_size = 0.4; //[0.2,0.3,0.4,0.6,0.8]

left_image = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,0,0,1,1,1,1,0,0,0,0,1,1,1,1,1,1,1,1,1,0,1,1,1,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,0,1,1,1,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,0,1,1,1,0,0,0,1,1,0,0,0,0,0,0,0,1,1,1,0,1,1,1,1,0,0,0,1,1,0,0,0,0,0,0,0,0,1,1,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,1,1,0,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,1,1,0,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,1,1,1,0,1,1,1,1,1,1,0,0,1,1,1,0,0,0,0,1,1,1,1,0,1,1,1,1,1,1,0,0,1,1,1,0,0,0,0,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1,1,0,0,0,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,0,0,1,1,1,1,1,1,1,1,1,0,0,1,1,1,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]; //  [image_array:20x20]
right_image = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,1,1,0,0,1,1,1,1,1,1,1,1,1,0,0,0,0,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,0,0,0,0,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,0,1,1,1,1,0,0,0,0,1,1,1,0,0,1,1,1,1,1,1,0,1,1,1,0,0,0,0,0,1,1,1,0,0,1,1,1,1,1,1,1,0,1,1,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,0,1,1,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,0,1,1,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,0,1,1,1,0,0,0,0,0,0,0,1,1,0,0,0,1,1,1,0,1,1,1,1,0,0,0,0,0,0,0,1,1,0,0,0,1,1,1,0,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,1,1,1,0,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,1,1,1,0,1,1,1,1,1,1,1,1,1,0,0,0,0,0,1,1,1,0,0,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]; //  [image_array:20x20]

/* [Hidden] */
// This gives you that beautiful circular crop. Always times out in the web UI.
overall_shape = "square"; //[circle,square]

// Resolution
pattern_width = 20;
pattern_height = 20;
// Extra plastic at the bottom.
base_height = 40;
// This many blank pixels are added to left. right, top, bottom.
border = 2;
// Should pixels be black or white?
border_fill = 0;

// Convert to B&W
right = invert_and_bin(right_image);
left  = invert_and_bin(left_image);

// This is used to calculate how thick the type 3 walls are. _|_.
// 20 means that the wall is 2/20 = 0.1 pixels wide.
// Lowering this number will allow you to increase the resolution at the cost of thick (ugly) walls.
// This number must be even.
unit_width = 20; 

// How high are the ledges in comparison to the pixel size? Basically z scale.
z_step_height = unit_width/1.5;


/*
Transition types:
_____ 0

__|-- 1

--|__ 2

__|__ 3

*/
function get_transitions(start, end, right, left) =
   [for (i = [start:end+1])
   let (
       a = i==start ? 0 : left[i-1],
       b = i>=end ? 0 : right[i]
   )
     a == 0 && b == 0 ? 0
   : a == 1 && b == 0 ? 1
   : a == 0 && b == 1 ? 2
   : 3];
function repeat(value, count) =
    [for(i = [0:count-1]) value];
// inverts color and converts anything to B&W
function invert_and_bin(pattern) =
    [for(i = [0:len(pattern)-1]) round(1 - pattern[i])];
    
/* Sections:
    
   1     2 3      4  
________|- -|________
__________|----------
_____________________
*/
function get_heights(
   unit_width, transitions, i, height
   ) =
   i >= len(transitions) - 1 ? [] :
   let (
        transition = transitions[i],
        section_1_height = height,
        section_2_height = height +
            (transition == 0 ? 0
            :transition == 1 ? 0
            :transition == 2 ? 0
            : 1),
        section_3_height = height +
            (transition == 0 ? 0
            :transition == 1 ? 1
            :transition == 2 ? -1
            : 1),
        section_4_height = height +
            (transition == 0 ? 0
            :transition == 1 ? 1
            :transition == 2 ? -1
            : 0)        
   )
   concat(
    repeat(section_1_height, unit_width/2 - 1),
    section_2_height,
    section_3_height,
    repeat(section_4_height, unit_width/2 - 1),
    
    get_heights(unit_width, transitions, i+1, section_4_height)
   );

 
function add_border(pattern, pattern_height, pattern_width, border, border_fill) =
  [for (row=[0-border:pattern_height-1+border])
    for (col=[0-border:pattern_width-1+border])
        row < 0 ? border_fill
        : row >= pattern_height ? border_fill
        : col < 0 ? border_fill
        : col >= pattern_width ? border_fill
        : pattern[row*pattern_height+col]
    ];
 
function get_surface(right, left, pattern_height, pattern_width, z_step_height) =
[for (row=[0:pattern_height-1])
    let (
        start = row*pattern_width,
        end = start + pattern_width,
        transitions = get_transitions(start, end, right, left),
        heights = get_heights(unit_width, transitions, 0, 0),
        center = (min(heights) + max(heights))/2
    )
    [for (col=[0:len(heights)-1])  
        (heights[col]-center)*z_step_height
    ]];
    
function min_of_surface(surface) =
    min([for (row=[0:len(surface)-1]) min(surface[row])]);
    
function normalize_surface(base_height, surface) =
    let (
        min_height = min_of_surface(surface)
    )
    [for (row=[0:len(surface)-1])
        [for (col=[0:len(surface[row])-1])
            surface[row][col] - min_height + base_height
    ]];
        
module draw_object() {
    bordered_right = add_border(
        right,
        pattern_height,
        pattern_width,
        border,
        border_fill);
    bordered_left = add_border(
        left,
        pattern_height,
        pattern_width,
        border,
        border_fill); 
    surface = get_surface(
        bordered_right,
        bordered_left,
        pattern_height+2*border,
        pattern_width+2*border,
        z_step_height);
    normalized_surface = normalize_surface(
        base_height,
        surface);

    for (row=[0:len(normalized_surface)-1])
        for (col=[0:len(normalized_surface[row])-1]) 
            translate(
                [col*printer_nozzle_size,
                row*printer_nozzle_size*unit_width,
                0])
            cube(
                [printer_nozzle_size,
                printer_nozzle_size*unit_width,
                normalized_surface[row][col]*printer_nozzle_size]);
}

if (overall_shape == "circle") {
    radius = (2*border + pattern_height)*unit_width*printer_nozzle_size/2;
    intersection() {        
    translate([radius, radius, -radius]) cylinder(h=radius*10, r=radius, center=false, $fn=100);
    draw_object();
}}
else if (overall_shape == "square") {
    draw_object();
}

    
    
    
    
    
   


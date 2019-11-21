// [* Options *]
// What title should be printed?
title_text = "FILAMENT HOLE SIZE TESTER";
// How many holes of each type should be printed?
holes_per_row = 17; // [5,7,9,11,13,15,17,19,21]
// What diameter should the smallest hole of each type be, in millimeters?
smallest_hole_diameter = 2.90;
// How much larger than the previous hole should each hole be, in millimeters?
per_hole_diameter_increase = 0.05;
// [* Hidden *]

// Convert strings to floating point for compatibility with Customizer
function atoi(str, base=10, i=0, nb=0) =
	i == len(str) ? (str[0] == "-" ? -nb : nb) :
	i == 0 && str[0] == "-" ? atoi(str, base, 1) :
	atoi(str, base, i + 1,
		nb + search(str[i], "0123456789ABCDEF")[0] * pow(base, len(str) - i - 1));

function substr(str, pos=0, len=-1, substr="") =
	len == 0 ? substr :
	len == -1 ? substr(str, pos, len(str)-pos, substr) :
	substr(str, pos+1, len-1, str(substr, str[pos]));
    
function atof(str) = len(str) == 0 ? 0 : let( expon1 = search("e", str), expon = len(expon1) ? expon1 : search("E", str)) len(expon) ? atof(substr(str,pos=0,len=expon[0])) * pow(10, atoi(substr(str,pos=expon[0]+1))) : let( multiplyBy = (str[0] == "-") ? -1 : 1, str = (str[0] == "-" || str[0] == "+") ? substr(str, 1, len(str)-1) : str, decimal = search(".", str), beforeDecimal = decimal == [] ? str : substr(str, 0, decimal[0]), afterDecimal = decimal == [] ? "0" : substr(str, decimal[0]+1) ) (multiplyBy * (atoi(beforeDecimal) + atoi(afterDecimal)/pow(10,len(afterDecimal)))); 

function aorftof(numorstr) = (numorstr + 1 == undef) ? atof(numorstr) : numorstr;
function aoritoi(numorstr) = (numorstr + 1 == undef) ? atoi(numorstr) : numorstr;

title_text_param = title_text;
holes_per_row_param = aoritoi(holes_per_row);
smallest_hole_diameter_param = aorftof(smallest_hole_diameter);
per_hole_diameter_increase_param = aorftof(per_hole_diameter_increase);


// Blank space at each edge of the block
edge_size = 4.0 + 0;
between_hole_minimum_spacing = 2.5 + 0;
between_row_minimum_spacing = 5.0 + 0;



largest_hole_diameter = smallest_hole_diameter_param + ((holes_per_row_param - 1) * per_hole_diameter_increase_param);

// Spacing between center of one hole and center of the next
hole_spacing_x = largest_hole_diameter + between_hole_minimum_spacing;
hole_spacing_y = largest_hole_diameter + between_row_minimum_spacing;

block_thickness = 8.0 + 0;

// X-coordinate of the center of the first hole in each row
first_hole_center_x = -((holes_per_row_param - 1) * hole_spacing_x) / 2;
// X-coordinate of the center of the last hole in each row
last_hole_center_x = -first_hole_center_x;

text_row_ysize = 8.0 + 0;
text_height = 0.8 + 0;

// Using this holes should come out approximately right when printed
module polyhole(h, d) {
    n = max(round(2 * d),3);
    rotate([0,0,180])
        cylinder(h = h, r = (d / 2) / cos (180 / n), $fn = n);
}

function hole_center_x(idx_hole) = first_hole_center_x + (hole_spacing_x * idx_hole);
function hole_diameter(idx_hole, smallest_hole_diameter_param) = smallest_hole_diameter_param + (per_hole_diameter_increase_param * idx_hole);

// Leftmost edge of the hole grid
hole_grid_xmin = hole_center_x(0) - (smallest_hole_diameter_param / 2);
// Rightmost edge of the hole grid
hole_grid_xmax = hole_center_x(holes_per_row_param-1) + (largest_hole_diameter / 2);
// Topmost edge of the hole grid
hole_grid_ymax = (hole_spacing_y / 2) + (largest_hole_diameter / 2);
// Bottommost edge of the hole grid
hole_grid_ymin = -(hole_spacing_y / 2) - (largest_hole_diameter / 2);
    

module holerow(use_polyholes, hole_center_y) {
    for(idx_hole = [0 : holes_per_row_param - 1]) {
        translate([hole_center_x(idx_hole),hole_center_y,0]) {
            d = hole_diameter(idx_hole, smallest_hole_diameter_param);
            if (use_polyholes > 0) {
                polyhole(h=block_thickness + 0.001, d=d);
            } else {
                cylinder(h=block_thickness + 0.001, r=d/2, $fn=48);
            }
        }
    }
}

module allholerows() {
    holerow(0, hole_spacing_y / 2);
    holerow(1, -hole_spacing_y / 2);
}

function textextrusionheight(text_height) = text_height + 0.001;

module label(smallest_hole_diameter, text_center_y) {
    hole_skip = 2 + 0; // Label only every other hole between the first and last
    for(idx_hole = [0 : hole_skip : holes_per_row_param - 1]) {
        labeltext = str(hole_diameter(idx_hole, smallest_hole_diameter));
        xsizemax = min(hole_spacing_x * 1.7, 4 * len(labeltext));
        echo(labeltext, xsizemax);
        translate([hole_center_x(idx_hole), text_center_y, block_thickness - 0.001]) {
            resize([xsizemax, 0, 0], auto=false)
            {
                linear_extrude(height=textextrusionheight(text_height)) {
                    text(text=labeltext, size=4, halign="center", valign="center");
                }
            }
        }
    }
}

module mainlabel(labeltext, text_center_y)
{
    xsizemax = min(hole_grid_xmax-hole_grid_xmin - 5, 10*len(labeltext));
    echo(xsizemax);
    translate([(hole_grid_xmin+hole_grid_xmax)/2, text_center_y, block_thickness - 0.001])
    {
        resize([xsizemax, 0, 0], auto=false)
        {
            linear_extrude(height=textextrusionheight(text_height))
            {
                text(text=labeltext, size=5, halign="center", valign="center");
            }
        }
    }
}
    
module block() {
    block_xmin = hole_grid_xmin - edge_size;
    block_xmax = hole_grid_xmax + edge_size;  
    block_xsize = block_xmax - block_xmin;
    block_ymax = hole_grid_ymax + edge_size + (2 * text_row_ysize);
    block_ymin = hole_grid_ymin - edge_size;
    block_ysize = block_ymax - block_ymin;
    block_zmax = block_thickness;
    block_zmin = 0;
    block_zsize = block_zmax - block_zmin;
    translate([block_xmin, block_ymin, block_zmin]) {
        cube([block_xsize, block_ysize, block_zsize]);
    }
}

function isdef(x) = (x != undef);
function isnumeric(x) = isdef(x) && ( x + 0 == x);
function isinteger(x) = isdef(x) && ( floor(x) == x) ;
assertions = [
    [ isinteger(holes_per_row_param), "Holes per row must be an integer" ] ,
    [ holes_per_row_param > 2, "Holes per row must be at least 3" ] ,
    [ isnumeric(smallest_hole_diameter_param), "Smallest hole diameter must be a number" ] ,
    [ smallest_hole_diameter_param > 0, "Smallest hole diameter must be greater than zero" ] ,
    [ isnumeric(per_hole_diameter_increase), "Hole diameter increase must be numeric"] ,
    [ per_hole_diameter_increase > 0, "Hole diameter increase must be greater than zero"]
];
module showfailedassertions() {
    for(idx = [0 : len(assertions)-1]) {
        if (!assertions[idx][0]) {
            translate([0, -12*idx, 0]) linear_extrude(height=1) text(text=assertions[idx][1]);
        }
    }
}

function anyassertionfailed(idx = len(assertions)-1) = (!(assertions[idx][0]) ? 1 : (idx <= 0) ? 0 : anyassertionfailed(idx-1)); 

module debugme(idx, label, val)
{
    * translate([0, -12*idx, 0]) linear_extrude(1) text(text=str(label, " = ", val));
}

if (anyassertionfailed())
{
    showfailedassertions();
}
else
{
    difference() {
       block();
       allholerows();
    }
    label(smallest_hole_diameter_param, hole_grid_ymax + (text_row_ysize / 2));
    mainlabel(title_text_param, hole_grid_ymax + (text_row_ysize * 3 / 2));
}

debugme(0, "Hole_grid_xmin", hole_grid_xmin);
debugme(1, "Hole_grid_xmax", hole_grid_xmax);
debugme(2, "Hole_grid_ymin", hole_grid_ymin);
debugme(3, "Hole_grid_ymax", hole_grid_ymax);
debugme(4, "Hole_center_x(0)", hole_center_x(0));
debugme(5, "Holes_per_row", holes_per_row_param + 0);
debugme(6, "Hole_spacing_x", hole_spacing_x);
debugme(7, "Largest_hole_diameter", largest_hole_diameter);
debugme(8, "Between_hole_minimum_spacing", between_hole_minimum_spacing);
debugme(9, "Smallest_hole_diameter", smallest_hole_diameter_param + 0);
debugme(10, "Perhole_diameter_increase", per_hole_diameter_increase_param + 0);
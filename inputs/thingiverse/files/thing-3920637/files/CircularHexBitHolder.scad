/**
	Customisable hex bit holder 
	Copyring Mykhaylo Lytvynyuk October 2019
	http://mobilemodding.info
	Released under 
	Attribution - Non-Commercial - No Derivatives License

	*** October 16, 2019 Initial Version
*/

// Diameter of the holder, mm
_diameter = 126;

// inside diameter of the HEX hole, mm
_bitSize = 6.35;

// Height of the holder, mm
_height = 10;

// Padding between HEX slots, mm
_padding = 2;

// Extra padding to take in account termal expansion/contaction of the material and printer precision, mm
_tolerance = 0.8;

// Make hole completely through
_holeThrough = 1;//[1:Yes,0:No]

// Make slot to add flex to the walls ( slot height is 75% of the height parameter )
_slotted = 1;//[1:Yes,0:No]

// Calculate outter radius of the hex bit slot based on in-radius (or hex bit size/2) and number of sides
outerRadius = outRadius(_bitSize + _tolerance,6);

/* center */
x1 = 0;
y1 = 0;
z1 = 0;

// Precalculate values
outer_diameter = outerRadius * 2;
_row = floor (_diameter  / (outer_diameter + _padding));
_col = floor (_diameter  / (outer_diameter + _padding));

// Calculate width and height of the grid
gridWidth = _row * (outer_diameter + _padding);
gridHeight = _col * (outer_diameter + _padding);

// Calculate starting point of row/col grid
originX = gridWidth / -2;
originY = gridHeight / -2;

// This is complete width/height of the slot + padding
delta = outer_diameter + _padding;

// Put all together
module assembly() {
difference() {
    
	base();
	for(yd = [1:_row]) {
		for(xd = [1:_col]) {
            x = originX + (xd * delta)-(delta/2);
            y = originY + (yd * delta)-(delta/2);
			if(false || inside (x,y) <= (_diameter / 2 - delta /2)) {
                translate([x, y, _holeThrough?0:1]) hexBit();
            }
		}
	}
}
}

// Hex bit slot
module hexBit() {
    translate([0,0,_height/2]) {
        cylinder(h=_height,r = outerRadius ,$fn=6, center = true);
        translate([0,0,_height - _height*0.75]) cube([gridWidth + 4, 2 , _height*0.75], center = true);
    }
};

// Circular base
module base() {
     color("red") cylinder(r = _diameter /2, h = _height , $fn=128, center = false);
}

// Calculates outradius (half long diagonal) by given inradius (half short diagonal) of the hexagon
function outRadius(smallDiagonal, sides) = smallDiagonal * sin(30)/sin(120);

// returns distance between centers of 2 circles
function inside(x,y) = abs( sqrt( pow((x-x1),2) + pow((y-y1),2)));

assembly();
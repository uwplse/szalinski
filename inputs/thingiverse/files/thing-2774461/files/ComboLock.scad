
$fn=100;
$fs=0.01;

// Outer diameter of the lid
outer_diameter = 100; // [50:1:500]

// Minimum height (will adjust up to accomodate extra digits)
height = 135; // [50:1:500]

// Wall thickness
wall_thickness=2; // [0.4:0.1:5]

// Number of "columns" (possible combination values)
value_count=10; // [2:1:30]

// Comma separated list of digits (must all be integers, no spaces)
digitString = "1,2,3,4,5";

coin_slot=true;
coin_size=28;
coin_thickness=3;

// Height of the base
base_height=15; // [5:1:50]
// Font size for the numbers at the base
font_size=10;
// Name of the font to use for the numbers, if you want to override the default
font_name="";

// Tolerance between the cylinder and the cover
tolerance=0.25; // [0.25:0.01:1.5]

// Which part to render (render each piece and save it!)
render = "base"; // [all, top, base]

// What is the height of each ring? (and spacing between them)
ring_height=10;
// Which is the thickness of each ring?
ring_thickness=3;

// The radius of notch corners.
notch_corners=3;

inner_radius=outer_diameter/2-wall_thickness;

outer_circumference = 2 * 3.14157 * outer_diameter/2;

// We don't want the notches to ever touch; at most there should be 1/2 of a notch's width
// spacing between each one
max_notch_diameter = (outer_circumference / value_count) * 0.5;
notch_radius = min(ring_height*0.6, max_notch_diameter/2);

core_radius = inner_radius - ring_thickness - tolerance;

digits = [ for (i = split(digitString, ",")) parse_int(i)];

echo("Actual height: ");
used_height = max(height - base_height, (ring_height * 2 * (len(digits) + 1)));
echo(used_height+base_height);

// ###############################################
// String functions used for customizer loading: #
// from https://www.thingiverse.com/thing:526023 #
// ###############################################
function split(string, seperator=" ", ignore_case = false, regex=false) = 
	_split(string, index_of(string, seperator, ignore_case=ignore_case, regex=regex));
    
function _split(string, indices, i=0) = 
    len(indices) == 0?
        [string]
    : i >= len(indices)?
        _coalesce_on(after(string, indices[len(indices)-1].y-1), "", [])
    : i == 0?
        concat( _coalesce_on(before(string, indices[0].x), "", []), _split(string, indices, i+1) )
    :
        concat( between(string, indices[i-1].y, indices[i].x), _split(string, indices, i+1) )
    ;

function _coalesce_on(value, error, fallback) = 
	value == error?
		fallback
	: 
		value
	;
function after(string, index=0) =
	string == undef?
		undef
	: index == undef?
		undef
	: index < 0?
		string
	: index >= len(string)-1?
		""
	:
        join([for (i=[index+1:len(string)-1]) string[i]])
	;
function before(string, index=0) = 
	string == undef?
		undef
	: index == undef?
		undef
	: index > len(string)?
		string
	: index <= 0?
		""
	: 
        join([for (i=[0:index-1]) string[i]])
	;
//note: start is inclusive, end is exclusive
function between(string, start, end) = 
	string == undef?
		undef
	: start == undef?
		undef
	: start > len(string)?
		undef
	: start < 0?
		before(string, end)
	: end == undef?
		undef
	: end < 0?
		undef
	: end > len(string)?
		after(string, start-1)
	: start > end?
		undef
	: start == end ? 
		"" 
	: 
        join([for (i=[start:end-1]) string[i]])
	;
function join(strings, delimeter="") = 
	strings == undef?
		undef
	: strings == []?
		""
	: _join(strings, len(strings)-1, delimeter, 0);
function _join(strings, index, delimeter) = 
	index==0 ? 
		strings[index] 
	: str(_join(strings, index-1, delimeter), delimeter, strings[index]) ;

function index_of(string, pattern, ignore_case=false, regex=false) = 
	_index_of(string, 
        regex? _parse_rx(pattern) : pattern, 
        regex=regex, 
        ignore_case=ignore_case);
function _index_of(string, pattern, pos=0, regex=false, ignore_case=false) = 		//[start,end]
	pos == undef?
        undef
	: pos >= len(string)?
		[]
	:
        _index_of_recurse(string, pattern, 
            _index_of_first(string, pattern, pos=pos, regex=regex, ignore_case=ignore_case),
            pos, regex, ignore_case)
	;
function _index_of_recurse(string, pattern, index_of_first, pos, regex, ignore_case) = 
    index_of_first == undef?
        []
    : concat(
        [index_of_first],
        _coalesce_on(
            _index_of(string, pattern, 
                    pos = index_of_first.y,
                    regex=regex,
                    ignore_case=ignore_case),
            undef,
            [])
    );
function _index_of_first(string, pattern, pos=0, ignore_case=false, regex=false) =
	pos == undef?
        undef
    : pos >= len(string)?
		undef
	: _coalesce_on([pos, _match(string, pattern, pos, regex=regex, ignore_case=ignore_case)], 
		[pos, undef],
		_index_of_first(string, pattern, pos+1, regex=regex, ignore_case=ignore_case))
    ;
function _match(string, pattern, pos, regex=false, ignore_case=false) = 
    regex?
    	_match_parsed_peg(string, undef, pos, peg_op=pattern, ignore_case=ignore_case)[_POS]
    : starts_with(string, pattern, pos, ignore_case=ignore_case)? 
        pos+len(pattern) 
    : 
        undef
    ;
function equals(this, that, ignore_case=false) = 
	ignore_case?
		lower(this) == lower(that)
	:
		this==that
	;
function upper(string) = 
	let(code = ascii_code(string))
	join([for (i = [0:len(string)-1])
			code[i] >= 97 && code[i] <= 122?
                chr(code[i]-97+65)
            :
                string[i]
		]);
function lower(string) = 
	let(code = ascii_code(string))
	join([for (i = [0:len(string)-1])
			code[i] >= 65 && code[i] <= 90?
                chr(code[i]+97-65)
            :
                string[i]
		]);

function starts_with(string, start, pos=0, ignore_case=false, regex=false) = 
	regex?
		_match_parsed_peg(string,
			undef,
			pos, 
			_parse_rx(start), 
			ignore_case=ignore_case) != undef
	:
		equals(	substring(string, pos, len(start)), 
			start, 
			ignore_case=ignore_case)
	;
function ends_with(string, end, ignore_case=false) =
	equals(	after(string, len(string)-len(end)-1), 
		end,
		ignore_case=ignore_case)
	;
function substring(string, start, length=undef) = 
	length == undef? 
		between(string, start, len(string)) 
	: 
		between(string, start, length+start)
	;
function parse_int(string, base=10, i=0, nb=0) = 
	string[0] == "-" ? 
		-1*_parse_int(string, base, 1) 
	: 
		_parse_int(string, base);

function _parse_int(string, base, i=0, nb=0) = 
	i == len(string) ? 
		nb 
	: 
		nb + _parse_int(string, base, i+1, 
				search(string[i],"0123456789ABCDEF")[0]*pow(base,len(string)-i-1));

// ############################################

module tube(height, outer_radius, wall_thickness) {
    difference() {
        cylinder(height, outer_radius, outer_radius, $fs=0.01);
        translate([0,0,-0.1])
            cylinder(height+2, outer_radius-wall_thickness, outer_radius-wall_thickness, $fs=0.01);
    }
}

module ring(val=1) {
    supportHeight = ring_thickness;
    difference() {
        union() {
            // First draw the tapered out base to the ring -- this allows us to 
            cylinder(supportHeight, core_radius, inner_radius - tolerance, $fs=0.01);
            translate([0,0,supportHeight])
                cylinder(ring_height - supportHeight, inner_radius - tolerance, inner_radius - tolerance, $fs=0.01);
        }
        translate([0,0,-0.1])
            cylinder(ring_height+0.2, core_radius, core_radius, $fs=0.01);
        
        for (rVal = [0 : 1 : value_count-1]) {
            if (rVal == val || val == -1) {
                rotate([0,90,(360/value_count)*rVal]) translate([-notch_radius*5, -notch_radius, 0]) cube([notch_radius*6, notch_radius*2, outer_diameter + 2], center=false);
            } else {
                translate([0,0,-notch_radius/4]) rotate([0,90,(360/value_count)*rVal]) hull() {
                    union() {
                        translate([-ring_height*5/8,-notch_radius+3,0]) cylinder(outer_diameter/2 + 2, notch_corners, notch_corners);
                        translate([-ring_height*5/8, notch_radius-3,0]) cylinder(outer_diameter/2 + 2, notch_corners, notch_corners);
                        translate([ ring_height*5/8,-notch_radius+3,0]) cylinder(outer_diameter/2 + 2, notch_corners, notch_corners);
                        translate([ ring_height*5/8, notch_radius-3,0]) cylinder(outer_diameter/2 + 2, notch_corners, notch_corners);
                    }
                    translate([-ring_height/4,0,0])
                        cylinder(outer_diameter/2 + 2, notch_radius, notch_radius);
                }
            }
        }
    }
}

module flubjub(r) {
    sphere_r = 3;
    hull() {
        translate([-r/2 + sphere_r/2, -r/2 + sphere_r/2, -r/2 + sphere_r/2]) sphere(sphere_r);
        translate([ r/2 - sphere_r/2, -r/2 + sphere_r/2, -r/2 + sphere_r/2]) sphere(sphere_r);
        translate([-r/2 + sphere_r/2,  r/2 - sphere_r/2, -r/2 + sphere_r/2]) sphere(sphere_r);
        translate([ r/2 - sphere_r/2,  r/2 - sphere_r/2, -r/2 + sphere_r/2]) sphere(sphere_r);
        translate([-r/2 + sphere_r/2, -r/2 + sphere_r/2,  r/2 - sphere_r/2]) sphere(sphere_r);
        translate([ r/2 - sphere_r/2, -r/2 + sphere_r/2,  r/2 - sphere_r/2]) sphere(sphere_r);
        translate([-r/2 + sphere_r/2,  r/2 - sphere_r/2,  r/2 - sphere_r/2]) sphere(sphere_r);
        translate([ r/2 - sphere_r/2,  r/2 - sphere_r/2,  r/2 - sphere_r/2]) sphere(sphere_r);
    }
}

module lock_cyl() {
    digit_count=len(digits);
    for (num = [1 : 1 : digit_count]) {
        translate([0,0,ring_height * (num*2 - 1)])
            /* render() */ ring(val=digits[num-1]);
    }
    translate([0,0,used_height - ring_height])
        ring(val=-1);
}

module draw_base() {
    difference() {
        cylinder(base_height, outer_diameter/2, outer_diameter/2);
        
        translate([0,0,base_height/2]) cylinder(base_height, core_radius - wall_thickness, core_radius - wall_thickness);
        for (rVal = [0 : 1 : value_count-1]) {
            rotate([0,0,(360/value_count)*(rVal+0.5)])
                translate([outer_diameter/2 + notch_radius/2, 0, -0.5]) cylinder(50, notch_radius, notch_radius);
            rotate([0,0,(360/value_count)*rVal])
                translate([outer_diameter/2 - 0.5, 0, base_height/2]) rotate([90,0,90]) linear_extrude(height=1) text(str(rVal), halign="center", valign="center", size=font_size, font=font_name);
        }
    }
}

module draw_cap() {
    difference() {
        cylinder(wall_thickness, outer_diameter/2, outer_diameter/2);
        if (coin_slot) {
            translate([0,coin_thickness/2,wall_thickness/2]) rotate([90,0,0]) cylinder(coin_thickness, coin_size/2, coin_size/2);
        }
    }
    translate([0,0,wall_thickness]) tube(used_height + 1, outer_diameter/2, wall_thickness);
    
    flubjub_radius=notch_radius*.95;
    translate([0, outer_diameter/2 - flubjub_radius/2 + wall_thickness, wall_thickness + used_height - notch_radius/2 - 3]) color("red") flubjub(flubjub_radius);
}

if (render == "all" || render == "base") {
    /* render() */ draw_base();
    translate([0,0,base_height]) {
        tube(used_height, core_radius, wall_thickness);

        lock_cyl();
    }
}

if (render=="all") {
    %rotate([0,0,18]) translate([0,0,used_height + base_height + wall_thickness + 1 + 10]) rotate([0,180,0]) draw_cap();
} else if (render == "top") {
    draw_cap();
}
//use <string.scad>;
//use <MQR-code.scad>;

/* [Shapes] */

edge_shape = "rectangular"; // [rectangular, circular, sphere]
edge_hole_shape = "rectangular"; // [rectangular, circular, none]
// The main hole is usefull if you want a mobile construction
main_hole_shape = "none"; // [rectangular, circular, none]
// The main shape of your corner.
shape = "Personalised"; // [Extremity, I, T, L, X, Cube_corner, T_corner, Half_star, Star, Tetrahedron_corner, Octahedron_corner, Personalised]
// On several shapes, you can change the number of members.
edges_number = 1; // [0:min, 1:medium, 2:max]
// In case of a personalised part, set here the part members angles, by pairs of vertical angle and horizontal angle.
angles = "090,000,000,090,090,090";

/* [Dimentions] */

// width of the part.
width = 7.5;
// Set 0 if you want than edge length equals Width.
edge_length = 14;
// Edges hole width size.
hole_width = 4.5;
// Set 0 if you want than edge length equals Width.
hole_deep = 8.5;
// Difference between the main hole size and the edges hole size.
main_hole_slack = 0.2;

/* [Clip] */

// This clip allows you to hold the rods on the plastic part.
clip_type = "hole"; // [none, hole]
clip_width = 2;
clip_position = 4;

/* [Bevel] */

edge_bevel = "none"; // [none, thin, medium, large, sphere]
external_bevel = "sphere"; // [none, sphere]
holes_bevel = "none"; // [none, thin, medium, large]

/* [Hidden] */

id = 12345;
notch_size = 1.5;
code = false;

/* Here is the serious stuff */

print_parts(shape);

module print_parts(part)
{
	if (part == "Extremity")
		part([[90,0]]);

	else if (part == "I")
		part([[90,0], [90,180]]);

	else if (part == "T")
		if (edges_number == 0)
			part([[90,0], [90,90], [90,180]]);
		else
			part([[90,0], [90,45], [90,90], [90,135], [90,180]]);

	else if (part == "L")
		if (edges_number == 0)
			part([[90,0], [90,90]]);
		else
			part([[90,0], [90,45], [90,90]]);

	else if (part == "X")
		if (edges_number == 0)
			part([[90,0], [90,90], [90,180], [90,270]]);
		else
			part([[90,0], [90,45], [90,90], [90,135], [90,180], [90,225], [90,270], [90,315]]);

	else if (part == "Cube_corner")
		if (edges_number == 0)
			part([[0,0], [90,0], [90,90]]);
		else if (edges_number == 1)
			part([[0,0], [45,0], [90,0], [45,90], [90,90]]);
		else
			part([[0,0], [45,0], [90,0], [45,90], [90,90], [90,45]]);

	else if (part == "T_corner")
		if (edges_number == 0)
			part([[0,0], [90,0], [90,90], [90,180]]);
		else if (edges_number == 1)
			part([[0,0], [45, 0], [90,0], [45,90], [90,90], [45,180], [90,180]]);
		else
			part([[0,0], [45, 0], [90,0], [45,90], [90,90], [45,180], [90,180], [90,45], [90,135]]);

	else if (part == "Half_star")
		if (edges_number == 0)
			part([[0,0], [90,0], [90,90], [90,180], [90, 270]]);
		else if (edges_number == 1)
			part([[0,0], [45, 0], [90,0], [45,90], [90,90], [45,180], [90,180], [90,270], [45,270]]);
		else
			part([[0,0], [45, 0], [90,0], [45,90], [90,90], [45,180], [90,180], [90,45], [90,135], [90,270], [45,270], [90,225], [90,315]]);

	else if (part == "Star")
		if (edges_number == 0)
			part([[0,0], [90,0], [90,90], [90,180], [90, 270], [180,0]]);
		else if (edges_number == 1)
			part([[0,0], [45, 0], [90,0], [45,90], [90,90], [45,180], [90,180], [90,270], [45,270], [180,0], [135,0], [135,90], [135,180], [135,270]]);
		else
			part([[0,0], [45, 0], [90,0], [45,90], [90,90], [45,180], [90,180], [90,45], [90,135], [90,270], [45,270], [90,225], [90,315], [180,0], [135,0], [135,90], [135,180], [135,270]]);
	
	else if (part == "Tetrahedron_corner")
		part([[35.26,0], [35.26,120], [35.26,240]]); // acos(sqrt(6)/3)

	else if (part == "Octahedron_corner")
		part([[45,0], [45, 90], [45,180], [45,270]]); // acos(sqrt(2)/2)

	else if (part == "Personalised")
		part([[d(0),d(1)], [d(2),d(3)], [d(4),d(5)], [d(6),d(7)], [d(8),d(9)], [d(10),d(11)]]);
}

module part(v)
{
	$fn = 50;
	edge_length = (edge_length < width) ? width : edge_length;
	hole_width = (hole_width >= width) ? width-1 : hole_width;
	main_hole_width = hole_width + main_hole_slack;
	hole_deep = (hole_deep <=0) ? edge_length : hole_deep;

	translate([0,0,width/2]) intersection() {
		if (external_bevel == "sphere") 
			sphere(edge_length);

		difference() {
			if (edge_shape == "sphere") {
				sphere(edge_length);
			} else {
				union() {
					sphere(width/2);
					for(i = [0:len(v)-1]) {
						if (v[i][0] != -1)
							rotate([v[i][0], 0, v[i][1]])
							translate([0,0,-width/8]) intersection() {
								cylinder(r1=width/2-width/64, r2=width, h=edge_length+width/8);
								block(width, edge_length+width/2, edge_shape, bevel = "ext");
						}
					}

				}
			}
	
			for(i = [0:len(v)-1]) {
					if (v[i][0] != -1)
						rotate([v[i][0], 0, v[i][1]]) {
							translate([0, 0, edge_length - hole_deep + 0.1])
								block(hole_width, hole_deep, edge_hole_shape, bevel = "int");
							translate([hole_width/4, -notch_size/2, edge_length-notch_size*0.6])
								cube([width/2, notch_size, notch_size]);
							if (clip_type == "hole") {
								translate([0, 0.5, edge_length-hole_deep+clip_position+1]) rotate([90,0,0]) translate([0, 0, -width/2])
									cylinder(r=clip_width/2, h=width+1);
							}
						}
			}

			block(main_hole_width, width+1, main_hole_shape);
		}
	}
	
	if (code == true)
		translate([0,0,width/2])
			for(i = [0:len(v)-1])
				if (v[i][0] != -1)
					rotate([v[i][0], 0, v[i][1]])
					translate([-hole_width/2, -hole_width/2, edge_length-hole_deep-0.1])
						mqr_code(id, hole_width, 4);
}

module block(block_width, length, shape, bevel)
{
	ext_bevel = bevel(edge_bevel, block_width)/2;
	int_bevel = bevel(holes_bevel, hole_width)*1.5;

	length = (length == 0) ? width : length;

	translate ([0, 0, length/2-0.1]) /*intersection()*/ {
		union() {
			if (shape=="rectangular")
				cube([block_width, block_width, length], center=true);
			else if (shape=="circular")
				cylinder(r=block_width/2, h=length, center=true);
			else if (shape=="hexagonal")
				rotate([0,0,22.5]) cylinder(r=block_width/2, h=length, center=true, $fn=8);
	
			if (bevel == "int")
				translate([0, 0, length/2 - block_width/2]) rotate([0,0,45])
					cylinder(r1=0, r2 = (edge_hole_shape == "rectangular") ? block_width*0.707 + int_bevel : block_width/2 + int_bevel, h=block_width/2, $fn = (edge_hole_shape == "rectangular") ? 4 : $fn);
		}
		
		/*union() {
			if (bevel == "ext") {
				translate([0, 0, length*1.5 - block_width*0.28 - ext_bevel]) rotate([180,0,45])
					cylinder(r1=0, r2 = block_width+0.1, h=block_width+0.1, $fn = (edge_hole_shape == "rectangular") ? 4 : $fn);
				translate([0, 0, -length/2]) cube([block_width+0.1, block_width+0.1, length*1.5+0.1], center=true);
			}
		}*/
	}
}

function bevel(type, ref) = (type == "thin") ? ref*0.2 : (type == "medium") ? ref*0.3 : (type == "large") ? ref*0.6 : 0;

function d(i) = (strToInt(getsplit(angles, i, ",")) == undef) ? -1 : strToInt(getsplit(angles, i, ","));


// *** string.scad library : http://www.thingiverse.com/thing:202724 ***


function strToInt(str, base=10, i=0, nb=0) = (str == undef) ? undef : (str[0] == "-") ? -1*_strToInt(str, base, 1) : _strToInt(str, base);
function _strToInt(str, base, i=0, nb=0) = (i == len(str)) ? nb : nb+_strToInt(str, base, i+1, search(str[i],"0123456789ABCDEF")[0]*pow(base,len(str)-i-1));

function strcat(v, car="") = _strcat(v, len(v)-1, car, 0);
function _strcat(v, i, car, s) = (i==s ? v[i] : str(_strcat(v, i-1, car, s), str(car,v[i]) ));

function substr(data, i, length=0) = (length == 0) ? _substr(data, i, len(data)) : _substr(data, i, length+i);
function _substr(str, i, j, out="") = (i==j) ? out : str(str[i], _substr(str, i+1, j, out));

function fill(car, nb_occ, out="") = (nb_occ == 0) ? out : str(fill(car, nb_occ-1, out), car);

function getsplit(text, index=0, car=" ") = get_index(text, index, car) == len(text)+1 ? undef : substr(text, get_index(text, index, car), get_index(text, index+1, car) - get_index(text, index, car) - len(car));
function get_index(text, word_number, car) = word_number == 0 ? 0 : search(car, text, len(text))[0][word_number-1] == undef ? len(text)+len(car) : len(car) + search(car, text, len(text))[0][word_number-1];
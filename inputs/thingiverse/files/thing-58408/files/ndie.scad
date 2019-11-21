include <write/Write.scad>

SIDES = 11;
//in mm
HEIGHT = 40;
//percent
FACE_DEPTH = 30;//[0:100]
//percent
FONT_DEPTH = 20;//[0:100]
//in mm
FONT_SIZE = 6;
//style
FONT = "write/Letters.dxf";//["write/Letters.dxf":Standard,"write/orbitron.dxf":Orbitron,"write/knewave.dxf":Knewave,"write/BlackRose.dxf":BlackRose,"write/braille.dxf":Braille]
RESOLUTION = 250;//[100:Low,250:Medium,400:High]



// radius of sphere
RADIUS = HEIGHT/2;

// approx depth of arc on sphere
SAGITTA_MAX = RADIUS-RADIUS*sin(90 - acos(1-2/SIDES));

// dot product of vector with z unit vector
function dot_z(x,y,z) = acos(z/sqrt(x*x + y*y + z*z));

// cross product of vector with z unit vector
function cross_z(x,y,z) = [y,-x,0];



/*
 * Wrapper for write that will disambiguate strings with only sixes or nines
 * by underlining the entire string
 */
module safe_write(word, t, h, center, font) {
	write(word, t=t, h=h, center=true, font=FONT);
	
	// only if string is all sixes or nines
	six_search = search("6", word);
	nine_search = search("9", word);
	if ((len(six_search) + len(nine_search)) == len(word))
	{
		translate([0,-6*h/10,0]) cube(size = [len(word)*(6*h/10),h/10,t], center = true);
	}
}


/*
 * Face number pair
 */
module face_pair(n, radius, face_depth, font_depth)
{
	translate([0,0,-2*(radius-face_depth)]) 
	{
		cube(2*radius, center=true);
	}
	translate([0,0,radius-font_depth/2]) 
	{
		safe_write(str(n), t=font_depth, h=FONT_SIZE, center=true, font=FONT);
	}
}

/*
 * N-sided face face number pairs
 *
 * Golden selection spiral adopted from:
 * http://www.xsi-blog.com/archives/115
 */
module n_face_pairs(n, radius, face_depth, font_depth)
{
	inc = 180 * (3 - sqrt(5));
	off = 2.0 / n;

	for (k = [0:n-1])
	{
		assign (y = k * off - 1 + (off / 2)) 
		{
			assign(r = sqrt(1 - y*y), phi = k * inc) 
			{

				assign(x=cos(phi)*r, z=sin(phi)*r)
				{
					// rotate by angle of dot product about the cross product vector
					// to align z unit vector to direction of given vector
					rotate(dot_z(x,y,z), cross_z(x,y,z))
					{
						face_pair(k+1, radius, face_depth, font_depth);
					}
				}
			}
		}
	}
}


/*
 * Rotate golden selection spiral where k=0, so that face of side-1 is
 * always z-down.
 */
module n_face_pairs_up(n, radius, face_depth, font_depth, resolution)
{
	x = sqrt( 2/n - 1/(n*n) );
	y = 1/n - 1;
	z = 0;
	// rotate by angle of dot product about the cross product vector
	// to align z unit vector to direction of given vector
	rotate(dot_z(x,y,z) + 180, cross_z(x,y,z)) {
		n_face_pairs(n, radius, face_depth, font_depth);
	}
}


module n_die(n, radius, face_depth, font_depth, resolution)
{
	difference() 
	{
		sphere(radius, $fn=resolution);

		// special handeling for low values of n
		if (n == 2) 
		{
			face_pair(1, radius, face_depth, font_depth);
			rotate(180, [1,0,0]) face_pair(2, radius, face_depth, font_depth);

		} 
		else if (n == 4) 
		{
			face_pair(1, radius, face_depth, font_depth);
			rotate(110, [1,0,0]) face_pair(2, radius, face_depth, font_depth);
			rotate(120, [0,0,1]) rotate(110, [1,0,0]) face_pair(3, radius, face_depth, font_depth);
			rotate(240, [0,0,1]) rotate(110, [1,0,0]) face_pair(4, radius, face_depth, font_depth);
			
		} 
		else if (n == 6) 
		{
			face_pair(1, radius, face_depth, font_depth);
			rotate(90, [1,0,0]) face_pair(2, radius, face_depth, font_depth);
			rotate(180, [1,0,0]) face_pair(6, radius, face_depth, font_depth);
			rotate(270, [1,0,0]) face_pair(5, radius, face_depth, font_depth);
			rotate(90, [0,1,0]) face_pair(3, radius, face_depth, font_depth);
			rotate(270, [0,1,0]) face_pair(4, radius, face_depth, font_depth);

		// else perform golden selection spiral
		} else {
			n_face_pairs_up(n, radius, face_depth, font_depth);
		}
	}
}

n_die(SIDES, RADIUS, FACE_DEPTH/100 * SAGITTA_MAX, FONT_DEPTH/25 * SAGITTA_MAX, RESOLUTION);

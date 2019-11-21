//custom dice
//source and license here: http://www.thingiverse.com/thing:1659071
//Derived from here: https://github.com/clothbot/makerbot/blob/master/fabjects/libraries/constructors/map2PointsOnSphere.scad
//which was in turn derived from here: http://www.softimageblog.com/archives/115
//string splitting from here http://www.thingiverse.com/thing:1237203
//geodesic sphere from here: http://www.thingiverse.com/thing:1484333
//deja vu font from here: http://dejavu-fonts.org/wiki/Download

/* [Main] */

//Separate with spaces, see thing description for more details
sides = "⚀ ⚁ ⚂ ⚃ ⚄ ⚅";

sphere_diameter = 30; //[10:100]

/* [Tweaks] */

//leave 0 for auto, set to a value if you need different size flat faces
flat_face_diameter = 0; //[0:100]

//leave 0 for auto, set to a value if you need different size numbers
number_size = 0; //[0:100]

number_depth = 0.8;  //[0:0.2:2]

//See fonts.google.com for available fonts, then type the name in
font = "DejaVu Sans";

/* [Hidden] */
//sample sides
//sides = "♣ ♠ ♥ ♦";
//sides = "♈ ♉ ♊ ♋ ♌ ♍ ♎ ♏ ♐ ♑ ♒ ♓";
//sides = "Andy Bob Chris Dave";
//sides = "1 20 2 19 3 18 4 17 5 16 6. 15 7 14 8 13 9. 12 10 11";
//sides = "0 1 2 3 4 5 6. 7 8 9. A B C D E F";
//sides = "1 2 3 4 5 6. 7 8 9. 10 11 12 13";
//sides = "1 2 3 4 5 6. 7 8 9. 10";
//sides = "1 2 3 4 5 6 7";
//sides = "1 2 3 4 5 6";
//sides = "Ⅰ Ⅱ Ⅲ Ⅳ Ⅴ Ⅵ Ⅶ Ⅷ Ⅸ Ⅹ";
//sides = "1 2 3";
//sides = "♚ ♛ ♜ ♝ ♞ ♟";

faces = split(sides);
echo(faces);
point_count = len(faces);
face_diameter = (flat_face_diameter<=0) ? sphere_diameter/pow(point_count,1/3)*0.9 : flat_face_diameter ;
echo(face_diameter=face_diameter);
pi=3.1415926;

number_height = (number_size<=0) ? face_diameter : number_size;
sphere_radius = sphere_diameter/2;
point_radius = face_diameter/2;
c0=pointOnSphere(radius=sphere_radius,k=0,N=point_count);
tilt = cart2sphere(c0[0],c0[1],c0[2]);
flat_height = sphere_radius - sqrt(sphere_radius*sphere_radius-point_radius*point_radius);

points_on_sphere = [for(i=[0:point_count-1]) pointOnSphere(radius=sphere_radius,k=i,N=point_count)];
points_vector = [
	for(i=[0:point_count-1]) 
		[	cart2sphere(points_on_sphere[i][0],points_on_sphere[i][1],points_on_sphere[i][2])[1]-tilt[1]+180,
			cart2sphere(points_on_sphere[i][0],points_on_sphere[i][1],points_on_sphere[i][2])[2]-tilt[2],
			0
		]
];
echo(points_vector=points_vector);

V2();
module V2() {
	difference() {
		//main body
		color("grey") sphere_shape(r=sphere_radius);
		//flatten faces
		color("grey") for(i=[0:point_count-1]) 
			rotate(points_vector[i])
				translate([0,0,sphere_radius-flat_height])
					cylinder(r=point_radius+1,h=sphere_radius);
		//numbers
		color("white") difference() {
			for(i=[0:point_count-1])
				rotate(points_vector[i])
					rotate([180,0,rands(0,360,1)[0]]) 
						linear_extrude(sphere_radius*2,convexity=10)
							text(faces[i],size=number_height,font=font,halign="center",valign="center");	
			difference() {
				sphere_shape(r=sphere_radius-number_depth);
				for(i=[0:point_count-1]) 
					rotate(points_vector[i]) 
						translate([0,0,sphere_radius-flat_height-number_depth])
							cylinder(r=point_radius,h=sphere_radius);
			}
		}
	}
	module sphere_shape(r) {
		geodesic_sphere(r=r);
		//sphere(r=r);
	}
}

function cart2sphere(x,y,z) = [ // returns [r, inclination, azimuth]
	sqrt( x*x+y*y+z*z )
	, acos(z/sqrt(x*x+y*y+z*z))
	, atan2(y,x)
	];

function pointOnSphere(radius=1.0,k,N) =
	[ radius*cos(360*k*pi*(3-sqrt(5))/(2*pi))*sqrt(1-(k*(2/N)-1+((2/N)/2))*(k*(2/N)-1+((2/N)/2)))
	, radius*(k*(2/N)-1+((2/N)/2))
	, radius*sin(360*k*pi*(3-sqrt(5))/(2*pi))*sqrt(1-(k*(2/N)-1+((2/N)/2))*(k*(2/N)-1+((2/N)/2)))
	];

//from here http://www.thingiverse.com/thing:1237203
function split(str, sep=" ", i=0, word="", v=[]) =
	i == len(str) ? concat(v, word) :
	str[i] == sep ? split(str, sep, i+1, "", concat(v, word)) :
	split(str, sep, i+1, str(word, str[i]), v);

// same syntax and semantics as built-in sphere, so should be a drop-in replacement
// it's a bit slow for large numbers of facets
module geodesic_sphere(r=-1, d=-1) {
  // if neither parameter specified, radius is taken to be 1
  rad = r > 0 ? r : d > 0 ? d/2 : 1;  
  
  pentside_pr = 2*sin(36);  // side length compared to radius of a pentagon
  pentheight_pr = sqrt(pentside_pr*pentside_pr - 1);
  // from center of sphere, icosahedron edge subtends this angle
  edge_subtend = 2*atan(pentheight_pr);

  // vertical rotation by 72 degrees
  c72 = cos(72);
  s72 = sin(72);
  function zrot(pt) = [ c72*pt[0]-s72*pt[1], s72*pt[0]+c72*pt[1], pt[2] ];

  // rotation from north to vertex along positive x
  ces = cos(edge_subtend);
  ses = sin(edge_subtend);
  function yrot(pt) = [ ces*pt[0] + ses*pt[2], pt[1], ces*pt[2]-ses*pt[0] ];
  
  // 12 icosahedron vertices generated from north, south, yrot and zrot
  ic1 = [ 0, 0, 1 ];  // north
  ic2 = yrot(ic1);    // north and +x
  ic3 = zrot(ic2);    // north and +x and +y
  ic4 = zrot(ic3);    // north and -x and +y
  ic5 = zrot(ic4);    // north and -x and -y
  ic6 = zrot(ic5);    // north and +x and -y
  ic12 = [ 0, 0, -1]; // south
  ic10 = yrot(ic12);  // south and -x
  ic11 = zrot(ic10);  // south and -x and -y
  ic7 = zrot(ic11);   // south and +x and -y
  ic8 = zrot(ic7);    // south and +x and +y
  ic9 = zrot(ic8);    // south and -x and +y
  
  // start with icosahedron, icos[0] is vertices and icos[1] is faces
  icos = [ [ic1, ic2, ic3, ic4, ic5, ic6, ic7, ic8, ic9, ic10, ic11, ic12 ],
    [ [0, 2, 1], [0, 3, 2], [0, 4, 3], [0, 5, 4], [0, 1, 5],
      [1, 2, 7], [2, 3, 8], [3, 4, 9], [4, 5, 10], [5, 1, 6], 
      [7, 6, 1], [8, 7, 2], [9, 8, 3], [10, 9, 4], [6, 10, 5],
      [6, 7, 11], [7, 8, 11], [8, 9, 11], [9, 10, 11], [10, 6, 11]]];
  
  // now for polyhedron subdivision functions

  // given two 3D points on the unit sphere, find the half-way point on the great circle
  // (euclidean midpoint renormalized to be 1 unit away from origin)
  function midpt(p1, p2) = 
    let (midx = (p1[0] + p2[0])/2, midy = (p1[1] + p2[1])/2, midz = (p1[2] + p2[2])/2)
    let (midlen = sqrt(midx*midx + midy*midy + midz*midz))
    [ midx/midlen, midy/midlen, midz/midlen ];
  
  // given a "struct" where pf[0] is vertices and pf[1] is faces, subdivide all faces into 
  // 4 faces by dividing each edge in half along a great circle (midpt function)
  // and returns a struct of the same format, i.e. pf[0] is a (larger) list of vertices and
  // pf[1] is a larger list of faces.
  function subdivpf(pf) =
    let (p=pf[0], faces=pf[1])
    [ // for each face, barf out six points
      [ for (f=faces) 
          let (p0 = p[f[0]], p1 = p[f[1]], p2=p[f[2]])
            // "identity" for-loop saves having to flatten
            for (outp=[ p0, p1, p2, midpt(p0, p1), midpt(p1, p2), midpt(p0, p2) ]) outp
      ],
      // now, again for each face, spit out four faces that connect those six points
      [ for (i=[0:len(faces)-1])
        let (base = 6*i)  // points generated in multiples of 6
          for (outf =
          [[ base, base+3, base+5], 
          [base+3, base+1, base+4],
          [base+5, base+4, base+2],
          [base+3, base+4, base+5]]) outf  // "identity" for-loop saves having to flatten
      ]
    ];

  // recursive wrapper for subdivpf that subdivides "levels" times
  function multi_subdiv_pf(pf, levels) =
    levels == 0 ? pf :
    multi_subdiv_pf(subdivpf(pf), levels-1);

  // subdivision level based on $fa:
  // level 0 has edge angle of edge_subtend so subdivision factor should be edge_subtend/$fa
  // must round up to next power of 2.  
  // Take log base 2 of angle ratio and round up to next integer
  ang_levels = ceil(log(edge_subtend/$fa)/log(2));
    
  // subdivision level based on $fs:
  // icosahedron edge length is rad*2*tan(edge_subtend/2)
  // actually a chord and not circumference but let's say it's close enough
  // subdivision factor should be rad*2*tan(edge_subtend/2)/$fs
  side_levels = ceil(log(rad*2*tan(edge_subtend/2)/$fs)/log(2));
  
  // subdivision level based on $fn: (fragments around circumference, not total facets)
  // icosahedron circumference around equator is about 5 (level 1 is exactly 10)
  // ratio of requested to equatorial segments is $fn/5
  // level of subdivison is log base 2 of $fn/5
  // round up to the next whole level so we get at least $fn
  facet_levels = ceil(log($fn/5)/log(2));
  
  // $fn takes precedence, otherwise facet_levels is NaN (-inf) but it's ok 
  // because it falls back to $fa or $fs, whichever translates to fewer levels
  levels = $fn ? facet_levels : min(ang_levels, side_levels);

  // subdivide icosahedron by these levels
  subdiv_icos = multi_subdiv_pf(icos, levels);
  
  scale(rad)
  polyhedron(points=subdiv_icos[0], faces=subdiv_icos[1]);
}

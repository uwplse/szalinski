/*

   Customizable Crystal Dice
   © Copyright - Tamas Decsi (silvereye)

   http://www.thingiverse.com/silvereye/

   License: Creative Commons - Attribution - Share Alike
   Commercial Use Allowed
   
*/

/* =================== parameters ====================== */
//CUSTOMIZER VARIABLES

/* [Shape and Size] */

// total length of die in millimeters
Dice_Length = 20; //[10:50]

// pyramid base polygon - determines number of die faces
pyramid_shape = 6; //[3:Triangle (D6),4:Square (D8),5:Pentagon (D10) ,6:Hexagon (D12),7:Heptagon (D14),8:Octagon (D16),9:Nonagon (D18),10:Decagon (D20)]

// body height ratio (percentage of pyramid's base radius)
body_height_ratio = 240; //[10:500]

// keep this between zero and half body height to make sure the die won't land on its top or bottom.
pyramid_height = 60; //[0:100]

/* [Text] */
// try any google font name
Font = "Ubuntu";

// relative size of letters
font_size = 4; //[2:6]

print_quality = 100; //[80:Low,100:Good,120:High]

text_1 = "1";
text_2 = "2";
text_3 = "3";
text_4 = "4";
text_5 = "5";
text_6 = "6.";
text_7 = "7";
text_8 = "8";
text_9 = "9.";
text_10 = "10";
text_11 = "11";
text_12 = "12";
text_13 = "13";
text_14 = "14";
text_15 = "15";
text_16 = "16";
text_17 = "17";
text_18 = "18";
text_19 = "19";
text_20 = "20";

//CUSTOMIZER VARIABLES END
/* ===================================================== */
/* [Hidden] */

poly = pyramid_shape;
h = body_height_ratio / 100;
t = pyramid_height / 100;
letter_size = font_size/10;
letters = [text_1,text_2,text_3,text_4,text_5,text_6,text_7,text_8,text_9,text_10,text_11,text_12,text_13,text_14,text_15,text_16,text_17,text_18,text_19,text_20];
e = 2*cos(90-(180/poly)); // pyramid edge length
ang = asin((1-1*sin(90-(180/poly)))/h); // body face to vertical angle

function poly_vertices(n, poly, radius, initial_angle, z_offset) =
  n>=poly?[]:concat(
    [
      [
        sin(initial_angle + n*(360/poly))*radius,
        cos(initial_angle + n*(360/poly))*radius,
        z_offset
      ]
    ],
    poly_vertices(n+1,poly,radius,initial_angle,z_offset)
  );

vertices = concat(
  //top vertex
  [[0,0,h/2+t]],
  // bottom vertex
  [[0,0,-h/2-t]],
  // top polygon
  poly_vertices(0,poly,1,0,h/2),
  // bottom polygon
  poly_vertices(0,poly,1,180/poly,-h/2)
);

function pyramid_faces(n, poly, top, first) =
  n>=poly?[]:concat(
    [
      [top, first+n, first+((n+1)%poly)]
    ],
    pyramid_faces(n+1,poly,top,first)
  );

function pyramid_faces_revorder(n, poly, top, first) =
  n>=poly?[]:concat(
    [
      [first+n, top, first+((n+1)%poly)]
    ],
    pyramid_faces_revorder(n+1,poly,top,first)
  );

function side_faces(n, poly, p1, p2) = 
  n>=poly?[]:concat(
    [
      [p1+(n+1)%poly,p2+n,p2+((n+1)%poly)],
      [p1+n, p2+n, p1+((n+1)%poly)]
    ],
    side_faces(n+1, poly, p1, p2)
  );

faces = concat(
  // top pyramid
  pyramid_faces(0, poly, 0, 2),
  // bottom pyramid
  pyramid_faces_revorder(0, poly, 1, 2+poly),
  // sides
  side_faces(0, poly, 2, 2+poly)
);

module letters_mask(poly, first) {
  union() {
    for(num=[0:poly-1]) {
      translate([0,0,-0.25])
      rotate([90-ang,0,(360/poly)*num])
      linear_extrude(height = 1, convexity=20) 
      text(str(letters[first+num]?letters[first+num]:""), size = letter_size, font = Font, halign = "center", valign = "center", $fn = print_quality/5);
    }
  }
}

echo(h+min(t,0)*2);
scale(Dice_Length/(h+min(t,0)*2))
  translate([0,0,1-(1-sin(90-(180/poly)))/2])
  rotate([90+(poly%2?ang:-ang),0,0])
  union () {
    difference() {
      polyhedron(points=vertices, faces=faces, convexity=10);
      // cut out text
      translate([0,0,h/3])
        rotate([0,0,(poly%2)?0:(180/poly)])
        letters_mask(poly,0);
      rotate([180,0,0])
        translate([0,0,h/3])
        letters_mask(poly,poly);
  }
  // infill
  scale(0.95)
    polyhedron(points=vertices, faces=faces, convexity=10);
};

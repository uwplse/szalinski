// KeyForge Julia Set Aember Tokens
//   by Michael Van Biesbrouck, c. 2019

// Create a set of unique Aember tokens.  To get a different
// set of tokens than anyone else you need to modify the
// Julia Set parameters.
//
// Make coarse adjustment with 2 rows and colums to change
// the designs that you will get and add some random digits
// to ensure that your tokens will be unique.  When you
// increase the number of rows and columns then you will get
// intermediate designs compared to your four seeds.
//
// Note that the generated models are extremely complex.
// Depending on your settings it may take longer to generate
// STL files than it does to print the tokens.

/* [Julia Set Parameters] */
// Mininum real part of constant
min_cx = -0.74; // [-0.74:0.0001:-0.715]
// Maximum real part of constant, must be greater than min
max_cx = -0.72; // [-0.74:0.0001:-0.715]
// Mininum imaginary part of constant
min_cy = 0.155; // [0.1:0.0001:0.19]
// Maximum imaginary part of constant, must be greater than min
max_cy = 0.185; // [0.1:0.0001:0.19]
// Iterations used to determine if value is in the Julia set
limit = 200;    // [200:100:1000]

/* [Aember Dimensions] */
// Actual height of bead not counting the Julia set
bead_final_height = 3;      // [2:10]
// Height of bead before slicing top and bottom off, greater than final height
bead_height = 5;            // [3:15]
// Long dimension of bead
bead_length = 14;           // [5:25]
// Short dimension of bead
bead_width = 10;            // [5:25]
// Complexity of bead
bead_facets = 10;           // [6:20]
// Resolution of Julia set.  Set too high and parts of the image will disappear when slicing.  If multiplying by length and width is not an integer then there won't be rotational symmetry.
bead_pixels_per_mm = 2.5;   // [1:0.5:10]
// Height of Julia set, limited by height removed from bead
bead_emboss_height = 0.5;   // [0.2:0.1:1.0]

/* [Aember Quantities] */
// Rows; if 1 only uses min_cx
bead_rows = 2;
// Columns; if 1 only uses min_cy
bead_cols = 2;

bead_x_pixels = bead_length * bead_pixels_per_mm;
bead_y_pixels = bead_length * bead_pixels_per_mm;
max_r = bead_rows - 1;
max_c = bead_cols - 1;
r_spacing = bead_length + 2;
c_spacing = bead_width + 2;
eps = 0.000001 + 0;

function julia (x, y, cx, cy) = real_julia(x*3.5-1.75, y*2-1, cx, cy, 0);

function real_julia (x, y, cx, cy, iter) =
    let (xx=x*x, yy=y*y) iter > limit ? 1 : xx+yy > 4 ? 0 : real_julia(xx-yy+cx, 2*x*y+cy, cx, cy, iter+1);

module bead (cx, cy) {
    intersection () {
        scale ([bead_length, bead_width, bead_height])
            sphere (d=1, $fn=bead_facets, center=true);
        union () {
            cube ([bead_length, bead_width, bead_final_height], center=true);
            for(x=[0:bead_x_pixels]) {
                for(y=[0:bead_y_pixels]) {
                  translate( [(x-bead_x_pixels/2)/bead_pixels_per_mm, (y-bead_y_pixels/2)/bead_pixels_per_mm, bead_final_height/2] )
                  cube( size = [1/bead_pixels_per_mm+eps, 1/bead_pixels_per_mm+eps, julia(x/bead_x_pixels, y/bead_y_pixels, cx, cy)*2*bead_emboss_height], center=true );
                }
            }
        }
    }
}

for (r = [0:max_r]) for (c=[0:max_c])
    translate ([r_spacing*r, c_spacing*c, 0])
        bead (min_cx + (max_r == 0 ? 0 : (r*(max_cx-min_cx)/max_r)), min_cy + (max_c == 0 ? 0 : (c*(max_cy-min_cy)/max_c)));

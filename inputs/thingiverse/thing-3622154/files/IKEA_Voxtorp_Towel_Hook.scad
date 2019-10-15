/*
 * IKEA Voxtorp Towel Hook by Luiz Motta
 * https://www.thingiverse.com/luizmotta/about
 */
$fn=40;

d=10;
plate_height=32;
plate_width=30;

hook_width=10;
hook_depth=10;
hook_length=25;

thickness=3;

translate( [0, 0, -(plate_width-hook_width)/2] ) {
    cylinder( plate_width, d/2, d/2 );
    translate( [0, d/2-thickness, 0] ) cube( [plate_height, thickness, plate_width]);
}
translate( [0, -d/2, 0] ) cube( [d/2+thickness, d, hook_width]);
translate( [5, -13, 0] ) cube( [thickness, 15, hook_width]);
translate( [-hook_length -thickness, -12 -thickness, 0] ) cube( [ 5 + hook_length + 2*thickness, thickness, hook_width ]);
translate( [-hook_length -thickness, -15 -thickness -hook_depth, 0] ) cube( [ thickness, hook_depth + thickness, hook_width ]);
translate( [-hook_length, -15 -thickness -hook_depth, 0] ) cube( [ hook_depth, thickness, hook_width ]);
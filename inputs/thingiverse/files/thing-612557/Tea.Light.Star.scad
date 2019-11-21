//variables
width = 75; // [50:150]
length = 75; // [50:150]
height = 75; // [50:150]
wallthickness = 1.5; // [1.5:5]
twist = 40; // [0:100]
resolution = 100; // [10:300]

// twisted shell
difference(){
linear_extrude(height = zheight , twist = ztwist , slices =  zresolution ) union(){square([ zwidth , zlength ], center=true); rotate([0,0,45]) {square([ zwidth , zlength ], center=true);}}
translate ([0,0, zwallthickness ])
linear_extrude(height = zheight- zwallthickness , twist = ztwist , slices = zresolution ) union(){square( [ zwidth - zwallthickness , zlength - zwallthickness ] , center=true); rotate([0,0,45]) {square( [ zwidth - zwallthickness , zlength - zwallthickness ] , center=true);}}
}

// candle support
difference(){
cylinder (h=12, r=20, $fn=100);
translate ([0,0,8]) cylinder (h=4, r=18, $fn=100);
}

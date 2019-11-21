//variables
width = 75; // [50:150]
length = 75; // [50:150]
height = 75; // [50:150]
wallthickness = 1.5; // [1.5:5]
twist = 40; // [0:100]
resolution = 10; // [10:300]

// twisted shell
difference(){
linear_extrude(height = height , twist = twist , slices =  resolution ) square([ width , length ], center=true);
translate ([0,0, wallthickness ])
linear_extrude(height = height- wallthickness , twist = twist , slices = resolution ) square( [ width - wallthickness , length - wallthickness ] , center=true);
}

// candle support
difference(){
cylinder (h=12, r=20, $fn=100);
translate ([0,0,8]) cylinder (h=4, r=18, $fn=100);
}

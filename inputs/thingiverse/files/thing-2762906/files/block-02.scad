// All dimensions are in mm 
// Block Width in mm  
X = 30; // [5:0.5:500]
// Block Depth in mm
Y = 25; //[5:0.5:500]
// Block Height in mm
Z = 20;//[5:0.5:500]

// Slices
// Width of Slices
KERF = .5; // [0.1:0.1:5]
// Distance Between Slices
INTERVAL = 2; // [0.1:0.1:10]

// preview[view:north west, tilt:top diagonal]

module slices(num, space) {
   for (i = [0 : num-2])
     translate([ 0, space*i, 0 ]) children(0);
   }
module block() {
    difference(){
        translate([ 0, -Y*.1, 0 ]) {
            cube([ X/.8, Y/.8, Z ]);
            }
            translate([ 0, INTERVAL, Z*.25]) {
                slices(Y/INTERVAL, INTERVAL) {
                    cube([X,KERF,Z+2]);
                    }
                    }
                    }
                    }
         
module sample() { // This is a total hack for now
    translate([ -5, -55, -4]){
        scale([ .3, .3, .3 ]) 
        rotate([ 90, 0, 90]){
            import("VenusOfWillendorf_scaled.stl", convexity=30);
            }
            }
            }

difference() {
    block();
    sample();
    }

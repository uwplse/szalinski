//
// Customizable Curd Cover
//

/* [Dimensions] */
// Natural vs. printable rendering of the object
FlipOver=0; // [0:no,1:yes]
// The x-dimension of the actual container to cover
CoverLength=116.0;
// The y-dimension of the actual container to cover
CoverWidth=78.0;
// The inner height of the cover that we are creating
CoverHeight=5.0;
// The wall thickness of the resulting cover
CoverThickness=2.0;
// The diameter of the lower left corner of the container to cover
LowerLeftCornerDiameter=8.0;
// The diameter of the lower right corner of the container to cover
LowerRightCornerDiameter=20.0;
// The diameter of the upper right corner of the container to cover
UpperRightCornerDiameter=20.0;
// The diameter of the upper left corner of the container to cover
UpperLeftCornerDiameter=20.0;
// The amount of oversizing of the resulting cover - less is tighter
Tolerance=0.2; // [0:0.05:0.5]
// How fine / coarse do you want to render the model
Resolution=40; // [12:120]

/* [Hidden] */
$fn       = Resolution;
flip      = (FlipOver!=0);

//
// Example data for a few brands
//

// Brand: Mark Brandenburg
// size      = [  87.0, 98.0 ];
// d         = [ [ 20.0, 20.0 ],
//               [  8.0, 20.0 ] ];

// Brand: milfina Hochwald Foods
// size      = [  116.0, 78.0 ];
// d         = [ [ 20.0, 20.0 ],
//               [  8.0, 20.0 ] ];

size      = [  CoverLength, CoverWidth ];
d         = [ [ UpperLeftCornerDiameter, UpperRightCornerDiameter ],
              [ LowerLeftCornerDiameter, LowerRightCornerDiameter ] ];

h         = CoverHeight;
w         = CoverThickness;
tolerance = Tolerance;


module lid_surface(oversize) {
    hull() {
        // Lower left corner
        translate([d[1][0]/2, d[1][0]/2, 0]) circle(d = d[1][0]);
        
        // Lower right corner
        translate([size[0]+oversize-(d[1][1]/2), d[1][1]/2, 0]) circle(d = d[1][1]);
        
        // Upper right corner
        translate([size[0]+oversize-(d[0][1]/2), size[1]+oversize-(d[0][1]/2), 0]) circle(d = d[0][1]);
        
        // Upper left corner
        translate([d[0][0]/2, size[1]+oversize-(d[0][0]/2), 0]) circle(d = d[0][0]);
    }
}

module curd_cover() {
    difference() {
        linear_extrude(height = h+w) lid_surface(2*w);
        translate([w, w, -0.01])
            linear_extrude(height = h) lid_surface(tolerance);
    }
}

if(flip) {
    translate([(size[0]+2*w), 0, h+w]) rotate([0, 180, 0]) curd_cover();
} else {
    curd_cover();
}
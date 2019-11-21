basesize=30; //mm
baseheight=15; //mm
cardthickness=1.4; //mm
curvedslit=0;

middlesize=basesize/3;
topsize=basesize/2;
edgeheight=basesize/15; //mm
slopeheight=baseheight-edgeheight;
slitelevation=baseheight*0.45;

module cardspace (height=10, radius=10, thickness=0.3) {
    difference () {
        cylinder(h=height, r=radius, center=true, $fn=200);
        cylinder(h=height, r=radius-thickness, center=true, $fn=200);
    }
}
    

difference () {
    rotate_extrude($fn=200) 
    polygon( points=[
                [0,0], 
                [basesize/2,0], 
                [basesize/2,edgeheight],
                [middlesize/2,baseheight*2/3],
                [topsize/2,baseheight],
                [0,baseheight]
    ] );
    if (curvedslit) {
        translate([-cardthickness+2*basesize,0,slitelevation+baseheight/2]) cardspace (height=baseheight, radius=2*basesize, thickness=cardthickness);       
    }
    else {
        translate([0,0,slitelevation+baseheight/2]) cube([cardthickness,basesize, baseheight], center=true);
    }
    
    
}
    

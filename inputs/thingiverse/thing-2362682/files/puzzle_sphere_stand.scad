// simple stand for emmett's puzzle sphere

// radius of puzzle (mm)
radius=30;
// tolerance (mm)
tol=0.5;
// percent of sphere to sink into cylinder (%)
sink = 15; // [1:50]
// distance between bottom of puzzle and bottom of model (mm)
baseHeight = 10; 

r = radius+tol;
sphereCapRadius = sqrt((2*((r*sink)/50)*r)-pow(((r*sink)/50),2));

difference() {
    translate([0,0,baseHeight/2+((r*sink)/50)/2]) {
    cylinder(baseHeight+((r*sink)/50), sphereCapRadius, sphereCapRadius, true);
    }
    translate([0,0,r+baseHeight]) {
        sphere(r,true);
    }
}

translate([0,0,r+baseHeight]) {
        //sphere(r,true);  //uncomment to show sphere
}
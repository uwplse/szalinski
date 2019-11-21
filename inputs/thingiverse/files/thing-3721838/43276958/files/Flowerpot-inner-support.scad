/* [Vase geometry] */
vaseDiameter_bot = 95;
vaseDiameter_top = 95;
vaseHeight = 100;

/* [Support dimensions] */
supportHeight = 20;
wallThickness = .8;

/* [Support parameters] */
nRadials = 6;
nInnerCircles = 1;
outerCircle = true;
holesInWalls = true;
holesHeightRatio = 0.75;
holesWidthRatio = 0.75;
maxHoleRatio = 0.75;

zScale = 1+(vaseDiameter_top-vaseDiameter_bot)/vaseDiameter_bot*supportHeight/vaseHeight;

/* [Hidden] */
$fa = 5; // increase to speed up the computation (and end up with a rougher model)

//r = vaseDiameter_bot/2;
//echo(n=($fn>0?($fn>=3?$fn:3):ceil(max(min(360/$fa,r*2*PI/$fs),5))),a_based=360/$fa,s_based=r*2*PI/$fs);


// Straight walls
for (i = [1:nRadials]) {
    difference() {
        linear_extrude(height=supportHeight, scale=[zScale, zScale])  rotate([0, 0, i*360/nRadials]) translate([0, -wallThickness/2]) square([vaseDiameter_bot/2, wallThickness]);
        for (j = [1:(nInnerCircles+1)]) {
            if (holesInWalls) {
                wHole = holesWidthRatio*vaseDiameter_bot/2/(nInnerCircles+1);
                hHole = holesHeightRatio*supportHeight;
                nHoles = (wHole/hHole > maxHoleRatio) ? ceil(wHole/hHole/maxHoleRatio) : 1;
                
                wHoleA = wHole/nHoles;
                
                for (k = [1:nHoles]) {
                    rotate([0, 0, i*360/nRadials])
                    translate([vaseDiameter_bot/2/(nInnerCircles+1)*((j-1)+(k-0.5)/nHoles), 0, supportHeight/2])
                    rotate([90, 0, 0])
                    scale([wHoleA/20, hHole/20, 1])
                    translate([0, 0, -wallThickness])
                    cylinder(h=wallThickness*2, r=10);
                }
            }
        }
    }
}


// Concentric circles
if (nInnerCircles > 0) {
    nOuterCircle = (outerCircle == true) ? 1 : 0;
    for (i = [1:nInnerCircles + nOuterCircle]) {
        difference () {
            linear_extrude(height=supportHeight, scale=[zScale, zScale]) difference() {
            circle(d=vaseDiameter_bot*i/(nInnerCircles+1)+wallThickness);
            circle(d=vaseDiameter_bot*i/(nInnerCircles+1)-wallThickness);}
            
            if (holesInWalls) {
                for (j = [1:nRadials]) {
                //for (j = [1:1]) {
                    d_loc = vaseDiameter_bot*i/(nInnerCircles+1);
                    wHole = sin(360*holesWidthRatio/nRadials/2)*d_loc;
                    hHole = holesHeightRatio*supportHeight;
                    nHoles = (wHole/hHole > maxHoleRatio) ? ceil(wHole/hHole/maxHoleRatio) : 1;
                    
                    wHoleA = sin(360*holesWidthRatio/nRadials/2/nHoles)*d_loc;
                    for (k = [1:nHoles]) {
                        translate([0, 0, supportHeight/2]) rotate([0, 0, 90 + j*360/nRadials + (k-0.5)*360/(nRadials*nHoles) ]) rotate([90, 0, 0]) scale([wHoleA/20, hHole/20, 1]) cylinder(h=vaseDiameter_bot, r=10);
                    }
                }
            }
        }
    }
}
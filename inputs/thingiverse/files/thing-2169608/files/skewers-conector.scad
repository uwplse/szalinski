// preview[view: north west, tilt: top diagonal]
//Enter the angle between the skewers
degrees=60; // [15:180]
//Measure the diameter of your skewers in mm
skewer_diameter=3; // [2:0.1:5]

/* [Hidden] */

    scale_model=skewer_diameter/3;
    wh=6*scale_model;
    l=12*scale_model; 
    deg=degrees;
    holeD=wh*0.5;
    holeL=l-2;
    plusW=wh*0.8;
    plusH=0.7;
    
render(convexity = 1){
union(){
   difference(){
            cube([wh,l,wh]);
            translate([wh/2,l+0.3,wh/2]) rotate([90,0,0]) cylinder($fn=20,holeL,d=holeD);
            translate([wh/2,l-0.5*holeL+0.3,wh/2]){
                cube([plusW,holeL,plusH],true);
                rotate([0,90,0]) cube([plusW,holeL,plusH],true);
            }
        }
    
    rotate([0,0,deg]) translate([-wh,0,0]){
        difference(){
            cube([wh,l,wh]);
            translate([wh/2,l+0.3,wh/2]) rotate([90,0,0]) cylinder($fn=20,holeL,d=holeD); 
            translate([wh/2,l-0.5*holeL+0.3,wh/2]){
                cube([plusW,holeL,plusH],true);
                rotate([0,90,0]) cube([plusW,holeL,plusH],true);
            } 
        }
    }    
}
}
linear_extrude(height = wh) polygon(
    points=[
        [wh,0],
        [0,0.2*l],
        [-0.2*l*cos(deg-90),-0.2*l*sin(deg-90)],
        [wh*cos(180-deg),-wh*sin(180-deg)]]);
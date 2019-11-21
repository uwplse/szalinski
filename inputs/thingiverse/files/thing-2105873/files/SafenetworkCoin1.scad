// coin dimensions
roundness=20;
coinHeight=3;
coinRadius=15;

// coin image
coinImage="Safenetwork.png";
imageSize=coinRadius*1.5;
imageHeight=coinHeight*1.5;

// pendant option
isPendant=true;

difference(){
    difference(){
        cylinder(h=coinHeight, r=coinRadius, center=false, $fn=roundness);
        resize([imageSize,imageSize,imageHeight])
            surface(file=coinImage, center=true, invert=false);
    }
    if(isPendant){
        translate([0,coinRadius*.875,0])
            cylinder(h=coinHeight, r=1.25, center=false, $fn=20);
    }
}
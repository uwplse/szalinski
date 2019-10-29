cableWidth=16;  // in mm
rodDelimiter=10; // in mm

// No more changes from here

outerRadius=(rodDelimiter-1+6)/2;
innerRadius=(rodDelimiter-1)/2;

difference() {
    cylinder (r=outerRadius, h=3, $fn=50); 
    cylinder (r=innerRadius, h=3, $fn=50);
    translate ([innerRadius*-0.67, innerRadius/1.35, 0]) cube ([innerRadius*1.33, outerRadius-((rodDelimiter-1)/2.7), 3]);

    
}

difference() {
    union() {
        translate ([(cableWidth-1)/-2, (outerRadius-2+7)*-1, 0]) cube ([(cableWidth+2.5), 7, 3]);
        translate ([(cableWidth-1)/-2, (outerRadius-2+3.5)*-1, 0]) cylinder (r=3.5, h=3, $fn=50);
    }
    translate ([(cableWidth/2+1)*-1, (outerRadius-2+5)*-1, 0]) cube ([(cableWidth+2), 3, 3]);
    translate ([(cableWidth/2+1), (outerRadius-2+3.5)*-1, 0]) cube ([2, 1, 3]);
}
/* [Parameters] */
parts = 3; // [3:both, 1:box_only, 2:lid_only]

width = 30;
height = 15;
depth = 27;

/* [Hidden] */
$fn = 32;

boardGap = 0.4;
boardThick = 0.8;
boardWidth = 3;
clearance = 0.3;


function getAdjustedNum(total, start, gap) = floor(total / (start + gap));
function getAdjustedDimension(total, start, gap) = (total - (floor(total / (start + gap))-1)*gap)/floor(total / (start + gap));

module crossPieces(w, h, d, both)
{
    crossW = sqrt(w*w+h*h);
    
    angle = atan(h/w);

    intersection() {
    
        if (both)
        {
            union() {
                difference() {
                    translate([w*0.5, d*0.5, h*0.5])
                    rotate([0, angle, 0])
                    cube([crossW*1.5, d+(boardThick*2), boardWidth], center=true);

                    translate([w*0.5, d*0.5, h*0.5])
                    rotate([0, -angle, 0])
                    cube([crossW*1.5, d+(boardThick*4), boardWidth+(boardGap*2)], center=true);
                }
            
            
            translate([w*0.5, d*0.5, h*0.5])
            rotate([0, -angle, 0])
            cube([crossW*1.5, d+(boardThick*2), boardWidth], center=true);
            }

        }
        else
        {
            translate([w*0.5, d*0.5, h*0.5])
            rotate([0, -angle, 0])
            cube([crossW*1.5, d+(boardThick*2), boardWidth], center=true);
            
        }
        
    
    translate([w/2,d/2,h/2])
    cube([w-(boardWidth+boardGap)*2,d+(boardThick*4),h-(boardWidth+boardGap)*0], center=true);
}
}


module sidePanels(w, h, d)
{
    numH = getAdjustedNum(h, boardWidth, boardGap);
    bH = getAdjustedDimension(h, boardWidth, boardGap);
    
    for (i=[0:numH-1])
    {
        translate([0, 0, i*(bH+boardGap)])
        cube([w, d, bH]);
    }
    
}


module corners(w,h,d)
{
    translate([0,-boardThick,-boardThick])
    cube([boardWidth, boardThick*2, h+boardThick]);

    translate([w-boardWidth,-boardThick,-boardThick])
    cube([boardWidth, boardThick*2, h+boardThick]);

    translate([0,d-boardThick,-boardThick])
    cube([boardWidth, boardThick*2, h+boardThick]);

    translate([w-boardWidth,d-boardThick,-boardThick])
    cube([boardWidth, boardThick*2, h+boardThick]);


    translate([-boardThick,0,-boardThick])
    cube([boardThick*2, boardWidth, h+boardThick]);

    translate([-boardThick,d-boardWidth,-boardThick])
    cube([boardThick*2, boardWidth, h+boardThick]);

    translate([w-boardThick,0,-boardThick])
    cube([boardThick*2, boardWidth, h+boardThick]);

    translate([w-boardThick,d-boardWidth,-boardThick])
    cube([boardThick*2, boardWidth, h+boardThick]);
}


module bottom(w, h, d)
{
    numW = getAdjustedNum(w, boardWidth, boardGap);
    bW = getAdjustedDimension(w, boardWidth, boardGap);
    
    for (i=[0:numW-1])
    {
        translate([i*(bW+boardGap),-boardThick,-boardThick*2])
        cube([bW, d+(boardThick*2), boardThick*2]);
    }
    
}


module crate(w, h, d)
{
    difference() {
        union() {
            sidePanels(w,h,d);
            
            rotate([0,0,-90])
            translate([-d,0,0])
            crossPieces(d, h, w, true);
            
            crossPieces(w, h, d, true);
            
            corners(w,h,d);
            bottom(w,h,d);

            // central part
            translate([boardGap, boardGap, 0])
            cube([w-(boardGap*2), d-(boardGap*2),h]);
        }
        
        adjust = (boardGap+boardThick) * 2;
        translate([adjust/2, adjust/2, boardThick])
        cube([w-adjust, d-adjust, h]);
    }
}


module lid(w, h, d)
{
    union() {
        numW = getAdjustedNum(w, boardWidth, boardGap);
        bW = getAdjustedDimension(w, boardWidth, boardGap);

        adjust = boardWidth + boardGap;        
        edgeClear = (boardGap+boardThick+clearance) * 2;
        
        for (i=[0:numW-1])
        {
            translate([i*(bW+boardGap),0,-boardThick])
            cube([bW, d, boardThick*1]);
        }
                
        translate([0,0,-boardGap])
        cube([w,d, boardGap]);
        
        translate([edgeClear/2, edgeClear/2, 0])
        cube([w-edgeClear,d-edgeClear, boardThick*2]);
        
        angle = atan(d/w);
        crossL = sqrt(w*w+d*d);
        
        // cross beams
        intersection() {
            union() {
                difference() {
                translate([w/2,d/2, -boardThick])
                rotate([0,0,angle])
                cube([crossL, boardWidth, boardThick*2], center=true);
                
                translate([w/2,d/2, -boardThick*(0.5)])
                rotate([0,0,-angle])
                cube([crossL, boardWidth+(boardGap*2), boardThick*4], center=true);
                }

                translate([w/2,d/2, -boardThick])
                rotate([0,0,-angle])
                cube([crossL, boardWidth, boardThick*2], center=true);
            }
            
            
            adjust = (boardWidth+boardGap)*2;
            translate([adjust/2,adjust/2,-boardThick*2.5])
            cube([w-adjust, d-adjust, boardThick*5]);
        }
        
        
        translate([0,0,-boardThick*2])
        cube([w, boardWidth, boardThick*1.1]);

        translate([0,d-boardWidth,-boardThick*2])
        cube([w, boardWidth, boardThick*1.1]);

        translate([0,adjust,-boardThick*2])
        cube([boardWidth, d-((boardWidth+boardGap)*2), boardThick*1.1]);

        translate([w-boardWidth,adjust,-boardThick*2])
        cube([boardWidth, d-((boardWidth+boardGap)*2), boardThick*1.1]);
    }
}



translate([0,0,boardThick*2])
{
    if (parts > 0) {
    
        if (parts % 2 == 1) {
                crate(width, height, depth);        
        }
        
        if (parts > 1) {
            // rotate([180,0,0])
            translate([0,-depth*1.2,0])
            lid(width, height, depth);
        }
    
    }
}
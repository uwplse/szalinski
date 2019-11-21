// preview[view:south east, tilt:top]

// - There are two types of peg board, they vary in thickness and hole size.
PegBoardType = "A"; //[A:Type A (1/8" holes),B:Type B (1/4" holes)]

// degrees - This angles the point from straight out to straight up.
BendAngle = 90; //[0:90]

// millimeters - This defines the radius of the bend from the shank (the wall) to the point.
BendRadius = 10; //[0:100]

// millimeters - Not a true gape (gap), this is the distance from the shank (the wall) to the bend in the hook.
Gape = 10; //[0:100]

// millimeters - The throat (bite) is the measure in millimeters from the lowest point in the gape(gap)to the height of the point.
Throat = 10; //[0:100]

// Circle/Sphere resolution
$fn = 40;

// millimeters - The peg board thickness, either 1/8" or 1/4"
pbt = PegBoardType == "A" ? 3.175 : 6.35;

// millimeters - The hole spacing is fixed at 1" for either type of peg board
hs = 25.4 * 1;

// millimeters - The hole diameter, either 3/16" or 1/4"
hd = ( PegBoardType == "A" ? 4.7625 : 6.35 ) - 1;

// millimeters - The hole radius, half the diameter.
hr = hd/2;


//To support pre 2016 versions of OpenSCAD 
module rotateExtrude(angle=360, convexity=12) {
    difference() {
        rotate_extrude(angle=angle, convexity=convexity)
        //rotate_extrude(convexity=convexity)
            children();
        
        if( version_num() < 20161004 ) {
            render()
                union(){
                    
            dim = max(Gape,Throat)+hd;
                   
            //NE
            if(angle < 90) {
                rotation = angle > 0 ? angle : 0;
                
                rotate([0,0,rotation])
                    translate([0,0,-dim/2])
                        cube([dim,dim,dim]);
            }
            
            //SE
            if(angle < 360) {
                rotation = angle > 270 ? angle-270 : 0;
                
                difference() {
                    rotate([0,0,rotation])
                        translate([0,-dim,-dim/2])
                            cube([dim,dim,dim]);

                    cube([dim,dim,dim]);
                }
            }
            
            //SW
            if(angle < 270) {
                rotation = angle > 180 ? angle-180 : 0;
                
                rotate([0,0,rotation])
                    translate([-dim,-dim,-dim/2])
                        cube([dim,dim,dim]);
            }
            
            //NW
            if(angle < 180) {
                rotation = angle > 90 ? angle-90 : 0;
                
                rotate([0,0,rotation])
                    translate([-dim,0,-dim/2])
                        cube([dim,dim,dim]);
            }
        }
                }
    }
}
module CircularHook(radius=2.5, angle=90, height=5, width=5, arcRadius=0) {    
    
    m = min(height,width,arcRadius);      // Arc should be no greater than the smallest
    arc = m > radius ? m-radius : m;
    
    arcX = arc * cos(0) - arc * cos(angle);
    arcY = arc * sin(angle) - arc * sin(0);    
    
    ht = height < arcX ? 0 : height-arcX; // Calculate height minus the arc
    w = width < arcY ? 0 : width-arcY;    // Calculate width minus the arc
    h = ht > radius ? ht-radius : 0;      // Compensate for the rounded tip
                                        
    
    translate([radius,width,radius*2])
        union() {
            
            if(width > 0) {
                translate([0,-w-arcY,-radius])
                    rotate([-90,0,0])
                        union() {
                            cylinder(h=w,r=radius,center=false);
                            
                            if(height <= 0)
                                translate([0,0,w])
                                    sphere(r=radius);                    
                        }
            }
                        
            if(height > 0) {
                rotate([0,90,0])
                    translate([-arc,-arcY,0])
                        rotateExtrude(angle=angle)
                            // rotate_extrude in v2015 can't handle objects touching
                            // the Y-Axis so we need to bump over the slightest bit
                            // in case arc is zero.
                            translate([radius+arc+.00001,0,0])
                                circle(r = radius);
                
                translate([0,-arcY,arc])
                    rotate([-90+angle,0,0])
                        translate([0,radius+arc,0])
                            union() {
                                cylinder(h=h,r=radius,center=false);
                                
                                translate([0,0,h])
                                    sphere(r=radius);                    
                            }
            }
        }
}

module PegBoardAnchor() {
    union() {
        // Upper pegboard anchor
        translate([pbt+hd+hr,pbt+hd,hd])
            rotate([0,90,180])
                CircularHook(hr,90,pbt+hr,pbt);
        
        // The shank of the hook
        translate([pbt+hr/2,pbt+hd,0])
            cube([hs+hd+hr,hr,hd]);

        // Lower pegboard anchor
        translate([hs+pbt+hr,pbt+hd,0])
            rotate([180,-90,0])
                CircularHook(hr,60,hr,pbt);

    }
}


module PegBoardHook(gape, throat, bendRadius, bendAngle, center=false) {
    pbaX = hs+pbt+hd+hr+hr/2;
    pbaY = pbt+hd+hr;
    
    partX = pbaX + max(pbaX,throat+hd+hr/2) - pbaX;
    partY = pbaY + gape + hd;
    
    offsetX = center ? (-partX/2 - (throat > pbaX ? pbaX-throat-hd-hr/2 : 0)) : 0;
    offsetY = center ? (-partY/2) : 0;
        
    translate([offsetX,offsetY,0])
        union() {
            PegBoardAnchor();
            
            translate([pbaX-hr/2,pbaY,0])
                rotate([0,-90,0])
                    CircularHook(hr, bendAngle, throat, gape, bendRadius);
        }
}



//render()
    PegBoardHook(Gape, Throat, BendRadius, BendAngle, true);


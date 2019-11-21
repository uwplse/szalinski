
$fn=60 * 1;

// Outer hex width 
_hexOuterWidth = 30;

// Inner hex width
_hexInnerWidth = 25;

// The hex height
_hexHeight = 3;

// The depth of the inset
_hexInnerDepth = 0.5;

// The slope of the hex sides
_hexOuterSlope = 0.9;

// Adds curves to the corners
_hexOuterAngleRadius = 0;

// The radius of the magent whole in the center (0 to disable)
_hexMagRadCenter = 1.5;

// The depth of the magnet hole (0 will cut through)
_hexMagDepth = 0;

// The radius of the magent whole(s) along the edge  (0 to disable)
_hexMagRadEdge = 1.5;

// How far are the magnets positioned from center.
_hexMagEdgeDistance = 9;

// Align the magnets with the corners or the edges
_hexMagPos = "Edge";   //[Edge,Corner]

// Put a magnet at every interval or every other (6 magnets for all, 3 for every other)
_hexMagFreq  = "EveryOther";  //[EveryOther,All]

// Hidden variables
//_hexInnerWidth = _hexOuterWidth * 0.85;   // multiplier ... 40=34, 20=17
//_hexMagEdgeDistance = (_hexInnerWidth/3);
_hexMagEdgeDistance2 = (_hexInnerWidth/2)-_hexMagRadEdge-0.1;           // distance #2 is tricky .... logic in loop
//_hexMagEdgeDistance2 = 0;


_rotHalf1 = []; _rotHalf2 = [];

_rotHalf1 = (_hexMagPos == "Edge" && _hexMagFreq=="All" ? [-120, -60, 0, 60, 120, 180]
    : (_hexMagPos == "Edge" && _hexMagFreq=="EveryOther" ? [-120, 0, 120]        
        : (_hexMagPos == "Corner" && _hexMagFreq=="EveryOther" ? [-150, 90, -30]
            : (_hexMagPos == "Corner" && _hexMagFreq=="All" ? [-150, -90, -30, 30, 90, 150]
                : [])
            )
        )    
    );
    

hexagonBase(
    _hexHeight, _hexOuterWidth, _hexOuterSlope, _hexOuterAngleRadius, 
    _hexInnerWidth, _hexInnerDepth, 
    _hexMagRadCenter, _hexMagRadEdge, _hexMagEdgeDistance, _hexMagEdgeDistance2, 
    _rotHalf1, _rotHalf2);




module hexagonBase(hexHeight, hexOuterWidth, hexOuterSlope, hexOuterAngleRadius, 
    hexInnerWidth, hexInnerDepth,
    hexMagRadCenter, hexMagRadEdge, hexMagEdgeDistance, hexMagEdgeDistance2, rotHalf1, rotHalf2) {
        
    depth = (hexOuterAngleRadius != 0 ? hexHeight - hexInnerDepth - 0.4 : hexHeight - hexInnerDepth + 0.1);
                        
    difference() 
    {
        // the part to add
        union(){
            hexagon(hexOuterWidth,hexHeight,hexOuterAngleRadius,hexOuterSlope);
            //hexagonSimple(40,4);
        }
      
        // the part to remove
        union(){
            // remove inner hex
            if(hexOuterAngleRadius != 0) {                
                //depth = hexHeight - hexInnerDepth - 0.4;    // -0.4 offset ... dunno
                if(depth <= 0) {
                    translate([0, 0, -1]) hexagonSimple(hexInnerWidth,hexHeight+3);
                } else {
                    translate([0, 0, depth]) hexagonSimple(hexInnerWidth,hexHeight);
                }
                
            } else {
                //depth = hexHeight - hexInnerDepth + 0.1;
                if(depth <= 0) {
                    translate([0, 0, -1]) hexagonSimple(hexInnerWidth,hexHeight+3);
                } else {
                    translate([0, 0, depth]) hexagonSimple(hexInnerWidth,hexHeight);
                }
            }
            
            if(depth > 0) {
                // remove center magnet hole
                if(hexMagRadCenter != 0) {
                    if(_hexMagDepth == 0) {
                        #cylinder(r=hexMagRadCenter,h=hexHeight+2,center=true);      // # will show the "ghost shape"
                    } else {
                        //translate([0, 0, _hexHeight-_hexMagDepth])
                        //    #cylinder(r=hexMagRadCenter,h=hexHeight+_hexMagDepth,center=true);      // # will show the "ghost shape"
                        translate([0, 0, _hexHeight-_hexMagDepth])
                            #cylinder(r=hexMagRadCenter,h=hexHeight,center=true);      // # will show the "ghost shape"
                    }
                }
                
                
                if(hexMagRadEdge != 0) {
                    
                    // remove edge wholes (center of edge)
                    for (r = rotHalf1) {   
                        rotate([0,0,r])
                        //translate([0, (hexInnerWidth/2)-hexMagRadEdge-0.1, 0])    // =7 if 20, =14 if 40
                        if(_hexMagDepth == 0) {
                            translate([0, hexMagEdgeDistance, 0])
                                #cylinder(r=hexMagRadEdge,h=hexHeight+2,center=true);  // # will show the "ghost shape"
                        } else {
                            translate([0, hexMagEdgeDistance, _hexHeight-_hexMagDepth])
                                #cylinder(r=hexMagRadEdge,h=hexHeight,center=true);  // # will show the "ghost shape"
                        }
                    }
                        
                    // remove edge wholes (center of edge)
                    for (r = rotHalf2) {   
                        rotate([0,0,r])
                        
                        if(_hexMagDepth == 0) {
                            //translate([0, (hexInnerWidth/2)-hexMagRadEdge-0.1, 0])    // =7 if 20, =14 if 40
                            translate([0, hexMagEdgeDistance2, 0])
                                #cylinder(r=hexMagRadEdge,h=hexHeight+2,center=true);  // # will show the "ghost shape"
                        } else {
                            translate([0, hexMagEdgeDistance2, _hexHeight-_hexMagDepth])
                                #cylinder(r=hexMagRadEdge,h=hexHeight,center=true);  // # will show the "ghost shape"
                        }
                    }                
                }
            }
        }    
    }   
}  


module hexagonSimple(size, height) {
    
    boxWidth = size/1.75;
    for (r = [-60, 0, 60]) {  
        rotate([0,0,r]) 
        //cube([boxWidth, size, height], true);
        linear_extrude(height, scale=1, center = true) square([boxWidth,size], center = true);
    }
}
module hexagon(size, height, radius, slope) {
// Hexagon with beveled corners and sloped edges
//    NOTE: Sizing issue when roundnig corners
    
    // adjust actual size based on cylinder radius used for corner bevel
    size = size - radius*2;
    
    // set boxWidth used for hex creation
    boxWidth = size/1.75;
        
    for (r = [-60, 0, 60]) {   
        rotate([0,0,r]) 
            
        if(radius != 0) {
 
            // FIX: height
            height = height-1;        // -1 offset ... not sure why (cylinder ?)

            // FIX: looses z center
            translate([0, 0, -1])     // -1 offset ... not sure why (cylinder ?)
            
            // slope edges and bevel corners
            minkowski() {    
                linear_extrude(height, scale=slope, center = true) square([boxWidth,size], center = true);
                cylinder(r=radius, true); // not sure why this creates a non-sloped bottom segment... ?
            }
        } else {
            // slope edges
            linear_extrude(height, scale=slope, center = true) square([boxWidth,size], center = true);
        }
           
    }
}
//Resolution of the curves.(Higher = more polygons and higher load time)
$fn = 30;
//What would you like the width to be?(mm)
widthOfBody     = 20;
//What would you like the height to be?(mm)
heightOfBody    = 12;
//How many slots do you want?(int)
numberOfSlots   = 5;
//How wide should the slots be?(mm)
widthOfSlots    = 8;
//How wide should the screw hole be?(mm)
widthOfScrew    = 4;
//How wide do you want the seperating walls?(mm)
widthOfWalls    = 5;

lengthOfBody    = (widthOfBody) + ( widthOfSlots * numberOfSlots ) + ( widthOfWalls * ( numberOfSlots - 1 ) );
difference(){
    union(){
        cube([widthOfBody, lengthOfBody, heightOfBody]);
        translate([ widthOfBody / 2, 0, 0]){
            cylinder( d = widthOfBody, h = heightOfBody );
            translate([ 0, lengthOfBody, 0]){
                cylinder( d = widthOfBody, h = heightOfBody );
            }
        }
    }
    union(){
        translate([ widthOfBody / 2, 0, -1 ]){
            cylinder( d = widthOfScrew, h = heightOfBody + 2 );
            translate([ 0, lengthOfBody, 0]){
                cylinder( d = widthOfScrew, h = heightOfBody + 2 );
            }
        }
        translate([ widthOfBody / 2, 0, heightOfBody - ( heightOfBody / 6 ) + 0.01]){
            cylinder( d1 = widthOfScrew, d2 = widthOfScrew * 2, h = ( heightOfBody / 6 ) );
            translate([ 0, lengthOfBody, 0]){
                cylinder( d1 = widthOfScrew, d2 = widthOfScrew * 2, h = 2 );
            }
        }
        for( i = [ 1 : numberOfSlots ] ){
            translate([-1, ( ( widthOfBody / 2 ) ) + ( ( i - 1 ) * widthOfWalls ) + ( ( i - 1) * widthOfSlots ),-1]){
                cube( [ 2 + widthOfBody, widthOfSlots, 1 + ( widthOfSlots / 2 ) ] );
                
                translate([0, widthOfSlots / 2, widthOfSlots / 2 ]){
                    rotate( a = [ 0, 90, 0 ] ){
                        cylinder( d = widthOfSlots, h = 2 + widthOfBody );
                    }
                }
            }
        }
    }
}

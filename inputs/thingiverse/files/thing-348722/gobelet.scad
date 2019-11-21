// Move the height of  the glass.
height =90; // [10:150]


// Move the first radius (bottom).
radius_bottom =27; // [5:75]

// Move the second radius (top).
radius_top =38; // [0:75]

// Move the thickness percent
thickness_percent=5; // [5:100]

thickness = radius_top*thickness_percent/100;

difference() {
cylinder ( h=height, r1=radius_bottom, r2=radius_top, $fn=100 ) ;
translate(v = [0, 0, 3])

cylinder ( h=height+thickness*1.5, r1=radius_bottom-thickness, r2=radius_top-thickness, $fn=100 ) ;
 }

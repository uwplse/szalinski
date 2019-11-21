radius = 20;
sides = 6;//[3:10]
thickness = 3;//[1:6]
sideHeight = 15;//[1:30]

linear_extrude( height = sideHeight)


shelf();

module shelf(){
    difference (){
        //corners

        circle (r=radius, $fn=sides);
{   
            circle ( r=radius-thickness, $fn=sides );
        }
    }
}




module tab(){
    difference(){
 cube([3*thickness,sideHeight,sideHeight/4]); 
      translate([thickness/2,thickness/2,0])  
 cube([2*thickness,2*radius,sideHeight]);
    }

}
translate([radius,radius,0])
tab();
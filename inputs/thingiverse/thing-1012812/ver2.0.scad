
/* variables */

//The number of Cables: 
ring_number = 2; //[2:6]

//The size of Ring:
ring_radius = 15; //[10:20]

//The height of Arranger:
height = 10; //[5:50]

//The thickness or Rings:
thickness = 5; //[3:10]


//edit
angle = 360/(ring_number*2);


module unit() {
    

        difference () {
            
            cylinder (h = height, r = ring_radius, center = true, $fn = 50);
            cylinder (h = height, r = ring_radius-thickness, center = true, $fn = 50);
            
            translate ( [ring_radius-thickness/2, 0, 0] ) {
                cube([(ring_radius+thickness)/2, (ring_radius+thickness)/2, height], center = true);
            }
        }
    }


for ( i = [0:ring_number-1] ) {
    rotate ( i*360/ring_number, [0, 0, 1] )
    translate ( [ring_radius/sin(angle)-1, 0, 0] ) 
     unit();
}

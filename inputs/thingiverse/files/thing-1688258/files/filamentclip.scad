/* [Basic] */
// size of filament, ie 2.85 or 1.75
filament_diameter = 2.85; // [3.0, 2.85, 1.75]

// You want a handle. It is really handy
handle = 1; // [1:Enabled,0:Disabled] 

/* [Advanced] */
handle_diameter = 16; // [3:30]


// Width of band
thickness = 1.6 ; // 
//Height of the print
object_height = 2; // 
// unfortunatly holes get a bit tighter than you would expect so you might have to take this into account. Negative value if you want to clip to be tighter.
expansion = 0.1; 
// Other value than 180 to make the clip asymetrical. Try 160 for instance.
rotation_2nd_ring = 180; // [100:200]

/* [Hidden] */
// preview[view:east, tilt:top]

$fn = 60;

holedia = filament_diameter + expansion;


module handle(){
    union(){
        translate([handle_diameter/2,0]){
            difference(){
                circle(d = handle_diameter);
                circle(d =handle_diameter/2);
                }
            }
//       translate([-5,0]){
//        #square([10,holedia], center = true);
//        }
    }
    
}

module ring(rotation=0){
 rotate(rotation){
      translate([(holedia+thickness)*0.5,0]){
        union(){
            difference(){
                circle(d = (holedia + thickness*2));
                union(){
                    circle(d = holedia);
                    translate([-holedia-thickness*2,0]){
                        square([holedia+thickness*2,holedia+thickness*2]);
                    }
                }
            }
            translate([-(holedia+thickness)/2,0]){
                circle(d=thickness);
            }
        }
      }
 }
}



linear_extrude(height=object_height){
    union(){
        if(handle){
            translate([(holedia+thickness/2),0]){
                handle();
            }
        }
        ring(0);
        ring(rotation_2nd_ring);
    };
}
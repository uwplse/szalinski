usb_count = 8;
thing_width = 15;


usb_length = 12.3;
usb_width = 5;
usb_height = 12.5;
usb_space = 10;

usb_offset = (thing_width-usb_width)/2; //offset and space between USB connectors

thing_length = usb_offset+(usb_count*(usb_length+usb_space))-(usb_space-usb_offset);
thing_height = 13;

echo(thing_length);

//usb_count = round((thing_length-(2*usb_offset))/(usb_length+usb_offset));
//echo(usb_count);

//rotate([180,0,0]){
    difference() {
      
        hull(){
            cube([thing_width-(usb_offset/4),thing_length,thing_height]);
            
            // Runde Ecken
            translate([usb_offset/4,usb_offset/4,0]){
                cylinder(thing_height,usb_offset/2,usb_offset/2, $fn=50);
            }
            translate([thing_width-(usb_offset/4),usb_offset/4,0]){
                cylinder(thing_height,usb_offset/2,usb_offset/2, $fn=50);
            }
            translate([usb_offset/4,thing_length-(usb_offset/4),0]){
                cylinder(thing_height,usb_offset/2,usb_offset/2, $fn=50);
            }
            translate([thing_width-(usb_offset/4),thing_length-(usb_offset/4),0]){
                cylinder(thing_height,usb_offset/2,usb_offset/2, $fn=50);
            }
        }
        for(i = [0 : usb_count-1]){
            translate([usb_offset,usb_offset+((usb_length+usb_space)*i),1.51]){
               
                difference(){
                    cube([usb_width,usb_length,usb_height]); //USB connector
                    
                    // Nubsis
                    translate([0,1.7,7.1]){
                        //cube([0.5,2,2]);
                        rotate([270,0,0]){
                            linear_extrude(2){
                                polygon([[0,0],[0,2],[0.6,1.5],[0.6,1]]);
                            }
                        }
                        
                    }
                    translate([0,usb_length-1.7-2,7.1]){
                        //cube([0.3,2,2]);
                        rotate([270,0,0]){
                            linear_extrude(2){
                                polygon([[0,0],[0,2],[0.6,1.5],[0.6,1]]);
                            }
                        }
                    }
                }
                
                // Leerraum hinter Nubsis, damit sich die Nubsis wegbiegen können.
                translate([-1.5,0,3]){
                    cube([1, usb_length, 6]);
                }

                // holes for screws
                translate([usb_width/2, usb_length/2, -1.65]){
                    cylinder(1.7,1,usb_width/2, $fn=50); 
                }
            }
        }
    }
//}
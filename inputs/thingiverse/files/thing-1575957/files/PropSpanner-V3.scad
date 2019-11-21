/*
    Customizable Two-Sided Keyring Thumb Spanner
    
    Set the 'testing' variable to 1 and then use the test_diameter variable to help you size the edge to edge diameter (upper_dia/lower_dia) to get the correct size for your spanner. Add in some tolerance for material shrinkage.
    
    Try to keep the lower_dia variable as your smaller spanner to avoid needing support. Remember to add tolerance for any shrinking you get, it can be worse closer to the heated bed.
    
    - by Harlo
    - 22/05/2016.
    
        ADDING TEXT:
    
        *   Don't forget to add in a reference to your desired font. Use variable 'font_var' to load your desired font into all the text modules automatically.
        **  Uncomment the text modules and the cutting references if you plan on adding them in.
        *** There are two text versions/options in the wrench_outer() module. Either use both the text_8mm (lower) & text_10mm (upper) modules together OR the text_any_mm(). Avoid using both.
*/

//Set to '0' for your final render
testing = 1; //[0,1]
//Edge to Edge Length
test_diameter = 8.5; //[0.1:0.1:20]
//Main Diameter Upper - set to accomodate the tube
upper_dia = 9.8; // [0.5:0.1:30]
//Main Diameter Lower - set to accomodate the tube
lower_dia = 9.8; //[0.5:0.1:30]
//Main Handle Thickness
handle_thickness = 5; //[5:0.1:20]
//Secondary Handle Thickness
handle_thickness_2 = 10; //[0:0.1:40]
//Wall thickness (around the nut)
additional_thickness = 3; //[2:0.1:15]
//Z Height
height = 14; //[3:0.1:60]
//Length of the handle
length = 35; //[25:0.1:100]




//Internal

key_ring_dia = 4*1;
key_ring_z_scale = 1*1;
key_ring_res = 60*1;



wrench_outer();

if (testing == 1){
    test_cut_cylinder();
}

/*
module text_10mm(){
    translate([0,-(upper_dia+additional_thickness)/2,height/4]){
        rotate([270,0,180]){
            text_module("8", 4.5);
        }
    }
}

module text_8mm(){
    translate([0,-(upper_dia+additional_thickness)/2,-height/4]){
        rotate([270,0,180]){
            text_module("8", 4.5);
        }
    }
}

module text_any_mm(){
    translate([0,-(upper_dia+additional_thickness)/2,0]){
        rotate([270,0,180]){
            text_module(label, label_size);
        }
    }
}

module text_module(text_in, text_size){
    scale([1,1,0.01])
    {
        linear_extrude(h = 1, center = true, convexity = 4) {
            text (text_in, size = text_size,font = font_var, halign = "center", valign = "center", $fn = 32 );
        }
    }
}

*/
          

module wrench_outer(){
    difference(){
        union(){
            cylinder(h = height ,d = upper_dia + additional_thickness*2, center = true, $fn = 6);
            handles();
            
        }
        inner_cuts();
        key_ring_cut();        
        //text_10mm(); //TOP
        //text_8mm(); //BOTTOM
        //text_any_mm(); //CENTER
    }
}



module test_cut_cylinder(){
      cylinder(h = height*2 ,d = test_diameter, center = true, $fn = 60);
}


module key_ring_cut(){
    translate([-length/2 + key_ring_dia/2.25,0,height/2 - (key_ring_dia * key_ring_z_scale)/1.25]){
        rotate([90,0,0]){
            scale([1,key_ring_z_scale,1]){
                cylinder(h = handle_thickness*2, d = key_ring_dia, center = true, $fn = key_ring_res);
            }
        }
    }
    
}


module handles(){
    hull(){
        translate([-length/2,0,0]){
            cylinder(h = height, d = handle_thickness, center = true, $fn = 60);
        }
        translate([length/2,0,0]){
            cylinder(h = height, d = handle_thickness, center = true, $fn = 60);
        }
        
        translate([0,0,2]){
            rotate([0,90,0]){    
                cylinder(h = 1, d = handle_thickness_2, center = true, $fn = 4);
            }
        }
        translate([0,0,-2]){
            rotate([0,90,0]){    
                cylinder(h = 1, d = handle_thickness_2, center = true, $fn = 4);
            }
        }
        
    }
}

module inner_cuts(){
    translate([0,0,height/2]){
        cylinder (h = height, d = upper_dia, center = true, $fn = 6);
    }
    
    translate([0,0,-height/2]){
        cylinder (h = height, d = lower_dia, center = true, $fn = 6);
    }
}
/*
* @author Timo Novak
* @date 2017-03-03
*
* This generates a loaded dice which will have a not-centered center of mass. This ist made by inserting a nut on one side.
*/


//which will more often roll on top
number=6; //[1,2,3,4,5,6]

//of the die in mm (default is 15 mm)
Edge_length=23; 
//(in mm)
wrench_size = 17; 
//(in mm)
nut_height = 8;

//(in mm) which your print setting is, needed for correct slicing of the indicator
layer_height = .25;


/* [Hidden] */


$fs = 1;
nut_tolerance = .4; //added to wrench size

dot_dia = Edge_length/5;
dot_distance = Edge_length*7/30;

//Height of the nut, fitted to number of layers necessary for it
nut_height_actual = layer_height*ceil(nut_height/layer_height);

//Starting height of the nut, fitted to layer height
start_height = layer_height*ceil((dot_dia/2+1)/layer_height);

//Top height of the nut, fitted to layer height
top_height = start_height+nut_height_actual;


print_part();

module print_part(){
	die();
}


module die(){
		difference(){
			bare_die();
			dots_rotated();
			nut();
			indicator();
		}
}

//Die without dots, corners rounded with a sphere
module bare_die(){
    translate([0,0,Edge_length/2])
	intersection(){
		cube(Edge_length, center = true);
		sphere(d = Edge_length*1.4, $fa = 5);
	}
}



module nut(){
    dia = (wrench_size+nut_tolerance)*2/sqrt(3);
    translate([0,0,start_height])
    cylinder(d = dia, h = nut_height_actual,$fn = 6 );
}

//An indicator to show when you can put in the nut. It is one layer high. When the layer with the indicator is printed, put in the nut. The next layer will cover it.
module indicator(){
	indi_len = wrench_size;
	translate([-indi_len/2,-indi_len/2,top_height-layer_height]){
	cube([indi_len,indi_len,layer_height]);
	}
}

module dots_cropped(){
	intersection(){
		dots_rotated();
		translate([0,0,Edge_length/2])
		cube(Edge_length, center = true);
	}
}

//Dots that are subtracted from the die surfaces. Rotated, so that the nut is opposite from the side which will fall on top.
module dots_rotated(){
		translate([0,0,Edge_length/2]){
		if(number ==6){
			dots();
		}else if(number == 1){
			rotate([0,180,0])
			dots();
		}else if(number == 2){
			rotate([0,90,0])
			dots();
		}else if(number == 5){
			rotate([0,-90,0])
			dots();
		}else if(number == 3){
			rotate([90,0,0])
			dots();
		}else if(number == 4){
			rotate([-90,0,0])
			dots();
		}
	}
}
module dots(){
    //1
    translate([0,0,-Edge_length/2])
        dot_center();
    //6
    translate([0,0,Edge_length/2]){
        dot_topleft();
        dot_centerleft();
        dot_bottomleft();
        dot_topright();
        dot_centerright();
        dot_bottomright();
    }
    //2
    rotate([0,-90,0])
        translate([0,0,Edge_length/2]){
            dot_topright();
            dot_bottomleft();
        }
    
    //5
    rotate([0,90,0])
        translate([0,0,Edge_length/2]){
            dot_center();
            dot_topleft();
            dot_bottomleft();
            dot_topright();
            dot_bottomright();
        }
    //3
    rotate([-90,0,0])
        translate([0,0,Edge_length/2]){
            dot_center();
            dot_topright();
            dot_bottomleft();
        }
    //4
        rotate([90,0,0])
        translate([0,0,Edge_length/2]){
            dot_topleft();
            dot_bottomleft();
            dot_topright();
            dot_bottomright();
        }
}

module dot_center(){
    scale([1,1,.5])
    sphere(d = dot_dia);
}

module dot_topleft(){
    translate([0,dot_distance,0])
    dot_centerleft();
}

module dot_centerleft(){
    translate([-dot_distance,0,0])
    dot_center();
}

module dot_bottomleft(){
    mirror([0,1,0])
    dot_topleft();
}

module dot_topright(){
    mirror([1,0,0])
    dot_topleft();
}

module dot_centerright(){
    mirror([1,0,0])
    dot_centerleft();
}

module dot_bottomright(){
    mirror([1,0,0])
    dot_bottomleft();
}

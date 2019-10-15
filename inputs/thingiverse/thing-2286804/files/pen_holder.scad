
//CUSTOMIZER VARIABLES


//	Number of cubes across the x axis
number_across = 3;              // [3:10]
//	Number of cubes across the y axis
number_deep = 3;                // [3:10]

//Set to true for a middle layer
have_middle_layer = false;      
//The text for the first pillar
theText = "Pens"; 
show_top = "no";	    //	[yes,no]
show_bottom = "yes";	//	[yes,no]
show_bl_pillar = "no";	//	[yes,no]
show_br_pillar = "no";	//	[yes,no]
show_tl_pillar = "no";	//	[yes,no]
show_tr_pillar = "no";	//	[yes,no]

//CUSTOMIZER VARIABLES END
/* [Hidden] */
cube_external_size = 19;        
wall_thickness = 1;            
pillar_height=110;
joining_pin_size = 2;           
cube_internal_size = cube_external_size - (wall_thickness*2);


if (show_top=="yes")    
    top_tray();
if (show_bottom=="yes")
    bottom_tray();

font1 = "Liberation Sans"; // here you can select other font type

//bottom left pillar
if (show_bl_pillar=="yes"){
    difference(){
        pillar(have_middle_layer);
        
        translate([13,0,20]){
            rotate([90,-90,0]){ 
                font="Liberation Sans:style=Bold Italic";
                linear_extrude(200) {
                    text(theText, font = font1, size = 7, direction = "ltr", spacing = 1 );
                }
            }
        }
    }
}

//bottom right pillar
if (show_br_pillar=="yes"){
    translate([(number_across*cube_external_size)-(number_across-1),0,0]){
        rotate([0,0,90]){
            pillar(have_middle_layer);
        }
    }
}

//top left pillar
if (show_tl_pillar=="yes"){
    translate([0,(number_deep*cube_external_size)-(number_deep-1),0]){
        rotate([0,0,-90]){
            pillar(have_middle_layer);
        }
    }
}

//top right pillar
if (show_tr_pillar=="yes"){
    translate([(number_across*cube_external_size)-(number_across-1),(number_deep*cube_external_size)-(number_deep-1),0]){
        rotate([0,0,180]){
            pillar(have_middle_layer);
        }
    }
}

//joining pin front
module joining_pin_front(){
    translate([cube_external_size/2,2,cube_external_size/2]){
        rotate([90,0,0]){
            cylinder(2,joining_pin_size-.2,joining_pin_size-.2,$fn=32);
        }
    }
}

//joining pin side
module joining_pin_side(){
    translate([0,cube_external_size/2,cube_external_size/2]){
        rotate([90,0,90]){
           cylinder(2,joining_pin_size-.2,joining_pin_size-.2,$fn=32);
        }
    }
}


//Show the object dimensions
echo("<h1>Dimensions of object</h1>");
echo("x=",cube_external_size*number_across,"mm");
echo("y=",cube_external_size*number_deep,"mm");
echo("z=",pillar_height,"mm");

module bottom_tray(){
        for (y=[0:number_deep-1])
        for (x=[0:number_across-1])
            translate([x*(cube_internal_size+1),y*(cube_internal_size+1),0])
                bottom_tray_cube(x,y);

}

module top_tray(){
        for (y=[0:number_deep-1])
            for (x=[0:number_across-1])
                translate([x*(cube_internal_size+1),y*(cube_internal_size+1),pillar_height-cube_external_size/2])
                    top_tray_cube(x,y);
        
}

module bottom_tray_cube(x,y){
    difference() {
        cube([cube_external_size,cube_external_size,cube_external_size]);

        translate([1,1,1]) {
            cube([cube_internal_size,cube_internal_size,cube_internal_size+2]);
        }
        
        if((x==0 && y==0) || (x==number_across-1 && y==number_deep-1)||((x==0)&&(y==number_deep-1))||((x==number_across-1)&&(y==0))){
            translate([cube_external_size/2,2,cube_external_size/2]) {
                rotate([90,0,0]){
                    cylinder(3,joining_pin_size,joining_pin_size,$fn=32);
                }
            }

            translate([cube_external_size/2,cube_external_size+1,cube_external_size/2]) {
                rotate([90,0,0]){
                    cylinder(3,joining_pin_size,joining_pin_size,$fn=32);
                }
            }
     
            translate([-1,cube_external_size/2,cube_external_size/2]) {
                rotate([90,0,90]){
                    cylinder(3,joining_pin_size,joining_pin_size,$fn=32);
                }
            }
            translate([cube_external_size-2,cube_external_size/2,cube_external_size/2]) {
                rotate([90,0,90]){
                    cylinder(3,joining_pin_size,joining_pin_size,$fn=32);
                }
            }
        }
    }
}

module top_tray_cube(x,y){
    difference() {
        cube([cube_external_size,cube_external_size,cube_external_size/2]);
     
        translate([1,1,-1]) {
            cube([cube_internal_size,cube_internal_size,cube_internal_size+4]);
        }
        if((x==0 && y==0) || (x==number_across-1 && y==number_deep-1)||((x==0)&&(y==number_deep-1))||((x==number_across-1)&&(y==0))){
            translate([cube_external_size/2,2,cube_external_size/4]) {
                rotate([90,0,0]){
                    cylinder(3,joining_pin_size,joining_pin_size,$fn=32);
                }
            }

            translate([cube_external_size/2,cube_external_size+1,cube_external_size/4]) {
                rotate([90,0,0]){
                    cylinder(3,joining_pin_size,joining_pin_size,$fn=32);
                }
            }
     
            translate([-1,cube_external_size/2,cube_external_size/4]) {
                rotate([90,0,90]){
                    cylinder(3,joining_pin_size,joining_pin_size,$fn=32);
                }
            }
            translate([cube_external_size-2,cube_external_size/2,cube_external_size/4]) {
                rotate([90,0,90]){
                    cylinder(3,joining_pin_size,joining_pin_size,$fn=32);
                }
            }
        }
    }
}

module pillar(middle_tray){
    union(){
        difference(){
            translate([-1,-1,0]){
                union(){
                    cube ([cube_external_size+1,2,pillar_height]);
                    cube ([2,cube_external_size+1,pillar_height]);

                }
            }
            //bottom cutout
            translate([0,0,-1]){
                cube([cube_external_size,cube_external_size,cube_external_size+1]);
            }
            
            if(middle_tray){
                //middle cutout
                translate([0,0,pillar_height/2]){
                    cube([cube_external_size,cube_external_size,cube_external_size/2+1]);
                    top_tray();
                }
            }
            
            //top cutout
            translate([0,0,pillar_height-cube_external_size/2]){
                cube([cube_external_size,cube_external_size,cube_external_size/2+1]);
            }
        }
        
        joining_pin_front();
        translate([.1,0,pillar_height-cube_external_size+5]){
            joining_pin_front();
        }
        
        joining_pin_side();
        translate([0,.1,pillar_height-cube_external_size+5]){
            joining_pin_side();
        }
        
        if (middle_tray){
            translate([0,0,(pillar_height/2)-4]){
                joining_pin_front();
                joining_pin_side();
                
            }
        }
    }
}


//How thick should the base be (in mm)?
base_thickness=2;
//How wide should the pocket be / is your HDD?
pocket_width=21;
//How long should the pocket be / is your HDD?
pocket_lenght=130;
//How thick should the wall_thickness be (in mm)?
wall_thickness=2;
//How high should the wall_thickness be (in mm)?
wall_height=15;
//How much pockets do you want?
quantity_of_racks=3;
//Do you want to add a skirt?
skirt_on = "no";// [yes,no]
skirt_width=5;//[1:20]



difference(){
    for(i=[1:quantity_of_racks]){    
        xOffset=(wall_thickness+pocket_width)*i;
        if (skirt_on=="yes"){
            translate([xOffset-skirt_width,-skirt_width,0]){
                cube([pocket_width+2*wall_thickness+2*skirt_width,pocket_lenght+2*wall_thickness+2*skirt_width,            base_thickness]);
            }
        }
        translate([xOffset,0,0]){
            difference(){

            //außen
            cube([2*wall_thickness+pocket_width,2*wall_thickness+pocket_lenght,base_thickness+  wall_height]);

            //innen
            translate([wall_thickness,wall_thickness,base_thickness]){
                cube([pocket_width,pocket_lenght,base_thickness+wall_height]);
                }
            }
        }
    }
}

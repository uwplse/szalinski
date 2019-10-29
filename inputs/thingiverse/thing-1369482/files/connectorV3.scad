
//celkovy cas: 4:07

//variables
/* [Hidden] */
//fragment number
$fn = 50;

/* [Main] */
//thickness of desks in mm
thickness_of_desks=5;
//thickness of walls in mm
thickness_of_walls = 1.2;
//length of connectors in mm
length_of_connectors = 25; 
//width of connectors 
width_of_connectors = 20;

number_of_connectors = 1; //[1:4]

secure_filament_thickness = 1.75; //[1.75,3.0]

/* [Addons] */
//Hinges or Arcs or Both - when both, arcs dont appear where hinge is
addons="none"; //[none,hinges,arcs,both]
// set on which axis you need hinges - this means the rotation of the connector in shelf
hinge_axis = "x"; //[x,y]

hinge_rotation = "up"; //[up,down]
//make sure customizer shows up all hinges(use rotation a lot, its a bit buggy)
hinges_positon="both_up";//[left_down,right_down,both_down,left_up,right_up,both_up,all]

arcs = (addons=="arcs" || addons=="both") ? true : false;

//arcs = true; //set to true if you want round shapes in the corner not recommended if building shelf with doors - using hinges, or with drawers

hinges = (addons=="hinges" || addons=="both") ? true : false;

//hinges = true; // set true if you want hinges for some door

hpos1 = ((hinges_positon=="right_up"||hinges_positon=="both_up"||hinges_positon=="all")&&(number_of_connectors==4 || (number_of_connectors==3 && hinge_axis =="y" )))? true:false; //position of hinge
hpos2 = (hinges_positon=="right_down"||hinges_positon=="both_down"||hinges_positon=="all")? true:false; //position of hinge
hpos3 = ((hinges_positon=="left_up"||hinges_positon=="both_up"||hinges_positon=="all")&&(number_of_connectors==4 || (number_of_connectors==3 && hinge_axis =="y" )))? true:false; //position of hinge
hpos4 = (hinges_positon=="left_down"||hinges_positon=="both_down"||hinges_positon=="all")? true:false; //position of hinge
rotate([-90,0,0])union(){

if(number_of_connectors==4){
  difference(){
cube([thickness_of_desks+(thickness_of_walls*2),width_of_connectors,thickness_of_desks+(thickness_of_walls*2)], center= true);
translate([0,-thickness_of_walls/2,0])cube([thickness_of_desks+2*thickness_of_walls,width_of_connectors-thickness_of_walls,thickness_of_desks+0.2], center= true);
translate([0,-thickness_of_walls/2,0])cube([thickness_of_desks+0.2,width_of_connectors-thickness_of_walls,thickness_of_desks+2*thickness_of_walls], center= true);}
}
else if(number_of_connectors==2){
difference(){
cube([thickness_of_desks+(thickness_of_walls*2),width_of_connectors,thickness_of_desks+(thickness_of_walls*2)], center= true);

translate([-(+thickness_of_walls)/2,-thickness_of_walls/2,0])cube([thickness_of_desks+thickness_of_walls+0.2,width_of_connectors-thickness_of_walls,thickness_of_desks+0.2], center= true);
translate([0,-thickness_of_walls/2,-(+thickness_of_walls)/2])cube([thickness_of_desks+0.2,width_of_connectors-thickness_of_walls,thickness_of_desks+thickness_of_walls+0.2], center= true);

}}
else if(number_of_connectors==3){
difference(){
cube([thickness_of_desks+(thickness_of_walls*2),width_of_connectors,thickness_of_desks+(thickness_of_walls*2)], center= true);
translate([0,-thickness_of_walls/2-0.5,0])cube([thickness_of_desks+0.2,width_of_connectors-thickness_of_walls+1,thickness_of_desks+2*thickness_of_walls+1], center= true);
translate([-thickness_of_desks+1,-thickness_of_walls/2-0.5,0])cube([thickness_of_desks+0.2,width_of_connectors-thickness_of_walls+1,thickness_of_desks+0.2], center= true);

}}
else if(number_of_connectors==1){
difference(){
cube([thickness_of_desks+(thickness_of_walls*2),width_of_connectors,thickness_of_desks+(thickness_of_walls*2)], center= true);
translate([0,-thickness_of_walls/2,0])cube([thickness_of_desks+0.2,width_of_connectors-thickness_of_walls,thickness_of_desks+0.2], center= true);

}}
for( i = [1 : number_of_connectors]){
   rotate([0,i*90,0])connector();
}

if(arcs==true && hinges_positon!="all" ){
    if((hpos1!=true && number_of_connectors ==4 && hinge_axis == "x")||(hpos2!=true && number_of_connectors ==4 && hinge_axis == "y") )
        rotate([0,4*90,0])arc();
    if((hpos2!=true && number_of_connectors >1&&hinge_axis == "x")||(hpos4!=true && number_of_connectors >1&&hinge_axis == "y"))
        rotate([0,1*90,0])arc();
    if((hpos3!=true && number_of_connectors>3&&hinge_axis == "x")||(hpos1!=true && number_of_connectors>3&&hinge_axis == "y"))
        rotate([0,3*90,0])arc();
    if((hpos4!=true && number_of_connectors>2&&hinge_axis == "x")||(hpos3 !=true && number_of_connectors>2 && hinge_axis == "y"))
        rotate([0,2*90,0])arc();
}
if(hinges==true){
rot=hinge_axis=="x"? 90:0;
hrot = hinge_rotation=="up"?0:(-length_of_connectors/4);
if(hpos1==true){
    translate([0,0,0
    ])rotate([0,rot,0])hinges(hrot);
}
if(hpos2==true){
    rotate([0,rot,0])translate([0,0,-thickness_of_desks/2-thickness_of_walls-length_of_connectors+length_of_connectors/4-length_of_connectors-thickness_of_desks/2-thickness_of_walls
    ])hinges(hrot);
}
if(hpos3==true){
    translate([0,-thickness_of_desks+width_of_connectors,0])rotate([0,-rot,180])hinges(hrot);
}
if(hpos4==true){
    rotate([0,-rot,180])translate([0,thickness_of_desks-width_of_connectors,-thickness_of_desks/2-thickness_of_walls-length_of_connectors+length_of_connectors/4-length_of_connectors-thickness_of_desks/2-thickness_of_walls])hinges(hrot);
}
}
}
module connector(){
    translate([(thickness_of_desks+(thickness_of_walls*2))/2,-width_of_connectors/2,-(thickness_of_desks+(thickness_of_walls*2))/2])difference(){
cube([length_of_connectors,width_of_connectors,thickness_of_desks+(thickness_of_walls*2)]);
translate([-0.5,-thickness_of_walls,thickness_of_walls-0.1])cube([length_of_connectors+0.5+1,width_of_connectors,thickness_of_desks+0.2]);
translate([length_of_connectors/2,width_of_connectors/2,-1])cylinder(h=thickness_of_desks+(thickness_of_walls*2+2), d=secure_filament_thickness );
}
}

module arc(){
translate([(0.1+(length_of_connectors/2)-secure_filament_thickness)+thickness_of_desks/2,width_of_connectors/2,-((0.1+(length_of_connectors/2)-secure_filament_thickness)+thickness_of_desks/2)])rotate([90,270,0])difference(){
intersection(){
union(){
cylinder(h=width_of_connectors, r = (length_of_connectors/2)-secure_filament_thickness);
cube([(length_of_connectors/2)-secure_filament_thickness,(length_of_connectors/2)-secure_filament_thickness,thickness_of_walls]);  
}
cube([(length_of_connectors/2)-secure_filament_thickness,(length_of_connectors/2)-secure_filament_thickness,width_of_connectors]);
}
translate([0,0,-1])cylinder(h=width_of_connectors+2, r = (length_of_connectors/2)-(secure_filament_thickness+thickness_of_walls-0.1));
}
}
module hinges(rotation){
translate([thickness_of_desks/2+thickness_of_walls,width_of_connectors/2-thickness_of_desks,thickness_of_desks/2+thickness_of_walls+length_of_connectors-length_of_connectors/4
    ])
union(){
    
translate([thickness_of_desks/2+thickness_of_walls,(thickness_of_desks-0.05)/2,rotation])
        cylinder(h=length_of_connectors/2, d=thickness_of_desks-0.05);
    
translate([0,0,0])cube([thickness_of_desks/2+thickness_of_walls,thickness_of_desks,length_of_connectors/4]);
}    

}

// preview[view:south west, tilt:top]
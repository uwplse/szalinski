// PROTECTIVE CORNER FOR TABLE
//////////////////////////////
//This part is meant to be placed on the corner of a table in order to avoid people from bumping into it and getting hurt
//Designed by David LE GALL on 13/04/2016 and published under the CC-BY-NC liscence
//////////////////////////////

///////////////////
//USER PARAMETERS//
///////////////////
Table_thickness=15;//Thickness of the table to protect
Part_edge_length=45;//Length of the part along the edge of the table
Part_thickness=4;//Thicknes of the part
Quality=25;//Quality of the model
Design_1_or_2=2;//First design "sticks" a little more to the shape of the table wereas second design is more rounded


//////////////////////////////////////////////
rotate([0,-90,0])rotate([0,0,45])difference(){
if ( Design_1_or_2 == 1)
{
    hull(){
        translate([Part_edge_length/2,Part_edge_length/2,Table_thickness/2])sphere(Part_thickness,$fn=Quality);
        translate([Part_edge_length/2,Part_edge_length/2,-Table_thickness/2])sphere(Part_thickness,$fn=Quality);
        translate([Part_edge_length/2,-Part_edge_length/2,Table_thickness/2])sphere(Part_thickness,$fn=Quality);
        translate([Part_edge_length/2,-Part_edge_length/2,-Table_thickness/2])sphere(Part_thickness,$fn=Quality);
        translate([-Part_edge_length/2,-Part_edge_length/2,Table_thickness/2])sphere(Part_thickness,$fn=Quality);
        translate([-Part_edge_length/2,-Part_edge_length/2,-Table_thickness/2])sphere(Part_thickness,$fn=Quality);
    }
}
if ( Design_1_or_2 == 2)
      hull(){
        translate([Part_edge_length/2,Part_edge_length/2,0])sphere(Part_thickness+Table_thickness/2,$fn=Quality);        
        translate([Part_edge_length/2,-Part_edge_length/2,0])sphere(Part_thickness+Table_thickness/2,$fn=Quality);        
        translate([-Part_edge_length/2,-Part_edge_length/2,0])sphere(Part_thickness+Table_thickness/2,$fn=Quality);
    }

union(){
cube([Part_edge_length,Part_edge_length,Table_thickness],true);
rotate([0,0,45])translate([0,2*(Part_edge_length+Part_thickness),0])cube([4*(Part_edge_length+Part_thickness),4*(Part_edge_length+Part_thickness),4*(Part_edge_length+Part_thickness)],true);
}
}

$fn=30;
board_x = 100.5;
board_y = 70.5;
board_z = 1.5;

flat_lip_size = 10;

screw_dia = 2.5;

edge_thickness = 15;

item_height = 4;

combi_x = board_x + edge_thickness+(flat_lip_size*2);
combi_y = board_y + edge_thickness+(flat_lip_size*2);
field_thickness = 2;


module exterior()
{
    difference()
    {
    translate([-edge_thickness/2,-edge_thickness/2,0]) cube([board_x+edge_thickness,board_y+edge_thickness,item_height]);
        
    translate([-edge_thickness/4, -edge_thickness/4,item_height-(item_height/2)]) cylinder(r=screw_dia/2, h=item_height/2);
        
    translate([-edge_thickness/4, ((-edge_thickness/4)+board_y+edge_thickness/2),item_height-(item_height/2)]) cylinder(r=screw_dia/2, h=item_height/2);
        
    translate([
        (-edge_thickness/4)+board_x+edge_thickness/2,
        ((-edge_thickness/4)+board_y+edge_thickness/2),
        (item_height-(item_height/2))
        ]) 
            cylinder(r=screw_dia/2, h=item_height/2);
    translate([
        ((-edge_thickness/4)+board_x+edge_thickness/2),
        ((-edge_thickness/4)),
        (item_height-(item_height/2))
        ])
         
            cylinder(r=screw_dia/2, h=item_height/2);

    }

}

module pcb()
{
    color([1,0,0]) translate([0,0,item_height-board_z]) cube([board_x, board_y, board_z]);
}

module field()
{
    cube([combi_x,combi_y,field_thickness]);
}


module holder()
{
    union() {
    difference() {
        exterior();
        pcb();
    }
    translate([-combi_x/8,-combi_x/8])field();
}
}

module plus_fingerhole() {
    difference()
    {
        holder();
        translate([combi_x/4,combi_x/4,0])cylinder(r=10, h=10);
    }
}
plus_fingerhole();



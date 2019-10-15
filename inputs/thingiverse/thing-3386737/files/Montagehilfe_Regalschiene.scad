//Montage Hilfe Regalschiene
//20190128 P. de Graaff

//slot in mm
slot=3;
//gap in mm
gap=0.2;
//shelf board thickness in mm
shelf_board_thickness=16;

rotate([0,180,0])difference(){
    cube([25,25,2*shelf_board_thickness],center=true);
    translate([-(slot/2+gap),-15,0])cube([slot+gap,30,shelf_board_thickness+1]);
}
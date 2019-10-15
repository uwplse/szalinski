
//celkovy cas - 3:11

//variablength_of_connectors
/* [Hidden] */
//fragment number
$fn = 100;

/* [Main] */
//thickness of desks in mm
thickness_of_desks=5;
//thickness of walls in mm
thickness_of_walls = 1.2;
//length of connectors in mm
length_of_connectors = 25; 
//width of connectors in mm 
width_of_connectors = 20;

secure_filament_thickness = 1.75; //[1.75,3.0]

connector();

translate([thickness_of_desks/2+thickness_of_walls+length_of_connectors/2,thickness_of_desks/2+thickness_of_walls+width_of_connectors/2,0])rotate([-90,0,90])difference(){
union(){
cylinder(h=length_of_connectors/2, d=thickness_of_walls+thickness_of_walls+thickness_of_desks);
translate([-(thickness_of_desks+thickness_of_walls+thickness_of_walls)/2,-(thickness_of_desks+thickness_of_walls+thickness_of_walls)/2,0])cube([thickness_of_walls+thickness_of_desks/2,thickness_of_desks+thickness_of_walls+thickness_of_walls,length_of_connectors/2]);
}    cylinder(h=length_of_connectors/2, d=thickness_of_desks+3*thickness_of_walls/4);
}

module connector(){
    translate([(thickness_of_desks+(thickness_of_walls*2))/2,-width_of_connectors/2,-(thickness_of_desks+(thickness_of_walls*2))/2])difference(){
cube([length_of_connectors,width_of_connectors,thickness_of_desks+(thickness_of_walls*2)]);
translate([0,-thickness_of_walls,thickness_of_walls-0.1])cube([length_of_connectors,width_of_connectors,thickness_of_desks+0.2]);
translate([length_of_connectors/2,width_of_connectors/2,0])cylinder(h=thickness_of_desks+(thickness_of_walls*2), d=secure_filament_thickness );
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
cylinder(h=width_of_connectors, r = (length_of_connectors/2)-(secure_filament_thickness+thickness_of_walls-0.1));
}
}
module hinges(){
translate([3+thickness_of_desks/2+0.1,0,length_of_connectors-7.5+secure_filament_thickness/2])difference(){
union(){
cylinder(h=5, d=5);
translate([-3,-2.5,0])cube([3,5,5]);
}    cylinder(h=5, d=3);
}

}


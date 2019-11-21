screw_holes = 3;//[2:20]
tool_handle_thickness=11;//[5:100]
tool_handle_inside_gape=10;//[3:50]
thickness=3;//[2:10]
/* [Hidden] */
$fn=40; 


rotate([90,45,0]){
difference() {
union() {
hull(){
translate([0,0,0])cylinder(h=thickness,r=screw_holes);
translate([(tool_handle_thickness*2)+(screw_holes*1.5)+tool_handle_inside_gape,0,0])cylinder(h=thickness,r=screw_holes);
translate([((tool_handle_thickness*2)+(screw_holes*1.5)+tool_handle_inside_gape)/2,-((tool_handle_thickness*2)+(screw_holes*1.5)+tool_handle_inside_gape)/2,0])cylinder(h=thickness,r=screw_holes);
}


hull(){
translate([((tool_handle_thickness*2)+(screw_holes*1.5)+tool_handle_inside_gape)/2,-((tool_handle_thickness*2)+(screw_holes*1.5)+tool_handle_inside_gape)/2,thickness])cylinder(h=tool_handle_thickness,r=screw_holes);

translate([((tool_handle_thickness*2)+(screw_holes*1.5)+tool_handle_inside_gape)/2-tool_handle_inside_gape/2,-((tool_handle_thickness*2)+(screw_holes*1.5)+tool_handle_inside_gape)/2+tool_handle_inside_gape/2,thickness])cylinder(h=tool_handle_thickness,r=screw_holes);

translate([((tool_handle_thickness*2)+(screw_holes*1.5)+tool_handle_inside_gape)/2+tool_handle_inside_gape/2,-((tool_handle_thickness*2)+(screw_holes*1.5)+tool_handle_inside_gape)/2+tool_handle_inside_gape/2,thickness])cylinder(h=tool_handle_thickness,r=screw_holes);

translate([((tool_handle_thickness*2)+(screw_holes*1.5)+tool_handle_inside_gape)/2,-((tool_handle_thickness*2)+(screw_holes*1.5)+tool_handle_inside_gape)/2+tool_handle_inside_gape,thickness])cylinder(h=tool_handle_thickness,r=screw_holes);

}

hull(){
translate([screw_holes*2,-screw_holes*2,tool_handle_thickness+thickness])cylinder(h=thickness,r=screw_holes);
translate([(tool_handle_thickness*2)+(screw_holes*1.5)+tool_handle_inside_gape-screw_holes*2,-screw_holes*2,tool_handle_thickness+thickness])cylinder(h=thickness,r=screw_holes);
translate([((tool_handle_thickness*2)+(screw_holes*1.5)+tool_handle_inside_gape)/2,-((tool_handle_thickness*2)+(screw_holes*1.5)+tool_handle_inside_gape)/2,tool_handle_thickness+thickness])cylinder(h=thickness,r=screw_holes);
}
}
translate([1,-.8,-1])cylinder(h=thickness+2,r1=screw_holes/2,r2=screw_holes);
translate([(tool_handle_thickness*2)+(screw_holes*1.5)+tool_handle_inside_gape-1,-.8,-1])cylinder(h=thickness+2,r1=screw_holes/2,r2=screw_holes);
}
}


hook_level=3;//[1:6]
plane_hight=0.8;
hook_width_x=7;
hook_width_y=2;
hOsn=plane_hight*1;
dL=hook_width_y*1;
rotate([0,90,0])
difference(){
union(){
translate([0,4.5/2-dL/2,8+hOsn-dL/2])
cube([hook_width_x,4.5,dL], center=true);
translate([0,0,4+hOsn])
cube([hook_width_x,dL,8], center=true);
translate([0,0,hOsn/2])    
cube([hook_width_x,11*1.5,hOsn], center=true);
}
//уголок немного спиливаем
translate([0,dL/2+((4.5-dL)/1.5)/2,8+hOsn-dL])
scale([1,1,hook_level/10])
rotate([90,0,90])
cylinder(r=(4.5-dL)/1.5,h=hook_width_x+0.2,$fn=3, center=true);
}

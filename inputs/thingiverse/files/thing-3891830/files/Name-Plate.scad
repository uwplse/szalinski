//change dimesions to fit name
//x-width of plate
x=160;
//y-width of plate
y=50;
//height of the plate
z=2.5;
//height of the text
h=2;
module plate(){
    cube([x,y,z],center=true);
}
//plate();
//moves plate up to rest at z=0
translate([0,0,z/2])plate();
//in the Your name here put your name
//you can change size of font with size
module name(){
translate([0,0,z])linear_extrude(height=h)text("Your Name Here",size=15,style=Bold,halign="center");
}
name();
union(){
    name();
    plate();
}
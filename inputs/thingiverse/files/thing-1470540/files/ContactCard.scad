Name = "J. Howlett";
Phone = "(555) 555 5555";
eMail = "checkout@3E8.us";

union(){
linear_extrude(height=.6)translate([0,0,10])square([89,50]);
linear_extrude(height=.9){
translate([45,33])text(Name,halign="center",size=5);
translate([45,23])text(Phone,halign="center",size=5);
translate([45,13])text(eMail,halign="center",size=5);
}
}
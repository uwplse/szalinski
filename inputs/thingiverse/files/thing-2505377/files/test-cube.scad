s= 50;
fs = s/3;
fsn = s/5;
f = "Arial";


difference(){
cube(s);
union(){

translate([s/2-4,1,s-1.5])linear_extrude(height = 3)text(text = "x", size = fs, font = "Arial");
translate([1,s/2,s-1.5])linear_extrude(height = 3)text(text = "y", size = fs, font = "Arial");
translate([1,1.5,s/2-4])rotate([90,0,0])linear_extrude(height = 3)text(text = "z", size = fs, font = "Arial");
    
    
  
translate([s/2-4,s-fsn-1,s-1.5])linear_extrude(height = 3)text(text = str(s/10), size = fsn, font = "Arial");
translate([s-fsn*2,s/2,s-1.5])linear_extrude(height = 3)text(text = str(s/10), size = fsn, font = "Arial");
translate([s-fsn*2,1.5,s/2-4])rotate([90,0,0])linear_extrude(height = 3)text(text = str(s/10), size = fsn, font = "Arial");

}
}
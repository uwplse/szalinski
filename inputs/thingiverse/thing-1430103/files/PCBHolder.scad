
part = "sleeve"; // [holder:Holder,sleeve:Sleeve]

width = 100; //[10:0.1:250]
length = 70; //[10:0.1:250]
height = 1.5; //[0.1:0.1:5]
inset = 0.5; //[0.1:0.1:5]
border = 5; //[1:0.5:10]
base = 5; //[1:0.1:10]
sleeve = 5; //[1:0.1:10]

if (part == "holder") {
 translate([0, 0, (base) / 2])
  difference(){
   cube([width + (border * 2), length + (border * 2), base],  true);
   translate([0, 0, (base - inset + 0.001) / 2])
    cube([width, length, inset + 0.001], true);
  }
} else if (part == "sleeve") {
 //rotate([0, 180, 0])
 difference(){
  translate([0,0,(base + (height - inset)) / 2])
   cube(
    [width + (border * 2) + (sleeve * 2),
     length + (border * 2) + (sleeve * 2),
     base + height - inset], true);
   translate([0, 0, (base - 0.001) / 2])
    cube([width + (border * 2), length + (border * 2), base],  true);
   translate([0, 0, (base + height + inset + 0.001) / 2])  
    cube([width, length,  base + height + inset + 0.001], true);
 }
}
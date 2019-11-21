Height=50; //
X=40; //
Y=40; //
Borediameter=5;
Nutdiameter=3;
Nutscrewdiameter=5.5;
difference() {
        
    cube([60,60,Height+3],center=true);
    translate([0,0,-3])
    cube([X,Y,Height+3],center=true);
    translate([0,0,0])
    cylinder(h=(Height+3)/2,r1=Borediameter/2,r2=Borediameter/2,$fn=100);
    translate([(((60-X)/4)+(X/2)),(((60-Y)/4)+(Y/2)),-((Height+3)/2)])
    cylinder(h=Height+3,r1=Nutdiameter/2,r2=Nutdiameter/2,$fn=100);
    translate([-(((60-X)/4)+(X/2)),(((60-Y)/4)+(Y/2)),-((Height+3)/2)])
    cylinder(h=Height+3,r1=Nutdiameter/2,r2=Nutdiameter/2,$fn=100);
    translate([(((60-X)/4)+(X/2)),-(((60-Y)/4)+(Y/2)),-((Height+3)/2)])
    cylinder(h=Height+3,r1=Nutdiameter/2,r2=Nutdiameter/2,$fn=100);
    translate([-(((60-X)/4)+(X/2)),-(((60-Y)/4)+(Y/2)),-((Height+3)/2)])
    cylinder(h=Height+3,r1=Nutdiameter/2,r2=Nutdiameter/2,$fn=100);
    
    
    translate([(((60-X)/4)+(X/2)),(((60-Y)/4)+(Y/2)),-((Height+3)/2)+10])
    cylinder(h=Height+3,r1=Nutscrewdiameter/2,r2=Nutscrewdiameter/2,$fn=100);
    translate([-(((60-X)/4)+(X/2)),(((60-Y)/4)+(Y/2)),-((Height+3)/2)+10])
    cylinder(h=Height+3,r1=Nutscrewdiameter/2,r2=Nutscrewdiameter/2,$fn=100);
    translate([(((60-X)/4)+(X/2)),-(((60-Y)/4)+(Y/2)),-((Height+3)/2)+10])
    cylinder(h=Height+3,r1=Nutscrewdiameter/2,r2=Nutscrewdiameter/2,$fn=100);
    translate([-(((60-X)/4)+(X/2)),-(((60-Y)/4)+(Y/2)),-((Height+3)/2)+10])
    cylinder(h=Height+3,r1=Nutscrewdiameter/2,r2=Nutscrewdiameter/2,$fn=100);
    
    translate([-8.4,25,-((Height+3)/2)])
scale([1,1,0.56547])
    cube(16.8);
}

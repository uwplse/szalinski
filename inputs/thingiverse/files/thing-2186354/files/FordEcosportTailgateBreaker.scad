$fn=100+0;

// Choose which part to generate
Mode = "Part1"; // [Part1,Part2,Part3]

// Mid way angle - affect Part 1
MidAngle = 7; // [0:0.5:8]

// Nut & bolt hole radius - affect all parts
BoltRadius = 2; // [1:0.1:3]

// Bolt cap radius - affect Part 1
BoltCapRadius = 3.5; // [3:0.1:5]

// Nut hexagon maximal radius - affect Part 3
NutMaxRadius = 3.95; // [3:0.05:6]

if (Mode == "Part1") {
    part1();
} else {
    if (Mode == "Part2") {
        part2();
    } else {
        part3();    
        }
    }

module part2()
{
    difference(){
        translate([-8,-20,0])cube([15+7,40,20]);
        translate([50+(15+6.5-8.2),0,0])rotate(2,[0,0,1])cube(100,center=true);
        translate([0,0,-1])cylinder(h=30,r=5.5);
        translate([-26,-5.5,-1])cube([26,11,30]);
        translate([-50,-12,10])rotate(90,[0,1,0])cylinder(h=100,r=BoltRadius+0.1);
        translate([-50,+12,10])rotate(90,[0,1,0])cylinder(h=100,r=BoltRadius+0.1);
    }
}


module part1(alpha = MidAngle)
{
    
difference(){
    
union()
    {
difference(){
cylinder(h=30,r=28.5);
rotate(90,[0,0,1])translate([0,0,-1])cube(500);
rotate(179,[0,0,1])translate([0,0,-1])cube(500);
rotate(220,[0,0,1])translate([0,0,-1])cube(500);
}

difference(){
translate([-1,-20,0])cube([17,40,30]);
translate([0,0,-1])cylinder(h=32,r=5);
translate([-26,-5,-1])cube([26,10,32]);}

translate([13,-20,0])cube([8,40,30]);

rotate(alpha,[0,0,1])translate([24.5,0,0])cylinder(h=30,r=6);

}

  translate([-50,-12,15])rotate(90,[0,1,0])cylinder(h=100,r=BoltRadius+0.1);
  translate([19.8,-12,15])rotate(90,[0,1,0])cylinder(h=100,r=BoltCapRadius+0.5);
  translate([-50,+12,15])rotate(90,[0,1,0])cylinder(h=100,r=BoltRadius+0.1);
  translate([19.8,+12,15])rotate(90,[0,1,0])cylinder(h=100,r=BoltCapRadius+0.5);

  translate([0,-270,0])cube(500,center=true);
  translate([0,+270,0])cube(500,center=true);
  translate([-250+13,0,0])cube(500,center=true);

  move = 2.1;
  rotate(alpha,[0,0,1]){
      for(i = [(20+move): 2 : (26+move)]){
          translate([i,6,15])rotate(4,[0,0,1])cube([1,4,32],center=true);
          translate([i,-6,15])rotate(-4,[0,0,1])cube([1,4,32],center=true);
      }
          translate([19.+move,-5,-1])cube([1.5,10,32]);
      translate([30.8,0,-1])cylinder(h=32,r=1.4);
  }
}
}

module part3()
{
    rotate(-90,[0,1,0])
    difference()
    {
        union()
        {
    translate([-20,-25,0])cube([12,50,20]);
    translate([-20,-25,-5])cube([7,50,30]);
    translate([-19,-10/2,0])cube([12,10,20]);
    translate([-19,-4.9/2+22.55,0])cube([12,4.9,20]);            
    translate([-19,-4.9/2-22.55,0])cube([12,4.9,20]);            
        }

translate([0,0,-1])cylinder(h=30,r=5);        

        translate([-50,-12,10])rotate(90,[0,1,0])cylinder(h=100,r=BoltRadius+0.1);
        translate([-17.5,-12,10])rotate(0,[1,0,0])cube([6,NutMaxRadius+0.05,(NutMaxRadius+0.05)*1.73],center=true);
        translate([-17.5,-12,10])rotate(60,[1,0,0])cube([6,NutMaxRadius+0.05,(NutMaxRadius+0.05)*1.73],center=true);
        translate([-17.5,-12,10])rotate(120,[1,0,0])cube([6,NutMaxRadius+0.05,(NutMaxRadius+0.05)*1.73],center=true);
        translate([-50,+12,10])rotate(90,[0,1,0])cylinder(h=100,r=BoltRadius+0.1);
        translate([-17.5,+12,10])rotate(0,[1,0,0])cube([6,NutMaxRadius+0.05,(NutMaxRadius+0.05)*1.73],center=true);
        translate([-17.5,+12,10])rotate(60,[1,0,0])cube([6,NutMaxRadius+0.05,(NutMaxRadius+0.05)*1.73],center=true);
        translate([-17.5,+12,10])rotate(120,[1,0,0])cube([6,NutMaxRadius+0.05,(NutMaxRadius+0.05)*1.73],center=true);
    }
}

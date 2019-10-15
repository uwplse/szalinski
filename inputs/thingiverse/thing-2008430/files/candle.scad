candleOD = 150;
WallThick = 8;
Height = 200;
fine = 10; // $fn, doesnt matter too much here
step = 2;  // how many degrees in iteration
wavyheight=11; // how much variation in height for the top surface
wavyness=2; // probably just keep this at 2
basethick=1; //how thick the base will be

// end of variables


pi = 3.1416; 
R = ((candleOD/2)-(WallThick));
$fn=fine;


for (theta=[0:step:360]){
    translate([R*cos(theta),R*sin(theta),0])
    union(){
        cylinder(Height + wavyheight*(cos(theta)+sin(wavyness*theta)),WallThick,WallThick);
        translate([0,0,Height + wavyheight*(cos(theta)+sin(wavyness*theta))])
        sphere(WallThick);
}
cylinder(r=candleOD/2, h=basethick);
}
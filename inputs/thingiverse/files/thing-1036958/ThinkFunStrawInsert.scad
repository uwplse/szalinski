//StrawInsert for ThinkFun
//Default values are for IKEA Sommarfint straws

// variable description
StrawD=7.9; 
StrawInsert=20;
WheelD=7.5;
WheelInsert=20;

linear_extrude(height=StrawInsert)
    circle (r=StrawD/2, $fn=200);
    
translate ([0,0,StrawInsert])
linear_extrude (height=2)
    circle (r=(StrawD/2)+1, $fn=200);

translate ([0,0,StrawInsert+2])
linear_extrude(height=WheelInsert)
    circle (r=WheelD/2, $fn=200);




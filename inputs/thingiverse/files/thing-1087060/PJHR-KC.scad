//Halloween Project I
//Kevin Chen
//H.Robotics I
//Oct. 11th
//This is a blackcat of Halloween style, 
//Black does not have very good looking (actually white is the best). In order to make it have a better looking, I used slate gray.
////////////////////////////////////

//parts
parts_to_render = 1; // [1:Ear, 2:Head, 3:Body, 4:Front_Leg, 5:Tail, 6:preview_part, 7:Assembled]

//Tails
tail_to_choose = 1; //[1:Regular, 2:Straight]

//Ears
ears_to_choose = 1; //[1:Round, 2:Sphere]

// Draft for preview, production for final
Render_Quality = 40;    // [10:Fastest(maybe cooler than others), 40:Fast, 60:Precise, 100:Highest_Definition]

$fn = Render_Quality;

module R(){
    union(){
    color("black")
    translate([-9,4,72])
    {
        difference()
        {
            rotate([90,-20,0])
            resize(newsize=[20,50,20])
            sphere(10);

        }
    }
    }
}

module L(){
    union(){
    color("black")
    translate([9,4,72])
    {
        difference()
        {
            rotate([90,20,0])
            resize(newsize=[20,50,20])
            sphere(10);

        }
    }
}
}

module R2(){
    union(){
        color("black")
    translate([-10,4,90])
    {
            rotate([90,-20,0])
            sphere(10);

        }
    }
    }


module L2(){
    union(){
    color("black")
    translate([10,4,90])
    {
        difference()
        {
            rotate([90,-20,0])
            sphere(10);

        }
    }
}
}

module Head(){
    union(){
    color("gray")
    translate([0,4,0])
    {
    difference()
    {
        translate([0,0,70])
        {
            sphere(20)
            sphere(18);
        }
        
    }
    translate([0,-18,70])
    {
        resize([5,5,5])
        sphere(10);
    }
    translate([8,-14,78])
    {
        resize([5,5,5])
        sphere(10);
    }
    translate([-8,-14,78])
    {
        resize([5,5,5])
        sphere(10);
    }
}
}
}

module Body(){
    union(){
    color("grey")
    translate([0,0,55])
    {
        resize([20,10,10])
        sphere(15);
        
        translate([0,8,0])
        {
            sphere(17);
        }
        hull()
        {
            translate([0,15,-10])
            {
                sphere(18);
            }
            translate([0,20,-20])
            {
                sphere(19);
            }
            translate([0,30,-12])
            {
                sphere(10);
            }
            translate([0,40,-30])
            {
                resize([20,20,40])
                sphere(12);
            }
            translate([0,45,-40])
            {
                sphere(12);
            }
            translate([0,45,-45])
            {
                sphere(10);
               
            }
        }
    }
}
}
module Back_Leg(){
    
    union(){
    //left
    color("darkgray")
    translate([5,30,25])
    {
        resize([35,0,40])
        sphere(15);
    }
        color("black")
        translate([20,10,7])
        {
            rotate([-90,0,30])
            cylinder(r=7,h=40);
        }
        color("black")
        translate([-5,30,25])
        {
            sphere(10);
        } 
        color("gray")
        translate([20,10,8])
        {
        sphere(8);   
        }
    //right
    color("darkgray")
    translate([-5,30,25])
    {
        resize([35,0,40])
        sphere(15);
    }
        color("black")
        translate([-20,10,7])
        {
            rotate([-90,0,-30])
            cylinder(r=7,h=40);
        }
        color("black")
        translate([-5,30,25])
        {
            sphere(10);
        }
        color("gray")
        translate([-20,10,8])
        {
        sphere(8);   
        }
}
}
module Front_Leg(){
    
    union(){
    //left
    color("black")
    translate([4,-4,3])
    {
        rotate([-18,10,0])
        cylinder(r=5,r2=4,h=50);
    }
    color("darkgray")
    translate([5.5,-4,6]) 
    {
       sphere(6.5);
   }       

    //right
    color("black")
    translate([-4,-4,3])
    {
        rotate([-18,-10,0])
        cylinder(r=5,r2=4,h=50);
    }
    color("darkgray")
    translate([-5.5,-4,6]) 
    {
        sphere(6.5);
    }
}
}
module Tail(){
    union(){
    color("black")
    translate([0,-3,0])
    {
            rotate([0,0,0])
            for(i = [ [ 0,  54,  10],
            [0, 56, 12],
            [0, 58, 14],
            [0, 60, 16],
            [0, 62, 18],
            [0, 64, 20],
            [0, 66, 22],
            [0, 68, 24],
            [0, 66, 26],
            [0, 64, 28],
            [0, 62, 30],
            [0, 60, 32],
            [0, 62, 34],
            [0, 64, 36],
            [0, 66, 38],
            [0, 68, 40],
            [0, 66, 42],
            [0, 64, 44],
            [0, 62, 46],
            [0, 60, 48],
            [0, 62, 50],
            [0, 64, 52],
            [0, 66, 54],
            [0, 68, 56],
            [0, 70, 58] ])
            {
                translate(i)
                resize([12,12,12])
                sphere(100, center = true);
            }
        
    }
}
}
module Tail2(){
    union(){
    color("black")
    translate([0,-3,0])
    {
            rotate([0,0,0])
            for(i = [ [ 0,  54,  10],
            [0, 56, 12],
            [0, 56, 14],
            [0, 56, 16],
            [0, 56, 18],
            [0, 56, 20],
            [0, 56, 22],
            [0, 56, 24],
            [0, 56, 26],
            [0, 56, 28],
            [0, 56, 30],
            [0, 56, 32],
            [0, 56, 34],
            [0, 56, 36],
            [0, 56, 38],
            [0, 56, 40],
            [0, 56, 42],
            [0, 56, 44],
            [0, 56, 46],
            [0, 56, 48],
            [0, 56, 50],
            [0, 56, 52],
            [0, 56, 54],
            [0, 56, 56],
            [0, 56, 58] ])
            {
                translate(i)
                resize([12,12,12])
                sphere(100, center = true);
            }
        
    }
}

}
    if (parts_to_render == 1) {
		translate([10,80,5])    rotate([90,0,0])      L();
		translate([-10,80,5])    rotate([90,0,0])      R();
        translate([10,60,-80])    rotate([0,0,0])      L2();
		translate([-10,60,-80])    rotate([0,0,0])      R2();
	}
	if (parts_to_render == 2) {
		translate([0,0,-50])                         Head();
	}
	if (parts_to_render == 3) {
        translate([0,0,0])                         Body();
		translate([0,0,0])                           Back_Leg();
	}
	if (parts_to_render == 4) {
        translate([0,-50,0]) rotate([-72.5,0,0])     Front_Leg();
	}
	if (parts_to_render == 5) {
		translate([35,60,5]) rotate([0,90,180])     Tail();
		translate([35,80,5]) rotate([0,90,180])     Tail2();
    }
    if (parts_to_render == 6) { 
		translate([-10,-10,5])    rotate([90,0,0])      R();
		translate([10,-10,5])    rotate([90,0,0])       L();
        translate([-50,-10,5])    rotate([90,0,0])      R2();
		translate([-90,-10,5])    rotate([90,0,0])       L2();
        translate([0,100,-50])                          Head();
		translate([0,0,0])                              Body();
		translate([0,0,0])                              Back_Leg();
		translate([0,-50,0]) rotate([-72.5,0,0])        Front_Leg();
		translate([35,130,5]) rotate([0,90,180])        Tail();
        translate([-30,120,5]) rotate([0,90,180])       Tail2();
	}
    if (parts_to_render == 7) {

        if (ears_to_choose == 1){
            L();
            R();
        }
        
        if (ears_to_choose == 2){
            L2();
            R2();
        }
            
        Head();
        Body();
        Back_Leg();
        Front_Leg();
            
        if (tail_to_choose == 1) {
            Tail();
        
        }
        
        if (tail_to_choose == 2) {
            Tail2();
        
        }
        
    }

   
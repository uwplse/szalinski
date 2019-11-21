diameter = 40;
//max amount of pepperonis
pepperoniAmount = 15;    
//max amount of olives
oliveAmount = 15;   
//max amount of mushrooms
mushAmount = 15;    
//max amount of jalapeno
jalapenoAmount = 15;     
//controls the amount of polygons
$fn = 50;

//[more controls]
//crust diameter
crust = 3;
pepperoniRadius = 2;
oliveRadius = .8;
mushroomRadius = 1.6;
jalapenoRadius = 1.2;




radius = diameter/2;
//a =   test ? TrueValue : FalseValue ;

function distFromOrigin(XY) = sqrt(pow(XY[0],2) + pow(XY[1],2));
function distance(p0,p1) = sqrt(  pow(p0[0]-p1[0],2)  +  pow(p0[1]-p1[1],2)  );


//pick locations for the pepperonis
pepperoniLocations=[for(i=[0:50])
    concat(rands(-radius,radius,2),0)
];

//check if the pepperonis will extend beyond the middle of the pizza
pepOnCheese=[for(i=[0:len(pepperoniLocations)-1])
    if(distFromOrigin(pepperoniLocations[i]) + pepperoniRadius < diameter/2 - crust/2)
    (pepperoniLocations[i])
];

/*
to test if a pepperoni will touch outher pepperonis:
start with second pepperoni position (index 0)
create list of true false values for if it seperated from other pepperonis
true=touching

each sub array is
run through isListAllFalse, to see which pepperonis are good
*/
touchingPepperonis = concat(false,[
    for(i=[1:len(pepOnCheese)-1])
        
        !isListAllFalse([for(j=[0:i-1])
            (distance(pepOnCheese[i],pepOnCheese[j])<=2*pepperoniRadius) ])   
    
]);

validPepperonis = 
        [for(i=[0:len(pepOnCheese)-1])
            if(touchingPepperonis[i]==false)
            pepOnCheese[i]];



//this stage places up to half the peps
//Is the number of pepperonis asked for in this stage,
//greater than the number of valid pepperoni spots?
//If it is, go with the number of valid pepperoni spots.
pepCount = len(validPepperonis)>round(pepperoniAmount/2) ? round(pepperoniAmount/2)-1 : len(validPepperonis)-1;         
            
            
            
            echo("pepCount",pepCount);
for(i=[0:pepCount]){
        
        translate(validPepperonis[i])
        pepperoni();
    
}        
        
/////////////////////////////////////peps2

//pick locations for the pepperonis
pepLocations2=[for(i=[0:50])
    concat(rands(-radius,radius,2),0)
];

//check if the pepperonis will extend beyond the middle of the pizza
pepOnCheese2=[for(i=[0:len(pepLocations2)-1])
    if(distFromOrigin(pepLocations2[i]) + pepperoniRadius < diameter/2 - crust/2)
    (pepLocations2[i])
];

pepNotTouchingToppings=[for(i=[0:len(pepOnCheese2)-1])
    if(isListAllFalse(
        [for(j=[0:pepCount])
            distance(pepOnCheese2[i],validPepperonis[j]) < (pepperoniRadius*2)
        
        ]
    ))(pepOnCheese2[i])
]; 
    
touchingPeps2 = concat(false,[
    for(i=[1:len(pepNotTouchingToppings)-1])
        
        !isListAllFalse([for(j=[0:i-1])
            (distance(pepNotTouchingToppings[i],pepNotTouchingToppings[j])<=2*pepperoniRadius) ])   
    
]);        

validPeps2 = 
        [for(i=[0:len(pepNotTouchingToppings)-1])
            if(touchingPeps2[i]==false)
            pepNotTouchingToppings[i]];
pepsAvailable2 = len(validPeps2);
pepsNeeded2 = pepperoniAmount - (pepCount+1);
            
            
//this stage places the remaining peps
//Is the number of pepperonis asked for in this stage,
//greater than the number of valid pepperoni spots?
//If it is, go with the number of valid pepperoni spots.                 
pepCount2 = (pepsAvailable2 > pepsNeeded2) ? pepsNeeded2-1 : pepsAvailable2-1;
            echo("pepCount2",pepCount2);
echo("pepsAvailable2",pepsAvailable2);
            echo("pepsNeeded2",pepsNeeded2);
            echo("pepCount2",pepCount2);
            

if(pepCount2>=0){  //this condition prevents errors with negative pepCount2 values
    for(i=[0:pepCount2]){
     
            translate(validPeps2[i])
            pepperoni();
        
    } 
}
totalPepCount = pepCount + pepCount2;


pepsPart1 = [for(i=[0:pepCount])validPepperonis[i]];
pepsPart2 = [for(i=[0:pepCount2])validPeps2[i]];

totalValidPeps = concat(pepsPart1,pepsPart2);



/////////////////////////////////peps2        

/////////////////////////////////////olives

//pick locations for the olives
oliveLocations=[for(i=[0:50])
    concat(rands(-radius,radius,2),0)
];

//check if the pepperonis will extend beyond the middle of the pizza
oliveOnCheese=[for(i=[0:len(oliveLocations)-1])
    if(distFromOrigin(oliveLocations[i]) + oliveRadius < diameter/2 - crust/2)
    (oliveLocations[i])
];

oliveNotTouchingToppings=[for(i=[0:len(oliveOnCheese)-1])
    if(isListAllFalse(
        [for(j=[0:len(totalValidPeps)-1])
            distance(oliveOnCheese[i],totalValidPeps[j]) < (oliveRadius + pepperoniRadius)
        
        ]
    ))(oliveOnCheese[i])
]; 
    
touchingOlives = concat(false,[
    for(i=[1:len(oliveNotTouchingToppings)-1])
        
        !isListAllFalse([for(j=[0:i-1])
            (distance(oliveNotTouchingToppings[i],oliveNotTouchingToppings[j])<=2*oliveRadius) ])   
    
]);        

validOlives = 
        [for(i=[0:len(oliveNotTouchingToppings)-1])
            if(touchingOlives[i]==false)
            oliveNotTouchingToppings[i]];
            
//this stage places up to the requested number of olives
//Is the number of olives asked for in this stage,
//greater than the number of valid olive spots?
//If it is, go with the number of valid olive spots.
oliveCount = len(validOlives)>oliveAmount ? oliveAmount-1 : len(validOlives)-1;
 
if(oliveCount>=0){  //this condition prevents errors with negative oliveCount values     
    for(i=[0:oliveCount]){
     
            translate(validOlives[i])
            olive();
        
    } 
}
/////////////////////////////////olives

/////////////////////////////////mushroom

//pick locations for the mush
mushLocations=[for(i=[0:50])
    concat(rands(-radius,radius,2),0)
];

//check if the pepperonis will extend beyond the middle of the pizza
mushOnCheese=[for(i=[0:len(mushLocations)-1])
    if(distFromOrigin(mushLocations[i]) + mushroomRadius < diameter/2 - crust/2)
    (mushLocations[i])
];

mushNotTouchingPep=[for(i=[0:len(mushOnCheese)-1])
    if(isListAllFalse(
        [for(j=[0:len(totalValidPeps)-1])
            distance(mushOnCheese[i],totalValidPeps[j]) < (mushroomRadius + pepperoniRadius)
        ]
    ))(mushOnCheese[i])
]; 

mushNotTouchingToppings=[for(i=[0:len(mushNotTouchingPep)-1])
    if(isListAllFalse(
        [for(j=[0:oliveCount])
            distance(mushNotTouchingPep[i],validOlives[j]) < (mushroomRadius + oliveRadius)
        
        ]
    ))(mushNotTouchingPep[i])
]; 
   
touchingMush = concat(false,[
    for(i=[1:len(mushNotTouchingToppings)-1])
        
        !isListAllFalse([for(j=[0:i-1])
            (distance(mushNotTouchingToppings[i],mushNotTouchingToppings[j])<=2*mushroomRadius) ])   
    
]);        

validMush = 
        [for(i=[0:len(mushNotTouchingToppings)-1])
            if(touchingMush[i]==false)
            mushNotTouchingToppings[i]];

mushCountSelector = len(validMush)>mushAmount ? mushAmount-1 : len(validMush)-1;
mushCount = mushCountSelector > 0 ?mushCountSelector : 0;
for(i=[0:mushCount]){
    translate(validMush[i])
    rotate([0,0,rands(0,360,1)[0]])
    mushroom(); 
} 


/////////////////////////////////mushroom

/////////////////////////////////jalapeno


//pick locations for the jalapenos
jalapenoLocations=[for(i=[0:50])
    concat(rands(-radius,radius,2),0)
];

//check if the pepperonis will extend beyond the middle of the pizza
jalapenoOnCheese=[for(i=[0:len(jalapenoLocations)-1])
    if(distFromOrigin(jalapenoLocations[i]) + jalapenoRadius < diameter/2 - crust/2)
    (jalapenoLocations[i])
];

jalapenoNotTouchingPep=[for(i=[0:len(jalapenoOnCheese)-1])
    if(isListAllFalse(
        [for(j=[0:len(totalValidPeps)-1])
            distance(jalapenoOnCheese[i],totalValidPeps[j]) < (jalapenoRadius + pepperoniRadius)
        ]
    ))(jalapenoOnCheese[i])
]; 

jalapenoNotTouchingOlives=[for(i=[0:len(jalapenoNotTouchingPep)-1])
    if(isListAllFalse(
        [for(j=[0:oliveCount])
            distance(jalapenoNotTouchingPep[i],validOlives[j]) < (jalapenoRadius + oliveRadius)
        
        ]
    ))(jalapenoNotTouchingPep[i])
]; 
   
jalapenoNotTouchingToppings=[for(i=[0:len(jalapenoNotTouchingOlives)-1])
    if(isListAllFalse(
        [for(j=[0:mushCount])
            distance(jalapenoNotTouchingOlives[i],validMush[j]) < (jalapenoRadius + mushroomRadius)
        
        ]
    ))(jalapenoNotTouchingOlives[i])
];         
        
        
        
        
touchingJalapeno = concat(false,[
    for(i=[1:len(jalapenoNotTouchingToppings)-1])
        
        !isListAllFalse([for(j=[0:i-1])
            (distance(jalapenoNotTouchingToppings[i],jalapenoNotTouchingToppings[j])<=2*jalapenoRadius) ])   
    
]);        

validJalapeno = 
        [for(i=[0:len(jalapenoNotTouchingToppings)-1])
            if(touchingJalapeno[i]==false)
            jalapenoNotTouchingToppings[i]];

jalapenoCountSelector = len(validJalapeno)>jalapenoAmount ? jalapenoAmount-1 : len(validJalapeno)-1;
jalapenoCount = jalapenoCountSelector > 0 ?jalapenoCountSelector : 0;
for(i=[0:jalapenoCount]){
    translate(validJalapeno[i])
    rotate([0,0,rands(0,360,1)[0]])
    jalapeno(); 
} 























/////////////////////////////////jalapeno

//makes a list of false values and concat a true at the end.
//if the input list has no false values,
//the list will only contain the "true"
//by taking the first element in the array
//this returns "true" if the list contains no false elements
function isListAllTrue(list)=
    concat(
        [for(i=[0:len(list)-1])
            if(list[i]==false)
                (list[i])]
           ,true
    )[0];
    
function isListAllFalse(list)=
    concat(
        [for(i=[0:len(list)-1])
            if(list[i]==true)
                (false)]
           ,true
    )[0];








/*
color("gold")
cheeseBubbles(100);
*/


    color("tan")
rotate_extrude(angle = 360, convexity = 2)
translate([diameter/2,0,0])
    
circle(d=crust);



translate([0,0,-crust/2])
color("tan")
cylinder(d=diameter,h=crust/4);
    
    
translate([0,0,-crust/4])
color("yellow")
cylinder(d=diameter,h=crust/4);




module pepperoni(){
    translate([0,0,-.1])
    color("FireBrick")
    difference(){
        cylinder(r=pepperoniRadius,h=.5);
        translate([0,0,.6])
        scale([2.2,2.2,.5]){
            sphere(r=1);
        }
    }
}

module olive(){
    translate([0,0,-.1])
    color("black")
    difference(){
        cylinder(r=oliveRadius,h=.5);
        translate([0,0,-1])
        cylinder(r=oliveRadius*(.3/.8),h=2);
    }
}



module mushroom(){
    linear_extrude(height = .4)
    scale([mushroomRadius/20.322,mushroomRadius/20.322,mushroomRadius/20.322]){
        translate([0,-20.322,0]){
            mirrorCopy([1,0,0]){
            //top curve
            intersection(){ 
                translate([0,19.573,0])
                square([14.827,16]);
                circle(r=34.427);
            }
            //side curve
            translate([10.021,22.322,0])
            intersection(){
                circle(r=9.982);
                translate([4.806,-8.749,0])
                square([6.173,19.427]);
            }
            //under curve
            translate([11.941,21.1,0])
                intersection(){
                    circle(r=8.057);
                    translate([-7.941,-11.339,0])
                    square([10.827,10.827]);
                }
            }
            polygon([[7,3],[9,31],[-9,31],[-7,3]]);
        }
    }
}





module jalapeno(){
    color("olive")
    linear_extrude(height=.5)
    scale([jalapenoRadius/14.25,jalapenoRadius/14.25,1])
    difference(){
    union(){
    rotate([0,0,90])
    pepperArc();
    
    rotate([0,0,270])
    pepperArc();
    
    rotate([0,0,180])
    pepperArc();
    
    
    pepperArc();
    }
    
    pepperCircle();
     rotate([0,0,90])
    pepperCircle();
    
    rotate([0,0,270])
    pepperCircle();
    
    rotate([0,0,180])
    pepperCircle();
    
    
    pepperCircle();
    
}
    
}

module pepperArc2(){
    scale([1,1.05,1])
    mirrorCopy()
    translate([-.1,0,0])
    intersection(){
    translate([8,5,0]){
        difference(){
            circle(r=9);
            circle(r=6);
        }
    }
    translate([0,6,0]){
        square([12,12],center=true);
    }
}
}

module pepperArc(){
    rotate([0,0,45])
    translate([0,4.2,0])
        difference(){
        circle(r=10);
    
        
            
        circle(r=5);
     
    }  
}

module pepperCircle(){
    rotate([0,0,45])
    translate([0,4.2,0])
    circle(r=5);
    
    
}


module mirrorCopy(vector){
    children();
    mirror(vector)
    children();
    
    
}

module cheeseBubbles(amount=100){
    difference(){
        for(i=[0:amount]){
            bubble();
        }
        translate([0,0,-1])
        difference(){
            cylinder(r=sqrt(2*pow(radius,2))+4,h=5);
            translate([0,0,-1])
            cylinder(d=diameter,h=7);  
        }
    }     
}

module bubble(){
    XYscale = rands(.5,10,1)[0];
    Zscale = rands(.1,1,1)[0];
    Xmove = rands(-radius,radius,1)[0];
    Ymove = rands(-radius,radius,1)[0];
    translate([Xmove,Ymove,0])
    scale([XYscale,XYscale,Zscale])
    difference(){
        translate([0,0,-.9])
        sphere();
        
        translate([0,0,-1])
        cube([3,3,2],center=true);
    }
}
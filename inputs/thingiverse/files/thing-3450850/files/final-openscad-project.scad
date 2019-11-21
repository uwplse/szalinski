//////////////////////////////////////////////////////////////////////////////////parameters////////////////////////////////////////////////////////////////////////////////////////////

type=3;

phrase=6;
/////////////////////////////////////////////////////////////

$fn = 3*1;

height= 304.8*1;

length= 20*1;

radius= 30*1;




 

//25.4mm= 1 inch

 

/////////////////////////////////////////////////////////////////ruler

 

 

rotate ([90,150,90])

    cylinder (height, radius, radius);

   

 

translate([-100,0,0]);

    color("black",alpha)

    translate([0,-23,-10])

    rotate(-30,[1,0,0])

    rotate (90,[1,0,0])
    linear_extrude(height=1)
        text("0",size=5);

       

translate([-100,0,0]);

    color("black",alpha)

    translate([24.75,-23,-10])

    rotate(-30,[1,0,0])

    rotate (90,[1,0,0])
    linear_extrude(height=1)
        text("1",size=5);       

        

translate([-100,0,0]);

    color("black",alpha)

    translate([49.5,-23,-10])

    rotate(-30,[1,0,0])

    rotate (90,[1,0,0])
    linear_extrude(height=1)
        text("2",size=5);

 

translate([-100,0,0]);

    color("black",alpha)

    translate([74.25,-23,-10])

    rotate(-30,[1,0,0])

    rotate (90,[1,0,0])
    linear_extrude(height=1)
        text("3",size=5);

 

translate([-100,0,0]);

    color("black",alpha)

    translate([99,-23,-10])

    rotate(-30,[1,0,0])

    rotate (90,[1,0,0])
    linear_extrude(height=1)
        text("4",size=5); 
        
        
translate([-100,0,0]);

    color("black",alpha)

    translate([123.75,-23,-10])

    rotate(-30,[1,0,0])

    rotate (90,[1,0,0])
    linear_extrude(height=1)
        text("5",size=5);
        
translate([-100,0,0]);

    color("black",alpha)

    translate([148.5,-23,-10])

    rotate(-30,[1,0,0])

    rotate (90,[1,0,0])
    linear_extrude(height=1)
        text("6",size=5);

translate([-100,0,0]);

    color("black",alpha)

    translate([173.25,-23,-10])

    rotate(-30,[1,0,0])

    rotate (90,[1,0,0])
    linear_extrude(height=1)
        text("7",size=5);
       
translate([-100,0,0]);

    color("black",alpha)

    translate([198,-23,-10])

    rotate(-30,[1,0,0])

    rotate (90,[1,0,0])
    linear_extrude(height=1)
        text("8",size=5);
        
translate([-100,0,0]);

    color("black",alpha)

    translate([222.75,-23,-10])

    rotate(-30,[1,0,0])

    rotate (90,[1,0,0])
    linear_extrude(height=1)
        text("9",size=5);
        
translate([-100,0,0]);

    color("black",alpha)

    translate([247.5,-23,-10])

    rotate(-30,[1,0,0])

    rotate (90,[1,0,0])
    linear_extrude(height=1)
        text("10",size=5);
        
translate([-100,0,0]);

    color("black",alpha)

    translate([272.25,-23,-10])

    rotate(-30,[1,0,0])

    rotate (90,[1,0,0])
    linear_extrude(height=1)
        text("11",size=5);
        
translate([-100,0,0]);

    color("black",alpha)

    translate([297,-23,-10])

    rotate(-30,[1,0,0])

    rotate (90,[1,0,0])
    linear_extrude(height=1)
        text("12",size=5);  

//name 

if (type==1){

translate([-100,0,0]);
    color("black",alpha)
    translate([200,23,-10])
    rotate(-30,[-1,0,0])
    rotate (90,[1,0,0])
    rotate (180,[0,1,0])
    linear_extrude(height=3)
        text("BOSS",size=30);  
}
 
if (type==2){
translate([-100,0,0]);
    color("black",alpha)
    translate([200,23,-10])
    rotate(-30,[-1,0,0])
    rotate (90,[1,0,0])
    rotate (180,[0,1,0])
    linear_extrude(height=3)
        text("Ella",size=30);
}

if (type==3){
translate([-100,0,0]);
    color("black",alpha)
    translate([220,23,-6])
    rotate(-30,[-1,0,0])
    rotate (90,[1,0,0])
    rotate (180,[0,1,0])
    linear_extrude(height=3)
        text("Chesley",size=30); 
} 
    

//other phrase

if (phrase==4){
translate([-100,0,0]);
    color("black",alpha)
    translate([200,23,-10])
    rotate(-30,[-1,0,0])
    rotate (90,[1,0,0])
    rotate (180,[0,0,1])
    rotate (-60,[1,0,0])
    translate ([-50,-35,5])
    linear_extrude(height=3)
        text("Back in 10.",size=30); 
} 
if (phrase==5){       
translate([-100,0,0]);
    color("black",alpha)
    translate([200,23,-10])
    rotate(-30,[-1,0,0])
    rotate (90,[1,0,0])
    rotate (180,[0,0,1])
    rotate (-60,[1,0,0])
    translate ([-60,-35,5])
    linear_extrude(height=3)
        text("Gone Fishin'",size=30);   
}    
if (phrase==6){               
translate([-100,0,0]);
    color("black",alpha)
    translate([200,23,-10])
    rotate(-30,[-1,0,0])
    rotate (90,[1,0,0])
    rotate (180,[0,0,1])
    rotate (-60,[1,0,0])
    translate ([-60,-35,5])
    linear_extrude(height=3)
        text("In A Meeting.",size=30);
}

    
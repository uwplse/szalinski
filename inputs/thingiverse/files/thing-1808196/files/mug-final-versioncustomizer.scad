

diameter= 60;
height=100;
resolution=10;//[10:100]
bottom_thickness=10; //[2:100]
wall_thickness=5; //[2:10]
handle_thickness= 8; //[2:10]
hand=40; //[10:100]
$fn=resolution;

size_letters= 3; //[0:10] 
word1= "Hope"; //[Hope,Life,Trust]
distance_word1=5; //[0:10]
word2= "Dream"; //[Dream,Luck,Joy]
distance_word2=6; //[0:10]
word3= "Love"; //[Love,Beauty,Happiness]
distance_word3=4; //[0:10]

Botton_radius=1.5;//[1,1.5,2,2.5,3,3.5]

//module for words that will be included in the cup
module text_1(letters,x){
translate([x, 27.8, 5])rotate([-90,-180,-90])rotate([0,90,0])
    linear_extrude(1)
        
        text(letters, size_letters, font = "Harlow Solid Italic");
}

//module for exterior cup
module ext_mug(){
     cylinder(d=diameter, h=height);
     
     for(i=[0:108:270]){rotate([0,0,i])text_1(word1,distance_word1);
}
     for(i=[36:108:234]){rotate([0,0,i])text_1(word2,distance_word2);
}
    for(i=[-36:108:270]){rotate([0,0,i])text_1(word3,distance_word3);
}
}

// module for hole inside the cup
module int_mug(){
  translate([0,0,bottom_thickness])
    cylinder(d=diameter-(wall_thickness), h=height);  
}
//module for the basic cup handle
module handle(){
    
translate([(hand/2.5),5,(height-hand-(handle_thickness))])rotate([90,0,0]) rotate_extrude() {
translate([hand, 0,0])circle(d=handle_thickness, $fn=20);
}
}


//branches surrounding the handle
 module cup_branch(x,y,z,thetax,thetay,thetaz,h,conv,tw,loc1,rad){
     translate([x,y,z]){
 rotate ([thetax,thetay,thetaz])linear_extrude(height = h, convexity = conv, twist = tw)
translate([loc1, 0, 0])
   
circle(r = rad);
}

 }
 module total_branch(){
 //Formation of branches in the handles
 cup_branch(25,0,1.9,0,30,10,75,10,-500,2,1.5);
 cup_branch(25,-4,1.5,-5,25,10,70,10,400,2,1.5);
 cup_branch(25,-3,1.6,-3,40,10,40,10,-500,1,1.5);
 cup_branch(56,8,60,0,-40,10,45,10,150,5,1.5);
 cup_branch(56,8,60,0,-40,10,45,10,310,-4,1.5);
 cup_branch(58,8,50,0,-40,10,48,10,300,-6,1.5);
 cup_branch(58,8,40,0,-40,10,48,10,300,-7,1.5);
 cup_branch(25,0,5,0,30,10,74,10,-500,4,1.5);
 cup_branch(56,8,60,0,-40,10,45,10,150,7,1.5);   
 cup_branch(25,4,2,0,30,10,75,10,500,2,1.5);
 cup_branch(56,8,60,0,-40,10,48,10,300,7,1.5);
 cup_branch(25,4,1.6,1,40,10,40,10,500,1,1.5);    

// decorative in the handle
translate([56,8,60]){
    rotate_extrude(convexity = 10)
translate([5, 5, 0])
circle(r = 2.1, $fn = 10);
}
}


 
//Decorative in the botton
module botton(Botton_radius){
rotate_extrude(convexity = 10, $fn=10)
translate([30, 0, 0])
circle(r=Botton_radius);
}

//basic operation unification between handle and exterior cup and creating hole
difference(){
    union(){
    ext_mug();
    handle();
    total_branch();
    botton(Botton_radius);} 
    
  int_mug(); 
    
}

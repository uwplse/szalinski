/* 
Update 3/17/17 - converted the tongue, groove, male block, and female block into modules. This greatly simplifies the program and eliminated repeated code. Next thinking about adding ability to add multiple tongues and grooves on a single block

Update 3/8/17 - added tolerance gap around tongue and female part, with 1/2 the tolerance removed from both parts. Next thinking about making the male and female tongue parts into modules so they can be placed in other locations, or in multiple locations...
*/


//////////////////User inputed variable////////////////////////////////////////////////////////////

//male or female part
partType="Both";//[Male,Female,Both]

//Number of tongues or grooves - not working yet...
Number_of_Joints=1;//[1,2]

//This is the max width of the tongue
width=6;

//This is the length of the tongue
Tongue_Length=6;

//This is the height of the block that the tongue is attached to
height=4;

//This is the height from the bottom of the block to the bottom of the tongue
height_2=1;

//this is the height of the end of the tongue (Height - Height_2 > height_3 > 0)
height_3=1;

//angle of tongue incut at base
angle =20;

//Additional width of male block, amount wider than tongue
Male_Block_Width = 0;

//Additional width of female block, amount wider than tongue
Female_Block_Width = 10;

//Length of block the tongue is attached to
Male_Block_Length = 20;

//Depth of Female Block (>=0) 
Block_Depth = 0;

//Tolerance Gap to ensure a good fit (0.1 a good starting point assuming exporting using mm) (must be >0 for equations below to be defined
Tolerance=0.1;

///////////////////////////////Calculated variables////////////////////////////////////////////////////

length=Tongue_Length+0.5*Tolerance;  //Tongue length adjusted to include tolerance

height_4 = height-height_2-height_3;  //height of base of tongue

Tongue_Rise_Angle = atan(height_4/length); //angle at which tongue rises from horizontal

z = Tolerance/(2*cos(Tongue_Rise_Angle)); //height of tolerance corrected for angle the tongues rises at

//////////////////////////////Code for generating dovetails based on inputted variables//////////////////////////

//acknowledged problem with displaying in preview mode because difference function 
//as written currently involves coincident faces. Because the F6
//render is not too slow, I'm not fixing it for now...

if(partType=="Male"){
        tongue();
        maleBlock();
}

if (partType=="Female"){
        difference(){ //female block with tongue and 1/2 tolerance cut out on sides and bottom
          femaleBlock();
          groove();
    }
}
if(partType=="Both") { 
    tongue();
    maleBlock();
    difference(){ //female block with tongue and 1/2 tolerance cut out on sides and bottom
          femaleBlock();
          groove();
    }
}
     
/////////////////////////////////MODULES/////////////////////////////////////////////////  
module tongue(){
    color([1,0,0])    
difference(){
    polyhedron(  //tongue polyhedron
        points=[[width-((height-height_2)*tan(angle)),0,height],
                [width,0,height_2],
                [0,0,height_2],
                [(height-height_2)*tan(angle),0,height],
                [width-(height_3)*tan(angle),length,height],
                [width,length,(height-height_3)],
                [0,length,height-height_3],
                [(height_3)*tan(angle),length,height] ],          
        faces=[ [0,1,2],[0,2,3], //base face
                [0,4,1],[1,4,5], //side 1
                [0,3,4],[3,7,4], //top
                [2,7,3],[2,6,7], //side 2
                [1,5,2],[2,5,6], //bottom
                [6,5,4],[4,7,6]] //end
    );

   polyhedron(   //this shaves off the half the tolerance thickness on one side of tongue
        points=[[(height-height_2)*tan(angle),0,height],                             //point 0
                [0,0,height_2],                                                      //point 1                       
                [0.5*Tolerance*sin(90-angle),0,height_2],                            //point 2
                [0.5*Tolerance*sin(90-angle)+(height-height_2)*tan(angle),0,height], //point 3
                [height_3*tan(angle),length,height],                                 //point 4
                [0,length, height -height_3],                                        //point 5
                [0.5*Tolerance*sin(90-angle),length, height-height_3],               //point 6
                [0.5*Tolerance*sin(90-angle)+height_3*tan(angle), length, height]],  //point 7
        faces=[ [0,3,2,1], //back
                [0,4,7,3], //top
                [0,1,5,4], //side 1
                [1,2,6,5], //bottom
                [3,7,6,2], //side 2
                [4,5,6,7]] //front
    );
    
       polyhedron(   //this shaves off half the tolerance thickness on other side of tongue
        points=[[width-(height-height_2)*tan(angle),0,height],                             //point 0
                [width,0,height_2],                                                        //point 1
                [width-0.5*Tolerance*sin(90-angle),0,height_2],                            //point 2
                [width-(height-height_2)*tan(angle)-0.5*Tolerance*sin(90-angle),0,height], //point 3
                [width-height_3*tan(angle),length,height],                                 //point 4
                [width,length, height -height_3],                                          //point 5
                [width-0.5*Tolerance*sin(90-angle),length, height-height_3],               //point 6
                [width-height_3*tan(angle)-0.5*Tolerance*sin(90-angle), length, height]],  //point 7
        faces=[ [0,1,2,3], //back
                [0,3,7,4], //top
                [0,4,5,1], //side 1
                [1,5,6,2], //bottom
                [3,2,6,7], //side 2
                [4,7,6,5]] //front
    );

       polyhedron(   //this shaves off the tolerance half the thickness on the bottom of the tongue
        points=[[width,0,height_2],                                                        //point 0
                [0,0,height_2],                                                            //point 1       
                [z*tan(angle),0,height_2+z],                                               //point 2
                [width-z*tan(angle),0,height_2+z],                                         //point 3
                [width,length,height-height_3],                                            //point 4
                [0,length,height-height_3],                                                //point 5
                [z*tan(angle),length,height-height_3+z],                                   //point 6
                [width-z*tan(angle),length,height-height_3+z]],                            //point 7
        faces=[ [0,1,2,3], //back
                [2,6,7,3], //top
                [1,5,6,2], //side 1
                [0,4,5,1], //bottom
                [7,4,0,3], //side 2
                [4,7,6,5]] //front
                
        );
    }
}
 
 
          
module maleBlock(){
color([1,0,0])translate([-Male_Block_Width/2,-Male_Block_Length,0]){cube([width+Male_Block_Width, Male_Block_Length, height]);}
}
module groove(){
translate([-(Female_Block_Width)/2,0,0]){cube([width+Female_Block_Width, Tolerance/2,height]);}
          polyhedron( //cuts out tongue on female block
               points=[ [width-((height-height_2)*tan(angle)),0,height],    //point 0
                        [width,0,height_2],                                 //point 1
                        [0,0,height_2],                                     //point 2
                        [(height-height_2)*tan(angle),0,height],            //point 3
                        [width-(height_3)*tan(angle),length,height],        //point 4
                        [width,length,(height-height_3)],                   //point 5
                        [0,length,height-height_3],                         //point 6
                        [(height_3)*tan(angle),length,height] ],            //point 7
               faces=[ [0,1,2],[0,2,3],//base face
                       [0,4,1],[1,4,5], //side 1
                       [0,3,4],[3,7,4], //top
                       [2,7,3],[2,6,7], //side 2
                       [1,5,2],[2,5,6], //bottom
                       [6,5,4],[4,7,6]],  //end
               convexity=10);
          
          translate([0,0,height]){linear_extrude(height=1){polygon(  //cuts out extra material above tongue, may be unnecessary
               points=[ [width-((height-height_2)*tan(angle)),0],
                        [(height-height_2)*tan(angle),0],
                        [(height_3)*tan(angle),length],
                        [width-(height_3)*tan(angle),length]]);   
          }}
    
   polyhedron(   //this shaves off half the tolerance thickness on one side of tongue
        points=[[(height-height_2)*tan(angle),0,height],                             //point 0
                [0,0,height_2],                                                      //point 1                       
                [-0.5*Tolerance*sin(90-angle),0,height_2],                            //point 2
                [-0.5*Tolerance*sin(90-angle)+(height-height_2)*tan(angle),0,height], //point 3
                [height_3*tan(angle),length,height],                                 //point 4
                [0,length, height -height_3],                                        //point 5
                [-0.5*Tolerance*sin(90-angle),length, height-height_3],               //point 6
                [-0.5*Tolerance*sin(90-angle)+height_3*tan(angle), length, height]],  //point 7
        faces=[ [0,3,2,1], //back
                [0,4,7,3], //top
                [0,1,5,4], //side 1
                [1,2,6,5], //bottom
                [3,7,6,2], //side 2
                [4,5,6,7]] //front
       );
    
   polyhedron(   //this shaves off half the tolerance thickness on other side of tongue
        points=[[width-(height-height_2)*tan(angle),0,height],                             //point 0
                [width,0,height_2],                                                        //point 1                     
                [width+0.5*Tolerance*sin(90-angle),0,height_2],                            //point 2
                [width-(height-height_2)*tan(angle)+0.5*Tolerance*sin(90-angle),0,height], //point 3
                [width-height_3*tan(angle),length,height],                                 //point 4
                [width,length, height -height_3],                                          //point 5
                [width+0.5*Tolerance*sin(90-angle),length, height-height_3],               //point 6
                [width-height_3*tan(angle)+0.5*Tolerance*sin(90-angle), length, height]],  //point 7
        faces=[ [0,1,2,3], //back
                [0,3,7,4], //top
                [0,4,5,1], //side 1
                [1,5,6,2], //bottom
                [3,2,6,7], //side 2
                [4,7,6,5]] //front
        );

       polyhedron(   //this shaves off half the tolerance thickness on the bottom of the tongue
        points=[[width+Tolerance/2,0,height_2],                               //point 0
                [-Tolerance/2,0,height_2],                                    //point 1       
                [-Tolerance/2+z*tan(angle),0,height_2+z],                     //point 2
                [Tolerance/2+width-z*tan(angle),0,height_2+z],                //point 3
                [width+Tolerance/2,length,height-height_3],                   //point 4
                [-Tolerance/2,length,height-height_3],                        //point 5
                [-Tolerance/2+z*tan(angle),length,height-height_3+z],         //point 6
                [width-z*tan(angle)+Tolerance/2,length,height-height_3+z]],   //point 7
        faces=[ [0,1,2,3], //back
                [2,6,7,3], //top
                [1,5,6,2], //side 1
                [0,4,5,1], //bottom
                [7,4,0,3], //side 2
                [4,7,6,5]] //front           
    );
}
module femaleBlock(){
translate([-(Female_Block_Width)/2,0,0]){cube([width+Female_Block_Width, length+Block_Depth,height]);}
}
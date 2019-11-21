//Living Hinge
//Ari M Diacou
//Metis Industries
//August 2016

//Thanks to Ronaldo Persiano for the inspiration for add_hinge() and tesselation_hinge()

///////////////////////////// Parameters /////////////////////////////////////
/* [Array dimensions] */
//The y dimension of the hinge, parallel to the laser cuts
length=30;
//The x dimension of the hinge, transverse to laser cuts
width=40;
//Number of objects in x direction
num_in_x=6;
//Number of objects in y direction
num_in_y=8;
//How thick do you want the hinge to be
height=.1;
//The character you want to tesselate(only first)
my_character="+";
//The type of the array you want
array_type="hexagonal";//[square,hexagonal,triangular]

/* [Transformations] */
//By how many degrees do you want to rotate the object?
theta=0;
//The percentage of a cell's height that should not be filled by the object
x_padding_percentage=10;//[0,1,2,3,4,5,10,15,20,25,30,40,50,60,70,80,90]
//The percentage of a cell's width that should not be filled by the object
y_padding_percentage=0;//[0,1,2,3,4,5,10,15,20,25,30,40,50,60,70,80,90]
//The percentage of a cell's width that an object should be translated
x_shift_adjustment=-30;//[-50,-40,-30,-25,-20,-10,-5,-4,-3,2-,-1,0,1,2,3,4,5,10,15,20,25,30,40,50]
//The percentage of a cell's height that an object should be translated
y_shift_adjustment=-15;//[-50,-40,-30,-25,-20,-10,-5,-4,-3,2-,-1,0,1,2,3,4,5,10,15,20,25,30,40,50]

///////////////////////////////// Main() //////////////////////////////////////
//preview[view:north, tilt:top]
cell_x=width/num_in_x;
cell_y=length/num_in_y;
my_text=my_character[0];
linear_extrude(height) 
    tesselation_hinge(  
        num=[num_in_x,num_in_y], 
        size=[width,length],
        padding=[x_padding_percentage*cell_x/100,y_padding_percentage*cell_y/100],
        type=array_type
        ) 
        translate([x_shift_adjustment*cell_x/100,y_shift_adjustment*cell_y/100])  
            rotate(theta)
                text(my_text,valign="center",halign="center");

////Uncomment lines to see Examples (all flat for DXF exporting)
///////////////////////////// Hinge() ///////////////////////////////////////
//hinge();
//hinge(d=6);
//hinge(length=20, size[0]=39,d=6,hinge_length=2.5,hinges_across_length=2,minimum_thinness=3);
//hinge(length=30, size[0]=20,d=2,hinge_length=2.5,hinges_across_length=2,minimum_thinness=3,center=true);
//hinge(length=20, size[0]=40,d=3,hinge_length=4,hinges_across_length=0,minimum_thinness=1);
//linear_extrude(height=5) hinge(length=20, size[0]=40,d=6,hinge_length=2.5,hinges_across_length=2,minimum_thinness=3);
//////////////////////////// Add_Hinge() ////////////////////////////////////
//add_hinge(size[0]=20,length=size[1],center=true) square([3*size[1],size[1]-1],center=true);
//add_hinge(size[0]=20,length=90) translate([5,0]) circle(d=90);
//add_hinge(size[0]=30,length=90,hinges_across_length=3) circle(d=90);
//add_hinge(size[0]=30,length=90,hinges_across_length=3,center=false) circle(d=90);
//add_hinge(size[0]=30,length=90,hinges_across_length=3,minimum_thinness=.1) circle(d=90);
//////////////////////////// Tesselate() ////////////////////////////////////
//tesselate(num=[3,6], size=[3,2],padding=[.1,.1],type="hex") rotate(30) circle($fn=6);
//tesselate(num=[3,6], size=[2,1],padding=[.4,.1],type="tri") translate([-.1,-.1]) text("T",valign="center",halign="center");
//tesselate(num=[6,6], size=[2,.7071],padding=[0.01,.01],type="tri") translate([0,.25]) rotate(30)  circle($fn=3);
//tesselate(num=[8,6], size=[2,1],padding=[.6,.1],type="tri") translate([-.1,-.1]) rotate(25) text("y",valign="center",halign="center");
//tesselate(num=[6,8], size=[1.5,1],padding=[.6,.1],type="hex") translate([-.1,-.1])  text("+",valign="center",halign="center");
//////////////////////// Tesselation_Hinge() ////////////////////////////////
//tesselation_hinge(num=[6,8], size=[9,6],padding=[.6,.1],type="hex") translate([-.1,-.1])  text("+",valign="center",halign="center");
//tesselation_hinge(size=[4,5],num=[3,6],padding=[.1,.4],type="hex") translate([-.8,-.5])square(); //running bond bricks
//tesselation_hinge(size=[4,5],num=[4,5],padding=[.1,.1],type="tri") translate([0,.28])rotate(30) circle($fn=3);
//tesselation_hinge(size=[4,5],num=[4,5],padding=[.7,.1],type="tri") translate([-.1,-.1]) rotate(5) text("t",valign="center",halign="center");
//tesselation_hinge(num=[3,6], size=[3,6],padding=[.4,.1],type="tri") translate([-.1,-.1]) text("T",valign="center",halign="center");
//tesselation_hinge(size=[6,6],num=[6,6],padding=[.2,.2],type="hex") rotate(30) circle($fn=6);

/////////////////////////////// Functions /////////////////////////////////////
module hinge(size=[20,30],d=3,minimum_thinness=3,hinge_length=3,hinges_across_length=2,center=false){
    //size[1] = the y dimension of the hinge, parallel to the laser cuts
    //size[0] = the x dimension of the hinge, transverse to laser cuts
    //d=the distance between parallel laser cuts
    //What is the minimum distance that two parallel lines can be apart before the laser does something catastrophic? E.g. setting uncontrollable fire to the work piece. This is "minimum_thinness"
    //hinge_length=the distance between 2 colinear laser cuts
    //hinges_across_length=the number of hinges across the size[1] of the hinge
    //center is a boolean value, if true, place the center of the rectangle at the origin, if false, put the bottom left corner at the origin (just like square() and cube())
    ep=.00101;//epsilon, a small number,=1.01 micron, a hack (for OpenSCAD 2015.03) used to make square()'s which look like lines (which OpenSCAD doesn't support). Hopefully, your laser has a function which says something like "ignore cuts less than THRESHOLD apart", set that to anything greater than ep.
    adjust=center?-[size[0],size[1]]/2:[0,0];//a vector for adjusting the center position
    th=d/2<minimum_thinness?ep:d/2;//If the distance between lines is less than the minimum thickness, just make linear cuts, specifically, set the size[0]=th=thickness of the squares to ep, which is just above 1 micron (for 1=1mm slicers)
    n=floor(size[0]/d);
    m=floor(abs(hinges_across_length)); echo(str("Number of hinges (m)=",m)); //input cleaning, ensures m ϵ {non-negative integers}
    echo(str("Suggested filename: Living Hinge-",size[1],"x",size[0],"mm-h=",m,"x",hinge_length,"-th=",th));
    echo(str("The distance between parallel laser cuts (d) is: ",d," mm."));
    //the size[1] of the short lines
    short=(size[1]-m*hinge_length)/(m+1);
    //the size[1] of the long lines
    long=(size[1]-(m+1)*hinge_length)/(m);
    echo(str("There should be n=",n," links in the hinge."));
    translate(adjust) difference(){ 
        square([size[0],size[1]],center=false);
        if(m==0) 
            //In the special case where |hinges_across_length|<1, the hinge should look like:
            // |  --------------------------------------|
            // |--------------------------------------  |
            // |  --------------------------------------|
            // |--------------------------------------  |
                for(i=[0:n])
                    translate([i*d,(pow(-1,i))*hinge_length]) // (-1)^i,{iϵZ} = {-1,+1,-1,+1,...}
                        square([th,size[1]]);                
        else
            //A hinge with hinges_across_length=2 should look like:
            // |------------  ------------  ------------|
            // |  -----------------  -----------------  |
            // |------------  ------------  ------------|
            // |  -----------------  -----------------  |
            for(i=[0:n]){ //Iterating across x
                translate([i*d*1,0]){ //Do the x translation seperate from the y translations
                    if(i%2==1) //For odd columns
                        for(j=[0:m-1]){
                            translate([0,hinge_length+j*(long+hinge_length)]) 
                                square([th,long]);
                            }
                    if(i%2==0) //For even columns
                        for(j=[0:m]){
                            translate([0,j*(short+hinge_length)]) 
                                square([th,short]);
                        }
                    }
                }
            }
    }
    
module add_hinge(size=[20,30],d=3,minimum_thinness=3,hinge_length=3,hinges_across_length=2,center=true){
    //add_hinge() modifies another 2D object, by adding a hinge which is centered on the origin (by default, this can be changed to false, so that the bottom left corner of the hinge is at the origin. It uses the same parameters as hinge(). 
    //First, difference() a rectangle the size of the hinge from the child object (makes a hole for the hinge
    //Second, union() a hinge with First (puts the hinge in the hole)
    //Third, intersection() the child object with Second (cuts off any extra hinge that sticks out past the child object)
    intersection(){
        children();
        union(){
            hinge(size=size,d=d,minimum_thinness=minimum_thinness,hinge_length=hinge_length,hinges_across_length=hinges_across_length,center=center);
            difference(){
                children();
                square([size[0],size[1]],center=center);
                }
            }
        }
    }    

module tesselate(num=[1,1],size=[1,1],padding=[0,0],type="square"){
    //Tesselate acts on a child object, and tesselates it, in a sqaure, triagular or hexagonal array.
    //num is [the number of objects in x, the number of objects in y]
    //size is [the size of each "cell" in x, the size of each "cell" in y]
    //padding is how much should be subtracted from the "cell" size to get the object size. This is absolute, not proportional, i.e. padding of .1 means each object is 0.1mm smaller than the cell, not 10% or 90% the size of the cell.
    //type is the type of array. There are exactly 3 types of regular polyhedron tesselations, square (normal graph paper), hexagonal (hex tiles, e.g. Civilization 5, or bricks in "running bond"), and triangular (this particular code uses a 180 degree rotation in z instead of a reflection in the xz-plane
    index = (type=="h"||type=="hex"||type=="hexagon"||type=="hexagonal")     ? 1 :
            (type=="t"||type=="tri"||type=="triangle"||type=="triangular")   ? 2 : 0;//index converts the text of type into a numbered index. I didn't want to slow down computation time by having if statements or conditionals, so I calculate transforamtions for all 3, make an array of them, and then use index to pick the appropriate one.
    sq=[[1,0],[0,1]]; hex=[[1,0],[.5,.75]]; tri=[[.5,0],[0,1]]; //These are the unit vectors for each of the array types.
    Map=[sq,hex,tri][index]; 
    for(j=[0:num[1]-1]) //Iterate in y
        for(i=[0:num[0]-1]){ //Iterate in x
            translation=[(i+.5)*Map[0]*size[0]+(j+.5)*Map[1]*size[1],[(i+.5)*(size[0]*Map[0][0])+Map[1][0]*size[0]*(j%2),(j+.5)*(size[1]*Map[1][1])],(i+.5)*Map[0]*size[0]+(j+.5)*Map[1]*size[1]][index]; //What is the vector that describes the position of each object in the array?
            rot=[0,0,180*((i+j)%2)][index]; //Only triangular arrays need a rotation
            translate(translation) 
                rotate(rot) 
                    resize(size-padding)  
                        children();
            }
    }

module tesselation_hinge(num=[1,1],size=[1,1],padding=[0,0],type="square"){
    //Tesselation hinge takes the difference of a square(size) and a tesselate(). 
    //size as used in this function is the size of the hinge, not the size of each object (like in tesselate()) the size of the objects are dynamically adjusted based on num and padding, and of course, the size of the hinge.
    //num, padding and type have all the same meanings as they do in tesselate().
    index = (type=="h"||type=="hex"||type=="hexagon"||type=="hexagonal")     ? 1 :
            (type=="t"||type=="tri"||type=="triangle"||type=="triangular")   ? 2 : 0;
    sq=[[1,0],[0,1]]; hex=[[1,0],[.5,.75]]; tri=[[.5,0],[0,1]];
    Map=[sq,hex,tri][index];
    //These parameters need to be re-declared because when calling tesselate(), the size of each object needs to be recalculated based on the size of each cell. These parameters must be the same in both functions.
    difference(){
        square(size);
        tesselate(num=num,size=[size[0]/num[0]/Map[0][0],size[1]/num[1]/Map[1][1]],padding=padding,type=type)
            children();
        } 
    }    
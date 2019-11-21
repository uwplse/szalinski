//Living Hinge
//Ari M Diacou
//Metis Industries
//August 2016

//Thanks to Ronaldo Persiano for the inspiration for add_hinge()

///////////////////////////// Parameters /////////////////////////////////////
//The y dimension of the hinge, parallel to the laser cuts
length=30;
//The x dimension of the hinge, transverse to laser cuts
width=40;
//The distance between parallel laser cuts
d=6;
//The distance between 2 collinear laser cuts
hinge_length=3;
//The number of hinges across the length of the hinge
hinges_across_length=1;
//How thick do you want the hinge to be
height=5;
///////////////////////////////// Main() //////////////////////////////////////
//preview[view:north, tilt:top]
linear_extrude(height) hinge(length=length,width=width,d=d,minimum_thinness=.01,hinge_length=hinge_length,hinges_across_length=hinges_across_length);
////Uncomment lines to see samples (all flat for DXF exporting)
//hinge();
//hinge(d=6);
//hinge(length=20, width=39,d=6,hinge_length=2.5,hinges_across_length=2,minimum_thinness=3);
//hinge(length=30, width=20,d=2,hinge_length=2.5,hinges_across_length=2,minimum_thinness=3,center=true);
//hinge(length=20, width=40,d=3,hinge_length=4,hinges_across_length=0,minimum_thinness=1);
//linear_extrude(height=5) hinge(length=20, width=40,d=6,hinge_length=2.5,hinges_across_length=2,minimum_thinness=3);
//add_hinge(width=20,length=length,center=true) square([3*length,length-1],center=true);
//add_hinge(width=20,length=90) translate([5,0]) circle(d=90);
//add_hinge(width=30,length=90,hinges_across_length=3) circle(d=90);
//add_hinge(width=30,length=90,hinges_across_length=3,center=false) circle(d=90);
//add_hinge(width=30,length=90,hinges_across_length=3,minimum_thinness=.1) circle(d=90);

/////////////////////////////// Functions /////////////////////////////////////
module hinge(length=30,width=20,d=3,minimum_thinness=3,hinge_length=3,hinges_across_length=2,center=false){
    //length = the y dimension of the hinge, parallel to the laser cuts
    //width = the x dimension of the hinge, transverse to laser cuts
    //d=the distance between parallel laser cuts
    //What is the minimum distance that two parallel lines can be apart before the laser does something catastrophic? E.g. setting uncontrollable fire to the work piece. This is "minimum_thinness"
    //hinge_length=the distance between 2 colinear laser cuts
    //hinges_across_length=the number of hinges across the length of the hinge
    //center is a boolean value, if true, place the center of the rectangle at the origin, if false, put the bottom left corner at the origin (just like square() and cube())
    ep=.00101;//epsilon, a small number,=1.01 micron, a hack (for OpenSCAD 2015.03) used to make square()'s which look like lines (which OpenSCAD doesn't support). Hopefully, your laser has a function which says something like "ignore cuts less than THRESHOLD apart", set that to anything greater than ep.
    adjust=center?-[width,length]/2:[0,0];//a vector for adjusting the center position
    th=d/2<minimum_thinness?ep:d/2;//If the distance between lines is less than the minimum thickness, just make linear cuts, specifically, set the width=th=thickness of the squares to ep, which is just above 1 micron (for 1=1mm slicers)
    n=floor(width/d);
    m=floor(abs(hinges_across_length)); echo(str("Number of hinges (m)=",m)); //input cleaning, ensures m ϵ {non-negative integers}
    echo(str("Suggested filename: Living Hinge-",length,"x",width,"mm-h=",m,"x",hinge_length,"-th=",th));
    echo(str("The distance between parallel laser cuts (d) is: ",d," mm."));
    //the length of the short lines
    short=(length-m*hinge_length)/(m+1);
    //the length of the long lines
    long=(length-(m+1)*hinge_length)/(m);
    echo(str("There should be n=",n," links in the hinge."));
    translate(adjust) difference(){ 
        square([width,length],center=false);
        if(m==0) 
            //In the special case where |hinges_across_length|<1, the hinge should look like:
            // |  --------------------------------------|
            // |--------------------------------------  |
            // |  --------------------------------------|
            // |--------------------------------------  |
                for(i=[0:n])
                    translate([i*d,(pow(-1,i))*hinge_length]) // (-1)^i,{iϵZ} = {-1,+1,-1,+1,...}
                        square([th,length]);                
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
    
module add_hinge(length=30,width=20,d=3,minimum_thinness=3,hinge_length=3,hinges_across_length=2,center=true){
    //add_hinge() modifies another 2D object, by adding a hinge which is centered on the origin (by default, this can be changed to false, so that the bottom left corner of the hinge is at the origin. It uses the same parameters as hinge(). 
    //First, difference() a rectangle the size of the hinge from the child object (makes a hole for the hinge
    //Second, union() a hinge with First (puts the hinge in the hole)
    //Third, intersection() the child object with Second (cuts off any extra hinge that sticks out past the child object)
    intersection(){
        children();
        union(){
            hinge(length=length,width=width,d=d,minimum_thinness=minimum_thinness,hinge_length=hinge_length,hinges_across_length=hinges_across_length,center=center);
            difference(){
                children();
                square([width,length],center=center);
                }
            }
        }
    }    

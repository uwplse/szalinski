//Select an STL part to generate. 
part = "all"; // [cards,coins,cointop,all]

//The space around things to make them slide and not stick when put together
wiggle=.5;

//Show logo?
logo=true;

//Set to 0 to remove the holes to render and maybe print faster
do_holes_for_coins=0; //[0,1]

//Set to 0 to remove the holes to render and maybe print faster
do_holes_for_cards=1; //[0,1]

//set to avoid cutting off the corners
cornercutoff="onlyMiddle"; //["all_cutoff","onlyMiddle","none"]

/* [Hidden] */
$fn=50;

box_w=121;
box_h=170;
box_depth=37-2; //papers on top: 2mm
dice=16+2*wiggle;
coin=20.5;
coin_5_thick=11;
wall=1;
    
//to see into the coin holder
cut_to_see=false;

/*
Machi Koro storage
Version H, February 2015
Written by MC Geisler (mcgenki at gmail dot com)

This file defines a card box and a coin/dice holder for the  game 'Machi Koro'. 

Have fun!

License: Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0)
You are free to:
    Share - copy and redistribute the material in any medium or format
    Adapt - remix, transform, and build upon the material
Under the following terms:
    Attribution - You must give appropriate credit, provide a link to the license, and indicate if changes were made. 
    You may do so in any reasonable manner, but not in any way that suggests the licensor endorses you or your use.
    NonCommercial - You may not use the material for commercial purposes.
    ShareAlike - If you remix, transform, or build upon the material, you must distribute your contributions under the same license as the original. 
*/

//cards
width=59+wiggle; //59.5+wiggle; //printed: 21 - 20.7 -> 98,6%
length=91+2*wiggle; //printed: 43 - 42.65
corner=1.5; //2.5 -> 3
//coins
//coin_width_complete=(box_w-dice-3*wiggle); //23.5
coin_width_complete=(box_w-2*wiggle); //23.5
//coin_width=96/3; //23.5
coin_width=coin_width_complete/3;
coin_length=74; //46.5
coin_corner=3; //Eigentlich groesser

height=box_depth-wiggle;;

//two sizes as array to select them
//type = 0,1,2
w_arr=[width, coin_width];
l_arr=[length,coin_length];
c_arr=[corner,coin_corner];
h_arr=[height,height];

//box
wall=1.5; //Wall thickness

echo ("gamebox_w=",box_w," container_w=", 2*width+1*wall);
echo ("gamebox_w=",box_w," dice plus coincontainer_w=", coin_width_complete+2*wiggle);
echo ("gamebox_h=",box_h," container_h=", length+2*wall+coin_length+wiggle);
echo ("gamebox_depth=",box_depth," container_depth=", height+wiggle);

//breite derzeit: w_arr[type]*2+wall-.05 
//= width*2+wall-.05
//= (59.5+wiggle) *2 + wall -0.05

numholes=5;
numholespm=numholes/2-.5;
holedist=1.25; //hole distance in percent
hole=length/holedist/numholes/sqrt(2)*.9; //hole side length in mm

//corner cutoff: "corner_diag_in" diagonal length to cut in
module cutofftoken(w,l,h,corner_diag_in)
{
	cutoff=(w>l?w:l);
	cutoffdistzero = 1/(2*sqrt(2))*(w+l) + cutoff/2 ;
	//cutoffdist=cutoffdistzero-corner/sqrt(2);
	cutoffdist=cutoffdistzero-corner_diag_in;

	rotate([0,0,45])
	{
		translate([cutoffdist,0,0])
			cube([cutoff,cutoff,h], center=true);
		translate([-cutoffdist,0,0])
			cube([cutoff,cutoff,h], center=true);
		translate([0,cutoffdist,0])
			cube([cutoff,cutoff,h], center=true);
		translate([0,-cutoffdist,0])
			cube([cutoff,cutoff,h], center=true);
	}
}

//a pile of cards
module token(w,l,h,corner)
{
	difference()
	{
		cube([w,l,h], center=true);
		cutofftoken(w,l,h,corner/sqrt(2));
	}
}

module holerow(n1,n2)
{
	if (do_holes_for_cards!=0)
	{
		for(i=[n1:n2])
			translate([0,i*hole*sqrt(2)*holedist,0])
				rotate([0,0,45])
					cube([hole,hole,wall*4],center=true);
	}
}


module holearea(numrows,columns)
{
	for (i=[0:numrows-1])
	{
		assign (even = (i/2==floor(i/2)?1:0) )
			translate([i*hole*sqrt(2)*holedist/2,even*hole*sqrt(2)*holedist/2,0])
				holerow(-floor(columns/2-.5),(1-even)+floor(columns/2)-1);
	}
}

function corner_diag_in_Outside(wall,corner) = (sqrt(2)-1)*wall+corner/sqrt(2);
//a chamfered box without holes
module genericbox(w,l,hh,corner)
{
	difference()
	{
		cube([w+2*wall,l+2*wall,hh], center=true);

		//cutout the token storage
		translate([0,0,wall])
			token(w,l,hh,corner);

		//cutoff corners
		cutofftoken(w+2*wall,l+2*wall,hh+2,corner_diag_in_Outside(wall,corner));
	}		
}

//a token box
takeoutscale=1;
function stackheight(type)=(h_arr[type]);//stack plus bottom wall
module box(wall, type, num)
{
	w = w_arr[type];
	l = l_arr[type];
	h = stackheight(type);
	corner = c_arr[type];
	

	mirror([0,1,0])
            translate([w/2,l/2+wall,h/2]) //the w/2 works only if the last box is wider
		genericbox(w,l,h,corner);
}


//side holes
module sideholes(wall, type, side)
{
	w = w_arr[type];
	l = l_arr[type];
        h = stackheight(type);
	takeoutwidth=w-corner*2;

	mirror([0,side=="front"?1:0,0])
		translate([w/2,l/2+wall/2,0]) //the w/2 works only if the last box is wider
		{
				//cutout holes in the bottom to print faster
				translate([-2*hole*sqrt(2)*holedist/2,0,wall/2])
					holearea(5,5);
                    
				//lowest hole bigger
				if(type!=1)
                                {
                                    translate([0,3*hole*holedist+hole/sqrt(2)*4,h/2])
					rotate([0,0,45])
                                            cube([hole*4,hole*4,h+1],center=true);
                                }

				//cutout holes in the sides to print faster
				translate([0,-hole*sqrt(2)*holedist/2*0,hole*sqrt(2)/2+2*wall])
				{
					//side holes should cut only once - as the last compartment is bigger and they wouldnt match

					translate([-w/2,0,0])
                                            rotate([0,-90,0])
                                                holearea(2+(h_arr[type]>15?1:0),(type==0?5:3));

					translate([w/2,0,0])
                                            rotate([0,-90,0])
                                                holearea(2+(h_arr[type]>15?1:0),(type==0?5:3));
				}
		}
}

//several boxes
module boxes(number,type)
{
    intersection()
    {
            difference()
            {
                //boxes
                union()
                {
                        for (x = [0:number-1])
                        {
                                translate([x*(w_arr[type]+wall),0,0])
                                {
                                        box(wall,type,x);
                                }
                        }
                }
                
                //cut corner holders
                mirror([0,1,0]) 
                {
                    translate([w_arr[type]*1.5,l_arr[type]-wall,wall])
                        cube([w_arr[type]/2+5,4*wall,stackheight(type)*2]);
                    translate([0-1,l_arr[type]-wall,wall])
                        cube([w_arr[type]/2+5,4*wall,stackheight(type)*2]);
                }
                
                //cut holes
                union()
                {
                        for (x = [0:number-1])
                        {
                                translate([x*(w_arr[type]+wall),0,0])
                                {					
                                        sideholes(wall, type, "front");
                                }
                        }
                }
            }       
            
            //cut left and right side, as they are provided by the original game box (to save space)
            mirror([0,1,0])
                translate([.025,0,0])
                    cube([w_arr[type]*2+wall-.05,l_arr[type]+2*wall,stackheight(type)]);
    }
}



//-------------------------------

if (part=="cards" || part=="all")
{
    boxes(2,0);
}   

//-------------------------------

coin_dist=9.3;
coin_rotate=15;

logodepth=2;
scalelogo=.5;
module logo(dologo)
{
    if (dologo==true)
    {//logo
        translate([0,0,-logodepth])
            linear_extrude(height = logodepth*2+2, center = false, convexity = 10)
                import (file = "machikorologo.dxf", scale=scalelogo);
    }
}

//in the german first edition there are 72 token coins!)
//coin10=10
//coin5=12
//coin1=50;
txt_arr=        ["1","1","5","10"];
numcoinslots=   [25, 25, 12, 10];
module verticalcoins(numcoins,str,adder)
{
    numslots=round(numcoins/5);
    restcoins=numcoins%5;
    remainder=(restcoins==0?0:restcoins+.25);
    max=5;
    
    for(y = [max-(numslots-1):max+(remainder!=0?1:0)])
        translate([(y%2==0?coin_dist/2:0)+coin/2+5,
                    y*coin_5_thick+19-(y>max?coin_5_thick*(5-remainder)/5+.01:0)-(remainder!=0?coin_5_thick*remainder/5:0),0])
        {
                rotate([90,0,0])
                    translate([0,0,-adder])
                        cylinder(r=(coin+wiggle)/2+adder,h=(y>max?coin_5_thick*remainder/5:coin_5_thick)+2*adder);
    
                if (y==max && adder==0)
                {
                    translate([-.5+(str=="10"?-3:0),6+(remainder!=0?coin_5_thick*remainder/5:0),0])
                        linear_extrude(height = 3, center = true, convexity = 10, twist = 0)
                            text(str,size=6,font="PTF NORDIC Rnd",valign="center");
                }
        }
}


module takeoutcut(theight, takeout, takeoutscale, type)
{
    //takeoutscale=.4;

    rotate([0,0,45])
        linear_extrude(height = theight, scale=takeoutscale, center = false, convexity = 10)
            if (type=="square")
                square([takeout,takeout],center=true);
            else
                circle(r=takeout,center=true);
}

module coins_and_dice(adder)
{
    for(x = [0:3])
    {    
        translate([x*(coin+coin_dist)-2,0,0])
        {
            //verticalcoins(1,(x>1?3:6));
            verticalcoins(numcoinslots[x],txt_arr[x],adder);
            if (x==3)
            {
                //the 2 dice slot
                translate([dice*0.2,24,0])
                    cube([dice*2+2*adder,dice+2*adder,dice+2*adder],center=true);
            }
            
            if (adder>=wall)
            {
                //verticalrods
                verticalrod=1.5*coin;
                
                translate([coin-wall/2,24,0])
                    cube([wall,verticalrod,coin]);
            }
        }
    } 
  
    if (adder>=wall)
    {
         translate([coin*.5+5,19,0])
         {
            translate([0,.5*coin_5_thick,0])
                cube([3*(coin+coin_dist),wall,coin]);
            translate([0,4.3*coin_5_thick,0])
                cube([3*(coin+coin_dist),wall,coin]);
         }
    }
}


module coinholder(cornercutoff,dologo)
{
    intersection()
    {
        difference()
        {
            //straight up cube for cutting the general shape
            cube([coin_width_complete,coin_length,150]);
                        
            if (cornercutoff!="none")
            {
                //cut corners and in the middle, to easily take out the coin holder from the box later
                translate([0,coin_length,-.1])
                {
                    if(cornercutoff!="onlyMiddle")
                    {
                        for (i=[0,0.5,1])
                            translate([coin_width_complete*i,0,0])
                                takeoutcut(30,35,.4,"square"); 
                    
                        if(cornercutoff!="onlyMiddle")
                            for (i=[0,0.5,1])
                                translate([coin_width_complete*i,-coin_length,0])
                                    takeoutcut(12,30,.4,"square");     
                    }
                    else
                    {
                        for (i=[0.5])
                            translate([coin_width_complete*i,0,0])
                                takeoutcut(30,20,.53,"circle");  
                    }
               }
           }
        }
        
        //rotated coin holder
        translate([0,0,-32])
            rotate([coin_rotate,0,0])
                difference()
                {
                    //basic rotated shape
                    translate([0,10.7,0])
                        cube([coin_width_complete,coin_length*2,40]);

                    //coin slots
                    translate([0,0,40])
                    {
                        coins_and_dice(0);

                        //the logo
                        translate([75-2,33.5,0])
                            logo(dologo);
                    }
                    
                    //three holes in the base
                    if (do_holes_for_coins!=0)
                    {
                        //save material
                        translate([-1,0,0])
                            rotate([45-coin_rotate,0,0])
                            {
                                translate([0,70,-23])
                                        cube([coin_width_complete+2,10,10]);
                                translate([0,61,-14])
                                        cube([coin_width_complete+2,7.5,7.5]);
                                translate([0,54,-7])
                                        cube([coin_width_complete+2,5.5,5.5]);
                            }
                        }
                }
   }
}


module coinholdertop()
{
    additionalWiggle=0.4;
    
    intersection()
    {
        difference()
        {     
            //bigger holder
            union()
            {
                coins_and_dice(additionalWiggle+wall);   
                
                linear_extrude(height = wall, center = true)
                    offset(r = wall*1) 
                        projection(cut = true)
                            coins_and_dice(additionalWiggle+wall);    
            }
            
            //cutout coins
            #coins_and_dice(additionalWiggle);

            //cutoff bottom
            translate([2,10.7,-40])
                cube([coin_width_complete,coin_length*2,40]);
        }

        cube([box_w,box_h,(dice+2*wall)/2]);
    }
    
}

if (part=="coins" || part=="all")
{
    translate([0,-coin_length-(l_arr[0]+2.5*wall),0])
        difference()
        {
            coinholder(cornercutoff,logo);
            
            //to look into the coin holder for debugging purposes
            if (cut_to_see==true)
                translate([40,0,0]) cube(80);
        }
}

if (part=="all")
{
    translate([0,-coin_length-(l_arr[0]+2.5*wall),0])
        translate([0,0,-32])
            rotate([coin_rotate,0,0])
                translate([0,0,40]) 
                    coinholdertop();
    
    //show the german machi koro box 
    //%translate([0,-box_h,0]) 
    //    machikorobox();

}
if (part=="cointop")
{
     rotate([0,180,0])
        coinholdertop();
}

module machikorobox()
{
    cube([box_w,box_h,box_depth]);
}




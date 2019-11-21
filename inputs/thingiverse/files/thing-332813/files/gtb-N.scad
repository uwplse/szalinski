//Select an STL part to generate. 
part = "all"; // [one,two,three,stick,all,stick,printstick,lid, SmallBoxLid, all_SmallBox,print_SmallBoxStick]

//The space around things to make them slide and not stick when put together
wiggle=.25;

//Height of the stacked boxes
totalheight=65;

//Turn on debug to remove the holes in the bottom box to render faster
debug=0; //[0,1]

/* [Hidden] */
//stick="active"; 

/*
Galaxy trucker token storage
Version N, November 2017
Written by MC Geisler (mcgenki at gmail dot com)

This file defines 3 boxes and a central stick for the board game 'Galaxy Trucker'. It holds all credits, energy stones, start ship pieces, astronauts and cargo for the game including all extensions (the special edition).

Now there is also a SmallBox available after popular request...

Sorry for the use of German for variable names.
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

use<write/Write.scad> 

//positive credits
width=21.8+2*wiggle; //printed: 21 - 20.7 -> 98,6%
length=43.5+2*wiggle; //printed: 43 - 42.65
corner=3; //2.5 -> 3
thickness=1.7;     //1.7 -> height 21+1+wall: 37.6 ; 
					  //34.5/21=1.64286 -> height 21+1+wall: 37.6 ; 
					  //32/20   -> height 21+1+wall: 36.7
//echo ("thickness:",32/20);
echo ("thickness:",thickness);

//negative credits
neg_width=24.5+2*wiggle; //23.5
neg_length=47.5+2*wiggle; //46.5
neg_corner=3; //Eigentlich groesser

//two sizes as array to select them
w_arr=[width,neg_width];
l_arr=[length,neg_length];
c_arr=[corner,neg_corner];


//0		1c 		13+5+3		21
//1,2	2c		18+8+3		29 * make it two boxes: 15&14
//3		5c		12+4+3		19
//4,5	10c		18+6+5		29 * make it two boxes
//6		50c		4+1+5		10
//7		-12c	12			12
//counters=[21, 15,15, 19, 15,15, 10, 12];
//counters=[21, 21,21, 21, 21,21, 21, 21];
counters=[21, 15,15, 21, 15,15, 15, 15];
type	 =[ 0,  0, 0,  0,  0, 0,  0,  1];
cent	 =[ 1,  2, 2,  5, 10,10, 50,-12];  

//box
wall=1.5; //Wall thickness
height=20;
num_boxes=len(counters);

//inside
// 110 x 95 x 62(depth) / with box: 32

function stackheight(x)=(counters[x]+1)*thickness+wall;//stack plus bottom wall
echo ("Length: ",width*(num_boxes/2-1)+neg_width+wall*(num_boxes/2+1)); 
echo ("Width: ",length+neg_length+wall*(num_boxes/2+1)); 
echo ("Height 21+1: ",stackheight(0)-wall); 
echo ("Height 21+1 incl bottom wall: ",stackheight(0)); 
echo ("Height 15+1 incl bottom wall: ",stackheight(1)); 
echo ("Height first lid: ",stackheight(0)-stackheight(1)); 


numholes=5;
numholespm=numholes/2-.5;
holedist=1.25; //hole distance in percent
hole=length/holedist/numholes/sqrt(2); //hole side length in mm

//-----------------------------
fontfilename="orbitron.dxf";
//fontfilename="Letters.dxf";


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

//a pile of tokens
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
	if (debug!=1)
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
takeoutscale=.985;
function takeoutdistance(l,corner)=l/2*takeoutscale+corner-wall*5/2;
module box(wall, x, side)
{
	w = w_arr[type[x]];
	l = l_arr[type[x]];
	h = stackheight(x);
	corner = c_arr[type[x]];
	
	echo ("Box ",x, " Thick: ",h); 

	takeoutdistance=l/2*takeoutscale+corner-wall;

	mirror([0,side=="front"?1:0,0])
		translate([w/2,l/2+wall/2,h/2]) //the w/2 works only if the last box is wider
			difference()
			{
				genericbox(w,l,h,corner);
		
				//takeout slit
				translate([0,takeoutdistance(l,corner)+2*wall,0])
					cube([2*w,wall*4,h+1],center=true);
			}
}

//a number
module numbering(wall, x, side)
{
	w = w_arr[type[x]];
	l = l_arr[type[x]];
	h_min = stackheight(x)-wall;

	mirror([0,side=="front"?1:0,0])
		translate([w/2,wall/2,h_min/2+h_min/3]) //the w/2 works only if the last box is wider
			writecube(str(cent[x]),[0,0,0],0,face=side, t=wall-.4, h=w/4,space=6, rotate=0, font=fontfilename);
}

//side holes
module sideholes(wall, x, side)
{
	w = w_arr[type[x]];
	l = l_arr[type[x]];
	takeoutwidth=w-corner*2;

	mirror([0,side=="front"?1:0,0])
		translate([w/2,l/2+wall/2,0]) //the w/2 works only if the last box is wider
		{
				//cutout holes in the bottom to print faster
				translate([-hole*sqrt(2)*holedist/2,0,wall/2])
					holearea(3,5);
				//lowest hole bigger
				translate([0,2*hole*sqrt(2)*holedist+hole/sqrt(2)*3,wall/2])
					rotate([0,0,45])
						cube([hole*4,hole*4,wall*4],center=true);




				//cutout holes in the sides to print faster
				translate([0,-hole*sqrt(2)*holedist/2,hole*sqrt(2)/2+2*wall])
				{
					//side holes should cut only once - as the last compartment is bigger and they wouldnt match
					if (x != 7) 
						translate([-w/2,0,0])
							rotate([0,-90,0])
								holearea(4+(counters[x]>15?2:0),4);

					translate([w/2,0,0])
						rotate([0,-90,0])
							holearea(4+(counters[x]>15?2:0),4);
				}
		}
}

//several boxes
module boxes(number)
{
	difference()
	{
		union()
		{
			for (x = [0:number/2-1])
			{
				translate([x*(width+wall),0,0])
				{
					box(wall,x,"front");
					box(wall,x+number/2,"back");
				}
			}
		}

		union()
		{
			for (x = [0:number/2-1])
			{
				translate([x*(width+wall),0,0])
				{					
					numbering(wall, x, "front");
					numbering(wall, x+number/2, "back");
					sideholes(wall, x, "front");
					sideholes(wall, x+number/2, "back");	
				}
			}

			stick(wiggle);
		}
	}
}

distance=.4;

//box as lid
big_h = (counters[0]-counters[1])*thickness;
big_width = width*(num_boxes/2-1) + neg_width + wall*(num_boxes/2+1-2);
big_length = takeoutdistance(length,corner)*2;//-wall-distance+wall+distance; //length-wall-distance;
mid_width = width*2 - wall - 2*distance;
mid_length = takeoutdistance(length,corner)*2+wall;//length+wall+distance;
module lid_box()
{
	bottomheight=stackheight(1);

	echo ("1st Box height: ",big_h); 
	
	difference()
	{
		union()
		{
			translate([0,0,bottomheight])
			{
				translate([big_width/2,big_length/2+wall+wall/2+distance,big_h/2])
					genericbox(big_width,big_length,big_h,corner);
	
				mirror([0,1,0])
					translate([mid_width/2+width+2*wall+distance,mid_length/2-wall/2-distance,big_h/2])
						genericbox(mid_width,mid_length,big_h,corner);

				stickholder(big_h,stickw+wiggle+stickwiggle);
				stickpyramid(stickpyramidheight,stickw+wiggle+stickwiggle);
			}
		}

		stick(wiggle+stickwiggle);

		translate([0,0,bottomheight-2*wall])
			stickpyramid(stickpyramidheight,stickw+wiggle+stickwiggle);
		//cube(100);
	}
}

//second box as lid
module lid_2nd_box()
{
	bottomheight2=stackheight(0);
	all_height=totalheight-bottomheight2;
	all_width=takeoutdistance(length,corner)*2;
	all_length=width*(num_boxes/2)+wall*(num_boxes/2-1);

	echo ("2nd Box height: ",all_height); 

	difference()
	{
		union()
		{
			translate([0,0,bottomheight2])
			{
				//translate([big_width/2,(all_width+wall+distance)/2+wall/2,all_height/2])
				//	genericbox(big_width,(all_width+wall+distance),all_height,corner);
				translate([big_width/2,(all_width+wall)/2+wall/2,all_height/2])
					genericbox(big_width,(all_width+wall),all_height,corner);
	
				mirror([0,1,0])
					translate([all_length/2,all_width/2+wall/2,all_height/2])
						genericbox(all_length,all_width,all_height,corner);

				stickholder(all_height/2,stickw+wiggle+stickwiggle);
				stickpyramid(stickpyramidheight,stickw+wiggle+stickwiggle);
			}
		}

		stick(wiggle+stickwiggle);
		translate([0,0,bottomheight2-2*wall])
						stickpyramid(stickpyramidheight,stickw+wiggle+stickwiggle);

	}
}



module lid_for_everything()
{
	bottomheight2=stackheight(0);
	all_height=totalheight-bottomheight2;
	all_width=takeoutdistance(length,corner)*2;
	all_length=width*(num_boxes/2)+wall*(num_boxes/2-1);

	//echo ("2nd Box height: ",all_height); 

rotate([180,0,0])
	difference()
	{
		union()
		{
			translate([0,0,bottomheight2+wall])
			{
                //the plate for the lid
				translate([big_width/2,(all_width+wall)/2+wall/2,wall/2])
					genericbox(big_width,(all_width+wall),wall,corner);
	
				mirror([0,1,0])
					translate([all_length/2,all_width/2+wall/2,wall/2])
						genericbox(all_length,all_width,wall,corner);

                inwards=2*(wall+0.3);
                
                //to make a rim
                translate([0,0,wall])
                    mirror([0,0,1])
                    {
                        translate([big_width/2,(all_width+wall)/2+wall/2,wall*2/2])
                            genericbox(big_width-inwards,(all_width+wall)-inwards,wall*2,corner);
            
                        mirror([0,1,0])
                            translate([all_length/2,all_width/2+wall/2,wall*2/2])
                                genericbox(all_length-inwards,all_width-inwards,wall*2,corner);
                    }
			}
		}

		stick(wiggle+stickwiggle);
        translate([0,0,bottomheight2-2*wall])
						stickpyramid(stickpyramidheight,stickw+wiggle+stickwiggle);

	}
}



module lid_for_bottom()
{
	bottomheight2=stackheight(0);
	all_height=totalheight-bottomheight2;
	all_width=takeoutdistance(length,corner)*2;
	all_length=width*(num_boxes/2)+wall*(num_boxes/2-1);

	//echo ("2nd Box height: ",all_height); 

rotate([180,0,0])
	difference()
	{
		union()
		{
			translate([0,0,bottomheight2+wall])
			{
                //the plate for the lid
				translate([big_width/2,(all_width+wall)/2+wall/2,wall/2])
					genericbox(big_width,(all_width+wall),wall,corner);
	
				mirror([0,1,0])
					translate([all_length/2,all_width/2+wall/2,wall/2])
						genericbox(all_length,all_width,wall,corner);

                inwards=2*(wall+0.3);
                
                //to make a rim
                translate([0,0,wall])
                    mirror([0,0,1])
                    {
                        //lid: bigger part
                        translate([big_width/2,big_length/2+wall+wall/2+distance,wall*2/2])
                            genericbox(big_width-inwards,big_length-inwards,wall*2,corner);

                        *union()
                        {
                            for (x = [0,3])
                            {
                                translate([x*(width+wall),0,0])
                                {
                                    box(wall,x,"front");
                                    box(wall,x+number/2,"back");
                                }
                            }
                        }
          
                        mirror([0,1,0])
                            translate([mid_width/2+width+2*wall+distance,mid_length/2-wall/2-distance,wall*2/2])
                                genericbox(mid_width-inwards,mid_length-inwards,wall*2,corner);
                        

                    }	
			}
		}

		sticklength( (stickw+wiggle+stickwiggle)/2+wiggle , 40);
        stick (wiggle+stickwiggle);
        


	}
}


//stickw=2.6;
//stickw=2*(corner-wall/sqrt(2))/sqrt(2);
stickw = ( corner_diag_in_Outside(wall,corner) - sqrt(2)*(wall/2) )*2;
echo ("Stick Width: ",stickw); 
stickh=totalheight-1*0;
sticklockh=stackheight(1)/2; //(counters[1]+1)*thickness/2;
stickwiggle=1*wiggle;
//stick
module sticklength(adder, length)
{
	color("red")
		translate([(width*2+wall*2)-wall/2,0,-.1])
			rotate([0,0,45])
				
				{
					translate([0,0,length/2+wiggle])
						cube([stickw+2*adder,stickw+2*adder,length+wiggle*2],center=true);
					translate([0,0,sticklockh/2+adder/2])
						cube([stickw+2*adder+2*wall,stickw+2*adder,sticklockh+adder],center=true);
				}
}

module stick(adder)
{
    sticklength(adder, stickh);
}


//holder around stick
module stickholder(height,stickw)
{
	translate([(width*2+wall*2)-wall/2,0,0])
	{
		rotate([0,0,45])
			translate([0,0,height/2])
				cube([stickw+wall*2,stickw+wall*2,height],center=true);
		//cylinder(r1=(stickw+wall*2)*1.3,r2=(stickw+wall*2)/2,h=5,$fn=4);
	}
}

//pyramid around stick
stickpyramidheight=7;
module stickpyramid(height,stickw)
{
	translate([(width*2+wall*2)-wall/2,0,0])
		cylinder(r1=(stickw+wall*2)*1.3,r2=0,h=height,$fn=4);
}

//-------------------------------

if (part=="one" || part=="all" || part=="all_SmallBox")
	boxes(num_boxes);

if (part=="two" || part=="all" || part=="all_SmallBox")
	translate([0,0,distance])
		lid_box();

if (part=="three" || part=="all" )
    translate([0,0,2*distance])
		lid_2nd_box();


if (part=="lid" || part=="all" )
    translate([0,-100,42])
        lid_for_everything();

if (part=="SmallBoxLid" || part=="all_SmallBox")
    translate([0,-100,42])
        lid_for_bottom();


if (part=="stick" || part=="all" || stick=="active")
stick(0);

if (part=="printstick")
rotate([90,45,0]) stick(0);

if (part=="Bottom_stick" || part=="all_SmallBox" || stick=="active")
sticklength(0, 38.9+wall);

if (part=="print_SmallBoxStick")
rotate([90,45,0]) sticklength(0, 38.9+wall);
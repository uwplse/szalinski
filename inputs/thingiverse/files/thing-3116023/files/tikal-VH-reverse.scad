//todo: map noch anpassen!

//Select an STL part to generate. "Upgrade_xx" are replacements for the little square components. "Map_x" go on the hexagonal big map tiles. For counts of each component, refer to the instructions.
part = "temple_exploded"; // [oneprint,temple,templecut,upgrades,maps,Upgrade_02,Upgrade_03,Upgrade_04,Upgrade_05,Upgrade_06,Upgrade_07,Upgrade_08,Upgrade_09,Upgrade_10,Map_1,Map_2,Map_3,Map_4,Map_5,Map_6,upgrades_print1,upgrades_print2]

//part = "Map_6"; 

//in Millimeters
piece_height=4.5; 

//in Millimeters
piece_width=45;

//in Millimeters
piece_depth=40;

//Shrinkage from one piece to the next higher one
shrink_factor=.07;

//Steps of the staircase per piece
stairs_per_piece=3;

small_corner=.92;

large_corner=.85;

//front staircase width
stair_width_percent=.3;

/* [Hidden] */

//Todo: Flip over large temples

/*
Temple pieces for the board game Tikal
Version H, September 2018
Written by MC Geisler (mcgenki at gmail dot com)

This file defines 10 different temple pieces for the board game Tikal.  Each piece locks into the respective 
piece below it for stability. When your temple reaches level 10, it will be a complete Mayan temple.

Beside the functions to print single temple layer pieces and several temple layers in one block, there are 
several layouts of pieces for you to choose from:
- temple=1 defines a complete temple in one block
- tempelcut=1 will show a complete temple with a cutout to see the inner structure
- oneprint=1 contains all 10 pieces needed for a single temple. Print it to test the pieces. Note that you 
need much more pieces to play Tikal.
- upgrades=1 will show the complete set of upgrade pieces needed for the game Tikal
- maps=1 will show the complete set of map pieces needed. Both the temples on the board and the temples 
on the hexagonal land pieces are taken into account. You can use these map pieces so that all temples of
the same level are of the same height. During the game, whenever a hexagon with a temple is put down, 
select the corresponding map piece and put it into place.
- upgrades_print1=1, upgrades_print2=1, maps are fitting each to a Prusa MK3 printing area. 
Together they are all the map and upgrade pieces you need for one Tikal game.

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

use <write/Write.scad> 

//fontfilename="orbitron.dxf";
//fontfilename="BlackRose.dxf";
//fontfilename="knewave.dxf";
fontfilename="Letters.dxf";


startstufe=1;
endstufe=10;
anzahlstufen=endstufe-startstufe;// minus one as the last piece is without a step



tempelhoehe=piece_height*1.4;
tempelgroesse=.95;
dach1groesse=tempelgroesse*1.1;
dach2groesse= dach1groesse*.8;
dach3groesse= dach2groesse*.8;
dach4groesse= dach3groesse*.8;
tempeltiefe=.4;

shrinkabsolut=shrink_factor*piece_width;

rand=shrinkabsolut*1.5;

treppenhoehe=piece_height/stairs_per_piece;
treppentiefe=piece_depth/(anzahlstufen*stairs_per_piece)*.56;//the amount to subtract
treppeRaus=piece_depth/2*1.5;

	
druckabstand=1;
interlockdistance=.83; //.64 is too small! its not easily locking...; 1 was too big -> .83

//----------------------------------
// temple pieces
//----------------------------------

function piece_widthjetzt(i) = piece_width-(i-startstufe)*shrinkabsolut;
function piece_widthtotal(i) =  (piece_width-(i/2-startstufe)*shrinkabsolut+druckabstand)*(i-startstufe); //aufsummiert
function piece_depthjetzt(i) = piece_depth-(i-startstufe)*shrinkabsolut;
function piece_depthjetztincltreppe(i) = piece_depthjetzt(i)/2+ treppeRaus-treppentiefe*((i-startstufe)*stairs_per_piece+0) ;
function piece_depthjetztincltreppetotal(i) =   ( piece_depth/2-(i/2-startstufe)*shrinkabsolut/2+ treppeRaus-treppentiefe*(i/2-startstufe)*stairs_per_piece +druckabstand) * (i-startstufe); //aufsummiert

module interlock(i,adder)
{
//	do_interlock(piece_widthjetzt(i),piece_depthjetzt(i),adder, (i==9?1:0) );
	do_interlock(piece_widthjetzt(i),piece_depthjetzt(i),adder, 0);
}

module ebene(i,do_post,do_lock,do_up,do_writeonside)
{	
	do_ebene(i,piece_widthjetzt(i),piece_depthjetzt(i),do_post,do_lock,do_up,do_writeonside);
}

module do_interlock(piece_widthjetzt,piece_depthjetzt,adder, full)
{
	interlockwidth=1.5;
	interlocktiefeproz=.65; //.5
	interlockdist=piece_widthjetzt*.65; //.5
	interlockheight=piece_height/2;
	
	if (full==0)
	{
		translate([interlockdist/2,0,0]) 
			cube([interlockwidth+adder,piece_depthjetzt*interlocktiefeproz+adder,interlockheight+adder],center=true);
		translate([-interlockdist/2,0,0]) 
			cube([interlockwidth+adder,piece_depthjetzt*interlocktiefeproz+adder,interlockheight+adder],center=true);
	}
	else
	{
		cube([interlockdist+interlockwidth+adder,piece_depthjetzt*interlocktiefeproz+adder,interlockheight+adder],center=true);
	}

}

module do_floor(piece_widthjetzt,piece_depthjetzt)
{
	union()
	{
		square ([piece_widthjetzt*small_corner,piece_depthjetzt*small_corner],center = true);
		square ([piece_widthjetzt*large_corner,piece_depthjetzt],center = true);
		square ([piece_widthjetzt,piece_depthjetzt*large_corner],center = true);
		translate([0,-1,0])
			square ([piece_widthjetzt*.6,piece_depthjetzt],center = true);
	}
}

tapering=.2*0;
topcutback=-3.1;

//do_post: post down 
//do_lock: carve out on top and writing on top
module do_ebene(i=startstufe,piece_widthjetzt,piece_depthjetzt,do_post,do_lock,do_up,do_writeonside)
{
	//main block
	//rotate([(do_up==0 && i==10)?-90:0,(do_up==0 && i!=10)?180:0,0])
	difference()
	{
		union()
		{
			if (i<10)
			{

				//main cube, taper the bottom
				mirror([0,0,1])
					translate([0,0,piece_height/2-piece_height*tapering/2])
						linear_extrude(height = piece_height*tapering, center = true, scale=(1-0.1*(tapering)))
						{
							do_floor(piece_widthjetzt,piece_depthjetzt);
						}
				//main cube
				translate([0,0,+piece_height/2-piece_height*(1-tapering)/2])
					{
                        linear_extrude(height = piece_height*(1-tapering), center = true, scale=(1-0.05*(1-tapering)))
                        {
                            do_floor(piece_widthjetzt,piece_depthjetzt);
                            
                        }

                    }
                //square ([piece_widthjetzt*large_corner,piece_depthjetzt],center = true);
                    
				//treppe
				translate([0,.025,0])
					for ( j = [0:stairs_per_piece-1]) 
					{
						assign (treppentiefejetzt = treppeRaus-treppentiefe*((i-startstufe)*stairs_per_piece+j)  )
						{
							translate([0,
									-treppentiefejetzt/2,
									j*treppenhoehe-(piece_height/2-treppenhoehe/2)])
								cube([piece_widthjetzt*stair_width_percent,
									treppentiefejetzt,
									treppenhoehe],center=true);
						}
					}
				
				//posts out on top
				if (do_post) //i>1 && to be checked. Needed???????????
				{ 
					translate([0,0,piece_height/2-.1])
					{
						 interlock(i,0);
					}
				}
			}
			else
			{
				//top temple
				
				//translate([0,(do_up==0 && i==10)?topcutback:0,0])
				{
					//if (do_lock)
					//{
					//	translate([0,0,-piece_height/2-.1])
					//	{
					//		 interlock(i,0);
					//	}
					//}

					assign (tempeltiefejetzt = piece_depthjetzt*tempeltiefe)				
					translate([0,0,-piece_height/2+tempelhoehe/2])
					{
						//1. gerader quader
						difference()
						{	
							cube ([piece_widthjetzt*tempelgroesse,piece_depthjetzt*tempelgroesse,tempelhoehe],center = true);
							translate([0,-piece_depthjetzt*tempelgroesse/2,tempelhoehe*.1])
								cube([piece_widthjetzt*tempelgroesse/5,piece_depthjetzt*tempelgroesse,tempelhoehe*.8],center=true);
						}
						
						//dach 1
						translate([0,0,tempelhoehe/2+piece_height/2])
						{
							linear_extrude(height = piece_height, center = true, scale=.95)
								square ([piece_widthjetzt*dach1groesse,piece_depthjetzt*dach1groesse],center = true);
								
							//dach 2
							translate([0,tempeltiefejetzt*dach2groesse,piece_height/2+piece_height/2])
							{
								linear_extrude(height = piece_height, center = true, scale=.9)
									square ([piece_widthjetzt*dach2groesse,tempeltiefejetzt*dach2groesse],center = true);
								
								//dach 3
								translate([0,tempeltiefejetzt*(dach2groesse*.9-dach3groesse)/2,piece_height/2+piece_height/2])
								{
									linear_extrude(height = piece_height, center = true, scale=.9)
										square ([piece_widthjetzt*dach3groesse,tempeltiefejetzt*dach3groesse],center = true);
									
									//dach 4
									translate([0,tempeltiefejetzt*(dach3groesse-dach4groesse)/2,piece_height/2+piece_height/2])
										cube([piece_widthjetzt*dach4groesse,tempeltiefejetzt*dach4groesse*.85,piece_height],center = true);
								}

							}
						}
					}
				}
			}
		}
		
		//if (i<10 && do_lock)
		if (i>1 && do_lock)
		{
			//locks for the posts
			translate([0,0,-piece_height/2+.1])
			{
				 interlock(i-1,interlockdistance);
			}
		}
		
		//text
		if (i!=10 && do_post)
		{
			translate([0,0,piece_height/5]) 
				writecube(str(11-i),[0,0,piece_height/4],0,face="top", t=piece_height*.5,h=8,space=6, rotate=0, font=fontfilename);
            
        }
  		if (i!=11 && do_writeonside)
		{      
            //write on the side
           translate([0,piece_depthjetzt/2,(i==10?1:0)])
                //cylinder(r=2,h=1,center=true);//########################################
                rotate([80,0,180])
                    writecube(str(11-i),[0,0,0],0,face="top", t=piece_height*.5,h=piece_height-.5,space=6, rotate=0, font=fontfilename);

           translate([piece_widthjetzt/2,0,(i==10?1:0)])
                rotate([80,0,90])
                    writecube(str(11-i),[0,0,0],0,face="top", t=piece_height*.5,h=piece_height-.5,space=6, rotate=0, font=fontfilename);

           translate([-piece_widthjetzt/2,0,(i==10?1:0)])
                rotate([80,0,-90])
                    writecube(str(11-i),[0,0,0],0,face="top", t=piece_height*.5,h=piece_height-.5,space=6, rotate=0, font=fontfilename);


		}
		
		if (i==10 && do_writeonside)
		{
			//translate([0,-1.5+((do_up==0 && i==10)?topcutback:0),tempelhoehe+piece_height/5]) 
//			translate([0,-1.5,tempelhoehe+piece_height/5]) 
//				writecube(str(11-i),[0,0,piece_height/4],0,face="top", t=piece_height*.5,h=6,space=6, rotate=0, font=fontfilename);

			//translate([0,-1.5*0,tempelhoehe+piece_height/5]) 
				//writecube(str(11-i),[0,0,piece_height/4],0,face="top", t=piece_height*.5,h=6,space=6, rotate=0, font=fontfilename);
						
			//if (i==10)
			//translate([0,10/2+piece_depthjetzt*tempelgroesse*0-topcutback*1.7258+((do_up==0 && i==10)?topcutback:0),piece_widthjetzt/2])
			//	cube([piece_widthjetzt*2,10,piece_widthjetzt*2],center=true);
		}
	}
	
}

module templeupsidedown(height)
{
	//translate([0,0,(height-startstufe)*piece_height])
		//rotate([0,180,0])
			temple(height);
}

module temple(height,shiftup=0)
{
	for (i = [startstufe:height]) 
	{
		translate([0,0,(height-i)*(piece_height+shiftup)])
			ebene(11-i,0,(i==height),1,(height==10?1:(i==height?1:0)));
	}
}

//----------------------------------
// board game pieces
//----------------------------------

hexmapradius=82/2;

module octogon(type)
{
	if (type=="map")
	{
		cylinder(r=hexmapradius,h=1,$fn=6);
	}
	if (type=="small")
	{
		cylinder(r=11/2,h=10,$fn=6);
	}
	if (type=="large")
	{
		cylinder(r=12/2,h=15,$fn=6);
	}
}

module worker(shiftup)
{
	//small worker
	translate([hexmapradius*.75,0,0])
		octogon("small");
		
	//large workder
	translate([-hexmapradius*.75,0,0])
		octogon("large");
	
	//large worker on top
	translate([0,-3,piece_height*(endstufe+1)+shiftup])
		octogon("large");
}

//----------------------------------


//For Makerbot2 print area
//28.5 L x 15.3 W x 15.5 H cm
printareatotalwidth=285;
printareatotaldepth=153;
printsafe=10;
printareawidth=printareatotalwidth-printsafe;
printareadepth=printareatotaldepth-printsafe;

oneprint_start=1;
oneprint_stop=10;


//----------------------------------
// Model options
//----------------------------------

if (part=="Upgrade_02") ebene(2,1,1,0,1);	
if (part=="Upgrade_03") ebene(3,1,1,0,1);	
if (part=="Upgrade_04") ebene(4,1,1,0,1);	
if (part=="Upgrade_05") ebene(5,1,1,0,1);	
if (part=="Upgrade_06") ebene(6,1,1,0,1);	
if (part=="Upgrade_07") ebene(7,1,1,0,1);	
if (part=="Upgrade_08") ebene(8,1,1,0,1);	
if (part=="Upgrade_09") ebene(9,1,1,0,1);	
if (part=="Upgrade_10") ebene(10,1,1,0,1);	
if (part=="Map_1") templeupsidedown(1);
if (part=="Map_2") templeupsidedown(2);
if (part=="Map_3") templeupsidedown(3);
if (part=="Map_4") templeupsidedown(4);
if (part=="Map_5") templeupsidedown(5);
if (part=="Map_6") templeupsidedown(6);



if (part=="temple")
{
	//ground map
	octogon("map");
	
	translate([0,0,1])
	{
		worker(2);
		
		//temple
		translate([0,0,piece_height/2])
			temple(endstufe);

	}
}

if (part=="temple_exploded")
{
	//ground map
	octogon("map");
	
	translate([0,0,1])
	{
		worker(85);
		
		//temple
		translate([0,0,piece_height/2])
            for (i = [startstufe:endstufe]) 
            {
                translate([0,0,(endstufe-i)*(piece_height+8)])
                    ebene(11-i,1,1,1,1);
            }

	}
}


if (part=="templecut")
{
	//ground map
	%octogon("map");
	
	translate([0,0,1])
	{
		worker();
		
		difference()
		{
			//temple
			for (i = [startstufe:endstufe]) 
			{
				translate([0,0,(i-startstufe)*(piece_height+.1)+piece_height/2])
					ebene(i,1,1,1,1);
			}
			rotate([0,0,180])
                cube(50);
		}
	}
}

if (part=="upgrades")
{
	//to the left quadrant
	//translate([piece_widthjetzt(2)/2,-piece_depthjetztincltreppe(2)/2,piece_height/2])
	translate([-(piece_widthjetzt(5)+druckabstand)*11,-piece_depthjetztincltreppe(2)/2,piece_height/2])
	{	//rows
		for (i = [2:endstufe]) 
		{	//columns
			translate([0,piece_depthjetztincltreppetotal(11-i),0])
			{
				//Number of upgrade layers (for layer 1: on map/map cards)
				for (reihe = [0:lookup(i, [
									//[ 1, 3 ], //only this is on the board / on one card...
									[ 2, 3 ],
									[ 3, 6 ],
									[ 4, 9 ],
									[ 5, 11 ],
									[ 6, 8],
									[ 7, 5 ],
									[ 8, 3 ],
									[ 9, 2 ],
									[ 10, 1 ]
								])
									-1])	
				{
					{	//move
						translate([(piece_widthjetzt(11-i)+druckabstand)*reihe,0,0]) 
                            ebene(11-i,1,1,0,1);
					}
				}
			}
		}
	}
	//Printarea
	%translate([0,0,-1]) 
        cube([printareawidth,printareadepth,1]);
}

if (part=="upgrades_print1")
{
	//assign (from = , distance = i*10, r = i*2)
	//to the first quadrant
	translate([piece_widthjetzt(2)/2,-5*piece_depthjetztincltreppe(4),piece_height/2])
	{	//rows
		for (i = [2:4]) 
		{	//columns
			translate([0,piece_depthjetztincltreppetotal(11-i),0])
			{
				//Number of upgrade layers (for layer 1: on map/map cards)
				for (reihe = [0:lookup(i, [
									//[ 1, 3 ], //only this is on the board / on one card...
									[ 2, 3 ], //add two of part 4!
									[ 3, 6 ],
									[ 4, 9 ], //two missing
								])
									-1])	
				{
					{	//move
						translate([(piece_widthjetzt(11-i)+druckabstand)*reihe,0,0]) 
						if (i==4 && reihe > 4)
						{
							translate([-130,-30,0])
                                ebene(11-i,1,1,0,1);
						}
						else
						{
							ebene(11-i,1,1,0,1);		
						}
					}
				}
			}
		}
	}
	//Printarea
	%translate([0,0,-1]) cube([printareawidth,printareadepth,1]);
}

if (part=="upgrades_print2")
{
	translate([0,printareatotaldepth*0,0])
	{
		//to the first quadrant
		translate([piece_widthjetzt(11-2)/2,-piece_depthjetztincltreppetotal(11-5)+piece_depthjetztincltreppe(11-2)/2,piece_height/2])
		{	//rows
			for (i = [5:10]) 
			{	//columns
				translate([0,piece_depthjetztincltreppetotal(11-i),0])
				{
					//Number of upgrade layers (for layer 1: on map/map cards)
					for (reihe = [0:lookup(i, [
										//[ 1, 3 ], //only this is on the board / on one card...
										[ 5, 11 ], 
										[ 6, 8],
										[ 7, 5 ], 
										[ 8, 3 ], 
										[ 9, 2 ],
										[ 10, 1 ],
									])
										-1])	
					{
						{	//move
							translate([(piece_widthjetzt(11-i)+druckabstand)*reihe,0,0]) 
							if ((i==5 && reihe>6) || (i==6 && reihe>6))
							{
									translate([-97,-115,0])
										ebene(11-i,1,1,0,1);	
							}
							else
							{
                                if (i==10)
                                {
                                        translate([180,60,0])
                                            ebene(11-i,1,1,0,1);	
                                }
                                else
                                {
                                            ebene(11-i,1,1,0,1);		
                                }	
							}
						}
					}
				}
			}
		}
		//Printarea
		%translate([0,0,-1]) cube([printareawidth,printareadepth,1]);
	}
}

if (part=="maps")
{
	translate([-piece_widthjetzt(1)*7,piece_depthjetztincltreppe(1)*2,0])
		for (i = [startstufe:6]) 
		{
			translate([(piece_widthjetzt(5)+druckabstand)*i,0,piece_height/2])
			{
				//Numbers on map cards 
				for (reihe = [0:lookup(i, [
									[ 1, 3 ], 
									[ 2, 3 ],
									[ 3, 4 ],
									[ 4, 3 ],
									[ 5, 3 ],
									[ 6, 1]
								])
									-1])	
				{
					translate([0,(piece_depthjetztincltreppe(5)+druckabstand)*reihe,0])
						templeupsidedown(i);
				}
			}
		}

	//Printarea
	//%cube([printareawidth,printareadepth,1],center=true);
}

druckabstandadder=3;

if (part=="oneprint")
{
	translate([-piece_widthjetzt(1)*1.5,piece_depthjetztincltreppe(1)/2,0])
	{
		for (i = [oneprint_start:oneprint_stop]) 
		{
			translate([piece_widthtotal(i)-(i<5?0:piece_widthtotal(5)-piece_widthjetzt(4)/2*0+piece_widthjetzt(5)/2*0),-(piece_depthjetztincltreppe(1)+druckabstand)*(i>4?1:0),piece_height/2])
			{
					ebene(i,1,1,0,1);

				//large workder
				%translate([0,-3,piece_height/2+1*(i==endstufe?tempelhoehe:0)])
					//rotate([(i<10?0:-90),0,(i<10?30:0)])
						octogon("large");
                
			}
		}
	}
	//Printarea
//	%translate([0,0,-.5])
//		cube([printareawidth,printareadepth,1],center=true);
}

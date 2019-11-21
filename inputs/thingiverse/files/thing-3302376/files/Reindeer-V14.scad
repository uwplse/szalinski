//Select type of render. All the exact values below "Randomize_polygon_count" are only working if you select here "configurable_reindeer". 
type="random_reindeer"; //[configurable_reindeer,random_reindeer,4_random_reindeers,9_random_reindeers,16_random_reindeers,25_random_reindeers]

//For "random_reindeer..." above: You can randomize the polygon count from reindeer to reindeer. Select 1 here.
Randomize_polygon_count=1; //[0, 1]

//If you set "0" above for Randomize_polygon_count: You can set here a fixed polygon count. 12 is low-poly, 30 is OK to print in most cases
Fixed_polygon_count=30; //30



//radius head
r_head=5;

//length head
l_head=12; 

//lift of the head -> r_head*.7;
lift_head=5.6;

//neck length
up_neck=20; 

//radius body
r_body=9; 

//length body
l_body=18;

//leg radius at bottom
r_leg=5; 

//length legs
l_leg=28; 

//legs to the outside -> l_leg/3
out_leg=6;

//length feet -> 
r_hoof=6.5;

//radius tail
r_tail=3;

//length tail
l_tail=15; 

//position of the eye
pos_eye=.3;

//radius of the eye
r_eye=3;

//nose radius
nose_r=1.6;

//position of the antler
pos_antler=0;

//Do you need a hole in the hat to use reindeer as Christmas tree decoration? Then specify the radius here. 1.5mm radius (3mm hole diameter) is OK. If it is zero, there will be no hole. (Thanks for CaptInsano for the idea!)
Hole_r=1; 

//should we have a base?
PrintBase=0; //[0, 1]

//Base size and grid distance. Typically 72x33 should be optimal for random reindeers in a grid. To save space and hope neighbouring reindeers are not both very big, distance is less, 60x30.
basex=75; 
basey=60;
//Thickness of the base
basethick=4;
    
    
/* [Antler Parameters] */

//depth of recursion (warning: each iteration will take exponentially more time to process)
number_of_iterations = 3; // [1:10]

//starting height of the first branch
antler_height = 11; //[1:100]

//how much the antler curves outwards
antler_rnd_out = 0;

//control the amount of taper on each branch segment
width_ratio_bottom = 0.25; 

//control the amount of taper on each branch segment
width_ratio_top = 0.21;

//size of the "knuckles" between segments
knuckle_size = 0.21; 

//minimum size ratio of a new branch to its parent
min_rate_of_growth = 0.85; //[0.05:1.0]

//maximum size ratio of a new branch to its parent
max_rate_of_growth = 1.20; //[1.0:5.0]

//antler angle out
antler_angle=18;

//specific antler to choose from, any integer number
antler_seed = 0;
    
/* [Hidden] */
//-------------------------------------------------------------------------------
/*
Configurable reindeer pack
Version 11, December 2018
Written by MC Geisler (mcgenki at gmail dot com)

You need configurable reindeers? You have configurable reindeers. Either one or nine, you decide.
Use it to create mini or big reindeer sculptures!

Have fun!

This uses parts from:
 "Customizable Fractal Tree" By steveweber314 5/12/2015
 https://www.thingiverse.com/thing:1595362 
 Creative Commons - Attribution license
 "This builds a tree using a recursive algorithm. For more information, please visit the Instructable, at http://www.instructables.com/id/Procedurally-Generated-Trees/"

License: Attribution 4.0 International (CC BY 4.0)

You are free to:
    Share - copy and redistribute the material in any medium or format
    Adapt - remix, transform, and build upon the material
    for any purpose, even commercially.
*/


//------------------------------------------
minpoly=4;
maxpoly=35;

module antler(size, depth, seed,antler_rnd_out)
{
    //automatically stop if the size gets too small so we dont waste computation time on tiny little twigs
    translate([0,0,size*.8])
        rotate([0,50,0])
            trunk(size*.8, depth-1, seed,antler_rnd_out);
    rotate([0,-5,0])
        trunk(size, depth, seed,antler_rnd_out);
}

module trunk(size, depth, seed,antler_rnd_out)
{
    //automatically stop if the size gets too small so we dont waste computation time on tiny little twigs
    if (size > 5)
    {
        branch(size*.9, depth, seed+2, antler_rnd_out);          
    }
}
module branch(size, depth, seed, antler_rnd_out)
{
    rots=7 ; //randomness of antler
    sizemod = rands(min_rate_of_growth,max_rate_of_growth,10, seed+1);
	rotations = rands(-rots/2,rots,10, seed+3);
    rot_backforward=10;
    
	cylinder(h = size, r1 = size*width_ratio_bottom, r2 = size*width_ratio_top);

	translate([0,0,size])
	{
		if (depth > 0) 
		{
            union() 
            {
                sphere(size*knuckle_size);
                rotate([antler_rnd_out+rotations[0],rot_backforward+rotations[1],0+rotations[2]])
                {
                    trunk(size*.9*sizemod[0], depth-1, seed+2);
                }
                rotate([antler_rnd_out+rotations[3],rot_backforward+rotations[4],180+rotations[5]])
                {
                    trunk(size*.9*sizemod[1], depth-1, seed+3);
                }
            }   
		}
		else
		{
            sphere(size*knuckle_size);
		}
	}
    
}

module reindeer(r_head,l_head,lift_head,up_neck,r_body,l_body,r_leg,l_leg,out_leg,r_hoof,r_tail,l_tail,pos_eye,r_eye,antler_seed,antler_angle,pos_antler,antler_height,antler_rnd_out,nose_r)
{
    r_neck=r_head;
	forward_neck=15;
	straight_neck=.4;

    back_body = [-l_body/2,0,0, r_body];
    front_body = [l_body/2,0,0, r_body];
    Body = [back_body,front_body];
    
    NooseFactor=1.1;
    rNoose=r_head*NooseFactor;
    back_head = [l_body/2+forward_neck,0,up_neck,r_head*1.5];
    front_head = [l_body/2+forward_neck+l_head,0,up_neck+lift_head,r_head];
    front_noose = [l_body/2+forward_neck+l_head,0,up_neck+lift_head,rNoose];
    Head = [back_head, front_head, front_noose];

    //NoseHoleX=.3;
    //NoseHoleZ=.4;
    //NoseNegL = [l_body/2+forward_neck+l_head+rNoose*NoseHoleX, -rNoose*1.1, up_neck+lift_head+rNoose*NoseHoleZ,1]; 
    //NoseNegR = [l_body/2+forward_neck+l_head+rNoose*NoseHoleX,  rNoose*1.1, up_neck+lift_head+rNoose*NoseHoleZ,1]; 
    //NoseHoleNeg =[NoseNegL,NoseNegR];
    
    angle_head=atan(lift_head/l_head)*2;
    //echo(angle_head);
    nose_pos_x=l_head+r_head;
    nose0 = [l_body/2+forward_neck+l_head+r_head*NooseFactor*cos(angle_head),0,up_neck+lift_head+r_head*NooseFactor*sin(angle_head), nose_r];
    Nose = [nose0,nose0];

    //neck
    neck_high_shift=.5+straight_neck/2;
    mid_neck_high = [l_body/2+forward_neck*neck_high_shift,0,up_neck*neck_high_shift, r_neck];
    Neck = [front_body,mid_neck_high,back_head];
    
    EyeR0 = [l_body/2+forward_neck+pos_eye*l_head,  r_head*1,  up_neck+r_head*1.1+lift_head*pos_eye-r_eye,   r_eye];
    EyeL0 = [l_body/2+forward_neck+pos_eye*l_head, -r_head*1,  up_neck+r_head*1.1+lift_head*pos_eye-r_eye,   r_eye];
    EyeL = [EyeL0, EyeL0];
    EyeR = [EyeR0, EyeR0];
    
    EyeNegL0 = [l_body/2+forward_neck+pos_eye*l_head, -r_head,  up_neck+r_head*1.1+lift_head*pos_eye-r_eye,   r_eye/2];
    EyeNegL1 = [l_body/2+forward_neck+pos_eye*l_head, -r_head*3,  up_neck+r_head*1.1+lift_head*pos_eye-r_eye+r_eye,   r_eye/2];
    EyeNegR0 = [l_body/2+forward_neck+pos_eye*l_head,  r_head,  up_neck+r_head*1.1+lift_head*pos_eye-r_eye,   r_eye/2];
    EyeNegR1 = [l_body/2+forward_neck+pos_eye*l_head,  r_head*3,  up_neck+r_head*1.1+lift_head*pos_eye-r_eye+r_eye,   r_eye/2];
    EyeNegL = [EyeNegL0, EyeNegL1];
    EyeNegR = [EyeNegR0, EyeNegR1];

    AntlerR0 = [l_body/2+forward_neck+pos_antler*l_head,r_eye*.7,up_neck,r_eye];
    AntlerL0 = [l_body/2+forward_neck+pos_antler*l_head,-1*r_eye*.7,up_neck,r_eye];
    AntlerL = [AntlerL0, AntlerL0];
    AntlerR = [AntlerR0, AntlerR0];
    
    r_mid_tail_percent=1.3;
	tail_mid_percent=.65;
	tail_low_percent=.25;
    //tail_end = [-l_body/2-l_tail,0,l_tail,r_tail];
    tail_upper = [-l_body/2-l_tail*(tail_low_percent+tail_mid_percent)/2,0,l_tail*tail_mid_percent,r_tail];
    tail_lower = [-l_body/2-l_tail*tail_low_percent,0,l_tail*tail_low_percent,r_tail*r_mid_tail_percent];
    Tail = [tail_upper, tail_lower, back_body];
  
    //cutoffposition
    angle_hoof=45;
    hoof_delta_z2=r_hoof*cos(angle_hoof); 
    hoof_width_at_45_point=r_hoof*sin(angle_hoof); 
    hoof_delta_z1=(hoof_width_at_45_point-r_leg)*tan(angle_hoof);
    cutoffcube_Z=l_leg+hoof_delta_z1+hoof_delta_z2;  
    hoof_z=-cutoffcube_Z;
    
  	leg_mid_percent=.3;

    leg_x=l_body/2+out_leg;
    leg_mid_x=l_body/2+out_leg*leg_mid_percent;
    
    leg_y=(r_body-r_leg)+out_leg;
    leg_mid_y=(r_body-r_leg)+out_leg*leg_mid_percent;
    
    hoof_F_x=leg_x+r_leg*.1;
    hoof_R_x=-leg_x*.98+r_leg*.1;
    
    
    //leg
    foot_tip_FR = [hoof_F_x,    -leg_y,    hoof_z,                r_hoof]; 
    leg_low_FR =  [leg_x,    -leg_y,    -l_leg,                 r_leg];
    leg_mid_FR =  [leg_mid_x,-leg_mid_y,-l_leg*leg_mid_percent, r_leg];
    LegFR =       [foot_tip_FR, leg_low_FR, leg_mid_FR, front_body];
  
    //leg
    foot_tip_FL = [hoof_F_x,    leg_y,     hoof_z,                r_hoof];
    leg_low_FL =  [leg_x,    leg_y,    -l_leg,                 r_leg];
    leg_mid_FL =  [leg_mid_x,leg_mid_y,-l_leg*leg_mid_percent, r_leg];
    LegFL =       [foot_tip_FL, leg_low_FL, leg_mid_FL, front_body];
  
    //leg
    foot_tip_BR = [hoof_R_x,    -leg_y,     hoof_z,                r_hoof];
    leg_low_BR =  [-leg_x,    -leg_y,    -l_leg,                 r_leg];
    leg_mid_BR =  [-leg_mid_x,-leg_mid_y,-l_leg*leg_mid_percent, r_leg];
    LegBR =       [foot_tip_BR, leg_low_BR, leg_mid_BR, back_body];
  
    //leg
    foot_tip_BL = [hoof_R_x,    leg_y,     hoof_z,                r_hoof];
    leg_low_BL =  [-leg_x,    leg_y,    -l_leg,                 r_leg];
    leg_mid_BL =  [-leg_mid_x,leg_mid_y,-l_leg*leg_mid_percent, r_leg];
    LegBL =       [foot_tip_BL, leg_low_BL, leg_mid_BL, back_body];
  
    //hole to hang reindeer into the christmas tree
    //check if Hole_r > 0
    Hole_negative = (Hole_r == 0? 0 : 1);
    Hole_length = r_body*(Hole_r == 0? 0 : 1)*2;
    Hole_excenter=.7*r_body;
    Hole0 = [l_body/2, -Hole_length, r_body, Hole_r]; 
    Hole1 = [l_body/2, 0,            Hole_excenter, Hole_r]; 
    Hole2 = [l_body/2, Hole_length,  r_body, Hole_r]; 
    Hole = [Hole0,Hole1,Hole2];

    
        Part_arr=[Body,Head,Neck,EyeL,EyeR,Tail,LegFR,LegFL,LegBR,LegBL, AntlerL, AntlerR,Nose,EyeNegL,EyeNegR,Hole];       
    PartCut_arr= [0,   0,   0,   0,   0,   0,   0,    0,    0,    0,     0,       0,     ,0   ,0      ,0      ,0];         
    PartNeg_arr= [0,   0,   0,   0,   0,   0,   0,    0,    0,    0,     0,       0,     ,0   ,1      ,1      , Hole_negative];         
    rZ=10;//Headrotation;
    RotatePart=  [0,   0,   0,   0,   0,   0,   0,    0,    0 ,   0,antler_angle,-antler_angle,  ,0   ,0      ,0      ,0 ];      
    Donut_r_arr= [0,   0,   0,   0,   0,   0,   0,    0,    0,    0,     0,       0,     ,0   ,0      ,0      ,0 ];
    Anlter_arr = [0,   0,   0,   0,   0,   0,   0,    0,    0,    0,     1,       -1,    ,0   ,0      ,0      ,0 ];
    //all
    max_body_overall=l_head+forward_neck+l_body+out_leg+l_tail+r_head+r_tail;
    //echo(max_body_overall);
 
	module sphere_cube_posR(i,j,do,deltaradius) //[x,y,z,radius],do,deltaradius
	{
        Sphere_arr = Part_arr[i];
        PosR_arr=Sphere_arr[j];
        //echo("sphere --",PosR_arr[0],PosR_arr[1],PosR_arr[2],"radius=",PosR_arr[3]);
		
        rotate([0,0,RotatePart[i]])
        {
            translate([PosR_arr[0],PosR_arr[1],PosR_arr[2]])
            {
                if (do=="sphere")
                {
                    if (Donut_r_arr[i]==0)
                    {
                        sphere(r=PosR_arr[3]+deltaradius,center=true);
                    }
                    else
                    {
                        //do donut
                        rotate_extrude(convexity = 7)
                            translate([Donut_r_arr[i], 0, 0])
                                circle(r = PosR_arr[3]+deltaradius);//, $fn = 100);
                    }
                }
                else
                {
                    cut=(PosR_arr[3]+deltaradius)*2;
                    
                    translate([-cut/2,-cut,-cut/2])
                        cube(cut);
                }
            }
        }
	}
    
	module sphere_posR(i,j,half,deltaradius) //x,y,z,radius
	{
		if (half!=1)
        {
            sphere_cube_posR(i,j,"sphere",deltaradius);
        }
        else
        {
            difference()
            {
                sphere_cube_posR(i,j,"sphere",deltaradius);
                sphere_cube_posR(i,j,"cube",deltaradius);
            }
        }
	}
    
    module hulls(i,half,deltaradius) //index
    {      
        //echo("part",i, " len=",len(Part_arr[i])-2);
        
        for(j_Sphere = [0:len(Part_arr[i])-2]) 
        {
            //echo("sphere",j_Sphere);
            hull()
            {                  
                sphere_posR(i,j_Sphere,half,deltaradius);
                sphere_posR(i,j_Sphere+1,half,deltaradius);
            }              
        }
    }
    
    translate([0,0,cutoffcube_Z])
        difference()
        {
            //echo("starting...");
            for(i_Part = [0:len(Part_arr)-1]) 
            {
                if(PartNeg_arr[i_Part]==0)
                {
                    if(PartCut_arr[i_Part]==0)
                    {
                        if(Anlter_arr[i_Part]==0)
                        {
                            //echo("part for",i_Part);
                            hulls(i_Part,0,0);
                        }
                        else
                        {
                            Sphere_arr = Part_arr[i_Part];
                            PosR_arr=Sphere_arr[0];
                            
                            translate([PosR_arr[0],PosR_arr[1],PosR_arr[2]])
                                rotate([RotatePart[i_Part],-20,0])
                                    scale([1,Anlter_arr[i_Part],1])
                                        antler(antler_height, number_of_iterations, antler_seed,antler_rnd_out);
                                
                        }  
                    }
                    else
                    {
                            difference()
                            {
                                //echo("part for",i_Part);
                                hulls(i_Part,1,0); //first 1 does only half of the hull
                                hulls(i_Part,0,PartCut_arr[i_Part]); //cut out inner ear by full hull
                            } 
                    }         
                }
            }
            
            //subtract the negatives
            for(i_Part = [0:len(Part_arr)-1]) 
            {
                if(PartNeg_arr[i_Part]!=0)
                hulls(i_Part,0,0);
            }
            
            //cutoff bottom
            translate([0,0,-cutoffcube_Z-max_body_overall/2])
                cube([max_body_overall,max_body_overall,max_body_overall],center=true);
        }



   
    if(PrintBase==1)
    {
            scalingx=(basex+2*basethick)/basex;
            scalingy=(basey+2*basethick)/basey;
            translate([0,0,-basethick/2])
                    scale([1,1,-1])
                        linear_extrude(height = basethick, center = true, scale=[scalingx,scalingy])
                            square([basex,basey],center=true);
            
            chamfer=1;
            goalx=(basex+2*basethick-chamfer);
            goaly=(basey+2*basethick-chamfer);
            chamferx=(basex+2*basethick)/goalx;
            chamfery=(basey+2*basethick)/goaly;
           
            translate([0,0,-basethick-chamfer/2])
                    linear_extrude(height = chamfer, center = true, scale=[chamferx,chamfery])
                        square([goalx,goaly],center=true);
    }
}

module random_reindeer()
{
	$fn= floor( Randomize_polygon_count == 1 ? rands(minpoly,maxpoly,1)[0] : Fixed_polygon_count); 
    
    r_head=rands(30,70,1)[0]/10; //5;
	l_head=rands(6,18,1)[0]; //12;
	lift_head=rands(6,12,1)[0]; //.7;
	up_neck=rands(10,30,1)[0]; //15
	r_body=rands(7,13,1)[0]; //9
	l_body=rands(7,20,1)[0]; //18
	r_leg=rands(8,12,1)[0]/2; //5
	l_leg=rands(15,35,1)[0]; //28
	out_leg=l_leg/6*rands(0,3,1)[0];
	r_hoof=r_leg+rands(7,25,1)[0]/10; //1.2
	r_tail=rands(3,6,1)[0]/2; //3
	l_tail=rands(13,19,1)[0]; //15
	pos_eye=rands(2,7,1)[0]/10; //.3;
	r_eye=rands(15,35,1)[0]/10; //2.5
    pos_antler=rands(0,2,1)[0]/10; //0;
    antler_seed = rands(0,1000,1)[0];
    antler_angle = rands(7,22,1)[0]; //18
    antler_height= rands(8,14,1)[0]; //11
    antler_rnd_out = rands(0,10,1)[0]/2; //0-5
    //Headrotation=rands(-35,35,1)[0];//0;
    nose_r=rands(12,40,1)[0]/10;//1.6 
        
	reindeer(r_head,l_head,lift_head,up_neck,r_body,l_body,r_leg,l_leg,out_leg,r_hoof,r_tail,l_tail,pos_eye,r_eye,antler_seed,antler_angle,pos_antler,antler_height,antler_rnd_out,nose_r);
}


module standard_reindeer()
{
    $fn= floor( Randomize_polygon_count == 1 ? rands(minpoly,maxpoly,1)[0] : Fixed_polygon_count); 
    
    reindeer(r_head,l_head,lift_head,up_neck,r_body,l_body,r_leg,l_leg,out_leg,r_hoof,r_tail,l_tail,pos_eye,r_eye,antler_seed,antler_angle,pos_antler,antler_height,antler_rnd_out,nose_r);
}

////---------------------------------------


module randomreindeers(xx,yy)
{
    for (x = [0:xx-1]) 
    {
        for (y = [0:yy-1]) 
        {
            translate([x*basex,y*basey,0])
                random_reindeer();
        }
    }
}

if (type=="4_random_reindeers")
{
    randomreindeers(2,2);
}

if (type=="9_random_reindeers")
{
    randomreindeers(3,3);
}

if (type=="16_random_reindeers")
{
    randomreindeers(4,4);
}

if (type=="25_random_reindeers")
{
    randomreindeers(5,5);
}

if (type=="configurable_reindeer")
{
    standard_reindeer();
}

if (type=="random_reindeer")
{
    random_reindeer();
}

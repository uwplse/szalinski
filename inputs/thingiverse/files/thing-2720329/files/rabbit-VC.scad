type="9_random_rabbits"; //[configurable_rabbit,random_rabbit, 9_random_rabbits,16_random_rabbits]

//cube([150,150,1]);
$fn=10;

//should we have a base?
PrintBase=false;

$fn=30;

basex=45;
basey=30;
basethick=4;
    
//sizes
body_r=20;
head_r=17;
body_to_head_length=.3;
body_len=40;
Headrotation=20;

leg_r=8;
leg_len=5;
leg_cutbottom=.5;
legoutpercent=.45;

ear_len=25;
earoutpercent=.45;
ear_r=7;
ear_wall=2;

arm_r=5;
arm_len=20;
arm_angle=30;
arm_front_Percent=.2;

eye_r=4.4;
eye_out_angle=40;
eyeHolepercent=.3;

mouth_r=10;
mouthangle=20;


/* [Hidden] */
//-------------------------------------------------------------------------------
/*
Configurable rabbit pack
Version C, March 2018
Written by MC Geisler (mcgenki at gmail dot com)

You need configurable rabbits? You have configurable rabbits. Either one or nine, you decide.
Use it to create mini or big rabbit sculptures!

Thanks to 'Treator' go out to for debugging!

Have fun!

License: Attribution 4.0 International (CC BY 4.0)

You are free to:
    Share - copy and redistribute the material in any medium or format
    Adapt - remix, transform, and build upon the material
    for any purpose, even commercially.
*/


//------------------------------------------


module rabbit(body_r,head_r,Headrotation,body_to_head_length,body_len,leg_r,leg_len,leg_cutbottom,legoutpercent,ear_len,earoutpercent,ear_r,ear_wall,arm_r,arm_len,arm_angle,arm_front_Percent,eye_r,eye_out_angle,eyeHolepercent,mouth_r,mouthangle)
{
    //echo("body_r",body_r,"head_r",head_r,body_to_head_length,"body_len",body_len,"leg_r",leg_r,leg_len,leg_cutbottom,legoutpercent,"ear_len",ear_len,earoutpercent,"ear_r",ear_r,arm_r,"arm_len",arm_len,arm_angle,arm_front_Percent,"eye_r",eye_r,eye_out_angle,eyeHolepercent,"mouth_r",mouth_r,"mouthangle",mouthangle);    
    // centers-x-y-z, radius
    legout=body_r*legoutpercent;
    leg_foot_bigger=1.1;
    leg_cutbottomshiftup=(1-leg_cutbottom)*leg_r*leg_foot_bigger;
    LegL0 = [legout, 0, leg_cutbottomshiftup, leg_r*leg_foot_bigger]; 
    LegL1 = [legout, 0, leg_cutbottomshiftup+leg_len, leg_r];

    LegR0 = [-legout, 0, leg_cutbottomshiftup, leg_r*leg_foot_bigger];
    LegR1 = [-legout, 0, leg_cutbottomshiftup+leg_len, leg_r];

    body_lower=leg_cutbottomshiftup+leg_len+body_r*.8;
    Body0 = [0, 0, body_lower, body_r];
    Body1 = [0, 0, body_lower+body_len*body_to_head_length, (body_r+head_r)/2*.7];
    Body2 = [0, 0, body_lower+body_len, head_r];

    body_upper=body_lower+body_len;
    //earoutpercent;
    
    ear0=head_r-ear_r*.7;
    ear1=ear0+ear_len;
    EarL0 = [-earoutpercent*ear0, 0, body_upper+ear0, ear_r*.7]; 
    EarL1 = [-earoutpercent*ear1, 0, body_upper+ear1, ear_r]; 
    EarR0 = [earoutpercent*ear0, 0, body_upper+ear0, ear_r*.7]; 
    EarR1 = [earoutpercent*ear1, 0, body_upper+ear1, ear_r]; 

    arm_out=arm_len+body_r;
    arm_z=sin(arm_angle)*arm_out;
    arm_x=cos(arm_angle)*arm_out;
    arm_front=arm_len*arm_front_Percent;
    ArmL0 = [0, arm_front, body_lower, arm_r*.7]; 
    ArmL1 = [-arm_x, -arm_front, body_lower+arm_z, arm_r]; 
    ArmR0 = [0, arm_front, body_lower, arm_r*.7]; 
    ArmR1 = [arm_x, -arm_front, body_lower+arm_z, arm_r]; 

    eye_x=sin(eye_out_angle)*head_r;
    eye_y=cos(eye_out_angle)*head_r;
    EyeL0 = [-eye_x,0,body_lower+body_len,eye_r]; 
    EyeL1 = [-eye_x,-eye_y,body_lower+body_len,eye_r]; 
    EyeR0 = [eye_x,0,body_lower+body_len,eye_r]; 
    EyeR1 = [eye_x,-eye_y,body_lower+body_len,eye_r]; 
    eyeHolepercent=.3;
    EyeNegL0 = [-eye_x,-eye_y,body_lower+body_len,eye_r*eyeHolepercent]; 
    EyeNegL1 = [-eye_x,-eye_y*2,body_lower+body_len,eye_r*eyeHolepercent]; 
    EyeNegR0 = [eye_x,-eye_y,body_lower+body_len,eye_r*eyeHolepercent]; 
    EyeNegR1 = [eye_x,-eye_y*2,body_lower+body_len,eye_r*eyeHolepercent]; 

    position_percent=1-head_r/body_len;//position where in the body the mouth should be in percent (should be at end of head)
    interpolated_y=position_percent*body_r+(1-position_percent)*head_r; //intermediate y between head and body
    mouthmain_y=-interpolated_y+mouth_r;
    mouthmain_z=body_lower+body_len-head_r;
    Mouth0 = [0,mouthmain_y,mouthmain_z,mouth_r]; 
    Mouth1 = [0,mouthmain_y,mouthmain_z,mouth_r]; 

    mouthline_r=1;
    mouth_x=sin(mouthangle)*mouth_r;
    mouth_y=cos(mouthangle)*mouth_r;
    mouth_x2=sin(mouthangle/2)*mouth_r;
    mouth_y2=cos(mouthangle/2)*mouth_r;
    mouth_z=mouthline_r*.5;
    mouth_z2=mouthline_r*.4;
    Mouthneg0 = [-mouth_x, mouthmain_y-mouth_y, mouthmain_z,mouthline_r]; 
    Mouthneg1 = [-mouth_x2,mouthmain_y-mouth_y2,mouthmain_z-mouth_z2,mouthline_r]; 
    Mouthneg2 = [0,        mouthmain_y-mouth_r, mouthmain_z-mouth_z,mouthline_r]; 
    Mouthneg3 = [ mouth_x2,mouthmain_y-mouth_y2,mouthmain_z-mouth_z2,mouthline_r]; 
    Mouthneg4 = [ mouth_x, mouthmain_y-mouth_y, mouthmain_z,mouthline_r]; 

    // lines
    LegL = [LegL0, LegL1, Body0];
    LegR = [LegR0, LegR1, Body0];
    Body = [Body0,Body1,Body2];
    EarL = [EarL0, EarL1];
    EarR = [EarR0, EarR1];
    ArmL = [ArmL0, ArmL1];
    ArmR = [ArmR0, ArmR1];
    EyeL = [EyeL0, EyeL1];
    EyeR = [EyeR0, EyeR1];
    EyeNegL = [EyeNegL0, EyeNegL1];
    EyeNegR = [EyeNegR0, EyeNegR1];
    Mouth = [Mouth0, Mouth1];
    MouthNeg = [Mouthneg0,Mouthneg1,Mouthneg2,Mouthneg3,Mouthneg4];

    Part_arr=   [LegL,LegR,Body,EarL,EarR,ArmL,ArmR,EyeL,EyeR,EyeNegL,EyeNegR,Mouth,MouthNeg];         
    PartCut_arr=[0,   0,   0,   -ear_wall,  -ear_wall,  0,   0,   0,   0,   0,      0,      0,    0];         
    PartNeg_arr=[0,   0,   0,    0,   0,  0,   0,   0,   0,   1,      1,      0,    1];         
    rZ=Headrotation;
    RotatePart= [0,   0,   0,   rZ,  rZ,  0,   0,  rZ,  rZ,  rZ,     rZ,     rZ,   rZ];         
    //all
    max_body_overall=body_r+body_lower+leg_len+leg_r;

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
                    sphere(r=PosR_arr[3]+deltaradius,center=true);
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
    
    difference()
    {
        //echo("starting...");
        for(i_Part = [0:len(Part_arr)-1]) 
        {
            if(PartNeg_arr[i_Part]==0)
            {

                if(PartCut_arr[i_Part]==0)
                {
                        //echo("part for",i_Part);
                        hulls(i_Part,0,0);
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
        translate([0,0,-max_body_overall/2])
            cube([max_body_overall,max_body_overall,max_body_overall],center=true);
    }



   
    if(PrintBase==true)
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



//
module random_rabbit()
{
    body_r=rands(5,15,1)[0]; //10;
    head_r=rands(6,12,1)[0]; //8;
    body_to_head_length=rands(20,70,1)[0]/100;//.3;
    body_len=rands(10,30,1)[0]; //20;
    Headrotation=rands(-35,35,1)[0];//0;
    
    leg_r=rands(4,6,1)[0]; //4;
    leg_len=rands(5,50,1)[0]/10; //2.5;
    leg_cutbottom=.5;
    legoutpercent=rands(20,70,1)[0]/100;//.45;
    
    ear_len=rands(7,17,1)[0]; //12;
    earoutpercent=rands(20,90,1)[0]/100; //.45
    ear_r=rands(25,50,1)[0]/10; //3.5;
    ear_wall=1;
    
    arm_r=rands(20,35,1)[0]/10; //2.5;
    arm_len=rands(60,150,1)[0]/10; //10;
    arm_angle=rands(30,45,1)[0];//30;
    arm_front_Percent=rands(0,30,1)[0]/100;//.2;

    eye_r=rands(15,27,1)[0]/10; //2.2;
    eye_out_angle=rands(10,60,1)[0];//40;
    eyeHolepercent=.5;

    mouth_r=rands(25,max(body_r,head_r)*.7*10,1)[0]/10; //5;
    mouthangle=rands(10,40,1)[0];//20;

	rabbit(body_r,head_r,Headrotation,body_to_head_length,body_len,leg_r,leg_len,leg_cutbottom,legoutpercent,ear_len,earoutpercent,ear_r,ear_wall,arm_r,arm_len,arm_angle,arm_front_Percent,eye_r,eye_out_angle,eyeHolepercent,mouth_r,mouthangle);
}


module standard_rabbit()
{
rabbit(body_r,head_r,Headrotation,body_to_head_length,body_len,leg_r,leg_len,leg_cutbottom,legoutpercent,ear_len,earoutpercent,ear_r,ear_wall,arm_r,arm_len,arm_angle,arm_front_Percent,eye_r,eye_out_angle,eyeHolepercent,mouth_r,mouthangle);
}

////---------------------------------------


module randomrabbits(xx,yy)
{
    for (x = [0:xx-1]) 
    {
        for (y = [0:yy-1]) 
        {
         //     $fn=rands(5,40,1)[0]; //40; 
                translate([x*basex,y*basey,0])
                    random_rabbit();
        }
    }
}

if (type=="9_random_rabbits")
{
    randomrabbits(3,3);
}

if (type=="16_random_rabbits")
{
    randomrabbits(4,4);
}

if (type=="configurable_rabbit")
{
//    $fn=22;//40
    //get values from above (configuration possibility)
    standard_rabbit();
}

if (type=="random_rabbit")
{
    $fn=rands(5,40,1)[0]; //40; 
    random_rabbit();
}

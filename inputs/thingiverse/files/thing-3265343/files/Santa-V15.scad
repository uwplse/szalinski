//Select type of render. All the exact values below "Randomize_polygon_count" are only working if you select here "configurable_santa". 
type="random_santa"; //[configurable_santa,random_santa, 9_random_santas,16_random_santas,25_random_santas]

//For "random_santa..." above: You can randomize the polygon count from santa to santa. Select 1 here.
Randomize_polygon_count=0; //[0, 1]

//If you set "0" above for Randomize_polygon_count: You can set here a fixed polygon count. 12 is low-poly, 30 is OK to print in most cases
Fixed_polygon_count=30;

//Body radius
body_r=13;

//Head radius
head_r=11;

//Body to head ratio in length
body_to_head_length=.3;

//Body length
body_len=27;

//Head rotation in degrees
Headrotation=20;

//Nose radius
nose_r=3;

//Leg radius
leg_r=5;

//Leg length - they are short
leg_len=3;

//Cut off the bottom of legs to have a flat surface to print easily and so that the santas stand on their own
leg_cutbottom=.5;

//Move out the legs a bit
legoutpercent=.45;

//Santas hat - length
hat_len=20;

//Hat slant out in percent
hatoutpercent=.35;
hat_r=5;

//Arm radius
arm_r=3;
//Arm length
arm_len=13;
//Arm angle up
arm_angle=30;
//Arm to the front a bit
arm_front_Percent=.2;

//Eye radius
eye_r=3;
//Eye distance as angle out 
eye_out_angle=40;
//Eye center (Hole)
eyeHolepercent=.35;

//Mouth and beard
mouth_r=10;
//Smiling angle
mouthangle=20;

//Santas bag full of presents - radius
Bag_r=10;
//Bag is left or right
Bag_side=-1;

//Do you need a hole in the hat to use Santa as Christmas tree decoration? Then specify the radius here. 1.5mm radius (3mm hole diameter) is OK. If it is zero, there will be no hole. (Thanks for CaptInsano for the idea!)
Hole_r=0; 

//should we have a base?
PrintBase=0; //[0, 1]

//Base size and grid distance. Typically 72x33 should be optimal for random santas in a grid. To save space and hope neighbouring santas are not both very big, distance is less, 60x30.
basex=60; 
basey=30;
//Thickness of the base
basethick=4;
    
    
/* [Hidden] */
//-------------------------------------------------------------------------------
/*
Configurable santa pack
Version 15, December 2018
Written by MC Geisler (mcgenki at gmail dot com)

You need configurable santas? You have configurable santas. Either one or nine, you decide.
Use it to create mini or big santa sculptures!

Have fun!

License: Attribution 4.0 International (CC BY 4.0)

You are free to:
    Share - copy and redistribute the material in any medium or format
    Adapt - remix, transform, and build upon the material
    for any purpose, even commercially.
*/


//------------------------------------------

$fn= floor( Randomize_polygon_count == 1 ? rands(10,40,1)[0] : Fixed_polygon_count); 
echo($fn);

module santa(body_r,head_r,Headrotation,body_to_head_length,body_len,leg_r,leg_len,leg_cutbottom,legoutpercent,hat_len,hatoutpercent,hat_r,arm_r,arm_len,arm_angle,arm_front_Percent,eye_r,eye_out_angle,eyeHolepercent,mouth_r,mouthangle,Bag_r,Bag_side,nose_r)
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
    
    hat0=head_r-hat_r*.7;
    hat1=hat0+hat_len*.4;
    hat2=hat1+hat_len*.6;
    hatbottom_r=head_r*.9;
    Hat0 = [0, 0, body_upper+hat0, hatbottom_r]; //on head
    Hat1 = [-hatoutpercent*hat1, 0, body_upper+hat1, (hat_r*3+head_r)/4];  //before kink
    Hat2 = [-hatoutpercent*hat2, 0, body_upper+hat2, hat_r*.4];  //after kink
    HatBall = [-hatoutpercent*hat2, 0, body_upper+hat2, hat_r];  //same position, ball

    //hole to hang santa into the christmas tree
    //check if Hole_r > 0
    Hole_negative = (Hole_r == 0? 0 : 1);
    Hole_length = hatbottom_r*(Hole_r == 0? 0 : 1);
    Hole_excenter=.7*hatbottom_r;
    Hole0 = [0, -Hole_length, body_upper+hat0+hatbottom_r, Hole_r]; 
    Hole1 = [0, 0, body_upper+hat0+Hole_excenter, Hole_r]; 
    Hole2 = [0, Hole_length, body_upper+hat0+hatbottom_r, Hole_r]; 
    
    HatBrim_donut_radius = hatbottom_r;
    HatBrim0 = [0, 0, (body_upper+hat0)*.95, hatbottom_r*.1];
    HatBrim1 = [0, 0, body_upper+hat0, hatbottom_r*.1];
    
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
    //eyeHolepercent=.3;
    EyeNegL0 = [-eye_x,-eye_y,body_lower+body_len,eye_r*eyeHolepercent]; 
    EyeNegL1 = [-eye_x,-eye_y*2,body_lower+body_len,eye_r*eyeHolepercent]; 
    EyeNegR0 = [eye_x,-eye_y,body_lower+body_len,eye_r*eyeHolepercent]; 
    EyeNegR1 = [eye_x,-eye_y*2,body_lower+body_len,eye_r*eyeHolepercent]; 

    Bag0 = [Bag_side*arm_x, -arm_front, (1-leg_cutbottom)*Bag_r, Bag_r];
    Bag1 = [Bag_side*arm_x, -arm_front, ((body_lower+arm_z)*5+leg_cutbottomshiftup*5)/10, (Bag_r+arm_r)/2]; 
    Bag2 = [Bag_side*arm_x, -arm_front, body_lower+arm_z, arm_r*.5]; 
    Bag3 = [Bag_side*arm_x, -arm_front, body_lower+arm_z+1.5*arm_r, arm_r*.9]; 

    Belt_donut_radius = body_r;
    Belt0 = [0, 0, body_lower*.9, body_r*.1];
    Belt1 = [0, 0, body_lower, body_r*.1];


    position_percent=1-head_r/body_len;//position where in the body the mouth should be in percent (should be at end of head)
    interpolated_y=position_percent*body_r+(1-position_percent)*head_r; //intermediate y between head and body
    mouthmain_y=-interpolated_y+mouth_r;
    mouth_smaller_r=mouth_r/2;
    mouthmain_z=body_lower+body_len-head_r;
    Mouth0 = [0,mouthmain_y,                           mouthmain_z,          mouth_r]; 
    //Mouth1 = [mouth_r*.2,mouthmain_y+(-mouth_r+mouth_smaller_r),mouthmain_z-mouth_r/2,mouth_r/2]; 
    Mouth1 = [0,         mouthmain_y+(-mouth_r+mouth_smaller_r),mouthmain_z-1.2*mouth_r  ,mouth_r/2]; 

    nose_z=body_lower+body_len-head_r*.4;
    Nose0 = [0, -head_r+nose_r/2, nose_z+nose_r, nose_r*.7];;
    Nose1 = [0, -head_r+nose_r/4, nose_z, nose_r];;
    Nose2 = [0, -head_r+nose_r/4, nose_z, nose_r];;
    
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
    Hat = [Hat0, Hat1, Hat2, HatBall];
    HatBrim = [HatBrim0,HatBrim1];
    ArmL = [ArmL0, ArmL1];
    ArmR = [ArmR0, ArmR1];
    EyeL = [EyeL0, EyeL1];
    EyeR = [EyeR0, EyeR1];
    EyeNegL = [EyeNegL0, EyeNegL1];
    EyeNegR = [EyeNegR0, EyeNegR1];
    Mouth = [Mouth0, Mouth1];
    MouthNeg = [Mouthneg0,Mouthneg1,Mouthneg2,Mouthneg3,Mouthneg4];
    Bag = [Bag0, Bag1, Bag2, Bag3];
    Belt = [Belt0,Belt1];
    Nose = [Nose0,Nose1, Nose2];
    Hole = [Hole0,Hole1,Hole2];
    
    Part_arr=   [LegL,LegR,Body,Hat,ArmL,ArmR,EyeL,EyeR,EyeNegL,EyeNegR,Mouth,MouthNeg,Bag, Belt, HatBrim, Nose,Hole];         
    PartCut_arr=[0,   0,   0,    0,  0,   0,   0,   0,   0,      0,      0,    0,      0,      0,     0,     0,  0];         
    PartNeg_arr=[0,   0,   0,    0,  0,   0,   0,   0,   1,      1,      0,    1,      0,      0,     0,     0,  Hole_negative];         
    rZ=Headrotation;
    RotatePart= [0,   0,   0,   rZ,  0,   0,  rZ,  rZ,  rZ,     rZ,     rZ,   rZ,      0,      0,     0,     rZ, rZ];      
    Donut_r_arr=[0,   0,   0,    0,  0,   0,   0,   0,   0,      0,      0,    0,      0,Belt_donut_radius, HatBrim_donut_radius,0,0];
    //all
    max_body_overall=max(body_r+body_lower+leg_len+leg_r, arm_x*2 + Bag_r*2);
    echo(max_body_overall);
    
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



//
module random_santa()
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
    
    hat_len=rands(7,17,1)[0]; //12;
    hatoutpercent=(rands(0,1,1)[0] > 0.5 ? 1 : -1) * rands(20,90,1)[0]/100; //.45
    hat_r=rands(20,45,1)[0]/10; 
    
    arm_r=rands(20,35,1)[0]/10; //2.5;
    arm_len=rands(60,150,1)[0]/10; //10;
    arm_angle=rands(30,45,1)[0];//30;
    arm_front_Percent=rands(0,30,1)[0]/100;//.2;

    eye_r=rands(15,27,1)[0]/10; //2.2;
    eye_out_angle=rands(10,60,1)[0];//40;
    eyeHolepercent=.5;

    mouth_r=rands(25,max(body_r,head_r)*.7*10,1)[0]/10; //5;
    mouthangle=rands(10,40,1)[0];//20;

    Bag_r=rands(60,100,1)[0]/10;//3*arm_r;
    Bag_side=(rands(0,1,1)[0] > 0.5 ? 1 : -1);
    
    nose_r=rands(12,50,1)[0]/10;//1-5
    
	santa(body_r,head_r,Headrotation,body_to_head_length,body_len,leg_r,leg_len,leg_cutbottom,legoutpercent,hat_len,hatoutpercent,hat_r,arm_r,arm_len,arm_angle,arm_front_Percent,eye_r,eye_out_angle,eyeHolepercent,mouth_r,mouthangle,Bag_r,Bag_side,nose_r);
}


module standard_santa()
{
santa(body_r,head_r,Headrotation,body_to_head_length,body_len,leg_r,leg_len,leg_cutbottom,legoutpercent,hat_len,hatoutpercent,hat_r,arm_r,arm_len,arm_angle,arm_front_Percent,eye_r,eye_out_angle,eyeHolepercent,mouth_r,mouthangle,Bag_r,Bag_side,nose_r);
}

////---------------------------------------


module randomsantas(xx,yy)
{
    for (x = [0:xx-1]) 
    {
        for (y = [0:yy-1]) 
        {
            $fn= floor( Randomize_polygon_count == 1 ? rands(10,40,1)[0] : Fixed_polygon_count); 
            translate([x*basex,y*basey,0])
                random_santa();
        }
    }
}

if (type=="9_random_santas")
{
    randomsantas(3,3);
}

if (type=="16_random_santas")
{
    randomsantas(4,4);
}

if (type=="25_random_santas")
{
    randomsantas(5,5);
}

if (type=="configurable_santa")
{
    standard_santa();
}

if (type=="random_santa")
{
    random_santa();
}

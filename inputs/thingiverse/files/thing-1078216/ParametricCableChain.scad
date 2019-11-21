//
// PARAMETRIC Cable Chain v0.5
// Zerginator 10/2015
//



use <text_on.scad>


ChainDef = [[1,0],[1,0],[1,0],[1,0],[1,0],[1,0],[1,0],[1,0],[1,0],[1,0],[1,30],[1,30],[1,30],[1,30],[1,30],[1,30],[1,0],[1,0],[1,0],[1,0],[1,0],[1,0],[1,0]];


// ===============================================================================
// Type
Type        =       2;         // 1: +45° Bewegbar, 2: +-45°
Round       =       1;         // Runder oder eckiger Typ

// ===============================================================================
// box parameters
width       =       16.6;       // width of the chainlink (Standard: 16.6)
height      =       13;         // height of the chainlink (Standard: 13)
length      =       25;         // length of the chainlink  (Standard: 25, min 30 für Eckig)


// ===============================================================================
// === OUTPUT


// ===Check Consistency of Values
if((!Type && !Start && !End) || ((Round != 1) && (length/height<2.2)))
{
    // === IDIOT BOX (if imposible values were selected)
    cube([30,30,30]);
    color("red")
    text_on_cube("Doh!!", locn_vec=[15,15,15], cube_size=30, face="top", size=5, center=true); 
    color("red")
    text_on_cube("Error!!", locn_vec=[15,15,15], cube_size=30, face="front", size=5, center=true);   
    color("red")
    text_on_cube("Fehler!!", locn_vec=[15,15,15], cube_size=30, face="right", size=4, center=true);   
    color("red")
    text_on_cube("Défaut!!", locn_vec=[15,15,15], cube_size=30, face="left", size=4, center=true);   
    color("red")
    text_on_cube("ошибка!!", locn_vec=[15,15,15], cube_size=30, face="back", size=4, center=true); 
    color("red")
    text_on_cube("错误!!", locn_vec=[15,15,15], cube_size=30, face="bottom", size=4, center=true);     
}

else
    
// === Put the Chainlinks together to a single Cablechain
{
    if( Round == 1)
    {
        vec = select2(ChainDef,[1]);
        for (i = [1:len(ChainDef)]) { 
            c = sumv(vec,i-1,0);
            a = coslength(i,ChainDef,vec); 
            b = sinlength(i,ChainDef,vec); 

            pcsOChain(width, length, height, 0, a, b, c);
        }
    }

}


// ===============================================================================
// === Mathematikfunktionen
function sumv(v,i,s=0) = (i==s ? v[i] : v[i] + sumv(v,i-1,s));
function select(source_vector,select_vector)=
   [ for (i = [0 : len(select_vector) - 1]) source_vector[select_vector[i]] ];
function select2(source_vector,select_vector)=
   [ for (i = [0 : len(source_vector) - 1]) source_vector[i][1] ];
function coslength(j,ChainDef,vec,s=1)=
   (j==s ? (((height/13)*(length-10.5)) * cos(sumv(vec,j-1,0)-ChainDef[j-1][1])) : (((height/13)*(length-10.5))) * cos(sumv(vec,j-1,0)-ChainDef[j-1][1]) + coslength(j-1,ChainDef,vec));  
   
function sinlength(j,ChainDef,vec,s=1)=
   (j==s ? ((height/13)*(length-10.5))*(sin(sumv(vec,j-1,0)-ChainDef[j-1][1])) : ((height/13)*(length-10.5))*(sin(sumv(vec,j-1,0)-ChainDef[j-1][1])) + sinlength(j-1,ChainDef,vec));


// ===============================================================================
// === Generate Chain module
module pcsOChain(width, length, height, posx,posy,posz, ChainAngle) 
    {    
        translate([posx,posy,posz])
        translate([0,(height/13)*4.5,(height/13)*6.5])  
        rotate(a=ChainAngle, v=[1,0,0])
        translate([0,-(height/13)*4.5,-(height/13)*6.5])  
        if (Round != 1)
        {
            pcsMiddlePart(width, length, height);
            pcsOFront(width, length, height);
            translate([0,length - height - overlapping,0]) pcsOBack(width, length, height);
        }
        else
        {
            CableChain(width, length, height);
        }
    }





// ===============================================================================
// ===============================================================================
// ===============================================================================




// ===============================================================================
// === Cable Chain (Rund)

module CableChain(width, length, height)
{
translate([width,0,0])
rotate(a=90, v=[0,0,1])
difference()
    {
    union()
        {
        difference()
            {
                union()
                   {
                    translate([0,0.1,0])
                        rotate(a=0, v=[0,0,1])
                            cube([(height/13)*(length-7.5),width,(height/13)*13]);
                    translate([(height/13)*(length-7.5),0.1,(height/13)*6.5])
                        rotate(a=90, v=[-1,0,0])
                            cylinder(r=(height/13)*6.5, h=width);
                   }

                union()
                    {
                    union()
                        {
                        if (Type == 1)
                        {
                            translate([(height/13)*-0.8,-1,(height/13)*6.4])
                                rotate(a=35, v=[0,-1,0])
                                    cube([(height/13)*9,width+1.5,(height/13)*5]);
                            translate([(height/13)*3.2,-1,(height/13)*9.9])
                                rotate(a=0, v=[0,0,1])
                                    cube([(height/13)*7,width+1.5,(height/13)*4]);
                        } 
                        translate([(height/13)*4.6,2,(height/13)*6.5])
                            rotate(a=90, v=[1,0,0])   
                                cylinder(r=(height/13)*6.85, h=3);
                        
                        //FEMALE
                            translate([(height/13)*(length-6),width+0.5,(height/13)*6.5])
                                rotate(a=90, v=[1,0,0])   
                                    cylinder(r=(height/13)*2.45, h=width+0.9);                         
                         translate([(height/13)*4.6,width+1.3,(height/13)*6.5])
                            rotate(a=90, v=[1,0,0])   
                                cylinder(r=(height/13)*6.85, h=3);
                        }
                    difference()
                        {
                        translate([0,-0.5,0])
                            rotate(a=0, v=[0,0,1])
                                cube([(height/13)*5,width+0.9,(height/13)*4]);
                        {
                        translate([(height/13)*5,width+0.4,(height/13)*5.5])
                            rotate(a=90, v=[1,0,0])   
                                cylinder(r=(height/13)*5.5, h=width+0.9);
                            }
                        }
                    if (Type == 2)
                        {
                        difference()
                            {
                            translate([0,-0.5,9])
                                rotate(a=0, v=[0,0,1])
                                    cube([(height/13)*5,width+0.9,(height/13)*4]);
                            {
                            translate([(height/13)*5,width+0.4,(height/13)*7.5])
                                rotate(a=90, v=[1,0,0])   
                                    cylinder(r=(height/13)*5.5, h=width+0.9);
                                }
                            }
                        }
                    }
                }
                
                // MALE
                difference()
                {
                    translate([(height/13)*4.5,width-0.3,(height/13)*6.5])
                        rotate(a=90, v=[1,0,0])   
                            cylinder(r=(height/13)*1.85, h=width-0.8); 
                    translate([(height/13)-1,-2,(height/13)*4.5])
                        rotate(a=-20, v=[0,0,1])
                            cube([4,4,4]);
                    translate([(height/13)-1,18.8,(height/13)*4.5]) //2.5
                            rotate(a=-70, v=[0,0,1]) //-15
                                cube([4,4,4]);
                } 
        } 
        
    union()
        {
            translate([(height/13)*-1,3.4,1.5])
                rotate(a=0, v=[0,0,1])
                    cube([(height/13)*(length+1),width-6.6,height-3]);
           translate([(height/13)*(length-9.65),3.4,(height/13)*3.5])
                rotate(a=0, v=[0,0,1])
                    cube([(height/13)*8,width-6.6,(height/13)*10]);    
            
            if (Type == 1)
            {
                translate([(height/13)*-1,3.4,(height/13)*-1.5])
                    rotate(a=0, v=[0,0,1])
                        cube([(height/13)*8,width-6.6,(height/13)*13]);
                translate([(height/13)*(length-12.5),1.6,(height/13)*9.7])
                    rotate(a=-60, v=[1,0,0])
                        cube([(height/13)*11,3,3]);  
                translate([(height/13)*(length-12.5),width-1.4,(height/13)*9.7])
                    rotate(a=150, v=[1,0,0])
                        cube([(height/13)*11,3,3]);
                translate([(height/13)*(length-12.5),1.6,1.5])
                    rotate(a=0, v=[0,0,1])
                        cube([(height/13)*6,width-3,((height/13)*8.2)+((height/13)*1.5-1.5)]);
                translate([(height/13)*(length-9.65),1.6,0])
                    rotate(a=0, v=[0,0,1])
                        cube([(height/13)*10,width-3,(height/13)*9.7]);
            }
            
            if (Type == 2)
            {
            translate([(height/13)*-1,3.4,(height/13)*-1.5])
                    rotate(a=0, v=[0,0,1])
                        cube([(height/13)*8,width-6.6,(height/13)*16]);
            translate([(height/13)*(length-12.5),1.6,1.5])
                    rotate(a=0, v=[0,0,1])
                        cube([(height/13)*6,width-3,height-3]);

            translate([(height/13)*(length-9.65),1.6,0])
                rotate(a=0, v=[0,0,1])
                    cube([(height/13)*10,width-3,(height/13)*13]);
            }
        }
    }    
    
} // END CABLE CHAIN RUND


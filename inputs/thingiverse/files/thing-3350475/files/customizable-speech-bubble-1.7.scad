// This file is licensed under the following license:
// https://creativecommons.org/licenses/by-nc-nd/3.0/legalcode
// https://creativecommons.org/licenses/by-nc-nd/3.0/

// (c) 2018 Rainer Schlosshan

/*
Text Ideas:
- Bazinga! \n GotYa
- Creepy
- WTF?!?
- Life is a bitch
- AdiosBitChaChos
- Back In Five Minutes
- Don't feed the trolls!
- Prusa @Work
- Welcome to the Madhouse
-My Body is just a filter
--Coffe goes in, Sarcasm comes out
+

*/
//preview[view:south, tilt:top]
// Your Text Line 1 
text="Bazinga!"; 
// Your Text Line 2 
text2="Customize Me!";
// Your Text Line 3     
text3="";
// Your Text Line 4
text4="";

//The X Size of text area for RoundedRectangle&Cloud frames
SizeX=89;
//The Y Size of text area for RoundedRectangle&Cloud frames
SizeY=50;

FrameType=0; //[0:Rounded Rectangle,1:Cloud,2:Outline]

/* [Arrow/Pointer] */
ArrowType=0; // [0:No Arrow,1:Arrow,2:Bubbles]
ArrowPos=0; //[0:bottomLeft,1:BottomRight]
ArrowLength=35;


/* [Advanced Formatting] */
// The base Height
baseHeight=2;
// Radius of the corner for frmae type rounded rectangle 
RoundedRectangleRadius=30;
BorderWidth=8;
BorderHeight=2;
// Width of the base outside the Border
BaseOutsideBorderWidth=2;


//The distance between the text and the border for an outline frame type
OutlineFrameBorderDistance=5;
//OutlineType=0;//[0:round outline,1:edgy outline]

/* [Text Location + Orientation] */
//The height of the letters
TextHeight=5;


// Rotate the text by this angle 
TextRotation=0; // positive values=clockwise, negative values=counter clockwise

// Allignment should only be changed wen Rotation=0
HorizontalAllignment="center"; //[left,center,right]
// If you want to render a complete fontList change this parameter
parts="sign"; // [sign,fontlist]

/* [Text Line 1 Format + Options] */
//Font to be used ( see https://fonts.google.com to choose from all of them )
font="bangers";//[Acme,bangers,BioRhyme,BlackOpsOne,bubblegumsans,cevicheOne,Coiny,Cookie,Creepster,DancingScript,Delius,DeliusSwashCaps,exo,Flavors,FreckleFace,Fruktur,Galindo,Gorditas,GravitasOne,HennyPenny,Inika,JotiOne,Kavoon,LeckerliOne,Lobster,Margarine,MervaleScript,Mogra,MouseMemoirs,MysteryQuest,Oregano,PasseroOne,Peralta,Piedra,Plaster,Ranchers,Risque,SnowburstOne,swankyandmoomoo,Wellfleet,YatraOne] 

//[Acme,bangers,Bubblegumsans,Ceviche One,Coiny,Cookie,Creepster,Delius,DeliusSwashCaps,exo,Flavors,FreckleFace,swankyandmoomoo,Galindo,Gorditas,HennyPenny,Inika,JotiOne,Kavoon,LeckerliOne,Margarine,MervaleScript,MouseMemoirs,MysteryQuest,Oregano,PasseroOne,Peralta,Piedra,Plaster,Ranchers,Risque,Signifika,SnowburstOne,WalterTurncoat,Wellfleet]

FontSize=22  ;
text1Spacing=1;//[0.5,0.55,0.6,0.65,0.7,0.75,0.8,0.85,0.9,0.95,1,1.05,1.1,1.15,1.2,1.25,1.3,1.35,1.4,1.45,1.5]
Bold=false;

// Add an additional horizontal offset (mm)
TextHorizontalOffset=0;
TextVerticalOffset=0;

/* [Text Line 2 Format + Options] */
//Font to be used ( see https://fonts.google.com to choose from all of them )
font2="bangers"; //[none,Acme,bangers,BioRhyme,BlackOpsOne,bubblegumsans,cevicheOne,Coiny,Cookie,Creepster,DancingScript,Delius,DeliusSwashCaps,exo,Flavors,FreckleFace,Fruktur,Galindo,Gorditas,GravitasOne,HennyPenny,Inika,JotiOne,Kavoon,LeckerliOne,Lobster,Margarine,MervaleScript,Mogra,MouseMemoirs,MysteryQuest,Oregano,PasseroOne,Peralta,Piedra,Plaster,Ranchers,Risque,SnowburstOne,swankyandmoomoo,Wellfleet,YatraOne]
FontSize2=13 ;
text2Spacing=1;//[0.7,0.75,0.8,0.85,0.9,0.95,1,1.05,1.1,1.15,1.2,1.25,1.3]
        
Bold2=false;

// Add an additional horizontal offset (mm)
Text2HorizontalOffset=0;
Text2VerticalOffset=0;

/* [Text Line 3 Format + Options] */
//Font to be used ( see https://fonts.google.com to choose from all of them )
font3="bangers"; //[none,Acme,bangers,BioRhyme,BlackOpsOne,bubblegumsans,cevicheOne,Coiny,Cookie,Creepster,DancingScript,Delius,DeliusSwashCaps,exo,Flavors,FreckleFace,Fruktur,Galindo,Gorditas,GravitasOne,HennyPenny,Inika,JotiOne,Kavoon,LeckerliOne,Lobster,Margarine,MervaleScript,Mogra,MouseMemoirs,MysteryQuest,Oregano,PasseroOne,Peralta,Piedra,Plaster,Ranchers,Risque,SnowburstOne,swankyandmoomoo,Wellfleet,YatraOne]
FontSize3=15 ;
text3Spacing=1;//[0.7,0.75,0.8,0.85,0.9,0.95,1,1.05,1.1,1.15,1.2,1.25,1.3]
        
Bold3=false;

// Add an additional horizontal offset (mm)
Text3HorizontalOffset=0;
Text3VerticalOffset=0;

/* [Text Line 4 Format + Options] */
//Font to be used ( see https://fonts.google.com to choose from all of them )
font4="bangers"; //[none,Acme,bangers,BioRhyme,BlackOpsOne,bubblegumsans,cevicheOne,Coiny,Cookie,Creepster,DancingScript,Delius,DeliusSwashCaps,exo,Flavors,FreckleFace,Fruktur,Galindo,Gorditas,GravitasOne,HennyPenny,Inika,JotiOne,Kavoon,LeckerliOne,Lobster,Margarine,MervaleScript,Mogra,MouseMemoirs,MysteryQuest,Oregano,PasseroOne,Peralta,Piedra,Plaster,Ranchers,Risque,SnowburstOne,swankyandmoomoo,Wellfleet,YatraOne]
FontSize4=15 ;
text4Spacing=1;//[0.7,0.75,0.8,0.85,0.9,0.95,1,1.05,1.1,1.15,1.2,1.25,1.3]
        
Bold4=false;

// Add an additional horizontal offset (mm)
Text4HorizontalOffset=0;
Text4VerticalOffset=0;

/* [Magnets] */
// Do you want Magnet Cutouts in the bottom?
MagnetCount=0; // [0,1,2]

// The Diameter of your Magnets (add some tolerance!)
MagnetDiameter=8.3;

// The Height of your Magnets (add some tolerance!)
MagnetHeight=2.2;


/* [Preview Colors] */
BaseColor="white";//[white,black,red,yellow,blue,green,orange,purple,pink,brown,gray,beige]
TextColor="red";//[white,black,red,yellow,blue,green,orange,purple,pink,brown,gray,beige]
BorderColor="yellow";//[white,black,red,yellow,blue,green,orange,purple,pink,brown,gray,beige]

// ignore variable values below
/* [Hidden] */

$fn=76;
Italic=false;
Italic2=false;
Italic3=false;
Italic4=false;
VerticalAllignment="center"; //[top,center,bottom]

//Automatically adjust variables

/*radius=0
    +(RoundedRectangleRadius>=min(SizeX,SizeY)?min(SizeX,SizeY):RoundedRectangleRadius);*/
radius=-0
    +(RoundedRectangleRadius>=min(SizeX,SizeY)/2
        ?min(SizeX,SizeY)/2
        :RoundedRectangleRadius);
if(radius!=RoundedRectangleRadius)
    echo(str("<b><font color='orange'>Automatically adjusted RoundedRectangleRadius from ",RoundedRectangleRadius," to ",radius));
//Adjust base Height based on Magnet Height
Height=(baseHeight<MagnetHeight+1 && MagnetCount > 0?MagnetHeight+1:baseHeight);
if(Height!=baseHeight)
    echo(str("<b><font color='orange'>Automatically adjusted baseHeight from ",baseHeight," to ",Height));
//radius=RoundedRectangleRadius;

//Xincr=0;//(radius-BorderWidth)/2;
//Yincr=0;//(radius-BorderWidth)/2;

// Prepare font style
_FontStr=str(font,":style=",(Bold?"Bold ":" "),(Italic?"Italic":""));
_FontStr2=str(font2,":style=",(Bold2?"Bold ":" "),(Italic2?"Italic":""));
_FontStr3=str(font3,":style=",(Bold3?"Bold ":" "),(Italic3?"Italic":""));
_FontStr4=str(font4,":style=",(Bold4?"Bold ":" "),(Italic4?"Italic":""));
        
        
// the writing space
//cube([SizeX,SizeY,Height+1]);
if (parts=="sign"){
    difference(){    
    union(){ //this is the full sign
        
        //the frame
        // ======================= Rounded Rectangle
        if(FrameType==0){
            CreateRoundedRectangleSign();
        }//FrameType rounded rectangle
        
        // ======================= Bubbly frame
        if(FrameType==1){ // Bubbly Frame
            CreateBubblySign();
        }//FrameType==1
        
        // ======================= outline frame
    
        if(FrameType==2){ // Outline Frame
            CreateOutlineSign();
        }
    }//union
        // Create Magnet Cutouts
        if(MagnetCount==1){
            translate([SizeX/2,SizeY/2,-0.02])
            cylinder(r=MagnetDiameter/2,h=MagnetHeight);
        }
        if(MagnetCount==2){
             //Estimate X/Y Size of Outline Frame
            OutlX=max(len(text)*FontSize*text1Spacing,len(text2)*FontSize2 *text2Spacing)
                    *0.55
                    +2*BorderWidth
                    +2*OutlineFrameBorderDistance;
            OutlY=FontSize+FontSize2+TextVerticalOffset+ Text2VerticalOffset ;
            //echo("Debug: OutlX=",OutlX,", OutlY=",OutlY);
            OffsetX=0
                +(FrameType==0||FrameType==1
                    ?(SizeX<SizeY?0:SizeX/4)
                    :0)
                +(FrameType==2
                    ?(OutlX<OutlY?0:OutlX/4)
                    :0)
                *0.5
                ;
            OffsetY=0
                +(FrameType==0||FrameType==1
                    ?(SizeX<SizeY?SizeY/4:0)
                    :0)
                 +(FrameType==2
                    ?(OutlX<OutlY?OutlY/4:0)
                    :0)
                *0.5
                ;
            translate([
                SizeX/2+ OffsetX
                ,SizeY/2+ OffsetY
                ,-0.02])
                cylinder(h = MagnetHeight, r = MagnetDiameter/2);
            translate([
                SizeX/2- OffsetX
                ,SizeY/2- OffsetY
                ,-0.02])
                cylinder(h = MagnetHeight, r = MagnetDiameter/2);
        }
    
    }//main difference
}//if sign
if(parts=="fontlist"){
    fontPreview();
}
module createText(
        _hAllign1=HorizontalAllignment
        ,_vAllign1=VerticalAllignment
        ,_hOffset1=TextHorizontalOffset
        ,_vOffset1=TextVerticalOffset
        ,_text1=text
        ,_font1=_FontStr
        ,_fontSize1=FontSize
        ,_text1Spacing=text1Spacing
        ,_hOffset2=Text2HorizontalOffset
        ,_vOffset2=Text2VerticalOffset
        ,_text2=text2
        ,_font2=_FontStr2
        ,_fontSize2=FontSize2
        ,_text2Spacing=text2Spacing
        ,_hOffset3=Text3HorizontalOffset
        ,_vOffset3=Text3VerticalOffset
        ,_text3=text3
        ,_font3=_FontStr3
        ,_fontSize3=FontSize3
        ,_text3Spacing=text3Spacing
        
        ,_hOffset4=Text4HorizontalOffset
        ,_vOffset4=Text4VerticalOffset
        ,_text4=text4
        ,_font4=_FontStr4
        ,_fontSize4=FontSize4
        ,_text4Spacing=text4Spacing
        
        ,_fontThickness=TextHeight
        ,_TBwidth=SizeX
        ,_TBheight=SizeY
        ,_extrude=true
        ,_debug=false
){
    textWriter(
                            hAllign1=_hAllign1,vAllign1=_vAllign1
                            ,hOffset1=_hOffset1,vOffset1=_vOffset1
                            ,text1=_text1,font1=_font1,fontSize1=_fontSize1,text1Spacing=_text1Spacing
                            ,hOffset2=_hOffset2,vOffset2=_vOffset2,text2=_text2
                            ,font2=_font2,fontSize2=_fontSize2,text2Spacing=_text2Spacing
                            ,hOffset3=_hOffset3,vOffset3=_vOffset3,text3=_text3
                            ,font3=_font3,fontSize3=_fontSize3,text3Spacing=_text3Spacing
                            ,hOffset4=_hOffset4,vOffset4=_vOffset4,text4=_text4
                            ,font4=_font4,fontSize4=_fontSize4,text4Spacing=_text4Spacing
        
                            ,fontThickness=_fontThickness
                            ,TBwidth=_TBwidth
                            ,TBheight=_TBheight
                            ,extrude=_extrude
                            ,debug=_debug);

    }    
module roundedFrame(r=5,SizeX=100,SizeY=60,Height=2,SizeInc=0){
        //SizeInc is the borderWidth to add to all sides
        factor=1;
        _SizeX=SizeX+2*SizeInc;
        _SizeY=SizeY+2*SizeInc;
        _radius=r+SizeInc;
        
       
        XOffset=_SizeX-_radius;
        YOffset=_SizeY-_radius;
        ZeroOffset=+_radius;
        echo("Debug: _SizeX=",_SizeX,",_SizeY=",_SizeY,",SizeInc=",SizeInc,",radius=",r,",Height=",Height);
        translate ([-SizeInc,-SizeInc,0])
        hull(){
            translate([ZeroOffset,ZeroOffset,0])cylinder(r=_radius,h=Height); //0,0
            translate([XOffset,ZeroOffset,0])cylinder(r=_radius,h=Height);     //x,0
            translate([XOffset,YOffset,0])cylinder(r=_radius,h=Height);    //x,y
            translate([ZeroOffset,YOffset,0])cylinder(r=_radius,h=Height);      //0,y
        }
    }
module roundedFrameOld(r=5,SizeX=100,SizeY=60,Height=2,SizeInc=0){
        //SizeInc is the borderWidth to add to all sides
        factor=1;
        _SizeX=SizeX+1*SizeInc;
        _SizeY=SizeY+1*SizeInc;
        hull(){
            translate([-SizeInc+r,-SizeInc+r,0])cylinder(r=r,h=Height);
            translate([_SizeX-r/factor,-SizeInc+r,0])cylinder(r=r,h=Height);
            translate([-SizeInc+r,_SizeY-r/factor,0])cylinder(r=r,h=Height);
            translate([_SizeX-r/factor,_SizeY-r/factor,0])cylinder(r=r,h=Height);
        }
    }
module BubbleFrame(r=5,SizeX=100,SizeY=60,Height=2,SizeInc=0){
    br=(SizeX+SizeY)*.11;
    brx=(SizeX)*1;
    bry=(SizeY)*1;
    linear_extrude(height=Height){
    offset(delta=SizeInc){
    union(){
        translate([
            brx*.5,bry*0.17,0])
            circle(r=br*1.2);
        translate([
            brx*.3,bry*0.17,0])
            circle(r=br*1.1);
        translate([
            brx*.68,bry*.25,0])
            circle(r=br*1.35);
        translate([
            brx*.85,bry*.13,0])
            circle(r=br*1.1);
        translate([
            brx*.9,bry*0.5,0])
            circle(r=br*1.2);
        translate([
            brx*.8,bry*0.6,0])
            circle(r=br*1.2);
        translate([
            brx*.65,bry*0.68,0])
            circle(r=br*1.1);
        translate([
            brx*.46,bry*.75,0])
            circle(r=br*1.3);
        translate([
            brx*.28,bry*.78,0])
            circle(r=br*1.1);
        translate([
            brx*.12,bry*.65,0])
            circle(r=br*1.3);
        translate([
            brx*.12,bry*.2,0])
            circle(r=br*1.3);
        translate([
            brx*.07,bry*.4,0])
            circle(r=br*1.3);
        }
        }
    }//union

}
    
module bubblyArrow(BW=5,OutsideBorderWidth=1,r=5,SizeX=100,SizeY=60,ArrowHeight=3,OutsideBorderHeight=1,l=30,pos=0,ArrowLength=ArrowLength,ArrowPos=ArrowPos){
    /*
    */
    translate([0,0,0])union(){
    
        color(BorderColor)
            linear_extrude(height=ArrowHeight)
            bubblyArrow2D(BW=BW,r=r,SizeX=SizeX,SizeY=SizeY,l=l,pos=pos,ArrowLength=ArrowLength,ArrowPos=ArrowPos);
        //echo("Debug:OutsideBorderWidth=",OutsideBorderWidth);
    
        if (OutsideBorderWidth>0){
            color(BaseColor){
                linear_extrude(height=OutsideBorderHeight)
                offset(delta=OutsideBorderWidth)
                    bubblyArrow2D(BW=BW,r=r,SizeX=SizeX,SizeY=SizeY,Height=Height,l=l,pos=pos,ArrowLength=ArrowLength,ArrowPos=ArrowPos);
            }
        }
    }
}
module bubblyArrow2D(BW=5,r=5,SizeX=100,SizeY=60,l=30,pos=0,ArrowLength=ArrowLength,ArrowPos=ArrowPos){
    br=(SizeX+SizeY)*.1;
    //ArrowPos: 
    // 0=BottomLeft
    // 1=BottomRight
    difference(){
    union(){
        translate([
            0
             +(ArrowPos==0?r+(SizeX-r)*0.2:0)
             +(ArrowPos==1?SizeX-r-(SizeX-r)*0.2:0)
            ,-(BorderWidth+ArrowLength)*0.15
            ,0])
            circle(r=br);
        translate([
            0
             +(ArrowPos==0?r+(SizeX-r)*0.2-br*.55:0)
             +(ArrowPos==1?SizeX-r-(SizeX-r)*0.2+br*.55:0)
            ,-(BorderWidth+ArrowLength)*0.55
            ,0])
            circle(r=br*.7);
        translate([
            0
             +(ArrowPos==0?r+(SizeX-r)*0.2-br*1.1:0)
             +(ArrowPos==1?SizeX-r-(SizeX-r)*0.2+br*1.1:0)
            ,-(BorderWidth+ArrowLength)*0.8
            ,0])
            circle(r=br*.5);
        translate([
            0
             +(ArrowPos==0?r+(SizeX-r)*0.2-br*1.6:0)
             +(ArrowPos==1?SizeX-r-(SizeX-r)*0.2+br*1.6:0)
            ,-(BorderWidth+ArrowLength)*0.9
            ,0])
            circle(r=br*.35);
        translate([
            0
             +(ArrowPos==0?r+(SizeX-r)*0.2-br*2:0)
             +(ArrowPos==1?SizeX-r-(SizeX-r)*0.2+br*2:0)
            ,-(BorderWidth+ArrowLength)//-BW-br*2.7
            ,0])
            circle(r=br*.25);
        }//union
        square([SizeX,br]);
    }//difference
}

module roundedArrow2D(BW=5,r=5,SizeX=100,SizeY=60,Height=2,l=30,pos=0,ArrowLength=ArrowLength,ArrowPos=ArrowPos){
     hull(){
        translate([
            0
             +(ArrowPos==0?r+(SizeX-r)*0.1:0)
             +(ArrowPos==1?SizeX-r+(SizeX-r)*0.1:0)
            ,-BW
            ,0])
            circle(r=BW);
        translate([
            0
              +(ArrowPos==0?r+(SizeX-r)*0.4:0)
              +(ArrowPos==1?SizeX-r-(SizeX-r)*0.1:0)
            ,-BW,0])circle(r=BW);
        
        translate([
            0
              +(ArrowPos==0?0:0)
              +(ArrowPos==1?SizeX:0)
              ,-(BorderWidth+ArrowLength)
              ,0])circle(r=1);
   }
}
module roundedArrow(OutsideBorderWidth=2,BW=5,r=5,SizeX=100,SizeY=60,ArrowHeight=2,OutsideBorderHeight=1,l=30,pos=0,ArrowLength=ArrowLength,ArrowPos=ArrowPos){
    
    color(BorderColor)
            linear_extrude(height=ArrowHeight)
        roundedArrow2D(BW=BW,r=r,SizeX=SizeX,SizeY=SizeY,Height=Height,l=l,pos=pos,ArrowLength=ArrowLength,ArrowPos=ArrowPos);
    //echo("Debug:OutsideBorderWidth=",OutsideBorderWidth);
    if (OutsideBorderWidth>0){
        color(BaseColor){
            linear_extrude(height=OutsideBorderHeight)
            offset(delta=OutsideBorderWidth)
                roundedArrow2D(BW=BW,r=r,SizeX=SizeX,SizeY=SizeY,Height=Height,l=l,pos=pos,ArrowLength=ArrowLength,ArrowPos=ArrowPos);
        }
    }
    
}

module textWriter(
    hAllign1="center",vAllign1="center"
    ,hOffset1=0,vOffset1=0,
    text1="text1",font1="",fontSize1=10,text1Spacing=1
    ,hOffset2=0,vOffset2=0
    ,text2="",font2="",fontSize2=10,text2Spacing=1
    ,hOffset3=0,vOffset3=0
    ,text3="",font3="",fontSize3=10,text3Spacing=1
    ,hOffset4=0,vOffset4=0
    ,text4="",font4="",fontSize4=10,text4Spacing=1
    ,fontThickness=5
    ,TBwidth=100,TBheight=50
    ,extrude=true
    ,debug=false)
               
{
    TBheight2=TBheight-2;
    TBwidth2=TBwidth-2;
    if(debug)translate([-TBwidth2/2,-TBheight2/2,0])cube([TBwidth2,TBheight2,1]);
    linespacing=2;
    // Calculate Total Height
    height=0
            +(text1!=""
                ?fontSize1+linespacing
                :0)
            +(text2!=""
                ?fontSize2+linespacing
                :0)
            +(text3!=""
                ?fontSize3+linespacing
                :0)
            +(text4!=""
                ?fontSize4
                :0);
    //echo("Debug: height=",height);
    
    _yAllign=(vAllign1=="bottom"
                            ? - (TBheight2/2)+height/2
                            : (vAllign1=="top"
                                ?(TBheight2/2)-(height/2)
                                :0))
        +(text3!=""?(fontSize3+linespacing):0);
    
            
    _y1height=0+(text1!=""
                ?fontSize1+linespacing
                :0);
    _y2height= 0+(text2!=""
                ?fontSize2+linespacing
                :0);
    _y3height= 0+(text3!=""
                ?fontSize3+linespacing
                :0);
    _y4height= 0+(text4!=""
                ?fontSize4
                :0);
    //echo("Debug: _y1height=",_y1height,",_y2height=",_y2height,",_y3height=",_y3height,"_yAllign=",_yAllign);
    
    _y1=height/2-_y1height/2 ;
    _y2=height/2-_y2height/2 -_y1height;
    _y3=height/2-_y3height/2 -_y1height-_y2height;
    _y4=height/2-_y4height/2 -_y1height-_y2height-_y3height;
    posX=(hAllign1=="left"
                            ? -TBwidth2/2
                            : (hAllign1=="right"
                                ?TBwidth2/2
                                :0)   );
                                
                                
    if(extrude){
        translate([0,0,(fontThickness<0?fontThickness+0.01:0)])
        union(){
      //      echo("_y1+vOffset1=",_y1+vOffset1);
            translate([posX+hOffset1,_y1+vOffset1,0])
            linear_extrude(height=abs(fontThickness)) 
            text(text1,size=fontSize1, font=font1,  halign = hAllign1,valign = "center",spacing=text1Spacing); 
            if(text2!=""){
        //        echo("_y2+vOffset2=",_y2+vOffset2);
                translate([posX+hOffset2,_y2+vOffset2,0])
                linear_extrude(height=abs(fontThickness)) 
                text(text2,size=fontSize2, font=font2,  halign = hAllign1,valign = "center",spacing=text2Spacing); 
            }
            if(text3!=""){
          //      echo("_y3+vOffset3=",_y1+vOffset3);
                translate([posX+hOffset3,_y3+vOffset3,0])
                linear_extrude(height=abs(fontThickness)) 
                text(text3,size=fontSize3, font=font3,  halign = hAllign1,valign = "center",spacing=text3Spacing); 
            }
            if(text4!=""){
            //    echo("_y4+vOffset4=",_y4+vOffset4);
                translate([posX+hOffset4,_y4+vOffset4,0])
                linear_extrude(height=abs(fontThickness)) 
                text(text4,size=fontSize4, font=font4,  halign = hAllign1,valign = "center",spacing=text4Spacing); 
            }
        }
    }else{
        translate([0,0,(fontThickness<0?fontThickness+0.01:0)])
        union(){
            translate([posX+hOffset1,_y1+vOffset1,0])
            text(text1,size=fontSize1, font=font1,  halign = hAllign1,valign = "center",spacing=text1Spacing); 
            if(text2!=""){
                translate([posX+hOffset2,_y2+vOffset2,0])
                text(text2,size=fontSize2, font=font2,  halign = hAllign1,valign = "center",spacing=text2Spacing); 
            }
            if(text3!=""){
                translate([posX+hOffset3,_y3+vOffset3,0])
                text(text3,size=fontSize3, font=font3,  halign = hAllign1,valign = "center",spacing=text3Spacing); 
            }
            if(text4!=""){
                translate([posX+hOffset4,_y4+vOffset4,0])
                text(text4,size=fontSize4, font=font4,  halign = hAllign1,valign = "center",spacing=text4Spacing); 
            }
        }
    }
}


module CreateRoundedRectangleSign(){
    if(ArrowType==1){ //arrow
            roundedArrow(OutsideBorderWidth=BaseOutsideBorderWidth,BW=BorderWidth/2,SizeX=SizeX,SizeY=SizeY
                ,ArrowHeight=Height+BorderHeight
                ,OutsideBorderHeight=Height
                ,ArrowLength=ArrowLength,ArrowPos=ArrowPos,r=radius);
            
    }
    if(ArrowType==2){ //Bubble
        bubblyArrow(BW=BorderWidth/2,OutsideBorderWidth=BaseOutsideBorderWidth
            ,SizeX=SizeX,SizeY=SizeY
            ,ArrowHeight=Height+BorderHeight
            ,OutsideBorderHeight=Height
            ,ArrowLength=ArrowLength,ArrowPos=ArrowPos,r=radius);
    }
    translate([0,0,0])
        color(BorderColor){
        difference(){
            // the outside frame including the border @ full height
            roundedFrame(r=radius,SizeX=SizeX,SizeY=SizeY
                    ,Height=Height+BorderHeight,SizeInc=BorderWidth);
            
            // cut the inner part where the text should go
            translate([0,0,Height])
            roundedFrame(r=radius,SizeX=SizeX,SizeY=SizeY
                    ,Height=BorderHeight+0.01,SizeInc=0);
        }//difference
    }
    //additional item to color the base
    color(BaseColor){
        
        roundedFrame(r=radius
                    ,SizeX=SizeX
                    ,SizeY=SizeY
             ,Height=Height+0.03,SizeInc=BaseOutsideBorderWidth+BorderWidth);
    }
    translate([SizeX/2,SizeY/2,0.02])
        color(TextColor){rotate([0,0,TextRotation])createText(_fontThickness=Height+TextHeight);}
}


module CreateBubblySign(){
        difference(){
            union(){
                // the outer Frame&Border
                color(BorderColor){BubbleFrame(r=radius-BorderWidth
                            ,SizeX=SizeX,SizeY=SizeY
                            ,Height=Height+BorderHeight,SizeInc=BorderWidth);}
                if(ArrowType==1){
                    roundedArrow(OutsideBorderWidth=BaseOutsideBorderWidth,BW=BorderWidth/2
                        ,SizeX=SizeX,SizeY=SizeY
                        ,ArrowHeight=Height+BorderHeight
                        ,OutsideBorderHeight=Height
                        ,ArrowLength=ArrowLength,ArrowPos=ArrowPos,r=radius);
                                    
                }
                if(ArrowType==2){
                     bubblyArrow(BW=BorderWidth/2,OutsideBorderWidth=BaseOutsideBorderWidth
                        ,SizeX=SizeX,SizeY=SizeY
                        ,ArrowHeight=Height+BorderHeight
                        ,OutsideBorderHeight=Height
                        ,ArrowLength=ArrowLength,ArrowPos=ArrowPos,r=radius);
                }
            }//union
            // cutout the inner Area
            translate([0,0,Height])
                BubbleFrame(r=radius-BorderWidth,SizeX=SizeX,SizeY=SizeY
                            ,Height=BorderHeight+0.02,SizeInc=1);
        }//difference
        // the base
        translate([0,0,-0.00])color(BaseColor){
                BubbleFrame(r=radius-BorderWidth,SizeX=SizeX,SizeY=SizeY
                            ,Height=Height+0.02,SizeInc=1);
        }
        //the BaseOutsideBorder
        if (BaseOutsideBorderWidth>0){
            translate([0,0,-0.00])
            color(BaseColor){
                BubbleFrame(r=radius+BaseOutsideBorderWidth,SizeX=SizeX,SizeY=SizeY
                                ,Height=Height+0.02,SizeInc=BorderWidth+BaseOutsideBorderWidth);
            }
        }
            color(TextColor){
                    translate([SizeX/2,SizeY/2,0.02])rotate([0,0,TextRotation])createText(_fontThickness=Height+TextHeight);
            }
        }
        
 module CreateOutlineSign(){
         difference(){
            union(){ 
                // The Base Outside Border
                if (BaseOutsideBorderWidth>0){
                    color(BaseColor)
                    linear_extrude(height=Height)
                        offset(r=BorderWidth+OutlineFrameBorderDistance+BaseOutsideBorderWidth)
                        translate([SizeX/2,SizeY/2,0])rotate([0,0,TextRotation])createText(_fontThickness=Height,_extrude=false);
                }
                // The Border of the outline Frame
                color(BorderColor)
                linear_extrude(height=Height+BorderHeight)
                    offset(r=BorderWidth+OutlineFrameBorderDistance)
                    translate([SizeX/2,SizeY/2,0])rotate([0,0,TextRotation])createText(_fontThickness=Height+TextHeight,_extrude=false);
            }
            // remove the inner part of the outline Frame
            
            color(BaseColor)
            translate([0,0,Height-0.01])
            linear_extrude(height=BorderHeight+Height+0.01)
                offset(r=OutlineFrameBorderDistance)
                translate([SizeX/2,SizeY/2,0])rotate([0,0,TextRotation])createText(_fontThickness=Height+TextHeight,_extrude=false);
            //remove inner artefacts
            translate([0,0,Height])
                linear_extrude(height=Height+0.01)
                    offset(r=-(max(FontSize,FontSize2)))
                    translate([SizeX/2,SizeY/2,0])rotate([0,0,TextRotation])createText(_fontThickness=Height+TextHeight,_extrude=false);
            
         }
        // the actual Text
        color(TextColor)
        translate([0,0,0.02])
        translate([SizeX/2,SizeY/2,0])rotate([0,0,TextRotation])createText(_fontThickness=Height+TextHeight);
         
}

module fontPreview(text="",FontSize=10){
    //[none,Acme,bangers,BioRhyme,BlackOpsOne,bubblegumsans,cevicheOne,Coiny,Cookie,Creepster,,DancingScript,Delius,DeliusSwashCaps,exo,Flavors,FreckleFace,Fruktur,Galindo,Gorditas,GravitasOne,HennyPenny,Inika,JotiOne,Kavoon,LeckerliOne,Lobster,Margarine,MervaleScript,Mogra,MouseMemoirs,MysteryQuest,Oregano,PasseroOne,Peralta,Piedra,Plaster,Ranchers,Risque,SnowburstOne,swankyandmoomoo,Wellfleet,YatraOne]
    Fonts=[  "no font selected"
            ,"Acme"
            ,"bangers"
            ,"BioRhyme"
            ,"BlackOpsOne"
            ,"bubblegumsans"
            ,"cevicheOne"
            ,"Coiny"
            ,"Cookie"
            ,"Creepster",
            ,"DancingScript"
            ,"Delius"
            ,"DeliusSwashCaps"
            ,"exo"
            ,"Flavors"
            ,"FreckleFace"
            ,"Fruktur"
            ,"Galindo"
            ,"Gorditas"
            ,"GravitasOne"
            ,"HennyPenny"
            ,"Inika"
            ,"JotiOne"
            ,"Kavoon"
            ,"LeckerliOne"
            ,"Lobster"
            ,"Margarine"
            ,"MervaleScript"
            ,"Mogra"
            ,"MouseMemoirs"
            ,"MysteryQuest"
            ,"Oregano"
            ,"PasseroOne"
            ,"Peralta"
            ,"Piedra"
            ,"Plaster"
            ,"Ranchers"
            ,"Risque"
            ,"SnowburstOne"
            ,"swankyandmoomoo"
            ,"Wellfleet"
            ,"YatraOne"
    ];
    echo("len=",len(Fonts));
    for(n=[0:floor(len(Fonts)/2)]){
        _text=(text==""?str("Bazinga! ",Fonts[n]):text);
        echo ("n=",n,", Font=",Fonts[n],", text=",_text);
        translate([0,-1*n*(FontSize+5),0])color("black")
        textWriter(
            hAllign1="left",vAllign1="center"
            ,hOffset1=0,vOffset1=0
            ,text1=_text,font1=Fonts[n],fontSize1=FontSize,text1Spacing=1
            ,text2=""
            ,text3=""
            ,text4=""
            ,fontThickness=1
            ,TBwidth=100
            ,TBheight=FontSize+1
            ,extrude=true
            ,debug=false);
    }
    for(n=[ceil(len(Fonts)/2):len(Fonts)-1]){
        _text=(text==""?str("Bazinga! ",Fonts[n]):text);
        echo ("n=",n,", Font=",Fonts[n],", text=",_text);
        translate([210,-1*(n-ceil(len(Fonts)/2))
                        *(FontSize+5),0])color("black")
        textWriter(
            hAllign1="left",vAllign1="center",hOffset1=0,vOffset1=0
            ,text1=_text,font1=Fonts[n],fontSize1=FontSize,text1Spacing=1
            ,text2=""
            ,text3=""
            ,text4=""
            ,fontThickness=1
            ,TBwidth=100
            ,TBheight=FontSize+1
            ,extrude=true
            ,debug=false);
    }
}
    

// Rainer's Cart Caddy
// This file is licensed under the following license:
// https://creativecommons.org/licenses/by-nc-nd/3.0/legalcode
// https://creativecommons.org/licenses/by-nc-nd/3.0/

// (c) 2018 Rainer Schlosshan

// Choose the part to view
part="preview";//[preview:Full Preview (or Single Material Printer),SingleColor_base:Base,SingleColor_border:Border,SingleColor_text:Text]

CoinDiameter=23.2;
CoinThickness=2.25;
HoleDiameter=4;
HandleLength=25;
HandleWidth=9;

// Do you want to create a round Cutout at the "coin" part
RoundCutout=1; // [0:No,1:Yes]


//which percentage of the coin should be created?
CirclePercantage=63;// [50:80]

/* [Border] */
BorderWidthTop=0.5;
BorderDepthTop=0.3;
BorderWidthBottom=0.5;
BorderDepthBottom=0.3;
BorderForHole=1;//[0:No,1:Yes]
BorderLocation=0;//[0:No Border,1:Top,2:Bottom,3:Both]


/* [Text Parameters] */
text1="Smart€";
TextLocation=2;//[0:No Text,1:Top,2:Bottom,3:Both]

DefaultFont="Bangers";//[---Fonts With All Styles Below,AlegreyaSans,exo,exo2,FiraSans,IBMplexSans,IBMplexSansCondensed,Lato,LibreFranklin,Montserat,Nunito,Oswald,Poppins,Roboto,SourceSans,SourceSansPro,SpaceMono,TitilliumWeb,WorkSans,---Other Fonts Below,Allerta,Convergence,DaysOne,RubikMonoOne,Sniglet,Staatliches,Acme,Aladin,Allan,Bangers,BioRhyme,BlackOpsOne,BubblegumSans,CevicheOne,Chango,Coiny,Cookie,Courgette,Creepster,DancingScript,Delius,DeliusSwashCaps,FingerPaint,Flavors,FreckleFace,Fruktur,Galindo,Gorditas,GravitasOne,Griffy,HennyPenny,Inika,JotiOne,Kavoon,LeckerliOne,Lobster,Margarine,MervaleScript,Mogra,MouseMemoirs,MysteryQuest,NothingYouCouldDo,Oregano,Pacifico,PasseroOne,Peralta,Piedra,Plaster,RammettoOne,Ranchers,Risque,RopaSans,SnowburstOne,TheGirlNextDoor,Dwankyandmoomoo,Vibur,WaitingForTheSunrise,Wellfleet,YatraOne] 
HorizontalAllignment="center"; //[left,center,right]
TextHorizontalOffset=0.1;
TextVerticalOffset=0.1;
LineSpacing=1.1;
TextRotation=0;

Font1="Bangers";//[---Fonts With All Styles Below,AlegreyaSans,exo,exo2,FiraSans,IBMplexSans,IBMplexSansCondensed,Lato,LibreFranklin,Montserat,Nunito,Oswald,Poppins,Roboto,SourceSans,SourceSansPro,SpaceMono,TitilliumWeb,WorkSans,---Other Fonts Below,Allerta,Convergence,DaysOne,RubikMonoOne,Sniglet,Staatliches,Acme,Aladin,Allan,Bangers,BioRhyme,BlackOpsOne,BubblegumSans,CevicheOne,Chango,Coiny,Cookie,Courgette,Creepster,DancingScript,Delius,DeliusSwashCaps,FingerPaint,Flavors,FreckleFace,Fruktur,Galindo,Gorditas,GravitasOne,Griffy,HennyPenny,Inika,JotiOne,Kavoon,LeckerliOne,Lobster,Margarine,MervaleScript,Mogra,MouseMemoirs,MysteryQuest,NothingYouCouldDo,Oregano,Pacifico,PasseroOne,Peralta,Piedra,Plaster,RammettoOne,Ranchers,Risque,RopaSans,SnowburstOne,TheGirlNextDoor,Dwankyandmoomoo,Vibur,WaitingForTheSunrise,Wellfleet,YatraOne] 

FontSize=6.5;
Text1Spacing=1;//[0.5,0.55,0.6,0.65,0.7,0.75,0.8,0.85,0.9,0.95,1,1.05,1.1,1.15,1.2,1.25,1.3,1.35,1.4,1.45,1.5]
Style1="ExtraBold";//[Thin:Thin,ExtraLight:Extra Light,Light:Light,"":Regular,Medium:Medium,SemiBold:Semi Bold,Bold:Bold,Black:Black,ExtraBold:Extra Bold]
Italic1=false;


/* [Preview Colors] */
BaseColor="yellow";//[white,black,red,yellow,blue,green,orange,purple,pink,brown,gray,beige,DarkRed,DarkSlateGrey]
TextColor="red";//[white,black,red,yellow,blue,green,orange,purple,pink,brown,gray,beige]
BorderColor="black";//[white,black,red,yellow,blue,green,orange,purple,pink,brown,gray,beige]

/* [Hidden] */
// Part Additional Depth. The border &Font will be placed this deep into the base
PartOverlapDepth=0.3;

$fn=100;
// X Size used to calculate the Frame Sizes
SizeX=HandleLength+ CoinDiameter/2   ;
// Y Size used to calculate the Frame Sizes
SizeY=HandleWidth;

Text1HorizontalOffset=0;
Text1VerticalOffset=0   ;

// Prepare Font style
_FontStr1=str(
(Font1=="default"?DefaultFont:Font1)
,":style="
,(Style1=="Bold"?"Bold":"")
,(Style1=="Black"?"Black":"")
,(Style1=="ExtraBold"?"ExtraBold":"")
,(Style1=="ExtraLight"?"ExtraLight":"")
,(Style1=="Light"?"Light":"")
,(Style1=="Medium"?"Medium":"")
,(Style1=="Regular"?"Regular":"")
,(Style1=="SemiBold"?"SemiBold":"")
,(Style1=="Thin"?"Thin":"")
//," "
,(Italic1?" Italic":""));

//======================================= Show the selected Part
if (part=="preview"){
	difference(){
		union(){
			createBorder();
			createBase();
			createText();
		}//union
		//createHoles();
	}
}else if(part=="SingleColor_base"){
	difference(){
		createBase();
		createBorder();
		createText();
		//createHoles();
	}
}else if(part=="SingleColor_border"){
	difference(){
		createBorder();
		createText();
		//createHoles();
	}
}else if(part=="SingleColor_text"){
	difference(){
		createText();
		//createHoles();
	}
}

// ======================================== Modules
// Create the body
module createBase(){
    color(BaseColor)MakeCoinTool();
}
//rotate([0,0,90])

//create the text
module createText(){
     //[0:No Text,1:1 Top,2:Bottom,3:Both]
    if(TextLocation==1||TextLocation==3){
        // Top 
        color(TextColor)translate([(HandleLength+ CoinDiameter/2)/2,0,CoinThickness-PartOverlapDepth])
        rotate([0,0,TextRotation])
        createTextHelper(_debug=false,_FontCoinThickness=PartOverlapDepth+0.02);
    }
    if(TextLocation==2||TextLocation==3){
        // Bottom
        color(TextColor)
        translate([(HandleLength+ CoinDiameter/2)/2,0,PartOverlapDepth])
        rotate([180,0,0+TextRotation])
        createTextHelper(_debug=false,_FontCoinThickness=PartOverlapDepth+0.02);
    }
    
}
module createBorder(){
    //unterseite
    if(BorderLocation==2||BorderLocation==3){
        translate([HandleLength,0,-0.01])
        rotate([0,0,90]){
            //bottom
            color(BorderColor)
            linear_extrude(height=BorderDepthBottom)
            difference(){
                offset(delta=+0.01)MakeCoin2d();
                offset(delta=-BorderWidthBottom)MakeCoin2d(BorderForHole);
            }
        }
    }
    //oberseite
    if(BorderLocation==1||BorderLocation==3){
        translate([HandleLength,0,CoinThickness-BorderDepthTop+0.01])
        rotate([0,0,90]){
            //top
            color(BorderColor)
            linear_extrude(height=BorderDepthTop)
            difference(){
                offset(delta=+0.01)MakeCoin2d();
                offset(delta=-BorderWidthTop)MakeCoin2d(BorderForHole);
            }
        }
    }
}



module MakeCoinTool(){
    translate([HandleLength,0,0])
    rotate([0,0,90])
    linear_extrude(height=CoinThickness){
        MakeCoin2d();
    }
}
module pie_slice(r, start_angle, end_angle) {

    R = r * sqrt(2) + 1;

    a0 = (4 * start_angle + 0 * end_angle) / 4;

    a1 = (3 * start_angle + 1 * end_angle) / 4;

    a2 = (2 * start_angle + 2 * end_angle) / 4;

    a3 = (1 * start_angle + 3 * end_angle) / 4;

    a4 = (0 * start_angle + 4 * end_angle) / 4;

    if(end_angle > start_angle)

        intersection() {

        circle(r);

        polygon([

            [0,0],

            [R * cos(a0), R * sin(a0)],

            [R * cos(a1), R * sin(a1)],

            [R * cos(a2), R * sin(a2)],

            [R * cos(a3), R * sin(a3)],

            [R * cos(a4), R * sin(a4)],

            [0,0]

       ]);

    }

}



module MakeCoin2d(CutHole=1){
    difference(){
        pie_slice(r=CoinDiameter/2, start_angle=-90-(360/200*CirclePercantage), end_angle=-90+(360/200*CirclePercantage));
        if(RoundCutout==1)translate([0,-CoinDiameter/1.2,0])circle(r=CoinDiameter/2);
    }
        difference(){
            union(){
                translate([-HandleWidth/2,0,0])
                square([HandleWidth,HandleLength]);
                translate([0,HandleLength])circle(r=HandleWidth/2);
            }
            if(CutHole)translate([0,HandleLength])circle(r=HoleDiameter/2);
        }
}
module MakeCoin2dorg(CutHole=1){
    difference(){
            circle(r=CoinDiameter/2);
            translate([-CoinDiameter/2,0,0])square([CoinDiameter,CoinDiameter]);
        }
        difference(){
            union(){
                translate([-HandleWidth/2,0,0])
                square([HandleWidth,HandleLength]);
                translate([0,HandleLength])circle(r=HandleWidth/2);
            }
            if(CutHole)translate([0,HandleLength])circle(r=HoleDiameter/2);
        }
}
module createTextHelper(
_hAllign1=HorizontalAllignment
,_vAllign1="center"

,_hOffset1=Text1HorizontalOffset
,_vOffset1=Text1VerticalOffset
,_text1=text1
,_Font1=_FontStr1
,_FontSize1=FontSize
,_Text1Spacing=Text1Spacing


,_FontCoinThickness=1
,_TBwidth=SizeX
,_TBheight=SizeY
,_extrude=true
,_debug=false)
{
	translate([TextHorizontalOffset,TextVerticalOffset,0])
	textWriter(
	hAllign1=_hAllign1,vAllign1=_vAllign1
	,hOffset1=_hOffset1,vOffset1=_vOffset1
	,text1=_text1,Font1=_Font1,FontSize1=_FontSize1,Text1Spacing=_Text1Spacing
	
	
	,FontCoinThickness=_FontCoinThickness
	,TBwidth=_TBwidth
	,TBheight=_TBheight
	,extrude=_extrude
	,debug=_debug);

}    
module textWriter(
    hAllign1="center",vAllign1="center"
    ,hOffset1=0,vOffset1=0,
    text1="text1",Font1="",FontSize1=10,Text1Spacing=1
    ,hOffset2=0,vOffset2=0
    ,text2="",Font2="",FontSize2=10,Text2Spacing=1
    ,hOffset3=0,vOffset3=0
    ,text3="",Font3="",FontSize3=10,Text3Spacing=1
    ,hOffset4=0,vOffset4=0
    ,text4="",Font4="",FontSize4=10,Text4Spacing=1
    ,hOffset5=0,vOffset5=0
    ,text5="",Font5="",FontSize5=10,Text5Spacing=1
    ,hOffset6=0,vOffset6=0
    ,text6="",Font6="",FontSize6=10,Text6Spacing=1
    ,hOffset7=0,vOffset7=0
    ,text7="",Font7="",FontSize7=10,Text7Spacing=1
    ,hOffset8=0,vOffset8=0
    ,text8="",Font8="",FontSize8=10,Text8Spacing=1
    ,FontCoinThickness=5
    ,TBwidth=100,TBheight=50
    ,extrude=true
    ,debug=false)
{
	TBheight2=TBheight-2;
	TBwidth2=TBwidth-2;
	if(debug)translate([-TBwidth2/2,-TBheight2/2,0])cube([TBwidth2,TBheight2,1]);
	linespacing=LineSpacing;
	// Calculate Total Height
	height=0
	+(text1!=""
	?FontSize1//+linespacing
	:0)	;
	
	_yAllign=(vAllign1=="bottom"
	? - (TBheight2/2)+height/2
	: (vAllign1=="top"
	?(TBheight2/2)-(height/2)
	:0))
	+(text3!=""?(FontSize3+linespacing):0);
	
	_y1height=0+(text1!=""
	?FontSize1+linespacing
	:0);
	_y2height= 0+(text2!=""
	?FontSize2+linespacing
	:0);
	_y3height= 0+(text3!=""
	?FontSize3+linespacing
	:0);
	_y4height= 0+(text4!=""
	?FontSize4+linespacing
	:0);
	_y5height= 0+(text5!=""
	?FontSize5+linespacing
	:0);
	_y6height= 0+(text6!=""
	?FontSize6+linespacing
	:0);
	_y7height= 0+(text7!=""
	?FontSize7+linespacing
	:0);
	_y8height= 0+(text8!=""
	?FontSize8+linespacing
	:0);
	
	_y1=height/2-FontSize1 ;
	_y2=height/2-FontSize2 -_y1height;
	_y3=height/2-FontSize3 -_y1height-_y2height;
	_y4=height/2-FontSize4 -_y1height-_y2height-_y3height;
	_y5=height/2-FontSize5 -_y1height-_y2height-_y3height-_y4height;
	_y6=height/2-FontSize6 -_y1height-_y2height-_y3height-_y4height-_y5height;
	_y7=height/2-FontSize7 -_y1height-_y2height-_y3height-_y4height-_y5height-_y6height;
	_y8=height/2-FontSize7 -_y1height-_y2height-_y3height-_y4height-_y5height-_y6height-_y7height;
	
	posX=(hAllign1=="left"
	? -TBwidth2/2
	: (hAllign1=="right"
	?TBwidth2/2
	:0)
	);

	if(extrude){
		translate([0,0,(FontCoinThickness<0?FontCoinThickness+0.01:0)])
		union(){
			translate([posX+hOffset1,_y1+vOffset1,0])
			linear_extrude(height=abs(FontCoinThickness)) 
			text(text1,size=FontSize1, font=Font1,  halign = hAllign1,valign = "baseline",spacing=Text1Spacing); 
			if(text2!=""){
				translate([posX+hOffset2,_y2+vOffset2,0])
				linear_extrude(height=abs(FontCoinThickness)) 
				text(text2,size=FontSize2, font=Font2,  halign = hAllign1,valign = "baseline",spacing=Text2Spacing); 
			}
			if(text3!=""){
				translate([posX+hOffset3,_y3+vOffset3,0])
				linear_extrude(height=abs(FontCoinThickness)) 
				text(text3,size=FontSize3, font=Font3,  halign = hAllign1,valign = "baseline",spacing=Text3Spacing); 
			}
			if(text4!=""){
				translate([posX+hOffset4,_y4+vOffset4,0])
				linear_extrude(height=abs(FontCoinThickness)) 
				text(text4,size=FontSize4, font=Font4,  halign = hAllign1,valign = "baseline",spacing=Text4Spacing); 
			}
			if(text5!=""){
				translate([posX+hOffset5,_y5+vOffset5,0])
				linear_extrude(height=abs(FontCoinThickness)) 
				text(text5,size=FontSize5, font=Font5,  halign = hAllign1,valign = "baseline",spacing=Text5Spacing); 
			}
			if(text6!=""){
				translate([posX+hOffset6,_y6+vOffset6,0])
				linear_extrude(height=abs(FontCoinThickness)) 
				text(text6,size=FontSize6, font=Font6,  halign = hAllign1,valign = "baseline",spacing=Text6Spacing); 
			}
			if(text7!=""){
				translate([posX+hOffset7,_y7+vOffset7,0])
				linear_extrude(height=abs(FontCoinThickness)) 
				text(text7,size=FontSize7, font=Font7,  halign = hAllign1,valign = "baseline",spacing=Text7Spacing); 
			}
			if(text8!=""){
				translate([posX+hOffset8,_y8+vOffset8,0])
				linear_extrude(height=abs(FontCoinThickness)) 
				text(text8,size=FontSize8, font=Font8,  halign = hAllign1,valign = "baseline",spacing=Text8Spacing); 
			}
		}
	}else{
		translate([0,0,(FontCoinThickness<0?FontCoinThickness+0.01:0)])
		union(){
			translate([posX+hOffset1,_y1+vOffset1,0])
			text(text1,size=FontSize1, font=Font1,  halign = hAllign1,valign = "baseline",spacing=Text1Spacing); 
			if(text2!=""){
				translate([posX+hOffset2,_y2+vOffset2,0])
				text(text2,size=FontSize2, font=Font2,  halign = hAllign1,valign = "baseline",spacing=Text2Spacing); 
			}
			if(text3!=""){
				translate([posX+hOffset3,_y3+vOffset3,0])
				text(text3,size=FontSize3, font=Font3,  halign = hAllign1,valign = "baseline",spacing=Text3Spacing); 
			}
			if(text4!=""){
				translate([posX+hOffset4,_y4+vOffset4,0])
				text(text4,size=FontSize4, font=Font4,  halign = hAllign1,valign = "baseline",spacing=Text4Spacing); 
			}
			if(text5!=""){
				translate([posX+hOffset5,_y5+vOffset5,0])
				text(text5,size=FontSize5, font=Font5,  halign = hAllign1,valign = "baseline",spacing=Text5Spacing); 
			}
			if(text6!=""){
				translate([posX+hOffset6,_y6+vOffset6,0])
				text(text6,size=FontSize6, font=Font6,  halign = hAllign1,valign = "baseline",spacing=Text6Spacing); 
			}
			if(text7!=""){
				translate([posX+hOffset7,_y7+vOffset7,0])
				text(text7,size=FontSize7, font=Font7,  halign = hAllign1,valign = "baseline",spacing=Text7Spacing); 
			}
			if(text8!=""){
				translate([posX+hOffset8,_y6+vOffset8,0])
				text(text8,size=FontSize8, font=Font8,  halign = hAllign1,valign = "baseline",spacing=Text8Spacing); 
			}
		}
	}
}
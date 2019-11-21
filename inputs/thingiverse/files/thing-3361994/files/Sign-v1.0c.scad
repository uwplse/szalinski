// This file is licensed under the following license:
// https://creativecommons.org/licenses/by-nc-nd/3.0/legalcode
// https://creativecommons.org/licenses/by-nc-nd/3.0/

// (c) 2018 Rainer Schlosshan

//preview[view:south, tilt:top]
// Choose the part to view
part="preview";//[preview:Full Preview (or Single Material) Printer,SingleColor_base:Base,SingleColor_border:Border,SingleColor_text:Text]

FrameType=0; //[0:Rounded Rectangle,1:Circle/Ellipse,3:Triangle,4:triangle UpsideDown,5:pentagon(5),6:hexagon(6),8:Octagon(8)]

text1="Welcome to the"; 
text2="Sign Workshop!";
text3="";
text4="";
text5="";
text6="";
text7="";
text8="";

// X Size used to calculate the Frame Sizes
SizeX=110    ;
// Y Size used to calculate the Frame Sizes
SizeY=60;

/* [Advanced Sign Layout] */
BaseHeight=2.5;
BorderHeight=1.5;
BorderWidth=2.5;
TextHeight=2.5;

// Radius of the corners (Higher makes the corners "rounder")
CornerRadius=2;
// Width of the additional base outside of the border
AdditionalBaseWidth=2;

/* [Text General Parameters] */
DefaultFont="Lato";//[---Fonts With All Styles Below,AlegreyaSans,exo,exo2,FiraSans,IBMplexSans,IBMplexSansCondensed,Lato,LibreFranklin,Montserat,Nunito,Oswald,Poppins,Roboto,SourceSans,SourceSansPro,SpaceMono,TitilliumWeb,WorkSans,---Other Fonts Below,Allerta,Convergence,DaysOne,RubikMonoOne,Sniglet,Staatliches,Acme,Aladin,Allan,Bangers,BioRhyme,BlackOpsOne,BubblegumSans,CevicheOne,Chango,Coiny,Cookie,Courgette,Creepster,DancingScript,Delius,DeliusSwashCaps,FingerPaint,Flavors,FreckleFace,Fruktur,Galindo,Gorditas,GravitasOne,Griffy,HennyPenny,Inika,JotiOne,Kavoon,LeckerliOne,Lobster,Margarine,MervaleScript,Mogra,MouseMemoirs,MysteryQuest,NothingYouCouldDo,Oregano,Pacifico,PasseroOne,Peralta,Piedra,Plaster,RammettoOne,Ranchers,Risque,RopaSans,SnowburstOne,TheGirlNextDoor,Dwankyandmoomoo,Vibur,WaitingForTheSunrise,Wellfleet,YatraOne] 

HorizontalAllignment="center"; //[left,center,right]
TextHorizontalOffset=0.1;
TextVerticalOffset=0.1;
LineSpacing=1.1;
TextRotation=0;

/* [Text Line 1 Format] */
Font1="default";//[default,---Fonts With All Styles Below,AlegreyaSans,exo,exo2,FiraSans,IBMplexSans,IBMplexSansCondensed,Lato,LibreFranklin,Montserat,Nunito,Oswald,Poppins,Roboto,SourceSans,SourceSansPro,SpaceMono,TitilliumWeb,WorkSans,---Other Fonts Below,Allerta,Convergence,DaysOne,RubikMonoOne,Sniglet,Staatliches,Acme,Aladin,Allan,Bangers,BioRhyme,BlackOpsOne,BubblegumSans,CevicheOne,Chango,Coiny,Cookie,Courgette,Creepster,DancingScript,Delius,DeliusSwashCaps,FingerPaint,Flavors,FreckleFace,Fruktur,Galindo,Gorditas,GravitasOne,Griffy,HennyPenny,Inika,JotiOne,Kavoon,LeckerliOne,Lobster,Margarine,MervaleScript,Mogra,MouseMemoirs,MysteryQuest,NothingYouCouldDo,Oregano,Pacifico,PasseroOne,Peralta,Piedra,Plaster,RammettoOne,Ranchers,Risque,RopaSans,SnowburstOne,TheGirlNextDoor,Dwankyandmoomoo,Vibur,WaitingForTheSunrise,Wellfleet,YatraOne] 
FontSize=10;
Text1Spacing=1;//[0.5,0.55,0.6,0.65,0.7,0.75,0.8,0.85,0.9,0.95,1,1.05,1.1,1.15,1.2,1.25,1.3,1.35,1.4,1.45,1.5]
Style1="ExtraBold";//[Thin:Thin,ExtraLight:Extra Light,Light:Light,"":Regular,Medium:Medium,SemiBold:Semi Bold,Bold:Bold,Black:Black,ExtraBold:Extra Bold]
Italic1=false;
Text1HorizontalOffset=0;
Text1VerticalOffset=4;

/* [Text Line 2 Format] */
Font2="default"; //[default,---Fonts With All Styles Below,AlegreyaSans,exo,exo2,FiraSans,IBMplexSans,IBMplexSansCondensed,Lato,LibreFranklin,Montserat,Nunito,Oswald,Poppins,Roboto,SourceSans,SourceSansPro,SpaceMono,TitilliumWeb,WorkSans,---Other Fonts Below,Allerta,Convergence,DaysOne,RubikMonoOne,Sniglet,Staatliches,Acme,Aladin,Allan,Bangers,BioRhyme,BlackOpsOne,BubblegumSans,CevicheOne,Chango,Coiny,Cookie,Courgette,Creepster,DancingScript,Delius,DeliusSwashCaps,FingerPaint,Flavors,FreckleFace,Fruktur,Galindo,Gorditas,GravitasOne,Griffy,HennyPenny,Inika,JotiOne,Kavoon,LeckerliOne,Lobster,Margarine,MervaleScript,Mogra,MouseMemoirs,MysteryQuest,NothingYouCouldDo,Oregano,Pacifico,PasseroOne,Peralta,Piedra,Plaster,RammettoOne,Ranchers,Risque,RopaSans,SnowburstOne,TheGirlNextDoor,Dwankyandmoomoo,Vibur,WaitingForTheSunrise,Wellfleet,YatraOne] 
FontSize2=10;
Text2Spacing=1;//[0.7,0.75,0.8,0.85,0.9,0.95,1,1.05,1.1,1.15,1.2,1.25,1.3]
Style2="";//[Thin:Thin,ExtraLight:Extra Light,Light:Light,"":Regular,Medium:Medium,SemiBold:Semi Bold,Bold:Bold,Black:Black,ExtraBold:Extra Bold]
Italic2=false;
Text2HorizontalOffset=0;
Text2VerticalOffset=0;

/* [Text Line 3 Format] */
Font3="default"; //[default,---Fonts With All Styles Below,AlegreyaSans,exo,exo2,FiraSans,IBMplexSans,IBMplexSansCondensed,Lato,LibreFranklin,Montserat,Nunito,Oswald,Poppins,Roboto,SourceSans,SourceSansPro,SpaceMono,TitilliumWeb,WorkSans,---Other Fonts Below,Allerta,Convergence,DaysOne,RubikMonoOne,Sniglet,Staatliches,Acme,Aladin,Allan,Bangers,BioRhyme,BlackOpsOne,BubblegumSans,CevicheOne,Chango,Coiny,Cookie,Courgette,Creepster,DancingScript,Delius,DeliusSwashCaps,FingerPaint,Flavors,FreckleFace,Fruktur,Galindo,Gorditas,GravitasOne,Griffy,HennyPenny,Inika,JotiOne,Kavoon,LeckerliOne,Lobster,Margarine,MervaleScript,Mogra,MouseMemoirs,MysteryQuest,NothingYouCouldDo,Oregano,Pacifico,PasseroOne,Peralta,Piedra,Plaster,RammettoOne,Ranchers,Risque,RopaSans,SnowburstOne,TheGirlNextDoor,Dwankyandmoomoo,Vibur,WaitingForTheSunrise,Wellfleet,YatraOne] 
FontSize3=10;
Text3Spacing=1;//[0.7,0.75,0.8,0.85,0.9,0.95,1,1.05,1.1,1.15,1.2,1.25,1.3]
Style3="";//[Thin:Thin,ExtraLight:Extra Light,Light:Light,"":Regular,Medium:Medium,SemiBold:Semi Bold,Bold:Bold,Black:Black,ExtraBold:Extra Bold]
Italic3=false;
Text3HorizontalOffset=0;
Text3VerticalOffset=0;

/* [Text Line 4 Format] */
Font4="default"; //[default,---Fonts With All Styles Below,AlegreyaSans,exo,exo2,FiraSans,IBMplexSans,IBMplexSansCondensed,Lato,LibreFranklin,Montserat,Nunito,Oswald,Poppins,Roboto,SourceSans,SourceSansPro,SpaceMono,TitilliumWeb,WorkSans,---Other Fonts Below,Allerta,Convergence,DaysOne,RubikMonoOne,Sniglet,Staatliches,Acme,Aladin,Allan,Bangers,BioRhyme,BlackOpsOne,BubblegumSans,CevicheOne,Chango,Coiny,Cookie,Courgette,Creepster,DancingScript,Delius,DeliusSwashCaps,FingerPaint,Flavors,FreckleFace,Fruktur,Galindo,Gorditas,GravitasOne,Griffy,HennyPenny,Inika,JotiOne,Kavoon,LeckerliOne,Lobster,Margarine,MervaleScript,Mogra,MouseMemoirs,MysteryQuest,NothingYouCouldDo,Oregano,Pacifico,PasseroOne,Peralta,Piedra,Plaster,RammettoOne,Ranchers,Risque,RopaSans,SnowburstOne,TheGirlNextDoor,Dwankyandmoomoo,Vibur,WaitingForTheSunrise,Wellfleet,YatraOne] 
FontSize4=10;
Text4Spacing=1;//[0.7,0.75,0.8,0.85,0.9,0.95,1,1.05,1.1,1.15,1.2,1.25,1.3]
Style4="";//[Thin:Thin,ExtraLight:Extra Light,Light:Light,"":Regular,Medium:Medium,SemiBold:Semi Bold,Bold:Bold,Black:Black,ExtraBold:Extra Bold]
Italic4=false;
Text4HorizontalOffset=0;
Text4VerticalOffset=0;

/* [Text Line 5 Format] */
Font5="default"; //[default,---Fonts With All Styles Below,AlegreyaSans,exo,exo2,FiraSans,IBMplexSans,IBMplexSansCondensed,Lato,LibreFranklin,Montserat,Nunito,Oswald,Poppins,Roboto,SourceSans,SourceSansPro,SpaceMono,TitilliumWeb,WorkSans,---Other Fonts Below,Allerta,Convergence,DaysOne,RubikMonoOne,Sniglet,Staatliches,Acme,Aladin,Allan,Bangers,BioRhyme,BlackOpsOne,BubblegumSans,CevicheOne,Chango,Coiny,Cookie,Courgette,Creepster,DancingScript,Delius,DeliusSwashCaps,FingerPaint,Flavors,FreckleFace,Fruktur,Galindo,Gorditas,GravitasOne,Griffy,HennyPenny,Inika,JotiOne,Kavoon,LeckerliOne,Lobster,Margarine,MervaleScript,Mogra,MouseMemoirs,MysteryQuest,NothingYouCouldDo,Oregano,Pacifico,PasseroOne,Peralta,Piedra,Plaster,RammettoOne,Ranchers,Risque,RopaSans,SnowburstOne,TheGirlNextDoor,Dwankyandmoomoo,Vibur,WaitingForTheSunrise,Wellfleet,YatraOne] 
FontSize5=10;
Text5Spacing=1;//[0.7,0.75,0.8,0.85,0.9,0.95,1,1.05,1.1,1.15,1.2,1.25,1.3]
Style5="";//[Thin:Thin,ExtraLight:Extra Light,Light:Light,"":Regular,Medium:Medium,SemiBold:Semi Bold,Bold:Bold,Black:Black,ExtraBold:Extra Bold]
Italic5=false;
Text5HorizontalOffset=0;
Text5VerticalOffset=0;

/* [Text Line 6 Format] */
Font6="default"; //[default,---Fonts With All Styles Below,AlegreyaSans,exo,exo2,FiraSans,IBMplexSans,IBMplexSansCondensed,Lato,LibreFranklin,Montserat,Nunito,Oswald,Poppins,Roboto,SourceSans,SourceSansPro,SpaceMono,TitilliumWeb,WorkSans,---Other Fonts Below,Allerta,Convergence,DaysOne,RubikMonoOne,Sniglet,Staatliches,Acme,Aladin,Allan,Bangers,BioRhyme,BlackOpsOne,BubblegumSans,CevicheOne,Chango,Coiny,Cookie,Courgette,Creepster,DancingScript,Delius,DeliusSwashCaps,FingerPaint,Flavors,FreckleFace,Fruktur,Galindo,Gorditas,GravitasOne,Griffy,HennyPenny,Inika,JotiOne,Kavoon,LeckerliOne,Lobster,Margarine,MervaleScript,Mogra,MouseMemoirs,MysteryQuest,NothingYouCouldDo,Oregano,Pacifico,PasseroOne,Peralta,Piedra,Plaster,RammettoOne,Ranchers,Risque,RopaSans,SnowburstOne,TheGirlNextDoor,Dwankyandmoomoo,Vibur,WaitingForTheSunrise,Wellfleet,YatraOne] 
FontSize6=10;
Text6Spacing=1;//[0.7,0.75,0.8,0.85,0.9,0.95,1,1.05,1.1,1.15,1.2,1.25,1.3]
Style6="";//[Thin:Thin,ExtraLight:Extra Light,Light:Light,"":Regular,Medium:Medium,SemiBold:Semi Bold,Bold:Bold,Black:Black,ExtraBold:Extra Bold]
Italic6=false;
Text6HorizontalOffset=0;
Text6VerticalOffset=0;

/* [Text Line 7 Format] */
Font7="default"; //[default,---Fonts With All Styles Below,AlegreyaSans,exo,exo2,FiraSans,IBMplexSans,IBMplexSansCondensed,Lato,LibreFranklin,Montserat,Nunito,Oswald,Poppins,Roboto,SourceSans,SourceSansPro,SpaceMono,TitilliumWeb,WorkSans,---Other Fonts Below,Allerta,Convergence,DaysOne,RubikMonoOne,Sniglet,Staatliches,Acme,Aladin,Allan,Bangers,BioRhyme,BlackOpsOne,BubblegumSans,CevicheOne,Chango,Coiny,Cookie,Courgette,Creepster,DancingScript,Delius,DeliusSwashCaps,FingerPaint,Flavors,FreckleFace,Fruktur,Galindo,Gorditas,GravitasOne,Griffy,HennyPenny,Inika,JotiOne,Kavoon,LeckerliOne,Lobster,Margarine,MervaleScript,Mogra,MouseMemoirs,MysteryQuest,NothingYouCouldDo,Oregano,Pacifico,PasseroOne,Peralta,Piedra,Plaster,RammettoOne,Ranchers,Risque,RopaSans,SnowburstOne,TheGirlNextDoor,Dwankyandmoomoo,Vibur,WaitingForTheSunrise,Wellfleet,YatraOne] 
FontSize7=10;
Text7Spacing=1;//[0.7,0.75,0.8,0.85,0.9,0.95,1,1.05,1.1,1.15,1.2,1.25,1.3]
Style7="";//[Thin:Thin,ExtraLight:Extra Light,Light:Light,"":Regular,Medium:Medium,SemiBold:Semi Bold,Bold:Bold,Black:Black,ExtraBold:Extra Bold]
Italic7=false;
Text7HorizontalOffset=0;
Text7VerticalOffset=0;

/* [Text Line 8 Format] */
Font8="default"; //[default,---Fonts With All Styles Below,AlegreyaSans,exo,exo2,FiraSans,IBMplexSans,IBMplexSansCondensed,Lato,LibreFranklin,Montserat,Nunito,Oswald,Poppins,Roboto,SourceSans,SourceSansPro,SpaceMono,TitilliumWeb,WorkSans,---Other Fonts Below,Allerta,Convergence,DaysOne,RubikMonoOne,Sniglet,Staatliches,Acme,Aladin,Allan,Bangers,BioRhyme,BlackOpsOne,BubblegumSans,CevicheOne,Chango,Coiny,Cookie,Courgette,Creepster,DancingScript,Delius,DeliusSwashCaps,FingerPaint,Flavors,FreckleFace,Fruktur,Galindo,Gorditas,GravitasOne,Griffy,HennyPenny,Inika,JotiOne,Kavoon,LeckerliOne,Lobster,Margarine,MervaleScript,Mogra,MouseMemoirs,MysteryQuest,NothingYouCouldDo,Oregano,Pacifico,PasseroOne,Peralta,Piedra,Plaster,RammettoOne,Ranchers,Risque,RopaSans,SnowburstOne,TheGirlNextDoor,Dwankyandmoomoo,Vibur,WaitingForTheSunrise,Wellfleet,YatraOne] 
FontSize8=10;
Text8Spacing=1;//[0.7,0.75,0.8,0.85,0.9,0.95,1,1.05,1.1,1.15,1.2,1.25,1.3]
Style8="";//[Thin:Thin,ExtraLight:Extra Light,Light:Light,"":Regular,Medium:Medium,SemiBold:Semi Bold,Bold:Bold,Black:Black,ExtraBold:Extra Bold]
Italic8=false;
Text8HorizontalOffset=0;
Text8VerticalOffset=0;

/* [Mounting Holes] */
// Currently only optimized for a rectagular sign
MountingHoles=0;//[0,1,2,4]
MountingHoleDiameter=3.1;
MountingHoleCountersunk=1;//[0:no,1:yes]
// Distance from the outer edge
MountingHoleDistance=5.5;

// Optional additional Distance on X Axis
MountingHoleXDistance=0.1;
// Optional additional Distance on Y Axis
MountingHoleYDistance=0.1;

/* [Bottom Magnets] */
// Number of Magnet Cutouts 
MagnetCount=0; // [0,1,2,4]
// Diameter of your Magnets (add some tolerance!)
MagnetDiameter=8.3;
// Height of your Magnets (add some tolerance!)
MagnetHeight=2.2;

/* [Preview Colors] */
BaseColor="white";//[white,black,red,yellow,blue,green,orange,purple,pink,brown,gray,beige]
TextColor="red";//[white,black,red,yellow,blue,green,orange,purple,pink,brown,gray,beige]
BorderColor="black";//[white,black,red,yellow,blue,green,orange,purple,pink,brown,gray,beige]

/* [Helpers] */
// If you want to render a complete FontList change this parameter
// check this to highlight the mounting holes&magnets during preview
HoleDebug=0;//[1:Yes,0:No]
DisplayFontList=0; //[0:No,1:Yes]



//===============================================================================

// ignore variable values below
/* [Hidden] */

// Part Additional Depth. The border &Font will be placed this deep into the base
PartOverlapDepth=0.3;
$fn=76;
//Automatically adjust variables
radius=-0
+(CornerRadius>=min(SizeX,SizeY)/2
?min(SizeX,SizeY)/2
:CornerRadius);
if(radius!=CornerRadius)
echo(str("<b><Font color='orange'>Automatically adjusted CornerRadius from ",CornerRadius," to ",radius));
//Adjust base Height based on Magnet Height
Height=(BaseHeight<MagnetHeight+1 && MagnetCount > 0?MagnetHeight+1:BaseHeight);
if(Height!=BaseHeight)
echo(str("<b><Font color='orange'>Automatically adjusted BaseHeight from ",BaseHeight," to ",Height));

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
_FontStr2=str(
(Font2=="default"?DefaultFont:Font2)
,":style="
,(Style2=="Bold"?"Bold":"")
,(Style2=="Black"?"Black":"")
,(Style2=="ExtraBold"?"ExtraBold":"")
,(Style2=="ExtraLight"?"ExtraLight":"")
,(Style2=="Light"?"Light":"")
,(Style2=="Medium"?"Medium":"")
,(Style2=="Regular"?"Regular":"")
,(Style2=="SemiBold"?"SemiBold":"")
,(Style2=="Thin"?"Thin":"")
,(Italic2?" Italic":""));
_FontStr3=str(
(Font3=="default"?DefaultFont:Font3)
,":style="
,(Style3=="Bold"?"Bold":"")
,(Style3=="Black"?"Black":"")
,(Style3=="ExtraBold"?"ExtraBold":"")
,(Style3=="ExtraLight"?"ExtraLight":"")
,(Style3=="Light"?"Light":"")
,(Style3=="Medium"?"Medium":"")
,(Style3=="Regular"?"Regular":"")
,(Style3=="SemiBold"?"SemiBold":"")
,(Style3=="Thin"?"Thin":"")
,(Italic3?" Italic":""));
_FontStr4=str(
(Font4=="default"?DefaultFont:Font4)
,":style="
,(Style4=="Bold"?"Bold":"")
,(Style4=="Black"?"Black":"")
,(Style4=="ExtraBold"?"ExtraBold":"")
,(Style4=="ExtraLight"?"ExtraLight":"")
,(Style4=="Light"?"Light":"")
,(Style4=="Medium"?"Medium":"")
,(Style4=="Regular"?"Regular":"")
,(Style4=="SemiBold"?"SemiBold":"")
,(Style4=="Thin"?"Thin ":"")
,(Italic4?" Italic":""));
_FontStr5=str(
(Font5=="default"?DefaultFont:Font5)
,":style="
,(Style5=="Bold"?"Bold":"")
,(Style5=="Black"?"Black":"")
,(Style5=="ExtraBold"?"ExtraBold":"")
,(Style5=="ExtraLight"?"ExtraLight":"")
,(Style5=="Light"?"Light":"")
,(Style5=="Medium"?"Medium":"")
,(Style5=="Regular"?"Regular":"")
,(Style5=="SemiBold"?"SemiBold":"")
,(Style5=="Thin"?"Thin":"")
,(Italic5?" Italic":""));
_FontStr6=str(
(Font6=="default"?DefaultFont:Font6)
,":style="
,(Style6=="Bold"?"Bold":"")
,(Style6=="Black"?"Black":"")
,(Style6=="ExtraBold"?"ExtraBold":"")
,(Style6=="ExtraLight"?"ExtraLight":"")
,(Style6=="Light"?"Light":"")
,(Style6=="Medium"?"Medium":"")
,(Style6=="Regular"?"Regular":"")
,(Style6=="SemiBold"?"SemiBold":"")
,(Style6=="Thin"?"Thin":"")
,(Italic6?" Italic":""));
_FontStr7=str(
(Font7=="default"?DefaultFont:Font7)
,":style="
,(Style7=="Bold"?"Bold":"")
,(Style7=="Black"?"Black":"")
,(Style7=="ExtraBold"?"ExtraBold":"")
,(Style7=="ExtraLight"?"ExtraLight":"")
,(Style7=="Light"?"Light":"")
,(Style7=="Medium"?"Medium":"")
,(Style7=="Regular"?"Regular":"")
,(Style7=="SemiBold"?"SemiBold":"")
,(Style7=="Thin"?"Thin":"")
,(Italic7?" Italic":""));
_FontStr8=str(
(Font8=="default"?DefaultFont:Font8)
,":style="
,(Style8=="Bold"?"Bold":"")
,(Style8=="Black"?"Black":"")
,(Style8=="ExtraBold"?"ExtraBold":"")
,(Style8=="ExtraLight"?"ExtraLight":"")
,(Style8=="Light"?"Light":"")
,(Style8=="Medium"?"Medium":"")
,(Style8=="Regular"?"Regular":"")
,(Style8=="SemiBold"?"SemiBold":"")
,(Style8=="Thin"?"Thin":"")
,(Italic8?" Italic":""));

//ToDo List
if(false){
	echo("<h1>ToDo's left!");
	echo("");
}
if(DisplayFontList){
	FontPreview();
}else if (part=="preview"){
	difference(){
		union(){
			createBorder();
			createBase();
			createText();
		}//union
		createHoles();
	}
}else if(part=="SingleColor_base"){
	difference(){
		createBase();
		createBorder();
		createText();
		createHoles();
	}
}else if(part=="SingleColor_border"){
	difference(){
		createBorder();
		createText();
		createHoles();
	}
}else if(part=="SingleColor_text"){
	difference(){
		createText();
		createHoles();
	}
}

// the writing space
//cube([SizeX,SizeY,0.5]);

module createBase(noMagnet=false){
	color(BaseColor){
		difference(){
			union(){
				//create the base including base for border&AdditionalBaseWidth
				if(FrameType==0){ //rounded rectangle
					roundedFrame(r=radius,SizeX=SizeX,SizeY=SizeY
					,Height=Height,SizeInc=BorderWidth+AdditionalBaseWidth);
				}
                if(FrameType==1){ //circle/ellipse
					ellipse(SizeX=SizeX,SizeY=SizeY
					,Height=Height,SizeInc=BorderWidth+AdditionalBaseWidth);
				}
				if(FrameType==3){ //Triangle
					RoundedMultigon(NumSides=3,r=CornerRadius,SizeX=SizeX,SizeY=SizeY
					,Height=Height
					,SizeInc=BorderWidth+AdditionalBaseWidth
					,rotate=90);
				}
				if(FrameType==4){ //triagnle upsidedown
					RoundedMultigon(NumSides=3,r=CornerRadius,SizeX=SizeX,SizeY=SizeY
					,Height=Height
					,SizeInc=BorderWidth+AdditionalBaseWidth
					,rotate=-90);
				}
				if(FrameType==5){ //pentagon
					RoundedMultigon(NumSides=5,r=CornerRadius,SizeX=SizeX,SizeY=SizeY
					,Height=Height
					,SizeInc=BorderWidth+AdditionalBaseWidth
					,rotate=90);
				}
				if(FrameType==6){ //hexagon
					RoundedMultigon(NumSides=6,r=CornerRadius,SizeX=SizeX,SizeY=SizeY
					,Height=Height,SizeInc=BorderWidth+AdditionalBaseWidth);
				}
				if(FrameType==8){ //Octagon
					RoundedMultigon(NumSides=8,r=CornerRadius,SizeX=SizeX,SizeY=SizeY
					,Height=Height,SizeInc=BorderWidth+AdditionalBaseWidth,rotate=360/8/2);
				}
			}//union
			if(noMagnet==false)createMagnets();
		}//difference
	}//color
}

module createBorder(){
	color(BorderColor){
		difference(){
			translate([0,0,Height-PartOverlapDepth+0.01])union(){
				if(FrameType==0){ //rounded rectangle
					//Draw a recttangle with outer size
					roundedFrame(r=radius,SizeX=SizeX,SizeY=SizeY
					,Height=BorderHeight+PartOverlapDepth,SizeInc=BorderWidth);
				}
                if(FrameType==1){ //circle/ellipse
					ellipse(SizeX=SizeX,SizeY=SizeY
					,Height=BorderHeight+PartOverlapDepth,SizeInc=BorderWidth);
				}
				if(FrameType==3){ //triangle
					RoundedMultigon(NumSides=3,r=CornerRadius,SizeX=SizeX,SizeY=SizeY
					,Height=BorderHeight+PartOverlapDepth,SizeInc=BorderWidth
					,rotate=90);
				}
				if(FrameType==4){ //triangleUpsideDown
					RoundedMultigon(NumSides=3,r=CornerRadius,SizeX=SizeX,SizeY=SizeY
					,Height=BorderHeight+PartOverlapDepth,SizeInc=BorderWidth
					,rotate=-90);
				}
				if(FrameType==5){ //pentagon
					RoundedMultigon(NumSides=5,r=CornerRadius,SizeX=SizeX,SizeY=SizeY
					,Height=BorderHeight+PartOverlapDepth,SizeInc=BorderWidth
					,rotate=90);
				}
				if(FrameType==6){ //hexagon
					RoundedMultigon(NumSides=6,r=CornerRadius,SizeX=SizeX,SizeY=SizeY
					,Height=BorderHeight+PartOverlapDepth,SizeInc=BorderWidth);
				}
				if(FrameType==8){ //hexagon
					RoundedMultigon(NumSides=8,r=CornerRadius,SizeX=SizeX,SizeY=SizeY
					,Height=BorderHeight+PartOverlapDepth,SizeInc=BorderWidth,rotate=360/8/2);
				}
			}//translate &union
			//remove a recttangle with inner size
			translate([0,0,Height-PartOverlapDepth-0.02])union(){
				if(FrameType==0){ //rounded rectangle
					roundedFrame(r=radius,SizeX=SizeX,SizeY=SizeY
					,Height=BorderHeight+PartOverlapDepth+1,SizeInc=0);
				}
                if(FrameType==1){ //circle/ellipse
                     ellipse(SizeX=SizeX,SizeY=SizeY
					,Height=BorderHeight+PartOverlapDepth+10
                    ,SizeInc=0);
				}
				if(FrameType==3){ //triangle
					RoundedMultigon(NumSides=3,r=CornerRadius,SizeX=SizeX,SizeY=SizeY
					,Height=BorderHeight+PartOverlapDepth+1
					,SizeInc=0,rotate=90);
				}
				if(FrameType==4){ //triangle Upsode Down
					RoundedMultigon(NumSides=3,r=CornerRadius,SizeX=SizeX,SizeY=SizeY
					,Height=BorderHeight+PartOverlapDepth+PartOverlapDepth+1
					,SizeInc=0,rotate=-90);
				}
				if(FrameType==5){ //pentagon
					RoundedMultigon(NumSides=5,r=CornerRadius,SizeX=SizeX,SizeY=SizeY
					,Height=BorderHeight+PartOverlapDepth+1
					,SizeInc=0,rotate=90);
				}
				if(FrameType==6){ //hexagon
					RoundedMultigon(NumSides=6,r=CornerRadius,SizeX=SizeX,SizeY=SizeY
					,Height=BorderHeight+PartOverlapDepth+1,SizeInc=0);
				}
				if(FrameType==8){ //octagon
					RoundedMultigon(NumSides=8,r=CornerRadius,SizeX=SizeX,SizeY=SizeY
					,Height=BorderHeight+PartOverlapDepth+1,SizeInc=0,rotate=360/8/2);
				}
			}//union
		}//difference
	}// color
}
module createText(){
	difference(){
		//Create The Text
		translate([SizeX/2,SizeY/2,0.01])
		color(TextColor)rotate([0,0,TextRotation])
		createTextHelper(_FontThickness=Height+TextHeight);
		//subtract the base & border
		translate([0,0,-PartOverlapDepth])createBase(noMagnet=true);
		translate([0,0,-PartOverlapDepth-0.01])createBorder();
	}
}

module createMagnets(){
	// Create Magnet Cutouts
	if(MagnetCount==1){
		translate([SizeX/2,SizeY/2,-0.02])
		CreateSingleMagnetHole();
		
	}
	if(MagnetCount==2){
		OffsetX=0
            +(FrameType==0||FrameType==1
            ?(SizeX<SizeY?0:SizeX/4)
            :0);

		OffsetY=0
            +(FrameType==0||FrameType==1
                ?(SizeX<SizeY?SizeY/4:0)
                :0)
        ;
		translate([
		SizeX/2+ OffsetX
		,SizeY/2+ OffsetY
		,-0.02])
		CreateSingleMagnetHole();
		
		translate([
		SizeX/2- OffsetX
		,SizeY/2- OffsetY
		,-0.02])
		CreateSingleMagnetHole();
		
	}
	if(MagnetCount==4){
		Dist=0
            +(FrameType==0?1.1:0)
            +(FrameType==1?1.5:0)
            +(FrameType==2?1.5:0)
            +(FrameType==3?1.5:0)
            +(FrameType==4?1.5:0)
            +(FrameType==5?1.3:0)
            +(FrameType==6?1.3:0)
            +(FrameType==7?1.5:0)
            +(FrameType==8?1.3:0)
            ;
		OffsetX=SizeX/Dist;
		OffsetY=SizeY/Dist;
		
        translate([
		OffsetX
		,OffsetY
		,-0.02])
		CreateSingleMagnetHole();
		translate([
		OffsetX
		,SizeY- OffsetY
		,-0.02])
		CreateSingleMagnetHole();
		translate([
		SizeX- OffsetX
		,OffsetY
		,-0.02])
		CreateSingleMagnetHole();
        translate([
		SizeX- OffsetX
		,SizeY- OffsetY
		,-0.02])
		CreateSingleMagnetHole();
	}
	
}
module CreateSingleMagnetHole(){
    if(HoleDebug)
        #cylinder(h = MagnetHeight, r = MagnetDiameter/2);
    else
        cylinder(h = MagnetHeight, r = MagnetDiameter/2);
	
}

module createHoles(){
	_SizeX=SizeX+2*BorderWidth+2*AdditionalBaseWidth;
	_SizeY=SizeY+2*BorderWidth+2*AdditionalBaseWidth;
	_SizeZ=Height+max(TextHeight,BorderHeight);
	if (MountingHoles==1){
		translate([-BorderWidth-AdditionalBaseWidth+_SizeX/2+MountingHoleXDistance
		,-BorderWidth-AdditionalBaseWidth+_SizeY-MountingHoleDistance-MountingHoleDiameter/2-MountingHoleYDistance
		,-0.01])
		createSingleMountingHole();
	}
	if (MountingHoles==2||MountingHoles==4){
		translate([-BorderWidth-AdditionalBaseWidth+MountingHoleDistance+MountingHoleDiameter/2+MountingHoleXDistance
		,-BorderWidth-AdditionalBaseWidth+_SizeY-MountingHoleDistance-MountingHoleDiameter/2-MountingHoleYDistance
		,-0.01])
		createSingleMountingHole();
		translate([-BorderWidth-AdditionalBaseWidth+_SizeX-MountingHoleDistance-MountingHoleDiameter/2-MountingHoleXDistance
		,-BorderWidth-AdditionalBaseWidth+_SizeY-MountingHoleDistance-MountingHoleDiameter/2-MountingHoleYDistance
		,-0.01])
		createSingleMountingHole();
	}
	if (MountingHoles==4){
		translate([-BorderWidth-AdditionalBaseWidth+MountingHoleDistance+MountingHoleDiameter/2+MountingHoleXDistance
		,-BorderWidth-AdditionalBaseWidth+MountingHoleDistance+MountingHoleDiameter/2+MountingHoleYDistance
		,-0.01])
		createSingleMountingHole();
		translate([-BorderWidth-AdditionalBaseWidth+_SizeX-MountingHoleDistance-MountingHoleDiameter/2-MountingHoleXDistance
		,-BorderWidth-AdditionalBaseWidth+MountingHoleDistance+MountingHoleDiameter/2+MountingHoleYDistance
		,-0.01])
		createSingleMountingHole();
	}
	
	
}
module createSingleMountingHole(height=Height,Diameter=MountingHoleDiameter){
	d=Diameter;
	h=height;
	AddH=BorderHeight+TextHeight+0.03;
	CounterSunkD=d*2;
	CounterSunkH=d/2;
	union(){
		if(HoleDebug)#cylinder(r=d/2,h=h+AddH);
            else      cylinder(r=d/2,h=h+AddH);


        cylinder(r=d/2,h=h+AddH);
		if(MountingHoleCountersunk){
			translate([0,0,h-CounterSunkH])
			cylinder(r1=d/2,r2=CounterSunkD/2,h=CounterSunkH);
			translate([0,0,h])
			cylinder(r=CounterSunkD/2,h=AddH); //some additional distance...
		}
	}
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
	translate ([-SizeInc,-SizeInc,0])
	hull(){
		translate([ZeroOffset,ZeroOffset,0])cylinder(r=_radius,h=Height); //0,0
		translate([XOffset,ZeroOffset,0])cylinder(r=_radius,h=Height);    //x,0
		translate([XOffset,YOffset,0])cylinder(r=_radius,h=Height);       //x,y
		translate([ZeroOffset,YOffset,0])cylinder(r=_radius,h=Height);    //0,y
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

,_hOffset2=Text2HorizontalOffset
,_vOffset2=Text2VerticalOffset
,_text2=text2
,_Font2=_FontStr2
,_FontSize2=FontSize2
,_Text2Spacing=Text2Spacing

,_hOffset3=Text3HorizontalOffset
,_vOffset3=Text3VerticalOffset
,_text3=text3
,_Font3=_FontStr3
,_FontSize3=FontSize3
,_Text3Spacing=Text3Spacing

,_hOffset4=Text4HorizontalOffset
,_vOffset4=Text4VerticalOffset
,_text4=text4
,_Font4=_FontStr4
,_FontSize4=FontSize4
,_Text4Spacing=Text4Spacing

,_hOffset5=Text5HorizontalOffset
,_vOffset5=Text5VerticalOffset
,_text5=text5
,_Font5=_FontStr5
,_FontSize5=FontSize5
,_Text5Spacing=Text5Spacing

,_hOffset6=Text6HorizontalOffset
,_vOffset6=Text6VerticalOffset
,_text6=text6
,_Font6=_FontStr6
,_FontSize6=FontSize6
,_Text6Spacing=Text6Spacing

,_hOffset7=Text7HorizontalOffset
,_vOffset7=Text7VerticalOffset
,_text7=text7
,_Font7=_FontStr7
,_FontSize7=FontSize7
,_Text7Spacing=Text7Spacing

,_hOffset8=Text8HorizontalOffset
,_vOffset8=Text8VerticalOffset
,_text8=text8
,_Font8=_FontStr8
,_FontSize8=FontSize8
,_Text8Spacing=Text8Spacing

,_FontThickness=TextHeight
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
	,hOffset2=_hOffset2,vOffset2=_vOffset2,text2=_text2
	,Font2=_Font2,FontSize2=_FontSize2,Text2Spacing=_Text2Spacing
	,hOffset3=_hOffset3,vOffset3=_vOffset3,text3=_text3
	,Font3=_Font3,FontSize3=_FontSize3,Text3Spacing=_Text3Spacing
	,hOffset4=_hOffset4,vOffset4=_vOffset4,text4=_text4
	,Font4=_Font4,FontSize4=_FontSize4,Text4Spacing=_Text4Spacing
	,hOffset5=_hOffset5,vOffset5=_vOffset5,text5=_text5
	,Font5=_Font5,FontSize5=_FontSize5,Text5Spacing=_Text5Spacing
	,hOffset6=_hOffset6,vOffset6=_vOffset6,text6=_text6
	,Font6=_Font6,FontSize6=_FontSize6,Text6Spacing=_Text6Spacing
	,hOffset7=_hOffset7,vOffset7=_vOffset7,text7=_text7
	,Font7=_Font7,FontSize7=_FontSize7,Text7Spacing=_Text7Spacing
	,hOffset8=_hOffset8,vOffset8=_vOffset8,text8=_text8
	,Font8=_Font8,FontSize8=_FontSize8,Text8Spacing=_Text8Spacing
	
	,FontThickness=_FontThickness
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
    ,FontThickness=5
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
	?FontSize1+linespacing
	:0)
	+(text2!=""
	?FontSize2+linespacing
	:0)
	+(text3!=""
	?FontSize3+linespacing
	:0)
	+(text4!=""
	?FontSize4+linespacing
	:0)
	+(text5!=""
	?FontSize5+linespacing
	:0)
	+(text6!=""
	?FontSize6+linespacing
	:0)
	+(text7!=""
	?FontSize7+linespacing
	:0)
	+(text8!=""
	?FontSize8
	:0);
	
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
	_y8=height/2-FontSize8 -_y1height-_y2height-_y3height-_y4height-_y5height-_y6height-_y7height;
	
	posX=(hAllign1=="left"
	? -TBwidth2/2
	: (hAllign1=="right"
	?TBwidth2/2
	:0)
	);

	if(extrude){
		translate([0,0,(FontThickness<0?FontThickness+0.01:0)])
		union(){
			translate([posX+hOffset1,_y1+vOffset1,0])
			linear_extrude(height=abs(FontThickness)) 
			text(text1,size=FontSize1, font=Font1,  halign = hAllign1,valign = "baseline",spacing=Text1Spacing); 
			if(text2!=""){
				translate([posX+hOffset2,_y2+vOffset2,0])
				linear_extrude(height=abs(FontThickness)) 
				text(text2,size=FontSize2, font=Font2,  halign = hAllign1,valign = "baseline",spacing=Text2Spacing); 
			}
			if(text3!=""){
				translate([posX+hOffset3,_y3+vOffset3,0])
				linear_extrude(height=abs(FontThickness)) 
				text(text3,size=FontSize3, font=Font3,  halign = hAllign1,valign = "baseline",spacing=Text3Spacing); 
			}
			if(text4!=""){
				translate([posX+hOffset4,_y4+vOffset4,0])
				linear_extrude(height=abs(FontThickness)) 
				text(text4,size=FontSize4, font=Font4,  halign = hAllign1,valign = "baseline",spacing=Text4Spacing); 
			}
			if(text5!=""){
				translate([posX+hOffset5,_y5+vOffset5,0])
				linear_extrude(height=abs(FontThickness)) 
				text(text5,size=FontSize5, font=Font5,  halign = hAllign1,valign = "baseline",spacing=Text5Spacing); 
			}
			if(text6!=""){
				translate([posX+hOffset6,_y6+vOffset6,0])
				linear_extrude(height=abs(FontThickness)) 
				text(text6,size=FontSize6, font=Font6,  halign = hAllign1,valign = "baseline",spacing=Text6Spacing); 
			}
			if(text7!=""){
				translate([posX+hOffset7,_y7+vOffset7,0])
				linear_extrude(height=abs(FontThickness)) 
				text(text7,size=FontSize7, font=Font7,  halign = hAllign1,valign = "baseline",spacing=Text7Spacing); 
			}
			if(text8!=""){
				translate([posX+hOffset8,_y8+vOffset8,0])
				linear_extrude(height=abs(FontThickness)) 
				text(text8,size=FontSize8, font=Font8,  halign = hAllign1,valign = "baseline",spacing=Text8Spacing); 
			}
		}
	}else{
		translate([0,0,(FontThickness<0?FontThickness+0.01:0)])
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

module FontPreview(text="",FontSize=10){
	Fonts=[  "no Font selected"
	//,"---Fonts With All Styles Below"
	,"AlegreyaSans"
	,"exo"
	,"exo2"
	,"FiraSans"
	,"IBMplexSans"
	,"IBMplexSansCondensed"
	,"Lato"
	,"LibreFranklin"
	,"Montserat"
	,"Nunito"
	,"Oswald"
	,"Poppins"
	,"Roboto"
	,"SourceSans"
	,"SourceSansPro"
	,"SpaceMono"
	,"TitilliumWeb"
	,"WorkSans"
	// ,"---Other Fonts Below"
	,"DaysOne"
	,"RubikMonoOne"
	,"Sniglet"
	,"Staatliches"
	,"Acme"
	,"Aladin"
	,"Allan"
	,"Bangers"
	,"BioRhyme"
	,"BlackOpsOne"
	,"BubblegumSans"
	,"CevicheOne"
	,"Chango"
	,"Coiny"
	,"Cookie"
	,"Courgette"
	,"Creepster"
	,"DancingScript"
	,"Delius"
	,"DeliusSwashCaps"
	,"FingerPaint"
	,"Flavors"
	,"FreckleFace"
	,"Fruktur"
	,"Galindo"
	,"Gorditas"
	,"GravitasOne"
	,"Griffy"
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
	,"NothingYouCouldDo"
	,"Oregano"
	,"Pacifico"
	,"PasseroOne"
	,"Peralta"
	,"Piedra"
	,"Plaster"
	,"RammettoOne"
	,"Ranchers"
	,"Risque"
	,"RopaSans"
	,"SnowburstOne"
	,"TheGirlNextDoor"
	,"Dwankyandmoomoo"
	,"Vibur"
	,"WaitingForTheSunrise"
	,"Wellfleet"
	,"YatraOne"
	];
	echo("len=",len(Fonts));
	//str(Font,":style=",(Bold?"Bold ":" "),(Italic?"Italic":""));
	for(n=[0:floor(len(Fonts)/3)]){
		_text=(text==""?str("Sign Workshop! ",Fonts[n]):text);
		echo ("n=",n,", Font=",Fonts[n],", text=",_text);
		translate([0,-1*n*(FontSize+5),0])color("black")
		textWriter(
		hAllign1="left",vAllign1="center"
		,hOffset1=0,vOffset1=0
		,text1=_text,Font1=Fonts[n],FontSize1=FontSize,Text1Spacing=1
		,text2=""
		,text3=""
		,text4=""
		,FontThickness=1
		,TBwidth=100
		,TBheight=FontSize+1
		,extrude=true
		,debug=false);
	}
	for(n=[ceil(len(Fonts)/3):ceil(len(Fonts)/3)*2]){
		_text=(text==""?str("Sign Workshop! ",Fonts[n]):text);
		echo ("n=",n,", Font=",Fonts[n],", text=",_text);
		translate([320,-1*(n-ceil(len(Fonts)/3))
		*(FontSize+5),0])color("black")
		textWriter(
		hAllign1="left",vAllign1="center",hOffset1=0,vOffset1=0
		,text1=_text,Font1=Fonts[n],FontSize1=FontSize,Text1Spacing=1
		,text2=""
		,text3=""
		,text4=""
		,FontThickness=1
		,TBwidth=100
		,TBheight=FontSize+1
		,extrude=true
		,debug=false);
	}
    for(n=[ceil(len(Fonts)/3)*2+1:len(Fonts)-1]){
		_text=(text==""?str("Sign Workshop! ",Fonts[n]):text);
		echo ("n=",n,", Font=",Fonts[n],", text=",_text);
		translate([640,-1*(n-ceil(len(Fonts)/3)*2-1)
		*(FontSize+5),0])color("black")
		textWriter(
		hAllign1="left",vAllign1="center",hOffset1=0,vOffset1=0
		,text1=_text,Font1=Fonts[n],FontSize1=FontSize,Text1Spacing=1
		,text2=""
		,text3=""
		,text4=""
		,FontThickness=1
		,TBwidth=100
		,TBheight=FontSize+1
		,extrude=true
		,debug=false);
	}
}

// RoundedMultigon
// Example: RoundedMultigon(NumSides=5,CompartmnetSize=20,radius=0,height=20);
module RoundedMultigon(NumSides=8,r=radius,SizeX=SizeX,SizeY=SizeY
,Height=5,SizeInc=0,rotate=0)
{ 
	//Limit Radius to avoid size increase of extrudedHexagon
	EdgeLength=SizeX+2*SizeInc;//CompartmentSize;
	rad = max(0.01,min(EdgeLength/2,r))+SizeInc; //Limit Radius to avoid size increase of Body
	echo("debug:rotate=",rotate);
	translate([SizeX/2,SizeY/2,0])
	scale([1,(SizeY+2*SizeInc)/(SizeX+2*SizeInc),1])
	rotate([0,0,rotate]){
		
		hull()  
		{
			for (S=[1:NumSides])
			{
				rotate([0,0,(360/NumSides)*(S-1)])
				translate([EdgeLength/2-rad,0,0])
				cylinder(r=rad,h=Height); 
			}
		}   
	}
} 
module ellipse(NumSides=8,SizeX=SizeX,SizeY=SizeY
,Height=5,SizeInc=0,rotate=0)
{ 
	_r=(SizeX+2*SizeInc)/2;
    translate([SizeX/2,SizeY/2,0])
    linear_extrude(height=Height)
	scale([1,(SizeY+2*SizeInc)/(SizeX+2*SizeInc),1])
        circle(r=_r,h=Height,center=true,$fn=150); 
} 
				
/* [General Settings] */
quality = 50;//[1:300]

/* [Text Settings] */
textInput = "THIJMEN";
textSize = 8;//[1:0.1:30]
textDistance = 0;//[-10:0.1:10]
textSpacing = 1;//[0:0.05:10]
textDistanceFromRing = 1;//[0:10]
textHeight = 5;//[1:0.1:30]
textHeightPosition = 5;//[1:0.1:10]
textFont = "Anton";//[anton,open sans,lora,noto sans,arimo,roboto,inconsolata,Encode Sans Semi Condensed,Baloo Tammudu,] 

/* [Text-bar Settings] */
barThickness = 4;//[1:0.1:20]
barLength = 37;//[1:0.5:100]
height = 5;//[1:0.1:30]

/* [Keyring Settings] */
keyringDiameter = 15;//[1:0.1:50]
keyringThickness = 3;//[1:0.1:10]
keyringHeight = 5;//[1:0.1:30]
keyringPosition = 5;//[1:0.1:10]
roundedEdgeAtRing = "no";//[no,yes]


//======================================
//      Source by Thijmen Schouten
//======================================


//text
translate([textDistanceFromRing,textDistance,height/10*textHeightPosition])//translate text
{
    linear_extrude(height=textHeight,center=true)   
    {
        text(textInput,textSize,textFont,spacing=textSpacing,$fn=quality);
    }
}



//underbar
translate([-0.1,-barThickness,0])//translate underbar
{
    cube([barLength,barThickness,height]);
}
translate([barLength-0.1,-barThickness/2,0])
{
        cylinder(height,d=barThickness,$fn=quality);
}



//Keyring
translate([-keyringDiameter/2-keyringThickness/2+0.3,-barThickness/2,height/10*keyringPosition])
{  
difference()
    {
        cylinder(keyringHeight,d=keyringDiameter+keyringThickness,$fn=quality,center=true);
        translate([0,0,0])
        {
        cylinder(keyringHeight+1,d=keyringDiameter,$fn=quality,center=true);
        }
    }
}

if(roundedEdgeAtRing=="yes")
{
    translate([0,-barThickness/2,0])cylinder(height,d=barThickness,$fn=quality);
}
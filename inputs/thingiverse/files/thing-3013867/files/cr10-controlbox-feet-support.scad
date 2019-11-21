/**************************************************    
 * CR-10 Controlbox Feet Support                  *
 *                                                *
 * Date: 21.07.2018                               *
 * Creator: Angel3D                               *
 *                                                *
 * Name: CR-10 Controlbox Feet Support            *
 * URL: https://www.thingiverse.com/thing:3013867 *
 *                                                *
 * Comment:                                       *
 * hugoarchicad's CR-10 SQUASH FOOT               *  
 * https://www.thingiverse.com/make:516539        * 
 *                                                *
 **************************************************/

// define smoothness of the final object
$fn=32;

//adapt this value according to the witdh of your CR-10 control box
controlBoxWidth=125;  

//adapt this value according to your squash ball diameter
ballDiameter=39.5;

// overall wall thickness
wallThinkness=5; // recommended value is 5

// parameter for raw base object
baseHeigth=50;
baseDepth=50;
baseWidth=controlBoxWidth+(2*wallThinkness);

// offset from outter border for ball insert space
ballInsertOffset=5;

// spacer used to create upper open part for control box
spacerHeigth=20;  // defines upper open part for control box to lay on
spacerDepth=baseDepth;
spacerWidth=baseWidth-(2*wallThinkness);
spacerOffsetFromBaseCenter=(baseHeigth/2)-(spacerHeigth/2);

// inner space to save printing time and material
// use switch "useMaterialSaver" to enable/disable usage
materialSaveWidth=baseHeigth-25; // you need possibly to adapt this value if you modify the "wallThinkness" value
materialSaveDepth=baseDepth-(2*wallThinkness);
materialSaveHeigth=baseWidth-(2*ballDiameter)-(4*wallThinkness);

// bottom base flatter to help printing avoiding usage of support material
// use switch "useBaseFlatter" enable/disable usage
baseFlatterWidth=10;
baseFlatterDepth=5;
baseFlatterHeigth=baseWidth;

// font details
fontName="Arial";
fontSize=8;
fontDepth=2;

// text for the logo
// use switches "showLogoTextFront" and/or "showLogoTextBack" to enable/disable usage
logoTextFront="CR-10"; // set your own text if you wish to
logoTextBack="CR-10";  // set your own text if you wish to
LogoTextOffset=5;      // set text offset from top (values between 0 and 5 reccomended)

// switches to customize outcome
useMaterialSaver=true;
useBaseFlatter=true;
showLogoTextFront=true;
showLogoTextBack=true;

// display object
leg();


module leg(){
  difference(){
    baseMain();
    baseSpacer();
    ballInsertLeft();
    ballInsertRigth();
    if (useMaterialSaver){
      materialSave(); // disable if not needed
    }  
    if (useBaseFlatter){
      baseFlatter();  // disable if not needed
    }
    if (showLogoTextFront){
      baseLogoFront();
    }
    if (showLogoTextBack){  
      baseLogoRear();
    }
  }
}

module baseMain(){
  cylinder(h=baseWidth,d=baseHeigth,center=true);
}

module baseSpacer(){
  translate([spacerOffsetFromBaseCenter,0,0]){
    rotate([0,90,0]){
      cube([spacerWidth,spacerDepth,spacerHeigth], center=true);  
    }
  }
}

module ballInsertLeft(){
  translate([-((baseHeigth/2)-wallThinkness),0,(baseWidth/2)-ballInsertOffset-(ballDiameter/2)]){
    sphere(d=ballDiameter);
  }  
}


module ballInsertRigth(){
  translate([-((baseHeigth/2)-wallThinkness),0,-(baseWidth/2)+ballInsertOffset+(ballDiameter/2)]){
    sphere(d=ballDiameter);
  }  
}

module materialSave(){
  cube([materialSaveWidth,materialSaveDepth,materialSaveHeigth], center=true);
}

module baseFlatter(){
  translate([-(baseHeigth/2)-(baseFlatterDepth/2.5),0,0]){
    rotate([0,0,90]){
      cube([baseFlatterWidth,baseFlatterDepth,baseFlatterHeigth], center=true);
    }
  }
}

module baseLogo(logoText){
  linear_extrude(fontDepth){
    text(logoText, font=fontName, fontSize, valign="bottom", halign="center");
  }
}

module baseLogoFront(){
  translate([-(fontSize/2)-LogoTextOffset,(baseDepth/2)-fontDepth,0]){
    rotate([-90,-90,0]){
      baseLogo(logoTextFront);
    }
  }
}

module baseLogoRear(){
  translate([-(fontSize/2)-LogoTextOffset,-(baseDepth/2)+fontDepth,0]){
    rotate([-90,-90-180,180]){
      baseLogo(logoTextBack);
    }
  }
}
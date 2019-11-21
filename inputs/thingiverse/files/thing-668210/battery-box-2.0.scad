/*
based almost entirely on Battery Holder by flummer
http://www.thingiverse.com/thing:331394

With thanks to Michael@OZ: https://groups.google.com/forum/#!topic/thingiverse/rTH3Fq_G_5k

CHANGE LOG
  16 March
  * major rewrite
  * simplified many things
  * moved most tasks into subs
  * added custom text


  9 February
  * adjusted overall length
  * adjusted grove to allow removal
  * fixed logic error in hookup wire channel

  7 February
  * added 168A at Thomas' request
  * Made base thicker

  5 February
  * Add customizer option to remove mounting flanges
  * make flange position more precice

  4 February
  * flip/flop cells for simpler wiring
  * baseThick needs to scale with battery diameter

  3 February
  * made base thickness a function of battery diameter

  2 February
  * Cleaned up customizer variables
  * Added and cleaned up comments
  * add option for different sized cells
  * made flanges a paramater
  *

*/



/*[Features]*/

flanges=1; //[0:no flange, 1:add bolt flange]
flangeLocation=15; //[0:100]
flangeMbolt=3; //[1:5]

/*[Hidden]*/
batteryDia=14.5; //temporary battery vars for lookup function
batteryLen=50.5;



/*Add more battery deffinitions here in the following format:

BatteryName=[
    [batteryLen, <Length of battery>],
    [bateryDia, <Diameter of battery>]
];


Battery Deffinitions based on this page:
http://en.wikipedia.org/wiki/List_of_battery_sizes#Cylindrical_cells

*/
AA=[
    [batteryLen, 50.5],
    [batteryDia, 14.5]
];

AAA=[
    [batteryLen, 44.5],
    [batteryDia, 10.5]
];

C=[
    [batteryLen, 50],
    [batteryDia, 26.2]
];

168A=[
      [batteryLen, 65.2],
      [batteryDia, 18.6]
];

D=[
    [batteryLen, 61.5],
    [batteryDia, 34.2]
];

cellList=[AAA, AA, C, D, 168A];

/*[Global]*/
//Number of Cells
cellCount=3; //[1:10]
cellTypeMeta=1; //[0:AAA, 1:AA, 2:C, 3:D, 4:168A]
customText="4.5V";

/*[Battery Clip]*/
clipThick=2; //Thickness of the folded part of the battery clip
clipMount=2; //thickness of mounting portion of clipa
clipDimensions=[1.4, 10.5, 11.6];
conductorDimensions=[1, 5.5, 100];
solderFlangeDim=[7, 5.5, 1.6];
endPlateThick=2; //end plate behind the conductor
wireThick=3; //thickness of hookup wire channels

/*[Hidden]*/
//This has to be AFTER the cell definitions and the cellTypeMeta is defined
pctOvr=1.04; //indrease sizes by this munc
cellType=cellList[cellTypeMeta];
batLen=lookup(batteryLen, cellType);
batRad=(lookup(batteryDia, cellType)/2)*pctOvr;
flangeHoleRad=flangeMbolt/2*pctOvr;



//battery cell
module cell() {
  rotate([0, 90, 0])
    cylinder(r=batRad, h=batLen+clipThick*2, center=true, $fn=100);
}

//polarity symbol
module polarity(symbol=1) {
  if (symbol==1) {
    cube([6, 2, 1], center=true);
    cube([2, 6, 1], center=true);
  }

  if (symbol==-1) {
    cube([2, 6, 1], center=true);
  }
}

module cornerFillet(rad=5, thick=10) {
  difference() {
    cube([thick, rad, rad], center=true);
    rotate([0, 90, 0])
      translate([rad/2, rad/2, 0])
      cylinder(r=rad, h=thick+1, center=true);
  }
}

module solderFlange() {
  union() {
    cube(solderFlangeDim, center=true);
    translate([solderFlangeDim[0]/2, 0, 0 ])
      cylinder(r=solderFlangeDim[1]/2, h=solderFlangeDim[2], $fn=36, center=true);
  }
}

module mountingFlange() {
  translate([0, 0, flangeHoleRad])
  difference() {
    union() {
      cylinder(r=flangeHoleRad*2, h=flangeHoleRad*2, center=true, $fn=36);
      translate([0, flangeHoleRad*2, 0])
        cube([flangeHoleRad*4, flangeHoleRad*4, flangeHoleRad*2], center=true);
    }
    cylinder(r=flangeHoleRad, h=flangeHoleRad*3, center=true, $fn=36);
  }
}

module endPlate(baseThick, batDisplace, baseY) {
  plateX=endPlateThick;
  plateY=batRad*2*cellCount;
  plateZ=baseThick+batDisplace+batRad;
  cornerRad=5;

  //cut off the corners
  difference() {
    translate([0, 0, plateZ/2])
      cube([plateX, plateY, plateZ], center=true);
    translate([0, (plateY/2-cornerRad/2), plateZ-cornerRad/2])
      rotate([-90, 0, 0])
      cornerFillet(rad=cornerRad);
    translate([0, -1*(plateY/2-cornerRad/2), plateZ-cornerRad/2])
      cornerFillet(rad=cornerRad);

  }
}


module mainBody() {
  baseThick=batRad; //Thickness of base
  batDisplace=batRad*2/3; //amount to displace the battery cutout in z axis
  
  baseX=batLen+2*clipThick+clipMount*2+conductorDimensions[0]*2+endPlateThick*2;
  baseY=batRad*2*cellCount;
  baseZ=baseThick+batDisplace;

  difference() {
    union() {
      //create the base
      translate([0, 0, (baseThick+batDisplace)/2])
        cube([baseX, baseY, baseZ], center=true);
      
      //create end plates
      for (i=[-1, 1]) {
        translate([i*(baseX/2-endPlateThick/2), 0, 0])
          endPlate(baseThick, batDisplace, baseY);
      }
    
      //add mounting flanges
      if (flanges==1) {
        for (i=[-1, 1]) {
          translate([i*flangeLocation, -baseY/2-flangeHoleRad*2, 0])
            mountingFlange();
          translate([i*flangeLocation, baseY/2+flangeHoleRad*2, 0])
            rotate([0, 0, 180])
            mountingFlange();
        }
      }
    }// end union

    //Custom Text
      translate([-baseX/2, 0, (baseZ+batDisplace)/2])
        rotate([90, 0, -90])
        linear_extrude(height=.5, center=true, twist=0)
        text(customText, halign="center", valign="center", h=batRad*2);

    //battery cell cut outs
    for (cell=[0:cellCount-1]) {
      translate([0, -batRad*(cellCount-1)+batRad*2*cell, 
        batDisplace+baseThick])
        cell();
      
      //add polarity symbols
      if (cell%2==0) {
        translate([batLen*.4, -cellCount*batRad+batRad+batRad*2*cell, batDisplace])
          polarity();
        translate([-batLen*.4, -cellCount*batRad+batRad+batRad*2*cell, batDisplace])
          polarity(-1);
      } else {
        translate([-batLen*.4, -cellCount*batRad+batRad+batRad*2*cell, batDisplace])
          polarity();
        translate([batLen*.4, -cellCount*batRad+batRad+batRad*2*cell, batDisplace])
          polarity(-1);
      }

      //add cutout for clip conductor


      //cutout to aid battery removal
      translate([0, 0, batDisplace+baseThick])
        rotate([90, 0, 0])
        scale([1.2, 1, 1])
        cylinder(r=batRad, h=cellCount*batRad*2+10, center=true);


      //cutout for battery clip, solder flange, conductor, hookup wire
      for(i=[-1,1]) {

        //clip
        translate([0, -batRad*(cellCount-1)+batRad*2*cell, 0])
        translate([i*(batLen/2+clipThick+clipMount), 0, baseThick+batDisplace])
          cube(clipDimensions, center=true);
        
        //conductor
        translate([0, -batRad*(cellCount-1)+batRad*2*cell, 0])
        translate([i*(batLen/2+clipThick+clipMount), 0, baseThick+batDisplace])
          cube(conductorDimensions, center=true);

        //solder flange
        if(i<0) {
          translate([0, -batRad*(cellCount-1)+batRad*2*cell, 0])
          translate([i*(batLen/2+clipThick+clipMount-solderFlangeDim[0]/2), 0, 0])
            solderFlange();
        } else {
          translate([0, -batRad*(cellCount-1)+batRad*2*cell, 0])
          translate([i*(batLen/2+clipThick+clipMount-solderFlangeDim[0]/2), 0, 0])
            rotate([0, 0, 180])
            solderFlange();
        }

        //hookup wire channel
        translate([i*(batLen/2+clipThick+clipMount-solderFlangeDim[0]/2), 0, 0])
          cube([wireThick, baseY*2, wireThick], center=true);

      } //end battery clip for 
    } //end for


  } // end difference
} //end mainBody

mainBody();


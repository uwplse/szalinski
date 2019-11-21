/*
Coin Magnet Holder
Version 3 - 26 July 2015
Created by Aaron Ciuffo - txoof.com

This SCAD can produce a plate with many coins.  See the example at the bottom.

Many coins are already available; add more using this format:
//ISO4217_name<value>=[Diameter, Thickness]

Check the examples below.

To draw a single coin holder call (the function expects a list of lists)
  drawCoinHolder([[coinDiameter, coinThickness]]);
  

To draw a plate of several holders call:
  drawCoinHolder([coinvar1, coinvar2, coinvar3]);

!!!NOTE!!! the largest coin must be the first item in the list!



Adjust the magnet variables for your particlar magnet.  If your magnet does not
quite fit after printing, adjust the 'ovr' variable in the Tweaks section.



*/

/* [Variables] */

//Coin Diameter
coinDia=24.5;
//Coin Thickness
coinThick=1.9;


/*[Design]*/
//Border around coin
border=2;


/*[Magnet Dimensions]*/
//Magnet X - Longest dimension
magnetX=20;
//Magnet Y
magnetY=10;
//Magnet Z
magnetZ=3;
//Magnet Base Base Thickness
baseThick=1.2;

/*[Layout]*/
separation=5;

/*[Tweak]*/
//You may need to tweak this if you find your magnets do not fit.  
//Increase this variable to make more space, decrease it to make fits more tight.
ovr=1.03;

/*[Hidden]*/
magX=magnetX*ovr;
magY=magnetY*ovr;
magZ=magnetZ*ovr;

//Canadian dollar - CAD
cad1=[26.5, 2];
cad2=[27.95, 1.75];
cadp25=[24, 1.6];

//French Community of Africa - CFA
cfa10=[23.5, 1.5];
cfa50=[22, 1.7];
cfa200=[24.5, 1.9];

//Danish krone - DKK
dkk5=[28.5, 2];

//Spanish Pesetas - ESP
esp100=[24.5, 2.9];

//French franc - FRF
frf1=[24,1.9];

//Great Britian Pound - GBP
gbpp02=[26, 2.1];

//Greek drachma - GRD
grd50=[27.5, 2.2];
grd100=[29.5, 2.2];

//Icelanding Krone ISK
isk100=[25.6, 2.3];
isk50=[23.05, 2.7]; 
isk10=[27.55, 1.8];
isk5=[24.55, 1.8];
isk1=[21.5, 1.7];

//Irsih pound - IEP
iepp02=[26, 2];
iepp20=[27.1, 2];
//non round! - distance from point/point (even sided), or point/flat (odd sided)
iepp50=[30.5, 2.5, 7];
iep1=[31.1, 1.9];


//Italian lira - ITL
itl200=[24, 1.7];

//Lebanese pound - LBP
lbp500=[24.5, 2.15];

//Mexican Peso - MXN
mxn10=[28, 2.3];

//Dutch guilder - NLG
nlg1=[24.5, 1.9];

//Norwegian kroner - NOK
nok1=[21, 1.7];
nok5=[26, 2.15];
nok10=[24, 2.5];
nok20=[27.55, 2.5];

//Thai baht - THB
thb5=[24, 2.2];

//Turkish lira - TRY
try1=[26.25, 2];
tryp5=[23.9, 2];

//United States dollar - USD
usdp25=[24.3, 1.75];
usd1=[26.5, 2.1];



module drawCoinHolder(coinDim) {
  coinD=coinDim[0];
  coinZ=coinDim[1];
  cutOvr=.01; //add a little bit to fight ZFighting
  magBorder=5; //Consider calculating this form something or other
  $fn=72;
  height=coinZ+magZ+baseThick;
  difference() {
    //create external cone - add 
    cylinder(h=height, 
      r2=(coinD+(border*2))/2,  
      r1=(magX+magBorder)/2);

    //cut void for coin
    translate([0, 0, coinZ+magZ+baseThick-coinZ])
      color("red")
      cylinder(h=coinZ+cutOvr, r=coinD*ovr/2);

    //cut void for magnet
    translate([0, 0, magZ/2+baseThick+cutOvr])
      color("blue")
      cube([magX, magY, magZ], center=true);
    
    //cut void for glue grooves
    groove=[coinD*.9, magY*.5, magZ*.5];
    for (i=[-1, 0]) {
      rotate([0, 0, 90*i])
        color("yellow")
        translate([0, 0, height-coinZ-groove[2]/2+cutOvr])
        cube(groove, center=true);
    }

  }

}

module draw_nonround_holder(coinDim) {
  coinT=coinDim[1];
  coinSides=coinDim[2];
  coinD=2*(coinDim[0]/(cos((360/(2*coinSides)))+1));
  echo(coinD);
  difference () {
    // create external cylinder
    cylinder(h=coinT+magZ+.9, r2=(coinD+4)/2,  r1=((coinD+2.5)/2)*.8, $fn=36); 
    // cut out internal space for coin
    translate([0,0,magZ+.9]) cylinder(h=coinT*3, r=(coinD+.7)/2, $fn=coinSides);
    // cut out slot for magnet
    translate([-magX/2,-magY/2,.5]) cube([magX+.3, magY+.3, magZ*5]);
    // grooves for holding a bit of hot glue
    translate([0,0,(magZ*1.5)-.2]) cube([coinD*.8, magY*.2, magZ], center=true);
    translate([0,0,(magZ*1.5)-.2]) cube([magX*.2, coinD*.8, magZ], center=true);


  }
}

module layout(coins) {
  //find the largest coin in the list
  //BLAH!  This does not work. max([[a, b], [q, r]]) always returns element 0.
  //maxCoin=max(coins);

  maxCoin=coins[0];
  gridUnit=((maxCoin[0]+separation));

  //check to see if the number of coins in the list is square
  sqrTest=sqrt(len(coins))-floor(sqrt(len(coins)));

  //assign the next closest square number if it is not
  closestSq = sqrTest > 0 ? floor(sqrt(len(coins))+1) : sqrt(len(coins));
  
  //center the coins around the origin
  translate([-gridUnit*(closestSq-1)*.5, -gridUnit*(closestSq-1)*.5, 0])
  //work across the row, then the column  
  for (row = [0:closestSq-1]) {
    for(col = [0:closestSq-1]) {
      translate([gridUnit*col, gridUnit*row, 0])
        if (row*closestSq+col  <= len(coins)-1 ) {
          //determine the index number of the coin array
          drawCoinHolder(coins[row*closestSq+col]);
        } 
    }
  }

}

//layout([isk10, usd1, nok5, cfa50, gbpp02, nlg1, mxn10, esp100, usdp25]);

//layout([isk10, isk50, isk5, isk100]);

//layout([isk10, isk10, isk10, isk10]);

layout([[coinDia, coinThick]]);


//Primary Parameters
//Outer diameter plate
outerdiamplate=46;
//Inner diameter plate/screwhole (limited to calculated max)
innerdiamplate=4.5;
//Number of rods
numberrods = 5;
//Diameter rod
diameterrod = 7.2;
//Tolerance correction for diameter rod (% wider)
diamrodcorrperc = 8;
//Height or depth holder rods
heightrodholder = 7;
//Thickness wall holder
thickmaterialholder = 0.8;
//Thickness plate (limited to calculated max)
thickmaterialplate = 6;

//modules
module ring(diam, tw, transy, transz, hr)  //tm = thickness wall
{ translate([0,transy,transz])
    difference()
    { cylinder(r=diam/2,h=hr);
      translate([0,0,-1])
      cylinder(r=diam/2-tw,h=hr+2);  
    }
}


//Secondary paramaters / limitations
diamrod2 = diameterrod+(diamrodcorrperc/100)*diameterrod;
tmatplate2 = min(thickmaterialplate,heightrodholder+thickmaterialholder);  
diamplate2 = outerdiamplate; //correcting outerdiameter is a bad plan but you can  max((diamrod2+thickmaterialholder*2)*2 + innerdiamplate, outerdiamplate); 
widthplate2 = max((diamplate2-innerdiamplate)/2, diamrod2+(2*thickmaterialholder));

//main
$fn=50;
union()
  {
  difference()   //the plate
    {
    ring(diamplate2, widthplate2,0,0,tmatplate2);
      for(i=[0:numberrods-1])
        rotate([0,0,(360/numberrods)*i])
           ring(diamrod2+0.5*thickmaterialholder,diamrod2,diamplate2/2-thickmaterialholder-diamrod2/2,thickmaterialholder,heightrodholder*2); 
    }
    
  for(i=[0:numberrods-1])  //the rodholders
    rotate([0,0,(360/numberrods)*i])
      ring(diamrod2 + (2*thickmaterialholder),thickmaterialholder,diamplate2/2-thickmaterialholder-diamrod2/2,min(thickmaterialholder, thickmaterialplate),heightrodholder); 
  }
/* [Ring Maker] */
// this uses a lot of hull commands, and thus takes a while to load.

//bare in mind that printers often print weird, so it might scaled in your slicer or cleaned up

//BEGIN CUSTOMIZER VARIABLES  
/*[Sizing]*/
Country="United States"; //[United States,Canada,Mexico,United Kingdom,Ireland,Australia,New Zealand,South Africa,Italy,Spain,Netherlands,Switzerland,India,China,South America,Japan,France,Germany,Austria,Belgium,Scandinavia]
//Format half sizes like that, regular sizes no spaces, always use capital letters if needed.
sizeValue= "11";
// Which one would you like to see?// Which one would you like to see?
part = 1; // [1:wholeRing,0:one strand]
/* [Ring Options] */
//work in progress
ringheight=3;
//ditto
thickness=2;//[1:0.5:10]
periods = 6;
//higher step takes more time but looks less blocky.
step = 5;//[.5:.5:20]
$fn=9;
/*[Extras]*/
//END CUSTOMIZER VARIABLES

/* [Hidden] */
US_Countries=["US","United States","Canada","Mexico"];
UK_Countries=["UK","United Kingdom","Ireland","Australia","New Zealand","South Africa"];
Spain_Countries=["ES","Italy","Spain","Netherlands","Switzerland"];
India_Countries=["IN","India"];
China_Countries=["CI","China","South America"];
Japan_Countries=["JP","Japan"];
ISO_Countries=["EU","France","Germany","Austria","Belgium","Scandinavia"];
//https://en.wikipedia.org/wiki/Ring_size

//USSizes_All
//USValues_All
//UKValues_All
//China_All
//India_All
//Spain_All
//source : https://www.kuberbox.com/blog/international-ring-size-conversion-chart/




if (search([Country],US_Countries)[0]>0)
{
  USValues_All=["1/2","3/4"   ,"1"  ,"1 1/4"  ,"1 1/2"  ,"1 3/4"  ,"2"     ,"2 1/4"  ,"2 1/2"  ,"2 3/4"  ,"3"     ,"3 1/4"  ,"3 1/2"  ,"3 3/4"  ,"4"     ,"4 1/4"  ,"4 1/2"  ,"4 3/4" ,"5"     ,"5 1/4"  ,"5 1/2" ,"5 3/4"  ,"6"      ,"6 1/4" ,"6 1/2"  ,"6 3/4"  ,"7"      ,"7 1/4"  ,"7 1/2"  ,"7 3/4" ,"8"      ,"8 1/4" ,"8 1/2"  ,"8 3/4" ,"9"     ,"9 1/4"  ,"9 1/2"  ,"9 3/4" ,"10"     ,"10 1/4"  ,"10 1/2"  ,"10 3/4" ,"11"     ,"11 1/4" ,"11 1/2"  ,"11 3/4" ,"12"     ,"12 1/4" ,"12 1/2"  ,"12 3/4"  ,"13"     ,"13 1/4"   ,"13 1/2"  ,"13 3/4" ,"14"     ,"14 1/4"  ,"14 1/2"  ,"14 3/4"  ,"15"      ];
  USSizes_All =[12.04,12.24   ,12.45,12.65    ,12.85    ,13.06    ,13.26   ,13.46    ,13.67    ,13.87    ,14.07   ,14.27    ,14.48    ,14.68    ,14.88   ,15.09    ,15.29    ,15.49   ,15.7    ,15.9     ,16.1    ,16.31    ,16.51    ,16.71   ,16.92    ,17.12    ,17.32    ,17.53    ,17.73    ,17.93   ,18.14    ,18.34   ,18.54    ,18.75   ,18.95   ,19.15    ,19.35    ,19.56   ,19.76    ,19.96     ,20.17     ,20.37    ,20.57    ,20.78    ,20.98     ,21.18    ,21.39    ,21.59    ,21.79     ,22        ,22.2     ,22.4       ,22.61     ,22.81    ,23.01    ,23.22     ,23.42     ,23.62     ,23.83     ];
  ring(USSizes_All[search([str(sizeValue)],USValues_All)[0]]);  
}

else if (search([Country],ISO_Countries)[0]>0)
{
  EUValues_All =["44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59","60","61","62","63","64","65","66","67","68","69","70","71"];
  EUSizes_All  =[14.01,14.33,14.65,14.97,15.29,15.61,15.92,16.24,16.56,16.88,17.2,17.52,17.83,18.15,18.47,18.79,19.11,19.43,19.75,20.06,20.38,20.7,21.02,21.34,21.66,21.97,22.29,22.61];
  //source : http://www.cartier.fr/fr/services/le-guide-cartier/guide-des-tailles/guide-des-tailles-bagues/-10402.html
  ring(EUSizes_All[search([str(sizeValue)],EUValues_All)[0]]);  
}

else if (search([Country],Spain_Countries)[0]>0)
{
  SpainValues_All =["0.5", "1"  , "1.75", "2.25", "3"  , "3.5", "4.25", "4.75", "5.5", "6"  , "6.75", "7.5", "8"  , "8.75", "9.25", "10", "10.5", "11.25", "11.75", "12.5", "13.25", "13.75", "14.5", "15" , "15.75", "16.25", "17" , "17.5", "18.25", "19" , "19.5", "20.25", "20.75", "21.5", "22" , "22.75", "23.25", "24" , "24.75", "25.25", "26" , "26.5", "27.25", "27.75", "28.5", "29", "29.75", "30.5", "31" , "31.75", "32.25", "33" , "33.5", "34.25", "34.75"];
  SpainSizes_All  =[12.85, 13.06, 13.26 , 13.46 , 13.67, 13.87, 14.07 , 14.27 , 14.48, 14.68, 14.88 , 15.09, 15.29, 15.49 , 15.7  , 15.9, 16.1  , 16.31  , 16.51  , 16.71 , 16.92  , 17.12  , 17.32 , 17.53, 17.73  , 17.93  , 18.14, 18.34 , 18.54  , 18.75, 18.95 , 19.15  , 19.35  , 19.56 , 19.76, 19.96  , 20.17  , 20.37, 20.57  , 20.78  , 20.98, 21.18 , 21.39  , 21.59  , 21.79 , 22  , 22.2   , 22.4  , 22.61, 22.81  , 23.01  , 23.22, 23.42 , 23.62  , 23.83  ];
  ring(SpainSizes_All[search([str(sizeValue)],SpainValues_All)[0]]);  
}

else if (search([Country],UK_Countries)[0]>0)
{
  UKValues_All=["A"  , "A 1/2", "B"  , "B 1/2", "C"  , "C 1/2", "D"  , "D 1/2", "E"  , "E 1/2", "F"  , "F 1/2", "G"  , "G 1/2", "H"  , "H 1/2", "I"  , "J"  , "J 1/2", "K" , "K 1/2", "L"  , "L 1/2", "M"  , "M 1/2", "N"  , "N 1/2", "O"  , "O 1/2", "P"  , "P 1/2", "Q"  , "Q 1/2", "R"  , "R 1/2", "S"  , "S 1/2", "T"  , "T 1/2", "U"  , "U 1/2", "V"  , "V 1/2", "W"  , "W 1/2", "X"  , "X 1/2", "Y"  , "Z"  , "Z 1/2", "Z1", "Z2" , "Z3" , "Z4" ];
  UKSizes_All =[12.04, 12.24  , 12.45, 12.65  , 12.85, 13.06  , 13.26, 13.46  , 13.67, 13.87  , 14.07, 14.27  , 14.48, 14.68  , 14.88, 15.09  , 15.29, 15.49, 15.7   , 15.9, 16.1   , 16.31, 16.51  , 16.71, 16.92  , 17.12, 17.32  , 17.53, 17.73  , 17.93, 18.14  , 18.34, 18.54  , 18.75, 18.95  , 19.15, 19.35  , 19.56, 19.76  , 19.96, 20.17  , 20.37, 20.57  , 20.78, 20.98  , 21.18, 21.39  , 21.59, 21.79, 22     , 22.4, 22.81, 23.01, 23.42];
  ring(UKSizes_All[search([str(sizeValue)],UKValues_All)[0]]);  
}

else if (search([Country],India_Countries)[0]>0)
{
  IndiaValues_Main   =["1"      ,"2"     ,"3"      ,"4"      ,"5"      ,"6"      ,"7"      ,"8 1/2"  ,"9"     ,"10"     ,"11"     ,"12"     ,"13"     ,"14"     ,"15"     ,"16"    ,"17"     ,"18"     ,"19"    ,"20"     ,"21"     ,"22"     ,"23"      ,"24"     ,"25"     ,"26"      ,"27"      ,"28"     ,"29"      ,"30"     ,"31"      ,"32"     ,"33"      ,"34"      ,"35"      ];
  IndiaSizes_Main    =[13.06    ,13.26   ,13.67    ,13.87    ,14.27    ,14.68    ,15.09    ,15.29    ,15.49   ,15.9     ,16.31    ,16.51    ,16.92    ,17.32    ,17.53    ,17.93   ,18.14    ,18.54    ,18.75   ,19.15    ,19.35    ,19.76    ,19.96     ,20.37    ,20.57    ,20.98     ,21.39    ,21.59    ,22        ,22.2     ,22.61     ,22.81    ,23.22     ,23.62     ,23.83     ];
  ring(IndiaSizes_Main[search([str(sizeValue)],IndiaValues_Main)[0]]);  
}

else if (search([Country],China_Countries)[0]>0)
{
  ChinaValues_Main   =["1"  ,"2"     ,"3"      ,"4"     ,"5"      ,"6"      ,"7"     ,"8"      ,"9"     ,"10"    ,"11"     ,"12"    ,"13"     ,"14"     ,"15"     ,"16"     ,"17"     ,"18"    ,"19"     ,"20"     ,"21"      ,"22"      ,"23"     ,"24"      ,"25"    ,"26"      ,"27"     ];
  ChinaSizes_Main    =[12.45,13.26   ,13.67    ,14.07   ,14.27    ,14.68    ,14.88   ,15.29    ,15.7    ,16.1    ,16.51    ,16.71   ,16.92    ,17.32    ,17.73    ,18.14    ,18.54    ,18.95   ,19.35    ,19.76    ,19.96     ,20.17     ,20.57    ,20.98     ,21.39   ,21.79     ,22.2     ];
  ring(ChinaSizes_Main[search([str(sizeValue)],ChinaValues_Main)[0]]);  
}

else if (search([Country],Japan_Countries)[0]>0)
{
  JapanSizes_All    =[12.37,13.21   ,13.61    ,14.05   ,14.36    ,14.56    ,14.86    ,15.27    ,15.7     ,16       ,16.51   ,16.92    ,17.35    ,17.75    ,18.19    ,18.53   ,18.89   ,19.41    ,19.84   ,20.02    ,19.96     ,20.68    ,21.08    ,21.49    ,21.89    ,22.33     ];
  JapanValues_All   =["1"  ,"2"     ,"3"      ,"4"     ,"5"      ,"6"      ,"7"      ,"8"      ,"9"      ,"10"     ,"12"    ,"13"     ,"14"     ,"15"     ,"16"    ,"17"     ,"18"    ,"19"     ,"20"     ,"21"      ,"22"    ,"23"     ,"24"     ,"25"     ,"26"     ,"27"  ];
  //JapanSource="http://www.ringsizes.co/"
  ring(JapanSizes_All[search([str(sizeValue)],JapanValues_All)[0]]);  
}

else
  ring(sizeValue);

//The fun logic is below, Just due to thingiverse standards can't leave all that alone in a seperate file.

module sweepAlongPath(step  = 3, end = 360, current = 0, radi)
{
  //the function:
  hull(){
    rotate([0,90+0,current])
      translate([ringheight*periods/2*cos(periods/2*current)*cos(periods/2*current),
          radi+thickness+thickness*sin(periods*2*current)])
        scale([ringheight,thickness,thickness])
           sphere();
    rotate([0,90,current+step])
      translate([ringheight*periods/2*cos(periods/2*(current+step))*cos(periods/2*(current+step)),
          radi+thickness+thickness*sin(periods*2*(current+step))])
        scale([ringheight,thickness,thickness])
          sphere();
  }
  if(current+step < end)
    sweepAlongPath(step = step, end = end, current = current + step, radi = radi);
}

module ring(diameter){
  color([.9,0,0])
    sweepAlongPath(radi = diameter/2, step = step); 
  if(part){
    color([0,.9,0])
      rotate([0,0,360/periods/3])
        sweepAlongPath(radi = diameter/2, step = step);
    color([0,0,.9])
      rotate([0,0,-360/periods/3])
        sweepAlongPath(radi = diameter/2, step = step);
  }
}


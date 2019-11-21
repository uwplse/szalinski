/* [Ring Sizer] */

// this thing is published by teinturman at
// http://www.thingiverse.com/thing:2031257


//bare in mind that if the chosen ring is wide, the needed measurement may be larger than if the ring is very narrow.
    

Country="United Kingdom"; //[United States,Canada,Mexico,United Kingdom,Ireland,Australia,New Zealand,South Africa,Italy,Spain,Netherlands,Switzerlands,India,China,South America,Japan,France,Germany,Austria,Belgium,Scandinavia]
precision="MainSizes";//[HalfSizes,MainSizes]
Model="Women";//[Women,Men,Children,ExtraLarge]



/* [Text Options] */
TextLine1="Happy";
TextLine2="StValentin";


/* [Advanced Options] */

//Height of each size
ringheight=4;//[4:1:12]

//thickness of the ring sizer
thickness=2;//[3:0.5:10]


/* [Hidden] */
US_Countries=["US","United States","Canada","Mexico"];
UK_Countries=["UK","United Kingdom","Ireland","Australia","New Zealand","South Africa"];
Spain_Countries=["ES","Italy","Spain","Netherlands","Switzerlands"];
India_Countries=["IN","India"];
China_Countries=["CI","China","South America"];
Japan_Countries=["JP","Japan"];
ISO_Countries=["EU","France","Germany","Austria","Belgium","Scandinavia"];

//https://en.wikipedia.org/wiki/Ring_size




//USSizes_All =[12.04,12.24   ,12.45,12.65    ,12.85    ,13.06    ,13.26   ,13.46    ,13.67    ,13.87    ,14.07   ,14.27    ,14.48    ,14.68    ,14.88   ,15.09    ,15.29    ,15.49   ,15.7    ,15.9     ,16.1    ,16.31    ,16.51    ,16.71   ,16.92    ,17.12    ,17.32    ,17.53    ,17.73    ,17.93   ,18.14    ,18.34   ,18.54    ,18.75   ,18.95   ,19.15    ,19.35    ,19.56   ,19.76    ,19.96     ,20.17     ,20.37    ,20.57    ,20.78    ,20.98     ,21.18    ,21.39    ,21.59    ,21.79     ,22        ,22.2     ,22.4       ,22.61     ,22.81    ,23.01    ,23.22     ,23.42     ,23.62     ,23.83     ];
//USValues_All=["1/2","3/4"   ,"1"  ,"1 1/4"  ,"1 1/2"  ,"1 3/4"  ,"2"     ,"2 1/4"  ,"2 1/2"  ,"2 3/4"  ,"3"     ,"3 1/4"  ,"3 1/2"  ,"3 3/4"  ,"4"     ,"4 1/4"  ,"4 1/2"  ,"4 3/4" ,"5"     ,"5 1/4"  ,"5 1/2" ,"5 3/4"  ,"6"      ,"6 1/4" ,"6 1/2"  ,"6 3/4"  ,"7"      ,"7 1/4"  ,"7 1/2"  ,"7 3/4" ,"8"      ,"8 1/4" ,"8 1/2"  ,"8 3/4" ,"9"     ,"9 1/4"  ,"9 1/2"  ,"9 3/4" ,"10"     ,"10 1/4"  ,"10 1/2"  ,"10 3/4" ,"11"     ,"11 1/4" ,"11 1/2"  ,"11 3/4" ,"12"     ,"12 1/4" ,"12 1/2"  ,"12 3/4"  ,"13"     ,"13 1/4"   ,"13 1/2"  ,"13 3/4" ,"14"     ,"14 1/4"  ,"14 1/2"  ,"14 3/4"  ,"15"      ];
//UKValues_All=["A"  ,"A 1/2" ,"B"  ,"B 1/2"  ,"C"      ,"C 1/2"  ,"D"     ,"D 1/2"  ,"E"      ,"E 1/2"  ,"F"     ,"F 1/2"  ,"G"      ,"G 1/2"  ,"H"     ,"H 1/2"  ,"I"      ,"J"     ,"J 1/2" ,"K"      ,"K 1/2" ,"L"      ,"L 1/2"  ,"M"     ,"M 1/2"  ,"N"      ,"N 1/2"  ,"O"      ,"O 1/2"  ,"P"     ,"P 1/2"  ,"Q"     ,"Q 1/2"  ,"R"     ,"R 1/2" ,"S"      ,"S 1/2"  ,"T"     ,"T 1/2"  ,"U"       ,"U 1/2"   ,"V"      ,"V 1/2"  ,"W"      ,"W 1/2"   ,"X"      ,"X 1/2"  ,"Y"      ,"Z"  ];
//China_All   =[""   ,""      ,"1"  ,""       ,""       ,""       ,"2"     ,""       ,"3"      ,""       ,"4"     ,"5"      ,""       ,"6"      ,"7"     ,""       ,"8"      ,""      ,"9"     ,""       ,"10"    ,""       ,"11"     ,"12"    ,"13"     ,""       ,"14"     ,""       ,"15"     ,""      ,"16"     ,""      ,"17"     ,""      ,"18"    ,""       ,"19"     ,""      ,"20"     ,"21"      ,"22"      ,""       ,"23"     ,""       ,"24"      ,""       ,"25"     ,""       ,"26"      ,""        ,"27"     ,""         ,""        ,""       ,""       ,""        ,""        ,""        ,""        ];
//India_All   =[""   ,""      ,""   ,""       ,""       ,"1"      ,"2"     ,""       ,"3"      ,"4"      ,""      ,"5"      ,""       ,"6"      ,""      ,"7"      ,"8 1/2"  ,"9"     ,""      ,"10"     ,""      ,"11"     ,"12"     ,""      ,"13"     ,""       ,"14"     ,"15"     ,""       ,"16"    ,"17"     ,""      ,"18"     ,"19"    ,""      ,"20"     ,"21"     ,""      ,"22"     ,"23"      ,""        ,"24"     ,"25"     ,""       ,"26"      ,""       ,"27      ,"28"     ," "       ,"29"      ,"30"     ,""         ,"31"      ,"32"     ,""       ,"33"      ,""        ,"34"      ,"35"      ];
//Spain_All   =[""   ,""      ,""   ,""       ,"0.5"    ,"1"      ,"1.75"  ,"2.25"   ,"3"      ,"3.5"    ,"4.25"  ,"4.75"   ,"5.5"    ,"6"      ,"6.75"  ,"7.5"    ,"8"      ,"8.75"  ,"9.25"  ,"10"     ,"10.5"  ,"11.25"  ,"11.75"  ,"12.5"  ,"13.25"  ,"13.75"  ,"14.5"   ,"15"     ,"15.75"  ,"16.25" ,"17"     ,"17.5"  ,"18.25"  ,"19"    ,"19.5"  ,"20.25"  ,"20.75"  ,"21.5"  ,"22"     ,"22.75"   ,"23.25"   ,"24"     ,"24.75"  ,"25.25"  ,"26"      ,"26.5"   ,"27.25"  ,"27.75"  ,"28.5"    ,"29"      ,"29.75"  ,"30.5"     ,"31"      ,"31.75"  ,"32.25"  ,"33"      ,"33.5"    ,"34.25"   ,"34.75"   ];
//source : https://www.kuberbox.com/blog/international-ring-size-conversion-chart/




$fn=60;


if (search([Country],US_Countries)[0]>0)
{
    USValues_Main=["1/2","1"  ,"1 1/2"  ,"2"     ,"2 1/2"  ,"3"     ,"3 1/2"  ,"4"     ,"4 1/2"  ,"5"     ,"5 1/2" ,"6"      ,"6 1/2"  ,"7"      ,"7 1/2"  ,"8"      ,"8 1/2"  ,"9"     ,"9 1/2"  ,"10"     ,"10 1/2"  ,"11"     ,"11 1/2"  ,"12"     ,"12 1/2"  ,"13"     ,"13 1/2"  ,"14"     ,"14 1/2"  ,"15"      ];
    USSizes_Main =[12.04,12.45,12.85    ,13.26   ,13.67    ,14.07   ,14.48    ,14.88   ,15.29    ,15.7    ,16.1    ,16.51    ,16.92    ,17.32    ,17.73    ,18.14    ,18.54    ,18.95   ,19.35    ,19.76    ,20.17     ,20.57    ,20.98     ,21.39    ,21.79     ,22.2     ,22.61     ,23.01    ,23.42     ,23.83     ];

    USValues_All=["1/2","3/4"   ,"1"  ,"1 1/4"  ,"1 1/2"  ,"1 3/4"  ,"2"     ,"2 1/4"  ,"2 1/2"  ,"2 3/4"  ,"3"     ,"3 1/4"  ,"3 1/2"  ,"3 3/4"  ,"4"     ,"4 1/4"  ,"4 1/2"  ,"4 3/4" ,"5"     ,"5 1/4"  ,"5 1/2" ,"5 3/4"  ,"6"      ,"6 1/4" ,"6 1/2"  ,"6 3/4"  ,"7"      ,"7 1/4"  ,"7 1/2"  ,"7 3/4" ,"8"      ,"8 1/4" ,"8 1/2"  ,"8 3/4" ,"9"     ,"9 1/4"  ,"9 1/2"  ,"9 3/4" ,"10"     ,"10 1/4"  ,"10 1/2"  ,"10 3/4" ,"11"     ,"11 1/4" ,"11 1/2"  ,"11 3/4" ,"12"     ,"12 1/4" ,"12 1/2"  ,"12 3/4"  ,"13"     ,"13 1/4"   ,"13 1/2"  ,"13 3/4" ,"14"     ,"14 1/4"  ,"14 1/2"  ,"14 3/4"  ,"15"      ];
    USSizes_All =[12.04,12.24   ,12.45,12.65    ,12.85    ,13.06    ,13.26   ,13.46    ,13.67    ,13.87    ,14.07   ,14.27    ,14.48    ,14.68    ,14.88   ,15.09    ,15.29    ,15.49   ,15.7    ,15.9     ,16.1    ,16.31    ,16.51    ,16.71   ,16.92    ,17.12    ,17.32    ,17.53    ,17.73    ,17.93   ,18.14    ,18.34   ,18.54    ,18.75   ,18.95   ,19.15    ,19.35    ,19.56   ,19.76    ,19.96     ,20.17     ,20.37    ,20.57    ,20.78    ,20.98     ,21.18    ,21.39    ,21.59    ,21.79     ,22        ,22.2     ,22.4       ,22.61     ,22.81    ,23.01    ,23.22     ,23.42     ,23.62     ,23.83     ];

    if ((Model=="Women") && precision=="MainSizes") Sizer(USValues_Main,USSizes_Main,"4","10");
    if ((Model=="Men") && precision=="MainSizes") Sizer(USValues_Main,USSizes_Main,"7","11");
    if ((Model=="Children") && precision=="MainSizes") Sizer(USValues_Main,USSizes_Main,"1","4");
    if ((Model=="ExtraLarge") && precision=="MainSizes") Sizer(USValues_Main,USSizes_Main,"10","15");

    if ((Model=="Women") && precision=="HalfSizes") Sizer(USValues_All,USSizes_All,"4","10");
    if ((Model=="Men") && precision=="HalfSizes") Sizer(USValues_All,USSizes_All,"7","11");
    if ((Model=="Children") && precision=="HalfSizes") Sizer(USValues_All,USSizes_All,"1","4");
    if ((Model=="ExtraLarge") && precision=="HalfSizes") Sizer(USValues_All,USSizes_All,"10","15");
}


if (search([Country],ISO_Countries)[0]>0)
{
    EUValues_All =["44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59","60","61","62","63","64","65","66","67","68","69","70","71"];
    EUSizes_All=[14.01,14.33,14.65,14.97,15.29,15.61,15.92,16.24,16.56,16.88,17.2,17.52,17.83,18.15,18.47,18.79,19.11,19.43,19.75,20.06,20.38,20.7,21.02,21.34,21.66,21.97,22.29,22.61];
    //source : http://www.cartier.fr/fr/services/le-guide-cartier/guide-des-tailles/guide-des-tailles-bagues/-10402.html

    if (Model=="Women") Sizer(EUValues_All,EUSizes_All,"48","56");
    if (Model=="Men") Sizer(EUValues_All,EUSizes_All,"56","65");
    if (Model=="Children") Sizer(EUValues_All,EUSizes_All,"44","48");
    if (Model=="ExtraLarge") Sizer(EUValues_All,EUSizes_All,"65","71");
}

if (search([Country],Spain_Countries)[0]>0)
{
    SpainSizes_All    =[12.85    ,13.06    ,13.26   ,13.46    ,13.67    ,13.87    ,14.07   ,14.27    ,14.48    ,14.68    ,14.88   ,15.09    ,15.29    ,15.49   ,15.7    ,15.9     ,16.1    ,16.31    ,16.51    ,16.71   ,16.92    ,17.12    ,17.32    ,17.53    ,17.73    ,17.93   ,18.14    ,18.34   ,18.54    ,18.75   ,18.95   ,19.15    ,19.35    ,19.56   ,19.76    ,19.96     ,20.17     ,20.37    ,20.57    ,20.78    ,20.98     ,21.18    ,21.39    ,21.59    ,21.79     ,22        ,22.2     ,22.4       ,22.61     ,22.81    ,23.01    ,23.22     ,23.42     ,23.62     ,23.83     ];
    SpainValues_All   =["0.5"    ,"1"      ,"1.75"  ,"2.25"   ,"3"      ,"3.5"    ,"4.25"  ,"4.75"   ,"5.5"    ,"6"      ,"6.75"  ,"7.5"    ,"8"      ,"8.75"  ,"9.25"  ,"10"     ,"10.5"  ,"11.25"  ,"11.75"  ,"12.5"  ,"13.25"  ,"13.75"  ,"14.5"   ,"15"     ,"15.75"  ,"16.25" ,"17"     ,"17.5"  ,"18.25"  ,"19"    ,"19.5"  ,"20.25"  ,"20.75"  ,"21.5"  ,"22"     ,"22.75"   ,"23.25"   ,"24"     ,"24.75"  ,"25.25"  ,"26"      ,"26.5"   ,"27.25"  ,"27.75"  ,"28.5"    ,"29"      ,"29.75"  ,"30.5"     ,"31"      ,"31.75"  ,"32.25"  ,"33"      ,"33.5"    ,"34.25"   ,"34.75"   ];

    if (Model=="Women") Sizer(SpainValues_All,SpainSizes_All,"8.75","24");
    if (Model=="Men") Sizer(SpainValues_All,SpainSizes_All,"16.25","25.25");
    if (Model=="Children") Sizer(SpainValues_All,SpainSizes_All,"0.5","8.75");
    if (Model=="ExtraLarge") Sizer(SpainValues_All,SpainSizes_All,"25.25","34.75");
}

if ( precision=="HalfSizes" && search([Country],UK_Countries)[0]>0)
{
    UKValues_All=["A"  ,"A 1/2" ,"B"  ,"B 1/2"  ,"C"      ,"C 1/2"  ,"D"     ,"D 1/2"  ,"E"      ,"E 1/2"  ,"F"     ,"F 1/2"  ,"G"      ,"G 1/2"  ,"H"     ,"H 1/2"  ,"I"      ,"J"     ,"J 1/2" ,"K"      ,"K 1/2" ,"L"      ,"L 1/2"  ,"M"     ,"M 1/2"  ,"N"      ,"N 1/2"  ,"O"      ,"O 1/2"  ,"P"     ,"P 1/2"  ,"Q"     ,"Q 1/2"  ,"R"     ,"R 1/2" ,"S"      ,"S 1/2"  ,"T"     ,"T 1/2"  ,"U"       ,"U 1/2"   ,"V"      ,"V 1/2"  ,"W"      ,"W 1/2"   ,"X"      ,"X 1/2"  ,"Y"      ,"Z"       ,"Z 1/2"   ,"Z1"       ,"Z2"     ,"Z3"     ,"Z4"         ];
    UKSizes_All =[12.04,12.24   ,12.45,12.65    ,12.85    ,13.06    ,13.26   ,13.46    ,13.67    ,13.87    ,14.07   ,14.27    ,14.48    ,14.68    ,14.88   ,15.09    ,15.29    ,15.49   ,15.7    ,15.9     ,16.1    ,16.31    ,16.51    ,16.71   ,16.92    ,17.12    ,17.32    ,17.53    ,17.73    ,17.93   ,18.14    ,18.34   ,18.54    ,18.75   ,18.95   ,19.15    ,19.35    ,19.56   ,19.76    ,19.96     ,20.17     ,20.37    ,20.57    ,20.78    ,20.98     ,21.18    ,21.39    ,21.59    ,21.79     ,22        ,22.4       ,22.81    ,23.01    ,23.42        ];

    if (Model=="Women") Sizer(UKValues_All,UKSizes_All,"J","V");
    if (Model=="Men") Sizer(UKValues_All,UKSizes_All,"P","W");
    if (Model=="Children") Sizer(UKValues_All,UKSizes_All,"A","J");
    if (Model=="ExtraLarge") Sizer(UKValues_All,UKSizes_All,"P","Z");
}


if ( precision=="MainSizes" && search([Country],UK_Countries)[0]>0)
{
    UKValues_Main=["A"  ,"B"  ,"C"  ,"D"  ,"E"  ,"F"  ,"G"  ,"H"  ,"I"  ,"J"  ,"K" ,"L"  ,"M"  ,"N"  ,"O"  ,"P"  ,"Q"  ,"R"  ,"S"  ,"T"  ,"U"  ,"V"  ,"W"  ,"X"  ,"Y","Z"];
    UKSizes_Main= [12.04,12.45,12.85,13.26,13.67,14.07,14.48,14.88,15.29,15.49,15.9,16.31,16.71,17.12,17.53,17.93,18.34,18.75,19.15,19.56,19.94,20.37,20.78,21.18,21.59,21.79];

    if (Model=="Women") Sizer(UKValues_Main,UKSizes_Main,"J","V");
    if (Model=="Men") Sizer(UKValues_Main,UKSizes_Main,"P","W");
    if (Model=="Children") Sizer(UKValues_Main,UKSizes_Main,"A","J");
    if (Model=="ExtraLarge") Sizer(UKValues_Main,UKSizes_Main,"P","Z");
}


if (search([Country],India_Countries)[0]>0)
{
    IndiaValues_Main   =["1"      ,"2"     ,"3"      ,"4"      ,"5"      ,"6"      ,"7"      ,"8 1/2"  ,"9"     ,"10"     ,"11"     ,"12"     ,"13"     ,"14"     ,"15"     ,"16"    ,"17"     ,"18"     ,"19"    ,"20"     ,"21"     ,"22"     ,"23"      ,"24"     ,"25"     ,"26"      ,"27"      ,"28"     ,"29"      ,"30"     ,"31"      ,"32"     ,"33"      ,"34"      ,"35"      ];
    IndiaSizes_Main    =[13.06    ,13.26   ,13.67    ,13.87    ,14.27    ,14.68    ,15.09    ,15.29    ,15.49   ,15.9     ,16.31    ,16.51    ,16.92    ,17.32    ,17.53    ,17.93   ,18.14    ,18.54    ,18.75   ,19.15    ,19.35    ,19.76    ,19.96     ,20.37    ,20.57    ,20.98     ,21.39    ,21.59    ,22        ,22.2     ,22.61     ,22.81    ,23.22     ,23.62     ,23.83     ];

    if (Model=="Women") Sizer(IndiaValues_Main,IndiaSizes_Main,"9","25");
    if (Model=="Men") Sizer(IndiaValues_Main,IndiaSizes_Main,"16","25");
    if (Model=="Children") Sizer(IndiaValues_Main,IndiaSizes_Main,"1","9");
    if (Model=="ExtraLarge") Sizer(IndiaValues_Main,IndiaSizes_Main,"16","35");
}

if (search([Country],China_Countries)[0]>0)
{

    ChinaValues_Main   =["1"  ,"2"     ,"3"      ,"4"     ,"5"      ,"6"      ,"7"     ,"8"      ,"9"     ,"10"    ,"11"     ,"12"    ,"13"     ,"14"     ,"15"     ,"16"     ,"17"     ,"18"    ,"19"     ,"20"     ,"21"      ,"22"      ,"23"     ,"24"      ,"25"    ,"26"      ,"27"     ];
    ChinaSizes_Main    =[12.45,13.26   ,13.67    ,14.07   ,14.27    ,14.68    ,14.88   ,15.29    ,15.7    ,16.1    ,16.51    ,16.71   ,16.92    ,17.32    ,17.73    ,18.14    ,18.54    ,18.95   ,19.35    ,19.76    ,19.96     ,20.17     ,20.57    ,20.98     ,21.39   ,21.79     ,22.2     ];
    if (Model=="Women") Sizer(ChinaValues_Main,ChinaSizes_Main,"9","25");
    if (Model=="Men") Sizer(ChinaValues_Main,ChinaSizes_Main,"16","25");
    if (Model=="Children") Sizer(ChinaValues_Main,ChinaSizes_Main,"1","9");
    if (Model=="ExtraLarge") Sizer(ChinaValues_Main,ChinaSizes_Main,"16","35");
}



if (search([Country],Japan_Countries)[0]>0)
{

    JapanSizes_All    =[12.37,13.21   ,13.61    ,14.05   ,14.36    ,14.56    ,14.86    ,15.27    ,15.7     ,16       ,16.51   ,16.92    ,17.35    ,17.75    ,18.19    ,18.53   ,18.89   ,19.41    ,19.84   ,20.02    ,19.96     ,20.68    ,21.08    ,21.49    ,21.89    ,22.33     ];
    JapanValues_All   =["1"  ,"2"     ,"3"      ,"4"     ,"5"      ,"6"      ,"7"      ,"8"      ,"9"      ,"10"     ,"12"    ,"13"     ,"14"     ,"15"     ,"16"    ,"17"     ,"18"    ,"19"     ,"20"     ,"21"      ,"22"    ,"23"     ,"24"     ,"25"     ,"26"     ,"27"  ];
    //JapanSource="http://www.ringsizes.co/"
    if (Model=="Women") Sizer(JapanValues_All,JapanSizes_All,"8","23");
    if (Model=="Mene") Sizer(JapanValues_All,JapanSizes_All,"22","27");
    if (Model=="Children") Sizer(JapanValues_All,JapanSizes_All,"1","8");
    if (Model=="ExtraLarge") Sizer(JapanValues_All,JapanSizes_All,"22","27");
}










module Sizer(SelValues,SelSizes,FirstSize,LastSize)
{

sizemin=min(SelSizes);
sizemax=max(SelSizes);

nbstart=search([FirstSize],SelValues)[0];
nbend=search([LastSize],SelValues)[0];

UKnb=nbend-nbstart;
for (i=[nbstart:1:nbend])
    {
    translate([0,(UKnb-i+nbstart-1)*ringheight,0]) InternationalTestring(SelSizes[i],SelValues[i],sizemin,sizemax); 
    }


difference()
    {
    union(){
    hull()
    {    
        translate([0,-ringheight,-thickness/2])cylinder(r=SelSizes[nbend]/2,h=thickness-0.5);
        translate([0,-ringheight-2*4,-thickness/2])cylinder(r=SelSizes[nbend]/2,h=thickness-0.5);
    }

    translate([0,-ringheight-SelSizes[nbend]/4,thickness/2-0.5])    HorizontalTag(Tstr=TextLine1);
    translate([0,-ringheight-4-SelSizes[nbend]/4,thickness/2-0.5])    HorizontalTag(Tstr=TextLine2);
    }
    
    translate([0,-ringheight-2*4-SelSizes[nbend]/4,-thickness/2])    cylinder(r=3,h=thickness+1);
    
    }

}

module InternationalTestring(size,ValueName,sizemin,sizemax)
{
 //   translate([0,-size/2,0])cube([ringheight,size,2]);
difference()
    {
     translate([0,0,0]) rotate([-90,0,0])cylinder(r=size/2,h=ringheight);
     translate([-sizemax/2,-1,thickness/2]) cube([sizemax,ringheight+2,sizemax])  ;
     translate([-sizemax/2,-1,-thickness/2-sizemax]) cube([sizemax,ringheight+2,sizemax]) ; 

    }
    HorizontalTag(TPosition=[0,0.5,thickness/2],Tstr=ValueName);
}


module HorizontalTag(TPosition=[0,0,0],Tstr="Text",Tsize=3,Thalign="center",Tcolor="red",Tfont = "Liberation Sans")
{
     translate(TPosition) linear_extrude(height = 0.5) {
   color([0.2,0,0])  text(text = Tstr, font = Tfont, size = Tsize, halign = Thalign);
 }   

}

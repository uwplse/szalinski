//////////////////F.A.R///////////////////
/*

First Attempt: 10/30/2016
Goals: Generate F.A.R from site input

*/

////////////////Parameters////////////////
/* [Global] */

/* [Location] */
Location="New_York"; // [New_York, Chicago]

/* [Zoning] */
Zoning="R9A"; // [R9A, R9X, R10]

/* [Site Lenght (x10 Feet)] */
Site_lenght=20;// [1:500]

/* [Site Width Feet] */
Site_width=10;// [1:500] 

/* [Site Situation] */
Placement="Corner_Lot"; // [Corner_Lot, Interior_Lot]
Frontage="Wide_Street"; // [Wide_Street, Narrow_Street]

/* [Extra] */
Inclusionary_Housing_Public_Plaza="Yes"; // [Yes, No]


/* [Hidden] */
Slab=0.1;
Hollow=0.8;
Bleu=[.3,.3,.3,.7];
Vitres=[.6,.7,1,.3];
Base=[.8,.3,.3,.8];

Area=(Site_lenght*Site_width);

Building_Width=((0.8*(Site_width*Site_lenght))/Site_width);
Base_Setback=(Site_lenght-Building_Width);

////////////////Renders//////////////////
  translate ([0,0,0]){
      cube([Site_width,Site_lenght,0.1],true,Color(Base));
  }


if ((Location=="New_York")&&(Zoning=="R9A")&&(Placement=="Corner_Lot")&&(Frontage=="Wide_Street")&&(Inclusionary_Housing_Public_Plaza=="Yes")){
   FAR=8.5;  
     scale([1,0.8,1]){
      translate([0,Base_Setback,0])
       Ground_Floor();}
        for (FAR=[2:1:8]){
            translate ([0,0,FAR-.9])
             scale([1,0.8,1])
              Upper_Floor ();
        }
}                        
if (Location=="Chicago"){
    for (FAR=[8:1:FAR]){
      translate([0,0,FAR-1])
        intersection(){
            Upper_Floor ();
                Setback_Two ();
        }
    } 
}

///////////////Module///////////////////
module Ground_Floor (){
      color(Bleu)
        cube([Site_width,Site_lenght,Slab],true);
      translate([0,0,.4])
        color(Vitres)
         cube([Site_width,Site_lenght,Hollow],true);
      translate([0,0,.9])
           color(Bleu)
            cube([Site_width,Site_lenght,Slab],true);
}
module Upper_Floor (){
     color(Vitres)
        cube([Site_width,Site_lenght,Hollow+1],true);
      translate([0,0,.9])
           color(Bleu)
            cube([Site_width,Site_lenght,Slab],true);
}
module Setback_One (){
    scale(.8,.9,0)
       Upper_Floor ();
}    
module Setback_Two (){
    scale(.5,.6,0)
       Upper_Floor ();
} 
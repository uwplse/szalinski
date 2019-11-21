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
Zoning="R10"; // [R9A, R10]

/* [Site Lenght (x10 Feet)] */
Site_lenght=20;// [1:500]

/* [Site Width Feet] */
Site_width=10;// [1:500] 

/* [Site Situation] */
Placement="Corner_Lot"; // [Corner_Lot, Interior_Lot]
Frontage="Narrow_Street"; // [Wide_Street, Narrow_Street]

/* [Extra] */
Inclusionary_Housing_Public_Plaza="Yes"; // [Yes, No]


/* [Hidden] */
Slab=0.1;
Hollow=0.8;
Bleu=[.3,.3,.3,.7];
Vitres=[.6,.7,1,.3];
Base=[.8,.3,.3,.6];

Area=(Site_lenght*Site_width);

Base_Setback=(Site_lenght-Building_Lenght);
Building_lenght=(0.8*Site_lenght); 
////////////////Renders//////////////////
  translate ([0,0,0]){
      cube([Site_width,Site_lenght,0.1],true,Color(Base));
  }

///NY - R9A - Corner Lot - Wide Street - Inclusion Housing//
if ((Location=="New_York")&&(Zoning=="R9A")&&(Placement=="Corner_Lot")&&(Frontage=="Wide_Street")&&(Inclusionary_Housing_Public_Plaza=="Yes")){
   FAR=8.5; 
   
     scale([1,0.8,1]){
      translate([0,0.125*Site_lenght,0])
       Ground_Floor();}
        for (FAR=[2:1:8]){
            translate ([0,0.1*Site_lenght,FAR-.9])
             scale([1,0.8,1])
              Upper_Floor ();
    }   for (FAR=[8:1:12]){
            translate ([.1*Site_width,0.025*Site_lenght,FAR-.9])
             scale([.8,0.65,1])
              Upper_Floor ();
    }
}   
///NY - R9A - Corner Lot - Wide Street - No Inclusion Housing//
if ((Location=="New_York")&&(Zoning=="R9A")&&(Placement=="Corner_Lot")&&(Frontage=="Wide_Street")&&(Inclusionary_Housing_Public_Plaza=="No")){
   FAR=7.5; 
   
     scale([1,0.8,1]){
      translate([0,0.125*Site_lenght,0])
       Ground_Floor();}
        for (FAR=[2:1:8]){
            translate ([0,0.1*Site_lenght,FAR-.9])
             scale([1,0.8,1])
              Upper_Floor ();
    }   for (FAR=[8:1:10]){
            translate ([.1*Site_width,0.025*Site_lenght,FAR-.9])
             scale([.8,0.65,1])
              Upper_Floor ();
    }
} 
///NY - R9A - Corner Lot - Narrow Street - Inclusion Housing//
if ((Location=="New_York")&&(Zoning=="R9A")&&(Placement=="Corner_Lot")&&(Frontage=="Narrow_Street")&&(Inclusionary_Housing_Public_Plaza=="Yes")){
   FAR=8.5; 
   
     scale([1,0.8,1]){
      translate([0,0.125*Site_lenght,0])
       Ground_Floor();}
        for (FAR=[2:1:7]){
            translate ([0,0.1*Site_lenght,FAR-.9])
             scale([1,0.8,1])
              Upper_Floor ();
    }   for (FAR=[7:1:13]){
            translate ([.1*Site_width,0.025*Site_lenght,FAR-.9])
             scale([.8,0.65,1])
              Upper_Floor ();
    }
}
///NY - R9A - Corner Lot - Narrow Street - No Inclusion Housing//
if ((Location=="New_York")&&(Zoning=="R9A")&&(Placement=="Corner_Lot")&&(Frontage=="Narrow_Street")&&(Inclusionary_Housing_Public_Plaza=="No")){
   FAR=7.5; 
   
     scale([1,0.8,1]){
      translate([0,0.125*Site_lenght,0])
       Ground_Floor();}
        for (FAR=[2:1:7]){
            translate ([0,0.1*Site_lenght,FAR-.9])
             scale([1,0.8,1])
              Upper_Floor ();
    }   for (FAR=[7:1:11]){
            translate ([.1*Site_width,0.025*Site_lenght,FAR-.9])
             scale([.8,0.65,1])
              Upper_Floor ();
    }
}
///NY - R9A - Interior Lot - Wide Street - Inclusion Housing//
if ((Location=="New_York")&&(Zoning=="R9A")&&(Placement=="Interior_Lot")&&(Frontage=="Wide_Street")&&(Inclusionary_Housing_Public_Plaza=="Yes")){
   FAR=8.5; 
   
     scale([1,0.7,1]){
      translate([0,0.215*Site_lenght,0])
       Ground_Floor();}
        for (FAR=[2:1:8]){
            translate ([0,0.150*Site_lenght,FAR-.9])
             scale([1,0.7,1])
              Upper_Floor ();
    }   for (FAR=[8:1:13]){
            translate ([0,0.05*Site_lenght,FAR-.9])
             scale([1,0.5,1])
              Upper_Floor ();
    }
} 
///NY - R9A - Interior Lot - Wide Street - No Inclusion Housing//
if ((Location=="New_York")&&(Zoning=="R9A")&&(Placement=="Interior_Lot")&&(Frontage=="Wide_Street")&&(Inclusionary_Housing_Public_Plaza=="No")){
   FAR=7.5; 
   
     scale([1,0.7,1]){
      translate([0,0.215*Site_lenght,0])
       Ground_Floor();}
        for (FAR=[2:1:8]){
            translate ([0,0.150*Site_lenght,FAR-.9])
             scale([1,0.7,1])
              Upper_Floor ();
    }   for (FAR=[8:1:11]){
            translate ([0,0.05*Site_lenght,FAR-.9])
             scale([1,0.5,1])
              Upper_Floor ();
    }
} 
///NY -R9A - Interior Lot - Narrow Street - Inclusion Housing//
if ((Location=="New_York")&&(Zoning=="R9A")&&(Placement=="Interior_Lot")&&(Frontage=="Narrow_Street")&&(Inclusionary_Housing_Public_Plaza=="Yes")){
   FAR=8.5; 
   
     scale([1,0.7,1]){
      translate([0,0.215*Site_lenght,0])
       Ground_Floor();}
        for (FAR=[2:1:7]){
            translate ([0,0.150*Site_lenght,FAR-.9])
             scale([1,0.7,1])
              Upper_Floor ();
    }   for (FAR=[7:1:14]){
            translate ([0,0.05*Site_lenght,FAR-.9])
             scale([1,0.5,1])
              Upper_Floor ();
    }
} 
///NY -R9A - Interior Lot - Narrow Street - No Inclusion Housing//
if ((Location=="New_York")&&(Zoning=="R9A")&&(Placement=="Interior_Lot")&&(Frontage=="Narrow_Street")&&(Inclusionary_Housing_Public_Plaza=="No")){
   FAR=7.5; 
   
     scale([1,0.7,1]){
      translate([0,0.215*Site_lenght,0])
       Ground_Floor();}
        for (FAR=[2:1:7]){
            translate ([0,0.150*Site_lenght,FAR-.9])
             scale([1,0.7,1])
              Upper_Floor ();
    }   for (FAR=[7:1:12]){
            translate ([0,0.05*Site_lenght,FAR-.9])
             scale([1,0.5,1])
              Upper_Floor ();
    }
} 
///NY - R10 - Corner Lot - Wide Street - Inclusion Housing//
if ((Location=="New_York")&&(Zoning=="R10")&&(Placement=="Corner_Lot")&&(Frontage=="Wide_Street")&&(Inclusionary_Housing_Public_Plaza=="Yes")){
   FAR=12; 
   
     scale([1,1,1]){
      translate([0,0,0])
       Ground_Floor();}
        for (FAR=[2:1:10]){
            translate ([0,0,FAR-.9])
             scale([1,1,1])
              Upper_Floor ();
    }   for (FAR=[10:1:14]){
            translate ([.1*Site_width,-0.1*Site_lenght,FAR-.9])
             scale([.8,0.8,1])
              Upper_Floor ();
    }
}  
///NY - R10 - Corner Lot - Wide Street - No Inclusion Housing//
if ((Location=="New_York")&&(Zoning=="R10")&&(Placement=="Corner_Lot")&&(Frontage=="Wide_Street")&&(Inclusionary_Housing_Public_Plaza=="No")){
   FAR=10; 
   
     scale([1,1,1]){
      translate([0,0,0])
       Ground_Floor();}
        for (FAR=[2:1:10]){
            translate ([0,0,FAR-.9])
             scale([1,1,1])
              Upper_Floor ();
    }
} 
///NY - R10 - Corner Lot - Narrow Street - Inclusion Housing//
if ((Location=="New_York")&&(Zoning=="R10")&&(Placement=="Corner_Lot")&&(Frontage=="Narrow_Street")&&(Inclusionary_Housing_Public_Plaza=="Yes")){
   FAR=12; 
   
     scale([1,1,1]){
      translate([0,0,0])
       Ground_Floor();}
        for (FAR=[2:1:8]){
            translate ([0,0,FAR-.9])
             scale([1,1,1])
              Upper_Floor ();
    }   for (FAR=[8:1:16]){
            translate ([.1*Site_width,-0.1*Site_lenght,FAR-.9])
             scale([.8,0.8,1])
              Upper_Floor ();
    }
} 
///NY - R10 - Corner Lot - Narrow Street - No Inclusion Housing//
if ((Location=="New_York")&&(Zoning=="R10")&&(Placement=="Corner_Lot")&&(Frontage=="Narrow_Street")&&(Inclusionary_Housing_Public_Plaza=="No")){
   FAR=10; 
   
     scale([1,1,1]){
      translate([0,0,0])
       Ground_Floor();}
        for (FAR=[2:1:8]){
            translate ([0,0,FAR-.9])
             scale([1,1,1])
              Upper_Floor ();
    }   for (FAR=[8:1:12]){
            translate ([.1*Site_width,-0.1*Site_lenght,FAR-.9])
             scale([.8,0.8,1])
              Upper_Floor ();    
    }
} 
///NY -R10 - Interior Lot - Wide Street - Inclusion Housing//
if ((Location=="New_York")&&(Zoning=="R10")&&(Placement=="Interior_Lot")&&(Frontage=="Wide_Street")&&(Inclusionary_Housing_Public_Plaza=="Yes")){
   FAR=12; 
   
     scale([1,0.7,1]){
      translate([0,0.215*Site_lenght,0])
       Ground_Floor();}
        for (FAR=[2:1:12]){
            translate ([0,0.150*Site_lenght,FAR-.9])
             scale([1,0.7,1])
              Upper_Floor ();
    }   for (FAR=[12:1:18]){
            translate ([0,0.075*Site_lenght,FAR-.9])
             scale([1,0.55,1])
              Upper_Floor ();
    }
} 
///NY -R10 - Interior Lot - Wide Street - No Inclusion Housing//
if ((Location=="New_York")&&(Zoning=="R10")&&(Placement=="Interior_Lot")&&(Frontage=="Wide_Street")&&(Inclusionary_Housing_Public_Plaza=="No")){
   FAR=10; 
   
     scale([1,0.7,1]){
      translate([0,0.215*Site_lenght,0])
       Ground_Floor();}
        for (FAR=[2:1:12]){
            translate ([0,0.150*Site_lenght,FAR-.9])
             scale([1,0.7,1])
              Upper_Floor ();
    }   for (FAR=[12:1:14]){
            translate ([0,0.075*Site_lenght,FAR-.9])
             scale([1,0.55,1])
              Upper_Floor ();
    }
} 
///NY -R10 - Interior Lot - Narrow Street - Inclusion Housing//
if ((Location=="New_York")&&(Zoning=="R10")&&(Placement=="Interior_Lot")&&(Frontage=="Narrow_Street")&&(Inclusionary_Housing_Public_Plaza=="Yes")){
   FAR=12; 
   
     scale([1,0.7,1]){
      translate([0,0.215*Site_lenght,0])
       Ground_Floor();}
        for (FAR=[2:1:9]){
            translate ([0,0.150*Site_lenght,FAR-.9])
             scale([1,0.7,1])
              Upper_Floor ();
    }   for (FAR=[9:1:17]){
            translate ([0,0.075*Site_lenght,FAR-.9])
             scale([1,0.55,1])
              Upper_Floor ();
    }
} 
///NY -R10 - Interior Lot - Narrow Street - No Inclusion Housing//
if ((Location=="New_York")&&(Zoning=="R10")&&(Placement=="Interior_Lot")&&(Frontage=="Narrow_Street")&&(Inclusionary_Housing_Public_Plaza=="No")){
   FAR=12; 
   
     scale([1,0.7,1]){
      translate([0,0.215*Site_lenght,0])
       Ground_Floor();}
        for (FAR=[2:1:9]){
            translate ([0,0.150*Site_lenght,FAR-.9])
             scale([1,0.7,1])
              Upper_Floor ();
    }   for (FAR=[9:1:13]){
            translate ([0,0.075*Site_lenght,FAR-.9])
             scale([1,0.55,1])
              Upper_Floor ();
    }
} 
///Chicago//
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
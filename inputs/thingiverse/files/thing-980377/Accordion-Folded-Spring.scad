/* [Accordion] */
accordion_length=100;//[5:300]
accordion_folds=13;//[1:150]
accordion_width=25;//[5:200]
accordion_height=25;//[1:0.1:200]
accordion_sheet_thickness=1;//[0.2:0.05:10]
accordion_right_angle_ends=0;//[0:None,1:To one side,2:To both sides]
reinforcement_for_ends="No";//[No,Yes]
/* [1. hole] */
hole_1=0;//[0:None,3:Triangle,4:Square,6:Hexagon,100:Circle]
hole_1_diameter=5;//[1:0.1:50]
hole_1_rotate=45;//[0:395]
hole_1_X_position=0;//[-100:0.1:100]
hole_1_Y_position=0;//[-100:0.1:100]
/* [2. hole] */
hole_2=0;//[0:None,3:Triangle,4:Square,6:Hexagon,100:Circle]
hole_2_diameter=5;//[1:0.1:50]
hole_2_rotate=45;//[0:395]
hole_2_X_position=0;//[-100:0.1:100]
hole_2_Y_position=0;//[-100:0.1:100]
/* [3. hole] */
hole_3=0;//[0:None,3:Triangle,4:Square,6:Hexagon,100:Circle]
hole_3_diameter=5;//[1:0.1:50]
hole_3_rotate=45;//[0:395]
hole_3_X_position=0;//[-100:0.1:100]
hole_3_Y_position=0;//[-100:0.1:100]
/* [4. hole] */
hole_4=0;//[0:None,3:Triangle,4:Square,6:Hexagon,100:Circle]
hole_4_diameter=5;//[1:0.1:50]
hole_4_rotate=45;//[0:395]
hole_4_X_position=0;//[-100:0.1:100]
hole_4_Y_position=0;//[-100:0.1:100]
/* [5. hole] */
hole_5=0;//[0:None,3:Triangle,4:Square,6:Hexagon,100:Circle]
hole_5_diameter=5;//[1:0.1:50]
hole_5_rotate=45;//[0:395]
hole_5_X_position=0;//[-100:0.1:100]
hole_5_Y_position=0;//[-100:0.1:100]
/* [Ends only hole] */
hole_6=0;//[0:None,3:Triangle,4:Square,6:Hexagon,100:Circle]
hole_6_diameter=5;//[1:0.1:50]
hole_6_rotate=45;//[0:395]
hole_6_X_position=0;//[-100:0.1:100]
hole_6_Y_position=0;//[-100:0.1:100]
/* [Folds only hole] */
hole_7=0;//[0:None,3:Triangle,4:Square,6:Hexagon,100:Circle]
hole_7_diameter=5;//[1:0.1:50]
hole_7_rotate=45;//[0:395]
hole_7_X_position=0;//[-100:0.1:100]
hole_7_Y_position=0;//[-100:0.1:100]
/* [Hidden] */
pikkus=accordion_length;
laius=accordion_width;
korgus=accordion_height;
paksus=accordion_sheet_thickness;
murdeid=accordion_folds;
samm=(pikkus-paksus)/murdeid;
kraadid=asin((samm)/(laius));
hole_1_X=abs(hole_1_X_position)>laius/2+hole_1_diameter/2?laius/2+hole_1_diameter/2-0.1:hole_1_X_position;
hole_1_Y=abs(hole_1_Y_position)>korgus/2+hole_1_diameter/2?korgus/2+hole_1_diameter/2-0.1:hole_1_Y_position;
hole_2_X=abs(hole_2_X_position)>laius/2+hole_2_diameter/2?laius/2+hole_2_diameter/2-0.1:hole_2_X_position;
hole_2_Y=abs(hole_2_Y_position)>korgus/2+hole_2_diameter/2?korgus/2+hole_2_diameter/2-0.1:hole_2_Y_position;
hole_3_X=abs(hole_3_X_position)>laius/2+hole_3_diameter/2?laius/2+hole_3_diameter/2-0.1:hole_3_X_position;
hole_3_Y=abs(hole_3_Y_position)>korgus/2+hole_3_diameter/2?korgus/2+hole_3_diameter/2-0.1:hole_3_Y_position;
hole_4_X=abs(hole_4_X_position)>laius/2+hole_4_diameter/2?laius/2+hole_4_diameter/2-0.1:hole_4_X_position;
hole_4_Y=abs(hole_4_Y_position)>korgus/2+hole_4_diameter/2?korgus/2+hole_4_diameter/2-0.1:hole_4_Y_position;
hole_5_X=abs(hole_5_X_position)>laius/2+hole_5_diameter/2?laius/2+hole_5_diameter/2-0.1:hole_5_X_position;
hole_5_Y=abs(hole_5_Y_position)>korgus/2+hole_5_diameter/2?korgus/2+hole_5_diameter/2-0.1:hole_5_Y_position;
hole_6_X=abs(hole_6_X_position)>laius/2+hole_6_diameter/2?laius/2+hole_6_diameter/2-0.1:hole_6_X_position;
hole_6_Y=abs(hole_6_Y_position)>korgus/2+hole_6_diameter/2?korgus/2+hole_6_diameter/2-0.1:hole_6_Y_position;
hole_7_X=abs(hole_7_X_position)>laius/2+hole_7_diameter/2?laius/2+hole_7_diameter/2-0.1:hole_7_X_position;
hole_7_Y=abs(hole_7_Y_position)>korgus/2+hole_7_diameter/2?korgus/2+hole_7_diameter/2-0.1:hole_7_Y_position;
difference(){
union(){
for(x=[0:2:murdeid-1]){vasakule(x);paremale(x);}
if(accordion_right_angle_ends>0){hull(){translate([paksus/2,laius/2-paksus/2,0])cylinder(d=paksus,h=korgus,center=true,$fn=100);translate([paksus/2,-laius/2+paksus/2,0])cylinder(d=paksus,h=korgus,center=true,$fn=100);}if(reinforcement_for_ends=="Yes"){hull(){translate([paksus/2,-laius/2+paksus/2,0])cylinder(d=paksus,h=korgus,center=true,$fn=100);translate([samm+paksus/2,-laius/2+paksus/2,0])cylinder(d=paksus,h=korgus,center=true,$fn=100);}}}
if(accordion_right_angle_ends>1){hull(){translate([pikkus-paksus/2,laius/2-paksus/2,0])cylinder(d=paksus,h=korgus,center=true,$fn=100);translate([pikkus-paksus/2,-laius/2+paksus/2,0])cylinder(d=paksus,h=korgus,center=true,$fn=100);}if(reinforcement_for_ends=="Yes"){pool=round(murdeid/2)*2==murdeid?-laius/2+paksus/2:laius/2-paksus/2;hull(){translate([pikkus-paksus/2,pool,0])cylinder(d=paksus,h=korgus,center=true,$fn=100);translate([pikkus-samm-paksus/2,pool,0])cylinder(d=paksus,h=korgus,center=true,$fn=100);}}}}
if(hole_1!=0){translate([0,hole_1_X,hole_1_Y])rotate([0,90,0])translate([0,0,pikkus/2])rotate([0,0,hole_1_rotate])cylinder(d=hole_1_diameter,h=pikkus,center=true,$fn=hole_1);}
if(hole_2!=0){translate([0,hole_2_X,hole_2_Y])rotate([0,90,0])translate([0,0,pikkus/2])rotate([0,0,hole_2_rotate])cylinder(d=hole_2_diameter,h=pikkus,center=true,$fn=hole_2);}
if(hole_3!=0){translate([0,hole_3_X,hole_3_Y])rotate([0,90,0])translate([0,0,pikkus/2])rotate([0,0,hole_3_rotate])cylinder(d=hole_3_diameter,h=pikkus,center=true,$fn=hole_3);}
if(hole_4!=0){translate([0,hole_4_X,hole_4_Y])rotate([0,90,0])translate([0,0,pikkus/2])rotate([0,0,hole_4_rotate])cylinder(d=hole_4_diameter,h=pikkus,center=true,$fn=hole_4);}
if(hole_5!=0){translate([0,hole_5_X,hole_5_Y])rotate([0,90,0])translate([0,0,pikkus/2])rotate([0,0,hole_5_rotate])cylinder(d=hole_5_diameter,h=pikkus,center=true,$fn=hole_5);}
if(hole_6!=0){translate([0,hole_6_X,hole_6_Y])rotate([0,90,0])translate([0,0,paksus/2+0.1])rotate([0,0,hole_6_rotate])cylinder(d=hole_6_diameter,h=paksus+0.2,center=true,$fn=hole_6);translate([0,hole_6_X,hole_6_Y])rotate([0,90,0])translate([0,0,pikkus-paksus/2-0.1])rotate([0,0,hole_6_rotate])cylinder(d=hole_6_diameter,h=paksus+0.2,center=true,$fn=hole_6);}
if(hole_7!=0){translate([0,hole_7_X,hole_7_Y])rotate([0,90,0])translate([0,0,pikkus/2])rotate([0,0,hole_7_rotate])cylinder(d=hole_7_diameter,h=pikkus-2*paksus-0.2,center=true,$fn=hole_7);}}
module vasakule(aste){
hull(){translate([aste*samm+paksus/2,laius/2-paksus/2,0])cylinder(d=paksus,h=korgus,center=true,$fn=100);translate([(aste+1)*samm+paksus/2,-laius/2+paksus/2,0])cylinder(d=paksus,h=korgus,center=true,$fn=100);}}
module paremale(aste){
if(aste<murdeid-1){hull(){translate([(aste+2)*samm+paksus/2,laius/2-paksus/2,0])cylinder(d=paksus,h=korgus,center=true,$fn=100);translate([(aste+1)*samm+paksus/2,-laius/2+paksus/2,0])cylinder(d=paksus,h=korgus,center=true,$fn=100);}}}    
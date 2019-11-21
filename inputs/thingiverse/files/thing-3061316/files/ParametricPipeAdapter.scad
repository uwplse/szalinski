/* [Universal Pipe Adapter] */

// this thing is published by teinturman
/* [PIPE 1] */
InternalDiameter1=35;
ExternalDiameter1=38;
Height1= 40; 

//Percentage of External Bevel
PercentExtBevel1=0;//[0:5:90]

//Percentage of Internal Bevel
PercentIntBevel1=0;//[0:5:90]


/* [PIPE 2] */
InternalDiameter2=32;
ExternalDiameter2=35;
Height2= 50;

//Percentage of External Bevel
PercentExtBevel2=4;//[0:5:90]

//Percentage of Internal Bevel
PercentIntBevel2=0;//[0:5:90]




/* [Hidden] */
InternalDiff=abs(InternalDiameter2-InternalDiameter1);
ExternalDiff=abs(ExternalDiameter2-ExternalDiameter1);
Hdiff=max(ExternalDiff,InternalDiff);

adapter(InternalDiameter1,ExternalDiameter1,InternalDiameter2,ExternalDiameter2,Hdiff);





module adapter(Int1,Ext1,Int2,Ext2,Hdiff)
{
$fn=100;
difference()
{
union()
  {  
    cylinder(r1=(Ext1/2)-(PercentExtBevel1*((Ext1-Int1)/2)/100),r2=Ext1/2,h=Height1);
    translate([0,0,Height1]) cylinder(r1=Ext1/2,r2=Ext2/2,h=Hdiff);
    translate([0,0,Height1+Hdiff])cylinder(r1=Ext2/2,r2=(Ext2/2)-PercentExtBevel2*((Ext2-Int2)/2)/100,h=Height2);
  }

    cylinder(r1=(Int1/2)+PercentIntBevel1*((ExternalDiameter1-InternalDiameter1)/2)/100,r2=(Int1/2),h=Height1);
    translate([0,0,Height1])cylinder(r1=Int1/2,r2=Int2/2,h=Hdiff);
    translate([0,0,Height1+Hdiff]) cylinder(r1=Int2/2,r2=(Int2/2)+PercentIntBevel2*((ExternalDiameter2-InternalDiameter2)/2)/100, h=Height2);

}

}

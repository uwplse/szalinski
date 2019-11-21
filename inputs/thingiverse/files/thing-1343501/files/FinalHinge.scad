/*[Link]*/
LinkRadius = 6;
//This is the length of each link, consider that this is the distance that your printer needs to be able to bridge.
LinkLength = 15;
//The thicker, the sturdier the overall hinge. Obiously InnerShaft + Inner Tolerance should never be bigger than Link Radius.
InnerShaft = 3.5;
//Depends on your printer/material, .6 worked well for me (this is the distance between the inner shaft and the inner layers of the links)
InnerTolerance = .6;
//Spacing between the links, i found .6mm to give good results
Spacing = .6;
//LinkNumber * LinkLength = the total length of your hinge.
LinkNumber = 5;
/*[Tabs]*/
TabLength0 = 25;
TabLength = 25;
TabThickness = 3;
HoleDiameter=4;
HoleOffset0=0;
HoleOffset=0;
//Do you want 2 long tabs or multiple smaller ones? 0=Yes, 1=No
LongTab = 0;

TotalLength = (LinkNumber*LinkLength)+(Spacing*(LinkNumber-1));


module solidHinge(LinkRadius,LinkLength,TabLength,TabThickness){
    union(){
        rotate([90,0,0]) linear_extrude(height=LinkLength,center=true) translate([0,LinkRadius,0]) circle(LinkRadius);
        translate([TabLength/2,0,TabThickness/2]) 
        difference(){cube([TabLength,LinkLength,TabThickness],center=true);
            translate([LinkRadius/2+HoleOffset,0,0])cylinder(h=TabThickness,r=HoleDiameter/2,center=true);
        }
    }
}


module hollowHinge(LinkRadius,LinkLength,TabLength,TabThickness,Spacing,InnerTolerance,InnerShaft){
    union(){
        difference(){
            union(){
                rotate([90,0,0]) linear_extrude(height=LinkLength,center=true) translate([0,LinkRadius,0]) circle(LinkRadius);
                translate([TabLength0/2,0,TabThickness/2]) 
                difference(){cube([TabLength0,LinkLength,TabThickness],center=true);
                translate([LinkRadius/2+HoleOffset0,0,0])cylinder(h=TabThickness,r=HoleDiameter/2,center=true);
                }
            }
            rotate([90,0,0]) linear_extrude(height=LinkLength+Spacing,center=true) translate([0,LinkRadius,0]) circle(InnerShaft+InnerTolerance,center=true);
        }
        rotate([90,0,0]) linear_extrude(height=LinkLength+(Spacing*2),center=true) translate([0,LinkRadius,0]) circle(InnerShaft,center=true);
    }
}

module CompleteHinge(LinkRadius,LinkLength,TabLength,TabThickness,Spacing,InnerTolerance,InnerShaft,LongTab,LinkNumber){
    
    union(){
        for(a=[0:LinkNumber-1]){
            if(a%2!=0){
                union(){
                mirror(1,0,0) translate([0,(LinkLength+(Spacing))*a,0]) hollowHinge(LinkRadius,LinkLength,TabLength,TabThickness,Spacing,InnerTolerance,InnerShaft); 
                   if(LongTab==0 && a!=LinkNumber-1){
                       if(a==1){
                       translate([-TabLength0/2-LinkRadius/2,0,TabThickness/2]) cube([TabLength0-LinkRadius,LinkLength+(Spacing*2),TabThickness],center=true);
                       }
                    translate([-TabLength0/2-LinkRadius/2,(LinkLength+(Spacing))*(a+1),TabThickness/2]) cube([TabLength0-LinkRadius,LinkLength+(Spacing*2),TabThickness],center=true); }
                } 
            }
            else{
                union(){
                translate([0,(LinkLength+(Spacing))*a,0]) solidHinge(LinkRadius,LinkLength,TabLength,TabThickness);
                    if(LongTab==0 && a!=LinkNumber-1){
                    translate([TabLength/2+LinkRadius/2,(LinkLength+(Spacing))*(a+1),TabThickness/2]) cube([TabLength-LinkRadius,LinkLength+(Spacing*2),TabThickness],center=true); }
                }             
            }
            if(LinkNumber%2==0){
                if(a==LinkNumber-1){
                    translate([0,((LinkLength+(Spacing))*a)+(LinkLength/2)+Spacing+(LinkLength/20),0]) rotate([90,0,0]) linear_extrude(height=LinkLength/10,center=true) translate([0,LinkRadius,0]) circle(LinkRadius); 
                }
            }
        }
        /*if(LongTab==0){
            color("blue",1) translate([(TabLength+LinkRadius)/2,(TotalLength/2)-(LinkLength/2)]) linear_extrude(height=TabThickness)square([(TabLength-LinkRadius),TotalLength],center=true);                
            color("blue",1) color("blue",1) translate([-(TabLength0+LinkRadius)/2,(TotalLength/2)-(LinkLength/2)]) linear_extrude(height=TabThickness)square([(TabLength0-LinkRadius),TotalLength],center=true);
        }*/
    }
    
}

CompleteHinge(LinkRadius,LinkLength,TabLength,TabThickness,Spacing,InnerTolerance,InnerShaft,LongTab,LinkNumber);
//hollowHinge(LinkRadius,LinkLength,TabLength,TabThickness,Spacing,InnerTolerance,InnerShaft);
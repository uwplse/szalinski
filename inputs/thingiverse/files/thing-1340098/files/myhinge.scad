//You can calculate the total length of the hinge with (TabLength * Number of Tabs) + (TabsTolerance * 2) + (TabLength / 5)
NumberOfTabs=4;
TabsTolerance=0.3;
TabLength=15;
//To determine the inner tolerance: OuterRadius - OuterThickness - InnerRadius
OuterRadius=6;
OuterThickness=2;
InnerRadius=3.5;
//Ideally you want TasselThickness to be equal to OuterThickness, but i left it modifiable for odd applications
TasselThickness=1;
TasselLength=15;
//If united is set to 0, the tabs will be linked together, if 1 they will be separated.
United=0;

module hingePart(partLength,outerRadius,outerThickness,innerRadius,tabWidth,tabThickness,tabLength){
    union(){
        difference(){
            rotate([90,0,0]) linear_extrude(height=partLength){
                circle(r=outerRadius);
            }
            rotate([90,0,0]) linear_extrude(height=partLength){
                circle(r=outerRadius-outerThickness);
            }
        }
        rotate([90,0,0]) linear_extrude(height=partLength){
                circle(r=innerRadius);}
        translate([(tabLength/2),-(partLength/2),-outerRadius+(tabThickness/2)]) cube([tabLength,tabWidth,tabThickness],center=true);
    }
}

module hinge(tabsNumber,tabsSpacing,partLength,outerRadius,outerThickness,innerRadius,tabThickness,tabLength,unite){
    tabWidth=partLength;
    for(a=[0:tabsNumber-1]){
        union(){if(a==0){
            if(unite==0){
                color("red",1) translate([(tabLength-((tabLength-outerRadius))),-(partLength),-outerRadius]) cube([tabLength-outerRadius,(tabWidth+tabsSpacing)*tabsNumber-tabsSpacing,tabThickness]);
                mirror(1,0,0) color("red",1) translate([(tabLength-((tabLength-outerRadius))),-(partLength),-outerRadius]) cube([tabLength-outerRadius,(tabWidth+tabsSpacing)*tabsNumber-tabsSpacing,tabThickness]);
            }
            color("blue",1) translate([0,-partLength-tabsSpacing,0]){rotate([90,0,0]) linear_extrude(height=partLength/10){
                circle(r=outerRadius);}
            color("blue",1) translate([0,tabsSpacing+1,0]){rotate([90,0,0]) linear_extrude(height=tabsSpacing+1){
                circle(r=innerRadius);}
             }
         } 
        }
        if(a%2==0){
            translate ([0,(partLength+tabsSpacing)*a,0]) hingePart(partLength,outerRadius,outerThickness,innerRadius,tabWidth,tabThickness,tabLength);
        }
        else{
            translate ([0,(partLength+tabsSpacing)*a,0]) mirror([1,0,0]) hingePart(partLength,outerRadius,outerThickness,innerRadius,tabWidth,tabThickness,tabLength);
        }
        if(a!=tabsNumber-1){
            color("red",1) translate ([0,(tabsSpacing+1+((partLength+tabsSpacing)*a)),0]) rotate([90,0,0]) linear_extrude(height=tabsSpacing+1){
                circle(r=innerRadius);} 
        }
        else{
            color("blue",1) translate([0,partLength*a+(tabsSpacing*(a+1)),0]){rotate([90,0,180]) linear_extrude(height=partLength/10){
                circle(r=outerRadius);}
            translate([0,-tabsSpacing,0]){rotate([90,0,180]) linear_extrude(height=tabsSpacing+1){
                circle(r=innerRadius);}
             }
         } 
        }
    }}
}


hinge(NumberOfTabs,TabsTolerance,TabLength,OuterRadius,OuterThickness,InnerRadius,TasselThickness,TasselLength,United);

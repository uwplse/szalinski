/* [ Parametric 3 drawer box v.1 ]
written by: Hermes Alvarado <hermesalvarado@gmail.com
*/

//Define main dimensions:
thickness =1;
bottomthickness = 1;
boxwidth = 60;
boxheight = 40;
boxdepth = 40;
tolerance = .4;
//Handle dimension:
handlewidth = 12;
handledepth = 6;
//Automatic definitions:
holeheight = (boxheight/3)-(thickness*1.3333);
drawerwidth = boxwidth-(thickness*2)-(tolerance*2);
drawerheight = holeheight-tolerance*2;
drawerdepth = boxdepth-bottomthickness;
drawerpositionY = boxheight*.75+drawerdepth/2;
drawerpositionX = boxwidth*.75+drawerwidth/2;

//Making box:
difference(){
    cube([boxwidth,boxheight,boxdepth], true);
    translate([0,holeheight+thickness,bottomthickness]){
            cube([(boxwidth-(thickness*2)),holeheight,(boxdepth-bottomthickness)],true);
    }
    translate([0,0,bottomthickness]){
            cube([(boxwidth-(thickness*2)),holeheight,(boxdepth-bottomthickness)],true);
    }
    translate([0,-(holeheight+thickness),bottomthickness]){
            cube([(boxwidth-(thickness*2)),holeheight,(boxdepth-bottomthickness)],true);
    }
}

//Making drawers:
//Simple drawer:
difference(){
    union(){
        translate([0,drawerpositionY,0]){
            cube([drawerwidth,drawerdepth,drawerheight],true);
        }
        translate([0,drawerpositionY-drawerdepth/2-handledepth/2,-drawerheight/2+bottomthickness/2]){
            cube([handlewidth,handledepth,bottomthickness],true);
        }
    }
    translate([0,drawerpositionY,bottomthickness]){
        cube([drawerwidth-thickness*2,drawerdepth-thickness*2,drawerheight],true);
    }
}
//2 holes drawer:
difference(){
    union(){
        translate([drawerpositionX,drawerpositionY,0]){
            cube([drawerwidth,drawerdepth,drawerheight],true);
        }
        translate([drawerpositionX,drawerpositionY-drawerdepth/2-handledepth/2,-drawerheight/2+bottomthickness/2]){
            cube([handlewidth,handledepth,bottomthickness],true);
        }
    }
    translate([drawerpositionX-drawerwidth/4+thickness/3,drawerpositionY,bottomthickness]){
        cube([drawerwidth/2-thickness*2,drawerdepth-thickness*2,drawerheight],true);
    }
    translate([drawerpositionX+drawerwidth/4-thickness/3,drawerpositionY,bottomthickness]){
        cube([drawerwidth/2-thickness*2,drawerdepth-thickness*2,drawerheight],true);
    }
}
//3 holes drawer:
difference(){
    union(){
        translate([drawerpositionX*2,drawerpositionY,0]){
            cube([drawerwidth,drawerdepth,drawerheight],true);
        }
        translate([drawerpositionX*2,drawerpositionY-drawerdepth/2-handledepth/2,-drawerheight/2+bottomthickness/2]){
            cube([handlewidth,handledepth,bottomthickness],true);
        }
    }
    translate([drawerpositionX*2-drawerwidth/3+thickness/2,drawerpositionY,bottomthickness]){
        cube([drawerwidth/3-thickness*1.3333,drawerdepth-thickness*2,drawerheight],true);
    }
    translate([drawerpositionX*2,drawerpositionY,bottomthickness]){
        cube([drawerwidth/3-thickness*2,drawerdepth-thickness*2,drawerheight],true);
    }
    translate([drawerpositionX*2+drawerwidth/3-thickness/2,drawerpositionY,bottomthickness]){
        cube([drawerwidth/3-thickness*1.3333,drawerdepth-thickness*2,drawerheight],true);
    }
}
//4 holes drawer:
difference(){
    union(){
        translate([drawerpositionX*3,drawerpositionY,0]){
            cube([drawerwidth,drawerdepth,drawerheight],true);
        }
        translate([drawerpositionX*3,drawerpositionY-drawerdepth/2-handledepth/2,-drawerheight/2+bottomthickness/2]){
            cube([handlewidth,handledepth,bottomthickness],true);
        }
    }
    translate([drawerpositionX*3-drawerwidth/4+thickness/3,drawerpositionY+drawerdepth/4-thickness/3,bottomthickness]){
        cube([drawerwidth/2-thickness*2,drawerdepth/2-thickness*2,drawerheight],true);
    }
    translate([drawerpositionX*3+drawerwidth/4-thickness/3,drawerpositionY+drawerdepth/4-thickness/3,bottomthickness]){
        cube([drawerwidth/2-thickness*2,drawerdepth/2-thickness*2,drawerheight],true);
    }
    translate([drawerpositionX*3-drawerwidth/4+thickness/3,drawerpositionY-drawerdepth/4+thickness/3,bottomthickness]){
        cube([drawerwidth/2-thickness*2,drawerdepth/2-thickness*2,drawerheight],true);
    }
    translate([drawerpositionX*3+drawerwidth/4-thickness/3,drawerpositionY-drawerdepth/4+thickness/3,bottomthickness]){
        cube([drawerwidth/2-thickness*2,drawerdepth/2-thickness*2,drawerheight],true);
    }
}
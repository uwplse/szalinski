shape="soft";// [soft,mid,hard]
slit = 5; //[1:15]
COLOR="Orange"; // [Navy,Green,Orange,Gray]

color(COLOR)

difference(){    
intersection(){


    if (shape=="soft"){    //
        difference(){
        rotate(a=90,v=[1,0,0])
            linear_extrude(height=120,center=true,convexity=10)
            offset(r=3)
            polygon(points=[[0,41],[0,30],[26,15],[56,5],[95,0],[278,0],[278,34],[182,27],[123,21],[92,21],[58,24],[26,30],[8,36]]);
        
        //
        translate([0,0,10])
        rotate(a=90,v=[1,0,0])
        for(i = [0 : 1 : 4])
        hull(){
            translate([146+35*i,0,0])
            cylinder(h=100, r=2, center = true);
            translate([161+35*i,0,0])
            cylinder(h=100, r=2, center = true);
            }
        }
    } 
    

    
    else if(shape=="mid"){
        rotate(a=90,v=[1,0,0])
        linear_extrude(height=120,center=true,convexity=10)
        offset(r=3)
            polygon(points=[[0,48],[0,35],[16,24],[36,14],[57,7],[78,2],[100,0],[290,0],[290,35],[200,28],[135,22],[106,22],[62,26],[30,33],[10,40]]);
    }
    
    
    else if(shape=="hard"){   //
        rotate(a=90,v=[1,0,0])
        linear_extrude(height=120,center=true,convexity=10)
        offset(r=3)
            polygon(points=[[0,8],[0,17.5],[0,8],[0,17.5],[290,35],[290,0],[230,0],[230,12],[170,12],[100,0],[62,0]]);
    }


    //
    translate(v=[0,-50,0])
        linear_extrude(height=120,center=true,convexity=10)
        offset(r=-1)
            polygon(points=[[0,55],[9,40],[28,20],[54,6],[85,0],[120,3],[152,13],[181,17],[250,10],[270,16],[286,36],[290,56],[281,77],[263,91],[246,95],[202,85],[158,73],[91,101],[62,103],[31,92],[11,77],[4,68]]);
}


for(i = [0: slit*3 :290])
    translate([i,0,-3]) 
    rotate(a=45, v=[0,1,0])
    scale(v=[1,200,1])
    cube(slit*0.75,center=true);
}


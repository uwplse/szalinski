use <write/Write.scad>
ball_size=25;
font_size=8;//[6:Small,8:Medium,10:Large]
number_of_balls=1; //[0:10,1:20,2:40]
/* [Hidden] */
texts_options=[["H","He","O","C","Ne","Fe","N","Si","Mg","S"],["H","He","Li","Be","B","C","N","O","F","Ne","Na","Mg","Al","Si","P","S","Cl","Ar","K","Ca"],["Al","Ar","Ba","Be","B","Br","Ca","C","Cl","Cr","Co","Cu","F","Au","He","H","I","Fe","Pb","Li","Mg","Mn","Hg","Ne","Ni","N","O","P","Pt","Pu","K","Ra","Rn","Si","Ag","Na","S","Sn","U","Zn"]];
texts=texts_options[number_of_balls];
number_of_rows=round(sqrt(len(texts)));


union(){ 
if (sqrt(len(texts))>number_of_rows){
    echo ("More columns then rows.");
    for (row=[0:number_of_rows-1]){

    translate([row*ball_size,0,0]){
    balls_per_row = number_of_rows + 1;
    echo ("Number of balls per row: ", balls_per_row);
    // Now make the build the different rows
    if (row == number_of_rows-1){
        echo ("Last row.");
        for (column = [0:len(texts)-row*balls_per_row-1]){
            translate([0,column*ball_size,0]){
                echo ("Now make ball number: ", row*balls_per_row+column);
                BingoBall(str(texts[row*balls_per_row+column]),ball_size);
            }
        }
    }else{
        for (column = [0:balls_per_row-1]){
            translate([0,column*ball_size,0]){
                echo ("Now make ball number: ", row*balls_per_row+column);
                BingoBall(texts[row*balls_per_row+column],ball_size);
            }
        }
    }
}
}
}else{
    echo ("Equal number of rows and columns.");
    for (row=[0:number_of_rows-1]){

    translate([row*ball_size,0,0]){
    balls_per_row = round(sqrt(len(texts)));
    echo ("Number of balls per row: ", balls_per_row);
    if (row == number_of_rows-1){
        echo ("Last row.");
        if (sqrt(len(texts))==balls_per_row){
             for (column = [0:balls_per_row-1]){
                translate([0,column*ball_size,0]){
                    echo ("Now make ball number: ", row*balls_per_row+column);
                    BingoBall(texts[row*balls_per_row+column],ball_size);
                }
            }
        }else{
            for (column = [0:len(texts)-row*balls_per_row-1]){
                translate([0,column*ball_size,0]){
                    echo ("Now make ball number: ", row*balls_per_row+column);
                    BingoBall(texts[row*balls_per_row+column],ball_size);
                }
            }
        }
    }else{
        for (column = [0:balls_per_row-1]){
            translate([0,column*ball_size,0]){
                echo ("Now make ball number: ", row*balls_per_row+column);
                BingoBall(texts[row*balls_per_row+column],ball_size);
            }
        }
    }
}
}
}
}
module BingoBall(my_txt, ball_size){
    rotate([35,0,0]){
        rotate([-90,0,0]){
            color("black") writesphere(text=my_txt,where=[0,0,0],radius=ball_size/2.2,t=ball_size/(ball_size-(ball_size/1.95)),h=ball_size/5);          
        }
        union(){
            difference(){
                sphere(r=ball_size/2, $fn=70);
                translate([0,0,ball_size/2]){
                    rotate([180,0,0]){
                        difference(){
                            cylinder(ball_size/2,ball_size/2.2,00, $fn=35);   
                            translate([0,0,-ball_size*0.01]){
                                difference(){
                                    cylinder(ball_size/2,ball_size/4,ball_size/2, $fn=35);
                                    translate([0,0,-ball_size*0.01]){
                                        cylinder(ball_size/2.4,ball_size/2.4,ball_size/40,$fn=50);
                                    }
                                }
                            }
                        }
                    }                    
                }	
            }
            color("white") sphere(ball_size/2/1.05, $fn=70);
        }

    }
}



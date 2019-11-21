

insideWidth=155; 
insideLength=155;
insideHeight=90;


topThick=3; // thicknes of the top
pillarWidth=10; // width of the pillars

/*[Hidden]*/
pillarWallThick=1.9;
pillarInner = pillarWidth-(pillarWallThick*2);


outsideWidth=insideWidth+(pillarWidth*2); // insidewidth 150, outside width wil be 182 
outsideLength=insideLength+(pillarWidth*2);// as above - i.e 32mm wider outside than inside.



cube ([outsideLength, outsideWidth, topThick]); // baseplate

pillar();

translate([outsideLength-pillarWidth,0,0])
pillar(); // second corner suport

translate([0,outsideWidth-pillarWidth,0])
pillar(); // third corner suport

translate([outsideLength-pillarWidth,outsideWidth-pillarWidth,0])
pillar(); // fourth corner suport   




module pillar(){ // one to go in each corner
    difference(){
        cube ([pillarWidth,pillarWidth,insideHeight+topThick]);
            translate ([pillarWallThick,pillarWallThick,topThick+1])
                cube ([pillarInner,pillarInner,insideHeight]);

    } // end of difference
        
}// end of module pillar
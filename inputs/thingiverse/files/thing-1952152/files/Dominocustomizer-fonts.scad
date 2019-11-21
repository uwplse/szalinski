

number_for_first_domino_space = "six"; //[one, two, three, four, five, six, seven, eight, nine, ten, eleven, twelve, blank]
number_for_second_domino_space = "ten"; //[one, two, three, four, five, six, seven, eight, nine, ten, eleven, twelve, blank]

What_font = "Standard"; //[Standard, Fjalla One, Roboto, Ubuntu, Lobster, Anton, Exo Bold, Patua One]

echo(What_font);

// Hidden parameter
module stopCustomizer(){}
$fn=35;


// Declare what size to use for each number
numSize =       (What_font == "Standard") ? 13 : 
                (What_font == "Fjalla One") ? 13.5 :
                (What_font == "Roboto") ? 13 :
                (What_font == "Ubuntu") ? 13 :
                (What_font == "Lobster") ? 14 :
                (What_font == "Anton") ? 14 :
                (What_font == "Exo Bold" ? 14 : 14);
echo(numSize);

// Declare translate X to use for each number
translateX =    (What_font == "Standard") ? 18.5 : 
                (What_font == "Fjalla One") ? 20.5 :
                (What_font == "Roboto") ? 18.6 :
                (What_font == "Ubuntu") ? 18 :
                (What_font == "Lobster") ? 19.7 :
                (What_font == "Anton") ? 19.7 :
                (What_font == "Exo Bold" ? 19 : 19);

// Declare translate Y to use for each font on single digit numbers first space
singleTranslateFirstY = (What_font == "Standard") ? 8 : 
                (What_font == "Fjalla One") ? 9.5 :
                (What_font == "Roboto") ? 8 :
                (What_font == "Ubuntu") ? 8 :
                (What_font == "Lobster") ? 8 :
                (What_font == "Anton") ? 9 :
                (What_font == "Exo Bold" ? 7.7 : 10.3);

// Declare translate Y to use for each font on single digit numbers second space
singleTranslateSecondY = (What_font == "Standard") ? 31.5 : 
                (What_font == "Fjalla One") ? 32.5 :
                (What_font == "Roboto") ? 32 :
                (What_font == "Ubuntu") ? 32 :
                (What_font == "Lobster") ? 32 :
                (What_font == "Anton") ? 32 :
                (What_font == "Exo Bold" ? 31.8 : 33.4);

// Declare translate Y to use for each font on double digit numbers first space
doubleTranslateFirstY = (What_font == "Standard") ? 3 : 
                (What_font == "Fjalla One") ? 5 :
                (What_font == "Roboto") ? 3 :
                (What_font == "Ubuntu") ? 3 :
                (What_font == "Lobster") ? 4.3 :
                (What_font == "Anton") ? 4.8 :
                (What_font == "Exo Bold" ? 2 : 5);

// Declare translate Y to use for each font on double digit numbers second space
doubleTranslateSecondY = (What_font == "Standard") ? 26.7 : 
                (What_font == "Fjalla One") ? 28.5 :
                (What_font == "Roboto") ? 26 :
                (What_font == "Ubuntu") ? 26 :
                (What_font == "Lobster") ? 28 :
                (What_font == "Anton") ? 28.5 :
                (What_font == "Exo Bold" ? 25.8 : 28);

// Declare translate Y to use for first space for number 11
elevenTranslateFirstY = (What_font == "Standard") ? 3.7 : 
                (What_font == "Fjalla One") ? 5.2 :
                (What_font == "Roboto") ? 4 :
                (What_font == "Ubuntu") ? 3.8 :
                (What_font == "Lobster") ? 7 :
                (What_font == "Anton") ? 6.5 :
                (What_font == "Exo Bold" ? 3.3 : 7);

// Declare translate Y to use for second space for number 11
elevenTranslateY = (What_font == "Standard") ? 27.4 : 
                (What_font == "Fjalla One") ? 28.7 :
                (What_font == "Roboto") ? 27 :
                (What_font == "Ubuntu") ? 26.8 :
                (What_font == "Lobster") ? 30 :
                (What_font == "Anton") ? 29.5 :
                (What_font == "Exo Bold" ? 26.4 : 30.1);

/* Number Modules*/

module one()
{
    linear_extrude(height = 3)
    rotate([0,0,90])
    text("1", size = numSize, font = What_font);
}


module two()
{
    linear_extrude(height = 3)
    rotate([0,0,90])
    text("2", size = numSize, font = What_font);
}

module three()
{
    linear_extrude(height = 3)
    rotate([0,0,90])
    text("3", size = numSize, font = What_font);
}

module four()
{
    linear_extrude(height = 3)
    rotate([0,0,90])
    text("4", size = numSize, font = What_font);
}

module five()
{
    linear_extrude(height = 3)
    rotate([0,0,90])
    text("5", size = numSize, font = What_font);
}

module six()
{
    linear_extrude(height = 3)
    rotate([0,0,90])
    text("6", size = numSize, font = What_font);
}

module seven()
{
    linear_extrude(height = 3)
    rotate([0,0,90])
    text("7", size = numSize, font = What_font);
}

module eight()
{
    linear_extrude(height = 3)
    rotate([0,0,90])
    text("8", size = numSize, font = What_font);
}

module nine()
{
    linear_extrude(height = 3)
    rotate([0,0,90])
    text("9", size = numSize, font = What_font);
}

module ten()
{
    linear_extrude(height = 3)
    rotate([0,0,90])
    text("10", size = numSize, font = What_font);
}

module eleven()
{
    linear_extrude(height = 3)
    rotate([0,0,90])
    text("11", size = numSize, font = What_font);
}

module twelve()
{
    linear_extrude(height = 3)
    rotate([0,0,90])
    text("12", size = numSize, font = What_font);
}


// Main DominoBody
module dominoBody()
{
    linear_extrude(height=10)offset(r=5, $fn=30)
    square([15, 40]);
}

// Domino top cutout
module dominoCutout()
{
    linear_extrude(height=10-7.9)offset(r=5-3, $fn=30)
    square([15, 40]);
}

// Top seperator bar
module topBar()
{
    cube([25, 3, 10]);
}

// Complete Blank Domino
module blankDomino()
{
    difference()
    {
        translate([5,5,-6.5])
        dominoBody();
        translate([5,5,1.5])
        dominoCutout();
    }
    translate([0, 23.5, -6.5])
    topBar();
}


// Assignments for the first Spaces


// First domino space blank
module firstSpaceBlank()
{
        blankDomino();
}

// First domino space one

module firstSpaceOne()
{
    difference()
    {
        blankDomino();
        translate ([translateX, singleTranslateFirstY]) one();
    }
}

// First domino space two
module firstSpaceTwo()
{
    difference()
    {
        blankDomino();
        translate ([translateX, singleTranslateFirstY]) two();
    }
}

// First domino space three
module firstSpaceThree()
{
    difference()
    {
        blankDomino();
        translate ([translateX, singleTranslateFirstY]) three();
    }
}

// First domino space four
module firstSpaceFour()
{
    difference()
    {
        blankDomino();
        translate ([translateX, singleTranslateFirstY]) four();
    }
}

// First domino space five
module firstSpaceFive()
{
    difference()
    {
        blankDomino();
        translate ([translateX, singleTranslateFirstY]) five();
    }
}

// First domino space six
module firstSpaceSix()
{
    difference()
    {
        blankDomino();
        translate ([translateX, singleTranslateFirstY]) six();
    }
}

// First domino space seven
module firstSpaceSeven()
{
    difference()
    {
        blankDomino();
        translate ([translateX, singleTranslateFirstY]) seven();
    }
}

// First domino space eight
module firstSpaceEight()
{
    difference()
    {
        blankDomino();
        translate ([translateX, singleTranslateFirstY]) eight();
    }
}

// First domino space nine
module firstSpaceNine()
{
    difference()
    {
        blankDomino();
        translate ([translateX, singleTranslateFirstY]) nine();
    }
}

// First domino space ten
module firstSpaceTen()
{
    difference()
    {
        blankDomino();
        translate ([translateX, doubleTranslateFirstY]) ten();
    }
}

// First domino space eleven
module firstSpaceEleven()
{
    difference()
    {
        blankDomino();
        translate ([translateX, elevenTranslateFirstY]) eleven();
    }
}

// First domino space twelve
module firstSpaceTwelve()
{
    difference()
    {
        blankDomino();
        translate ([translateX, doubleTranslateFirstY]) twelve();
    }
}


// SPACE ONE ASSIGNMENTS

if (number_for_first_domino_space=="one")
{
    if (number_for_second_domino_space=="one")
    {
        difference()
        {
            firstSpaceOne();
            translate ([translateX, singleTranslateSecondY]) one();
        }
    }
    else
    if (number_for_second_domino_space=="two")
    {
        difference()
        {
            firstSpaceOne();
            translate ([translateX, singleTranslateSecondY]) two();
        }
    }
    else
    if (number_for_second_domino_space=="three")
    {    
        difference()
        {
            firstSpaceOne();
            translate ([translateX, singleTranslateSecondY]) three();
        }
    }
    else
    if (number_for_second_domino_space=="four")
    {
        difference()
        {
            firstSpaceOne();
            translate ([translateX, singleTranslateSecondY]) four();
        }
    }
    else        
    if (number_for_second_domino_space=="five")
    {
        difference()
        {
            firstSpaceOne();
            translate ([translateX, singleTranslateSecondY]) five();
        }
    }
    else
    if (number_for_second_domino_space=="six")
    {
        difference()
        {
            firstSpaceOne();
            translate ([translateX, singleTranslateSecondY]) six();
        }
    }
    else
    if (number_for_second_domino_space=="seven")
    {
        difference()
        {
            firstSpaceOne();
            translate ([translateX, singleTranslateSecondY]) seven();
        }
    }
    else
    if (number_for_second_domino_space=="eight")
    {
        difference()
        {
            firstSpaceOne();
            translate ([translateX, singleTranslateSecondY]) eight();
        }
    }
    else
    if (number_for_second_domino_space=="nine")
    {
        difference()
        {
            firstSpaceOne();
            translate ([translateX, singleTranslateSecondY]) nine();
        }
    }
    else
    if (number_for_second_domino_space=="ten")
    {
        difference()
        {
            firstSpaceOne();
            translate ([translateX, doubleTranslateSecondY]) ten();
        }
    }
    else
    if (number_for_second_domino_space=="eleven")
    {
        difference()
        {
            firstSpaceOne();
            translate ([translateX, elevenTranslateY]) eleven();
        }
    }
    else
    if (number_for_second_domino_space=="twelve")
    {
        difference()
        {
            firstSpaceOne();
            translate ([translateX, doubleTranslateSecondY]) twelve();
        }
    }
    else
    if (number_for_second_domino_space=="blank")
    {
        difference()
        {
            firstSpaceOne();
            translate ([translateX, doubleTranslateSecondY]) blank();
        }
    }
}
else{
if (number_for_first_domino_space=="two")
{
    if (number_for_second_domino_space=="one")
    {
        difference()
        {
            firstSpaceTwo();
            translate ([translateX, singleTranslateSecondY]) one();
        }
    }
    else
    if (number_for_second_domino_space=="two")
    {
        difference()
        {
            firstSpaceTwo();
            translate ([translateX, singleTranslateSecondY]) two();
        }
    }
    else
    if (number_for_second_domino_space=="three")
    {
        difference()
        {
            firstSpaceTwo();
            translate ([translateX, singleTranslateSecondY]) three();
        }
    }
    else
    if (number_for_second_domino_space=="four")
    {
        difference()
        {
            firstSpaceTwo();
            translate ([translateX, singleTranslateSecondY]) four();
        }
    }
    else
    if (number_for_second_domino_space=="five")
    {
        difference()
        {
            firstSpaceTwo();
            translate ([translateX, singleTranslateSecondY]) five();
        }
    }
    else
    if (number_for_second_domino_space=="six")
    {
        difference()
        {
            firstSpaceTwo();
            translate ([translateX, singleTranslateSecondY]) six();
        }
    }
    else
    if (number_for_second_domino_space=="seven")
    {
        difference()
        {
            firstSpaceTwo();
            translate ([translateX, singleTranslateSecondY]) seven();
        }
    }
    else
    if (number_for_second_domino_space=="eight")
    {
        difference()
        {
            firstSpaceTwo();
            translate ([translateX, singleTranslateSecondY]) eight();
        }
    }
    else
    if (number_for_second_domino_space=="nine")
    {
        difference()
        {
            firstSpaceTwo();
            translate ([translateX, singleTranslateSecondY]) nine();
        }
    }
    else
    if (number_for_second_domino_space=="ten")
    {
        difference()
        {
            firstSpaceTwo();
            translate ([translateX, doubleTranslateSecondY]) ten();
        }
    }
    else
    if (number_for_second_domino_space=="eleven")
    {
        difference()
        {
            firstSpaceTwo();
            translate ([translateX, elevenTranslateY]) eleven();
        }
    }
    else
    if (number_for_second_domino_space=="twelve")
    {
        difference()
        {
            firstSpaceTwo();
            translate ([translateX, doubleTranslateSecondY]) twelve();
        }
    }
    else
    if (number_for_second_domino_space=="blank")
    {
        difference()
        {
            firstSpaceTwo();
            translate ([translateX, doubleTranslateSecondY]) blank();
        }
    }
}
else{
if (number_for_first_domino_space=="three")
{
    if (number_for_second_domino_space=="one")
    {
        difference()
        {
            firstSpaceThree();
            translate ([translateX, singleTranslateSecondY]) one();
        }
    }
    else
    if (number_for_second_domino_space=="two")
    {
        difference()
        {
            firstSpaceThree();
            translate ([translateX, singleTranslateSecondY]) two();
        }
    }
    if (number_for_second_domino_space=="three")
    {
        difference()
        {
            firstSpaceThree();
            translate ([translateX, singleTranslateSecondY]) three();
        }
    }
    else
    if (number_for_second_domino_space=="four")
    {
        difference()
        {
            firstSpaceThree();
            translate ([translateX, singleTranslateSecondY]) four();
        }
    }
    else
    if (number_for_second_domino_space=="five")
    {
        difference()
        {
            firstSpaceThree();
            translate ([translateX, singleTranslateSecondY]) five();
        }
    }
    else
    if (number_for_second_domino_space=="six")
    {
        difference()
        {
            firstSpaceThree();
            translate ([translateX, singleTranslateSecondY]) six();
        }
    }
    else
    if (number_for_second_domino_space=="seven")
    {
        difference()
        {
            firstSpaceThree();
            translate ([translateX, singleTranslateSecondY]) seven();
        }
    }
    else
    if (number_for_second_domino_space=="eight")
    {
        difference()
        {
            firstSpaceThree();
            translate ([translateX, singleTranslateSecondY]) eight();
        }
    }
    else
    if (number_for_second_domino_space=="nine")
    {
        difference()
        {
            firstSpaceThree();
            translate ([translateX, singleTranslateSecondY]) nine();
        }
    }
    else
    if (number_for_second_domino_space=="ten")
    {
        difference()
        {
            firstSpaceThree();
            translate ([translateX, doubleTranslateSecondY]) ten();
        }
    }
    else
    if (number_for_second_domino_space=="eleven")
    {
        difference()
        {
            firstSpaceThree();
            translate ([translateX, elevenTranslateY]) eleven();
        }
    }
    else
    if (number_for_second_domino_space=="twelve")
    {
        difference()
        {
            firstSpaceThree();
            translate ([translateX, doubleTranslateSecondY]) twelve();
        }
    }
    else
    if (number_for_second_domino_space=="blank")
    {
        difference()
        {
            firstSpaceThree();
            translate ([translateX, doubleTranslateSecondY]) blank();
        }
    }
}
else{
if (number_for_first_domino_space=="four")
{
    if (number_for_second_domino_space=="one")
    {
        difference()
        {
            firstSpaceFour();
            translate ([translateX, singleTranslateSecondY]) one();
        }
    }
    else
    if (number_for_second_domino_space=="two")
    {
        difference()
        {
            firstSpaceFour();
            translate ([translateX, singleTranslateSecondY]) two();
        }
    }
    else
    if (number_for_second_domino_space=="three")
    {
        difference()
        {
            firstSpaceFour();
            translate ([translateX, singleTranslateSecondY]) three();
        }
    }
    else
    if (number_for_second_domino_space=="four")
    {
        difference()
        {
            firstSpaceFour();
            translate ([translateX, singleTranslateSecondY]) four();
        }
    }
    else
    if (number_for_second_domino_space=="five")
    {
        difference()
        {
            firstSpaceFour();
            translate ([translateX, singleTranslateSecondY]) five();
        }
    }
    else
    if (number_for_second_domino_space=="six")
    {
        difference()
        {
            firstSpaceFour();
            translate ([translateX, singleTranslateSecondY]) six();
        }
    }
    else
    if (number_for_second_domino_space=="seven")
    {
        difference()
        {
            firstSpaceFour();
            translate ([translateX, singleTranslateSecondY]) seven();
        }
    }
    else
    if (number_for_second_domino_space=="eight")
    {
        difference()
        {
            firstSpaceFour();
            translate ([translateX, singleTranslateSecondY]) eight();
        }
    }
    else
    if (number_for_second_domino_space=="nine")
    {
        difference()
        {
            firstSpaceFour();
            translate ([translateX, singleTranslateSecondY]) nine();
        }
    }
    else
    if (number_for_second_domino_space=="ten")
    {
        difference()
        {
            firstSpaceFour();
            translate ([translateX, doubleTranslateSecondY]) ten();
        }
    }
    else
    if (number_for_second_domino_space=="eleven")
    {
        difference()
        {
            firstSpaceFour();
            translate ([translateX, elevenTranslateY]) eleven();
        }
    }
    else
    if (number_for_second_domino_space=="twelve")
    {
        difference()
        {
            firstSpaceFour();
            translate ([translateX, doubleTranslateSecondY]) twelve();
        }
    }
    else
    if (number_for_second_domino_space=="blank")
    {
        difference()
        {
            firstSpaceFour();
            translate ([translateX, doubleTranslateSecondY]) blank();
        }
    }
}
else{
if (number_for_first_domino_space=="five")
{
    if (number_for_second_domino_space=="one")
    {
        difference()
        {
            firstSpaceFive();
            translate ([translateX, singleTranslateSecondY]) one();
        }
    }
    else
    if (number_for_second_domino_space=="two")
    {
        difference()
        {
            firstSpaceFive();
            translate ([translateX, singleTranslateSecondY]) two();
        }
    }
    else
    if (number_for_second_domino_space=="three")
    {
        difference()
        {
            firstSpaceFive();
            translate ([translateX, singleTranslateSecondY]) three();
        }
    }
    else
    if (number_for_second_domino_space=="four")
    {
        difference()
        {
            firstSpaceFive();
            translate ([translateX, singleTranslateSecondY]) four();
        }
    }
    else
    if (number_for_second_domino_space=="five")
    {
        difference()
        {
            firstSpaceFive();
            translate ([translateX, singleTranslateSecondY]) five();
        }
    }
    else
    if (number_for_second_domino_space=="six")
    {
        difference()
        {
            firstSpaceFive();
            translate ([translateX, singleTranslateSecondY]) six();
        }
    }
    else
    if (number_for_second_domino_space=="seven")
    {
        difference()
        {
            firstSpaceFive();
            translate ([translateX, singleTranslateSecondY]) seven();
        }
    }
    else
    if (number_for_second_domino_space=="eight")
    {
        difference()
        {
            firstSpaceFive();
            translate ([translateX, singleTranslateSecondY]) eight();
        }
    }
    else
    if (number_for_second_domino_space=="nine")
    {
        difference()
        {
            firstSpaceFive();
            translate ([translateX, singleTranslateSecondY]) nine();
        }
    }
    else
    if (number_for_second_domino_space=="ten")
    {
        difference()
        {
            firstSpaceFive();
            translate ([translateX, doubleTranslateSecondY]) ten();
        }
    }
    else
    if (number_for_second_domino_space=="eleven")
    {
        difference()
        {
            firstSpaceFive();
            translate ([translateX, elevenTranslateY]) eleven();
        }
    }
    else
    if (number_for_second_domino_space=="twelve")
    {
        difference()
        {
            firstSpaceFive();
            translate ([translateX, doubleTranslateSecondY]) twelve();
        }
    }
    else
    if (number_for_second_domino_space=="blank")
    {
        difference()
        {
            firstSpaceFive();
            translate ([translateX, doubleTranslateSecondY]) blank();
        }
    }
}
else{
if (number_for_first_domino_space=="six")
{
    if (number_for_second_domino_space=="one")
    {
        difference()
        {
            firstSpaceSix();
            translate ([translateX, singleTranslateSecondY]) one();
        }
    }
    else
    if (number_for_second_domino_space=="two")
    {
        difference()
        {
            firstSpaceSix();
            translate ([translateX, singleTranslateSecondY]) two();
        }
    }
    else
    if (number_for_second_domino_space=="three")
    {
        difference()
        {
            firstSpaceSix();
            translate ([translateX, singleTranslateSecondY]) three();
        }
    }
    else
    if (number_for_second_domino_space=="four")
    {
        difference()
        {
            firstSpaceSix();
            translate ([translateX, singleTranslateSecondY]) four();
        }
    }
    else
    if (number_for_second_domino_space=="five")
    {
        difference()
        {
            firstSpaceSix();
            translate ([translateX, singleTranslateSecondY]) five();
        }
    }
    else
    if (number_for_second_domino_space=="six")
    {
        difference()
        {
            firstSpaceSix();
            translate ([translateX, singleTranslateSecondY]) six();
        }
    }
    else
    if (number_for_second_domino_space=="seven")
    {
        difference()
        {
            firstSpaceSix();
            translate ([translateX, singleTranslateSecondY]) seven();
        }
    }
    else
    if (number_for_second_domino_space=="eight")
    {
        difference()
        {
            firstSpaceSix();
            translate ([translateX, singleTranslateSecondY]) eight();
        }
    }
    else
    if (number_for_second_domino_space=="nine")
    {
        difference()
        {
            firstSpaceSix();
            translate ([translateX, singleTranslateSecondY]) nine();
        }
    }
    else
    if (number_for_second_domino_space=="ten")
    {
        difference()
        {
            firstSpaceSix();
            translate ([translateX, doubleTranslateSecondY]) ten();
        }
    }
    else
    if (number_for_second_domino_space=="eleven")
    {
        difference()
        {
            firstSpaceSix();
            translate ([translateX, elevenTranslateY]) eleven();
        }
    }
    else
    if (number_for_second_domino_space=="twelve")
    {
        difference()
        {
            firstSpaceSix();
            translate ([translateX, doubleTranslateSecondY]) twelve();
        }
    }
    else
    if (number_for_second_domino_space=="blank")
    {
        difference()
        {
            firstSpaceSix();
            translate ([translateX, doubleTranslateSecondY]) blank();
        }
    }
}
else{
if (number_for_first_domino_space=="seven")
{
    if (number_for_second_domino_space=="one")
    {
        difference()
        {
            firstSpaceSeven();
            translate ([translateX, singleTranslateSecondY]) one();
        }
    }
    else
    if (number_for_second_domino_space=="two")
    {
        difference()
        {
            firstSpaceSeven();
            translate ([translateX, singleTranslateSecondY]) two();
        }
    }
    else
    if (number_for_second_domino_space=="three")
    {
        difference()
        {
            firstSpaceSeven();
            translate ([translateX, singleTranslateSecondY]) three();
        }
    }
    else
    if (number_for_second_domino_space=="four")
    {
        difference()
        {
            firstSpaceSeven();
            translate ([translateX, singleTranslateSecondY]) four();
        }
    }
    else
    if (number_for_second_domino_space=="five")
    {
        difference()
        {
            firstSpaceSeven();
            translate ([translateX, singleTranslateSecondY]) five();
        }
    }
    else
    if (number_for_second_domino_space=="six")
    {
        difference()
        {
            firstSpaceSeven();
            translate ([translateX, singleTranslateSecondY]) six();
        }
    }
    else
    if (number_for_second_domino_space=="seven")
    {
        difference()
        {
            firstSpaceSeven();
            translate ([translateX, singleTranslateSecondY]) seven();
        }
    }
    else
    if (number_for_second_domino_space=="eight")
    {
        difference()
        {
            firstSpaceSeven();
            translate ([translateX, singleTranslateSecondY]) eight();
        }
    }
    else
    if (number_for_second_domino_space=="nine")
    {
        difference()
        {
            firstSpaceSeven();
            translate ([translateX, singleTranslateSecondY]) nine();
        }
    }
    else
    if (number_for_second_domino_space=="ten")
    {
        difference()
        {
            firstSpaceSeven();
            translate ([translateX, doubleTranslateSecondY]) ten();
        }
    }
    else
    if (number_for_second_domino_space=="eleven")
    {
        difference()
        {
            firstSpaceSeven();
            translate ([translateX, elevenTranslateY]) eleven();
        }
    }
    else
    if (number_for_second_domino_space=="twelve")
    {
        difference()
        {
            firstSpaceSeven();
            translate ([translateX, doubleTranslateSecondY]) twelve();
        }
    }
    else
    if (number_for_second_domino_space=="blank")
    {
        difference()
        {
            firstSpaceSeven();
            translate ([translateX, doubleTranslateSecondY]) blank();
        }
    }
}
else{
if (number_for_first_domino_space=="eight")
{
    if (number_for_second_domino_space=="one")
    {
        difference()
        {
            firstSpaceEight();
            translate ([translateX, singleTranslateSecondY]) one();
        }
    }
    else
    if (number_for_second_domino_space=="two")
    {
        difference()
        {
            firstSpaceEight();
            translate ([translateX, singleTranslateSecondY]) two();
        }
    }
    else
    if (number_for_second_domino_space=="three")
    {
        difference()
        {
            firstSpaceEight();
            translate ([translateX, singleTranslateSecondY]) three();
        }
    }
    else
    if (number_for_second_domino_space=="four")
    {
        difference()
        {
            firstSpaceEight();
            translate ([translateX, singleTranslateSecondY]) four();
        }
    }
    else
    if (number_for_second_domino_space=="five")
    {
        difference()
        {
            firstSpaceEight();
            translate ([translateX, singleTranslateSecondY]) five();
        }
    }
    else
    if (number_for_second_domino_space=="six")
    {
        difference()
        {
            firstSpaceEight();
            translate ([translateX, singleTranslateSecondY]) six();
        }
    }
    else
    if (number_for_second_domino_space=="seven")
    {
        difference()
        {
            firstSpaceEight();
            translate ([translateX, singleTranslateSecondY]) seven();
        }
    }
    else
    if (number_for_second_domino_space=="eight")
    {
        difference()
        {
            firstSpaceEight();
            translate ([translateX, singleTranslateSecondY]) eight();
        }
    }
    else
    if (number_for_second_domino_space=="nine")
    {
        difference()
        {
            firstSpaceEight();
            translate ([translateX, singleTranslateSecondY]) nine();
        }
    }
    else
    if (number_for_second_domino_space=="ten")
    {
        difference()
        {
            firstSpaceEight();
            translate ([translateX, doubleTranslateSecondY]) ten();
        }
    }
    else
    if (number_for_second_domino_space=="eleven")
    {
        difference()
        {
            firstSpaceEight();
            translate ([translateX, elevenTranslateY]) eleven();
        }
    }
    else
    if (number_for_second_domino_space=="twelve")
    {
        difference()
        {
            firstSpaceEight();
            translate ([translateX, doubleTranslateSecondY]) twelve();
        }
    }
    else
    if (number_for_second_domino_space=="blank")
    {
        difference()
        {
            firstSpaceEight();
            translate ([translateX, doubleTranslateSecondY]) blank();
        }
    }
}
else{
if (number_for_first_domino_space=="nine")
{
    if (number_for_second_domino_space=="one")
    {
        difference()
        {
            firstSpaceNine();
            translate ([translateX, singleTranslateSecondY]) one();
        }
    }
    else
    if (number_for_second_domino_space=="two")
    {
        difference()
        {
            firstSpaceNine();
            translate ([translateX, singleTranslateSecondY]) two();
        }
    }
    else
    if (number_for_second_domino_space=="three")
    {
        difference()
        {
            firstSpaceNine();
            translate ([translateX, singleTranslateSecondY]) three();
        }
    }
    else
    if (number_for_second_domino_space=="four")
    {
        difference()
        {
            firstSpaceNine();
            translate ([translateX, singleTranslateSecondY]) four();
        }
    }
    else
    if (number_for_second_domino_space=="five")
    {
        difference()
        {
            firstSpaceNine();
            translate ([translateX, singleTranslateSecondY]) five();
        }
    }
    else
    if (number_for_second_domino_space=="six")
    {
        difference()
        {
            firstSpaceNine();
            translate ([translateX, singleTranslateSecondY]) six();
        }
    }
    else
    if (number_for_second_domino_space=="seven")
    {
        difference()
        {
            firstSpaceNine();
            translate ([translateX, singleTranslateSecondY]) seven();
        }
    }
    else
    if (number_for_second_domino_space=="eight")
    {
        difference()
        {
            firstSpaceNine();
            translate ([translateX, singleTranslateSecondY]) eight();
        }
    }
    else
    if (number_for_second_domino_space=="nine")
    {
        difference()
        {
            firstSpaceNine();
            translate ([translateX, singleTranslateSecondY]) nine();
        }
    }
    else
    if (number_for_second_domino_space=="ten")
    {
        difference()
        {
            firstSpaceNine();
            translate ([translateX, doubleTranslateSecondY]) ten();
        }
    }
    else
    if (number_for_second_domino_space=="eleven")
    {
        difference()
        {
            firstSpaceNine();
            translate ([translateX, elevenTranslateY]) eleven();
        }
    }
    else
    if (number_for_second_domino_space=="twelve")
    {
        difference()
        {
            firstSpaceNine();
            translate ([translateX, doubleTranslateSecondY]) twelve();
        }
    }
    else
    if (number_for_second_domino_space=="blank")
    {
        difference()
        {
            firstSpaceNine();
            translate ([translateX, singleTranslateSecondY]) blank();
        }
    }
}
else{
if (number_for_first_domino_space=="ten")
{
    if (number_for_second_domino_space=="one")
    {
        difference()
        {
            firstSpaceTen();
            translate ([translateX, singleTranslateSecondY]) one();
        }
    }
    else
    if (number_for_second_domino_space=="two")
    {
        difference()
        {
            firstSpaceTen();
            translate ([translateX, singleTranslateSecondY]) two();
        }
    }
    else
    if (number_for_second_domino_space=="three")
    {
        difference()
        {
            firstSpaceTen();
            translate ([translateX, singleTranslateSecondY]) three();
        }
    }
    else
    if (number_for_second_domino_space=="four")
    {
        difference()
        {
            firstSpaceTen();
            translate ([translateX, singleTranslateSecondY]) four();
        }
    }
    else
    if (number_for_second_domino_space=="five")
    {
        difference()
        {
            firstSpaceTen();
            translate ([translateX, singleTranslateSecondY]) five();
        }
    }
    else
    if (number_for_second_domino_space=="six")
    {
        difference()
        {
            firstSpaceTen();
            translate ([translateX, singleTranslateSecondY]) six();
        }
    }
    else
    if (number_for_second_domino_space=="seven")
    {
        difference()
        {
            firstSpaceTen();
            translate ([translateX, singleTranslateSecondY]) seven();
        }
    }
    else
    if (number_for_second_domino_space=="eight")
    {
        difference()
        {
            firstSpaceTen();
            translate ([translateX, singleTranslateSecondY]) eight();
        }
    }
    else
    if (number_for_second_domino_space=="nine")
    {
        difference()
        {
            firstSpaceTen();
            translate ([translateX, singleTranslateSecondY]) nine();
        }
    }
    else
    if (number_for_second_domino_space=="ten")
    {
        difference()
        {
            firstSpaceTen();
            translate ([translateX, doubleTranslateSecondY]) ten();
        }
    }
    else
    if (number_for_second_domino_space=="eleven")
    {
        difference()
        {
            firstSpaceTen();
            translate ([translateX, elevenTranslateY]) eleven();
        }
    }
    else
    if (number_for_second_domino_space=="twelve")
    {
        difference()
        {
            firstSpaceTen();
            translate ([translateX, doubleTranslateSecondY]) twelve();
        }
    }
    else
    if (number_for_second_domino_space=="blank")
    {
        difference()
        {
            firstSpaceTen();
            translate ([translateX, doubleTranslateSecondY]) blank();
        }
    }
}
else{
if (number_for_first_domino_space=="eleven")
{
    if (number_for_second_domino_space=="one")
    {
        difference()
        {
            firstSpaceEleven();
            translate ([translateX, singleTranslateSecondY]) one();
        }
    }
    else
    if (number_for_second_domino_space=="two")
    {
        difference()
        {
            firstSpaceEleven();
            translate ([translateX, singleTranslateSecondY]) two();
        }
    }
    else
    if (number_for_second_domino_space=="three")
    {
        difference()
        {
            firstSpaceEleven();
            translate ([translateX, singleTranslateSecondY]) three();
        }
    }
    else
    if (number_for_second_domino_space=="four")
    {
        difference()
        {
            firstSpaceEleven();
            translate ([translateX, singleTranslateSecondY]) four();
        }
    }
    else
    if (number_for_second_domino_space=="five")
    {
        difference()
        {
            firstSpaceEleven();
            translate ([translateX, singleTranslateSecondY]) five();
        }
    }
    else
    if (number_for_second_domino_space=="six")
    {
        difference()
        {
            firstSpaceEleven();
            translate ([translateX, singleTranslateSecondY]) six();
        }
    }
    else
    if (number_for_second_domino_space=="seven")
    {
        difference()
        {
            firstSpaceEleven();
            translate ([translateX, singleTranslateSecondY]) seven();
        }
    }
    else
    if (number_for_second_domino_space=="eight")
    {
        difference()
        {
            firstSpaceEleven();
            translate ([translateX, singleTranslateSecondY]) eight();
        }
    }
    else
    if (number_for_second_domino_space=="nine")
    {
        difference()
        {
            firstSpaceEleven();
            translate ([translateX, singleTranslateSecondY]) nine();
        }
    }
    else
    if (number_for_second_domino_space=="ten")
    {
        difference()
        {
            firstSpaceEleven();
            translate ([translateX, doubleTranslateSecondY]) ten();
        }
    }
    else
    if (number_for_second_domino_space=="eleven")
    {
        difference()
        {
            firstSpaceEleven();
            translate ([translateX, elevenTranslateY]) eleven();
        }
    }
    else
    if (number_for_second_domino_space=="twelve")
    {
        difference()
        {
            firstSpaceEleven();
            translate ([translateX, doubleTranslateSecondY]) twelve();
        }
    }
    else
    if (number_for_second_domino_space=="blank")
    {
        difference()
        {
            firstSpaceEleven();
            translate ([translateX, doubleTranslateSecondY]) blank();
        }
    }
}
else{
if (number_for_first_domino_space=="twelve")
{
    if (number_for_second_domino_space=="one")
    {
        difference()
        {
            firstSpaceTwelve();
            translate ([translateX, singleTranslateSecondY]) one();
        }
    }
    else
    if (number_for_second_domino_space=="two")
    {
        difference()
        {
            firstSpaceTwelve();
            translate ([translateX, singleTranslateSecondY]) two();
        }
    }
    else
    if (number_for_second_domino_space=="three")
    {
        difference()
        {
            firstSpaceTwelve();
            translate ([translateX, singleTranslateSecondY]) three();
        }
    }
    else
    if (number_for_second_domino_space=="four")
    {
        difference()
        {
            firstSpaceTwelve();
            translate ([translateX, singleTranslateSecondY]) four();
        }
    }
    else
    if (number_for_second_domino_space=="five")
    {
        difference()
        {
            firstSpaceTwelve();
            translate ([translateX, singleTranslateSecondY]) five();
        }
    }
    else
    if (number_for_second_domino_space=="six")
    {
        difference()
        {
            firstSpaceTwelve();
            translate ([translateX, singleTranslateSecondY]) six();
        }
    }
    else
    if (number_for_second_domino_space=="seven")
    {
        difference()
        {
            firstSpaceTwelve();
            translate ([translateX, singleTranslateSecondY]) seven();
        }
    }
    else
    if (number_for_second_domino_space=="eight")
    {
        difference()
        {
            firstSpaceTwelve();
            translate ([translateX, singleTranslateSecondY]) eight();
        }
    }
    else
    if (number_for_second_domino_space=="nine")
    {
        difference()
        {
            firstSpaceTwelve();
            translate ([translateX, singleTranslateSecondY]) nine();
        }
    }
    else
    if (number_for_second_domino_space=="ten")
    {
        difference()
        {
            firstSpaceTwelve();
            translate ([translateX, doubleTranslateSecondY]) ten();
        }
    }
    else
    if (number_for_second_domino_space=="eleven")
    {
        difference()
        {
            firstSpaceTwelve();
            translate ([translateX, elevenTranslateY]) eleven();
        }
    }
    else
    if (number_for_second_domino_space=="twelve")
    {
        difference()
        {
            firstSpaceTwelve();
            translate ([translateX, doubleTranslateSecondY]) twelve();
        }
    }
    else
    if (number_for_second_domino_space=="blank")
    {
        difference()
        {
            firstSpaceTwelve();
            translate ([translateX, doubleTranslateSecondY]) blank();
        }
    }
}
else{
if (number_for_first_domino_space=="blank")
{
    if (number_for_second_domino_space=="one")
    {
        difference()
        {
            firstSpaceBlank();
            translate ([translateX, singleTranslateSecondY]) one();
        }
    }
    else
    if (number_for_second_domino_space=="two")
    {
        difference()
        {
            firstSpaceBlank();
            translate ([translateX, singleTranslateSecondY]) two();
        }
    }
    else
    if (number_for_second_domino_space=="three")
    {
        difference()
        {
            firstSpaceBlank();
            translate ([translateX, singleTranslateSecondY]) three();
        }
    }
    else
    if (number_for_second_domino_space=="four")
    {
        difference()
        {
            firstSpaceBlank();
            translate ([translateX, singleTranslateSecondY]) four();
        }
    }
    else
    if (number_for_second_domino_space=="five")
    {
        difference()
        {
            firstSpaceBlank();
            translate ([translateX, singleTranslateSecondY]) five();
        }
    }
    else
    if (number_for_second_domino_space=="six")
    {
        difference()
        {
            firstSpaceBlank();
            translate ([translateX, singleTranslateSecondY]) six();
        }
    }
    else
    if (number_for_second_domino_space=="seven")
    {
        difference()
        {
            firstSpaceBlank();
            translate ([translateX, singleTranslateSecondY]) seven();
        }
    }
    else
    if (number_for_second_domino_space=="eight")
    {
        difference()
        {
            firstSpaceBlank();
            translate ([translateX, singleTranslateSecondY]) eight();
        }
    }
    else
    if (number_for_second_domino_space=="nine")
    {
        difference()
        {
            firstSpaceBlank();
            translate ([translateX, singleTranslateSecondY]) nine();
        }
    }
    else
    if (number_for_second_domino_space=="ten")
    {
        difference()
        {
            firstSpaceBlank();
            translate ([translateX, doubleTranslateSecondY]) ten();
        }
    }
    else
    if (number_for_second_domino_space=="eleven")
    {
        difference()
        {
            firstSpaceBlank();
            translate ([translateX, elevenTranslateY]) eleven();
        }
    }
    else
    if (number_for_second_domino_space=="twelve")
    {
        difference()
        {
            firstSpaceBlank();
            translate ([translateX, doubleTranslateSecondY]) twelve();
        }
    }
    else
    if (number_for_second_domino_space=="blank")
    {
        difference()
        {
            firstSpaceBlank();
            translate ([translateX, doubleTranslateSecondY]) blank();
        }
    }
}
}}}}}}}}}}}}














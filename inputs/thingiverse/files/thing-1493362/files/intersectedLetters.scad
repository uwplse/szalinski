difint = 2; //  [1: Difference, 2: Intersection]
letter1 = "A";
letter2 = "B";
letter3 = "C";
textFont = "BankGothic Lt BT";
size = 5;

intersectedLetters();

module intersectedLetters()
{
    if(difint == 1)
    {
        difference()
        {
            centerCube(size, size, size);
            if(letter1 != "")
            {
                rotate([90, 0, 0])
                {
                    letter(letter1, size * 2);
                }
            }
            if(letter2 != "")
            {
                rotate([90, 0, 90])
                {
                    letter(letter2, size * 2);
                }
            }
            if(letter3 != "")
            {
                rotate([0, 0, 90])
                {
                    letter(letter3, size * 2);
                }
            }
        }
    }
    else if(difint == 2)
    {
        intersection()
        {
            if(letter1 != "")
            {
                rotate([90, 0, 0])
                {
                    letter(letter1, size);
                }
            }
            if(letter2 != "")
            {
                rotate([90, 0, 90])
                {
                    letter(letter2, size);
                }
            }
            if(letter3 != "")
            {
                rotate([0, 0, 90])
                {
                    letter(letter3, size);
                }
            }
        }
    }
}

module letter(letter, height)
{
    translate([0, 0, -height / 2])
    {
        linear_extrude(height = height)
        {
            text(text = letter, size = size, font = textFont, halign = "center", valign = "center", direction = "ltr", language = "nl", script = "latin");
        }
    }
}

module centerCube(x, y, z)
{
    translate([-x / 2, -y / 2, -z / 2])
    {
        cube([x, y, z]);
    }
}
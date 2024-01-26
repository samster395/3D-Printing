# Parametric Spiral Wall Art - Work in progress

I have been working on parametric wall art inspired by inspired by [this](https://i.imgur.com/Kc8Cd5w.png) sculpture made by [Herschel Shapiro](https://www.tiktok.com/@herschelshapiro/video/7225225819789036805).

Ive been trying to recreate it in OpenSCAD, made some good progress so far, obviosuly I need to tweak the values that define how they twist/point but im happy with my progress so far, the idea isnt to completely copy Herschel's print, its just inspired by it.


Progress so far:

![Progress so far](https://raw.githubusercontent.com/samster395/3D-Printing/main/OpenScad/Art/horn_array/example.png)

### To do
 - Adjust horn twist parameter for better results, ideally it should base of a changing value rather than being harcoded, right now it is based off which number in the array the horn is, this is fine until you have upwards of 100 parts, where they starting being very twisty. I have experimented with using a random number between 25-235 degrees with promising results, I still feel like it could be further refined but this is a start.
 - Probably add mating interfaces on each horn as seen on Herschel's Horns
 - Maybe improve how the horns are ordered, not sure if my way of doing it is the best.

Example of Herchel's Horns:

![Example of Herchel's Horns](https://raw.githubusercontent.com/samster395/3D-Printing/main/OpenScad/Art/horn_array/Herschel_Shapiro_horn_example.png)

Any feedback is welcome, best place is probably the [Printables Page](https://www.printables.com/model/738765/).

### Credits
I am new to OpenSCAD so needed to take some bits of code from elsewhere to achieve what I wanted, I realise these may be very simple for someone who knows what they're doing but I didnt, so credit is due.

[Jeff Barr](https://www.reddit.com/user/jeffbarr/) on Reddit - [Row and Column code](https://www.reddit.com/r/openscad/comments/194zodo/incrementing_inside_a_loop/khlnhd4/?context=3)

[Sarah C](https://www.reddit.com/user/SarahC/) on Reddit - [Batch export script](https://www.reddit.com/r/openscad/comments/lbq58y/my_approach_to_scripting_parts_and_converting/)


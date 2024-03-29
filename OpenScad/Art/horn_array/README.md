# Parametric Spiral Wall Art - Work in progress

I have been working on parametric wall art inspired by inspired by [this](https://i.imgur.com/Kc8Cd5w.png) sculpture made by [Herschel Shapiro](https://www.tiktok.com/@herschelshapiro/video/7225225819789036805).

Ive been trying to recreate it in OpenSCAD, made some good progress so far, obviosuly I need to tweak the values that define how they twist/point but im happy with my progress so far, the idea isnt to completely copy Herschel's print, its just inspired by it.


Progress so far:

![Progress so far](https://raw.githubusercontent.com/samster395/3D-Printing/main/OpenScad/Art/horn_array/example.png)

### To do
 - Adjust horn twist parameter for better results, ideally it should base of a changing value rather than being harcoded, right now it is based off which number in the array the horn is, this is fine until you have upwards of 100 parts, where they starting being very twisty. I have experimented with using a random number between 25-235 degrees with promising results, I still feel like it could be further refined but this is a start.
 - Probably add mating interfaces on each horn as seen on Herschel's Horns - Update 26/1/2023 I have added an experimental mating interface file, not perfect but a start. I'm not sure if mating interfaces are really necessary though as the hex meshes together pretty well, also not sure how I would make it so they don't show on the outer faces. [Photo](https://media.printables.com/media/prints/738765/images/5777008_67fbdf4a-e515-4c67-8823-7a31723c9ed3_e97d5f4d-4f5d-43a0-8c39-a3cb0a688530/thumbs/inside/1280x960/png/openscad_2024-01-26_23-46-07.webp)
 - Maybe improve how the horns are ordered, not sure if my way of doing it is the best.

Example of Herchel's Horns:

![Example of Herchel's Horns](https://raw.githubusercontent.com/samster395/3D-Printing/main/OpenScad/Art/horn_array/Herschel_Shapiro_horn_example.png)

Any feedback is welcome, best place is probably the [Printables Page](https://www.printables.com/model/738765/).

### Credits
I am new to OpenSCAD so needed to take some bits of code from elsewhere to achieve what I wanted, I realise these may be very simple for someone who knows what they're doing but I didnt, so credit is due.

[Jeff Barr](https://www.reddit.com/user/jeffbarr/) on Reddit - [Row and Column code](https://www.reddit.com/r/openscad/comments/194zodo/incrementing_inside_a_loop/khlnhd4/?context=3)

[Sarah C](https://www.reddit.com/user/SarahC/) on Reddit - [Batch export script](https://www.reddit.com/r/openscad/comments/lbq58y/my_approach_to_scripting_parts_and_converting/)


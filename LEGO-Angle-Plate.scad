use <LEGO.scad>;

module angle_plate(
    angle=90, // To turn the overhang so it's pointing up, use negative degrees, like -90.
    base_stud_length=2,
    base_stud_width=2,
    overhang_stud_length=2,
    overhang_stud_width=2
    ) {
    // Values from Lego.scad.
    lego_brick_height = 9.6; // Height of the non-stud portion of a regular brick.
    stud_spacing=8; // Distance between centers of studs.
    stud_diameter=4.85; // Diameters of studs.
    wall_play=0.1; // Amount of space removed from the outer edge of bricks so that they will fit next to each other.

    base_height = lego_brick_height/3;
    base_width = (base_stud_width * stud_spacing) - (wall_play * 2);
    base_length = (base_stud_length * stud_spacing) - (wall_play * 2);

    overhang_height = lego_brick_height/3;
    overhang_width = (overhang_stud_width * stud_spacing) - (wall_play * 2);
    overhang_length = (overhang_stud_length * stud_spacing) - (wall_play * 2);

    // Generate the base.
    if (base_stud_length > base_stud_width) {
        // Lego.scad always makes the longest number the length. Rotate it manually if we want it wider than long.
        rotate([0, 0, 90])
            block(
                height=.33333333333,
                type="brick",
                length=base_stud_length,
                width=base_stud_width
            );
    }
    else {
        block(
            height=.33333333333,
            type="brick",
            length=base_stud_length,
            width=base_stud_width
        );
    }

    if (angle <= 90 ) {
        // Add a solid section protruding out one end of the base to join it to the angled portion.
       translate([((base_width+overhang_height*sin(angle))/2)+wall_play/2, 0, base_height/2])
            cube([(overhang_height*sin(angle))+wall_play, base_length,base_height], true);
    }

    // Generate the angled piece.
    if ( angle >= 0 ) {
        // Generate the angled piece.
        difference() {
            translate( [base_width/2 + (overhang_height*sin(angle))+wall_play, 0, base_height] )
                rotate([0, angle, 0])
                translate([overhang_width/2, 0, -overhang_height])
                union() {
                    if (overhang_stud_length > overhang_stud_width) {
                        // Lego.scad always makes the longest number the length. Rotate it manually if we want it wider than long.
                        rotate([0, 0, 90])
                            block(
                                height=.33333333333,
                                type="brick",
                                length=overhang_stud_length,
                                width=overhang_stud_width,
                                stud_type="hollow"
                            );
                    }
                    else {
                        block(
                            height=.33333333333,
                            type="brick",
                            length=overhang_stud_length,
                            width=overhang_stud_width,
                            stud_type="hollow"
                        );
                    }

                    // Fill in the underside of the angled portion. type=baseplate would do this, but it would also make it thinner and give it rounded edges.
                    translate( [0, 0, overhang_height/2] ) cube( [overhang_width, overhang_length, overhang_height], true );
            }

            // Remove from the angled brick everything above the top of the base brick.
            translate([ 0, 0, base_height + overhang_width/2]) {
                cube( [ base_width + (overhang_height * 2 * sin(angle)) + 0.01, max(base_length, overhang_length)+0.01, overhang_width ], true);
            }

            // Remove from the angle brick everything past the edge of the base.
            translate( [0, 0, base_height/2] ) {
                cube( [ base_width, max(base_length, overhang_length)+0.01, base_height * 10 ], true);
            }
        }
    }
    else {
        difference() {
            translate( [base_width/2+wall_play, 0, 0] )
                rotate([180, -angle, 180])
                translate([-overhang_width/2, 0, -base_height+overhang_height])
                union() {
                    if (overhang_stud_length > overhang_stud_width) {
                        // Lego.scad always makes the longest number the length. Rotate it manually if we want it wider than long.
                        rotate([0, 0, 90])
                            block(
                                height=.33333333333,
                                type="brick",
                                length=overhang_stud_length,
                                width=overhang_stud_width,
                                stud_type="hollow"
                            );
                    }
                    else {
                        block(
                            height=.33333333333,
                            type="brick",
                            length=overhang_stud_length,
                            width=overhang_stud_width,
                            stud_type="hollow"
                        );
                    }

                    // Fill in the underside of the angled portion. type=baseplate would do this, but it would also make it thinner and give it rounded edges.
                    translate( [0, 0, overhang_height/2] ) cube( [overhang_width, overhang_length, overhang_height], true );

            }
        }

        if ( angle >= -90 ) {
            // Make a polygon to fill the space between the 2.
                translate([base_width/2,base_length/2,0])
                rotate([90,0,0])
                linear_extrude( height=base_length )
                polygon(points=[
                    [0,0],
                    [0, base_height],
                    [wall_play + ( base_height / tan(-angle) ), base_height],
                    [wall_play, 0],
                    [0,0],

                ]);

        }
    }
}

angle_plate();

use <LEGO.scad>;

rotate([0, 0, 180])
union() {
    // First row.
    translate([0, 0 * (8 * 2), 0]) block(
        width=2,
        length=9,
        height=2
    );

    // Second row.
    translate([(0 * 4) + (0 * 8), (1 * 4) + (2 * 8), 0]) block(
        width=2,
        length=2,
        stud_type="hollow"
    );

    translate([(1 * 4) + (2 * 8), (1 * 4) + (2 * 8), 0]) block(
        width=2,
        length=2,
        height=1/3,
        vertical_axle_holes=true
    );

    translate([(2 * 4) + (4 * 8), (1 * 4) + (2 * 8), 0]) block(
        width=2,
        length=2,
        height=1/3,
        smooth=true
    );

    translate([(3 * 4) + (6 * 8), (1 * 4) + (2 * 8), 0]) translate([8, 0, 0]) rotate([0, 0, 90]) block(
        width=2,
        length=1,
        height=1/3,
        smooth=true
    );

    // Third row.
    translate([0, (2 * 4) + (4 * 8), 0]) block(
        width=4,
        length=9,
        height=1/3,
        type="wing",
        stud_notches=true
    );

    // Fourth row.
    translate([0, (3 * 4) + (8 * 8), 0]) block(
        width=1,
        length=6,
        horizontal_holes=true
    );
}
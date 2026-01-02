use <../LEGO.scad>;

block(
    width=2,
    length=4,
    height=1/3,
    type="wing",
    wing_type="right",
    wing_base_length=1,
    wing_end_width=2,
    stud_notches=true
);

// There's an extra stud on the base of the wing compared to the LEGO part.
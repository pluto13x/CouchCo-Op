if (keyboard_check_pressed(vk_space)) {
    show_debug_message("Attempting room change");
    room_goto(rMainRoom);
}
function resourcepack_temp_cleanup() {
    directory_destroy_recursive(game_directory + "replacedsprites")
    directory_destroy_recursive(game_directory + "_install")
    directory_destroy_recursive(game_directory + "_download")
}
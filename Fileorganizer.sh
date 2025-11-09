#!/bin/bash

# ===== Header =====
CYAN='\e[36m'; RED='\e[31m'; GREEN='\e[32m'; YELLOW='\e[33m'; BLUE='\e[34m'; NC='\e[0m'

echo -e "${CYAN}"
echo "====================================================="
echo "              FILE ORGANIZER (MENU MODE)"
echo "-----------------------------------------------------"
echo "  Organize files by type, view files, or move"
echo "  specific extensions into custom folders easily."
echo "====================================================="
echo -e "${NC}"

# ===== Ask for directory =====
echo -e "${BLUE}Enter directory path:${NC}"
read DIR
[ ! -d "$DIR" ] && echo -e "${RED}Folder not found!${NC}" && exit

# ===== Option 1: Auto Organize =====
organize_files() {
    cd "$DIR"
    mkdir -p Images Documents TextFiles Videos Music Others   # make folders

    for f in *; do
        [ -f "$f" ] || continue   # skip folders
        ext="${f##*.}"            # get extension

        case "$ext" in
            jpg|jpeg|png|gif) mv "$f" Images/ ;;
            pdf|doc|docx|pptx|xlsx) mv "$f" Documents/ ;;
            txt) mv "$f" TextFiles/ ;;
            mp4|mkv|mov) mv "$f" Videos/ ;;
            mp3|wav) mv "$f" Music/ ;;
            *) mv "$f" Others/ ;;
        esac
    done

    echo -e "${GREEN}✔ Organized.${NC}"
}

# ===== Option 2: Show Files =====
show_files() {
    ls "$DIR"
}

# ===== Option 3: Custom Move =====
custom_move() {
    echo -e "${BLUE}Enter extension (ex: txt, mp4):${NC}"
    read ext
    echo -e "${BLUE}Enter folder name:${NC}"
    read fol
    cd "$DIR"
    mkdir -p "$fol"
    mv *."$ext" "$fol" 2>/dev/null
    echo -e "${GREEN}✔ .$ext moved to $fol/${NC}"
}

# ===== Menu =====
while true; do
    echo -e "${YELLOW}"
    echo "1) Auto Organize Files"
    echo "2) Show Files"
    echo "3) Move Specific Extension"
    echo "4) Exit"
    echo -e "${NC}"
    read -p "Choose: " ch

    case $ch in
        1) organize_files ;;
        2) show_files ;;
        3) custom_move ;;
        4) echo -e "${GREEN}Bye 👋${NC}"; exit ;;
        *) echo -e "${RED}Invalid!${NC}" ;;
    esac
done

import sys

def check_braces(filename):
    with open(filename, 'r') as f:
        lines = f.readlines()

    brace_level = 0
    class_started = False

    for i, line in enumerate(lines):
        line_num = i + 1
        
        if 'class _RoomScreenState' in line:
            class_started = True
            print(f"[{line_num}] Class started.")

        if not class_started:
            continue

        code = line.split('//')[0]
        
        old_level = brace_level
        for char in code:
            if char == '{':
                brace_level += 1
            elif char == '}':
                brace_level -= 1
        
        if line_num >= 69 and line_num <= 120:
             print(f"[{line_num}] {line.strip()} | Level: {old_level} -> {brace_level}")

check_braces('shaheen_start_app-main/lib/view/screens/room/room_screen.dart')

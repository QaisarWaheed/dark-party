import sys

def check_braces(filename):
    with open(filename, 'r') as f:
        lines = f.readlines()

    brace_level = 0
    class_started = False
    class_start_line = 0

    for i, line in enumerate(lines):
        line_num = i + 1
        
        # Detect class start (approximate)
        if 'class _RoomScreenState' in line:
            class_started = True
            class_start_line = line_num
            print(f"Class started at line {line_num}")

        if not class_started:
            continue

        # Count braces
        # Ignore strings and comments? 
        # For simplicity, let's just count { and } assuming no tricky strings with braces
        # This is a heuristic.
        
        # Remove comments //
        code = line.split('//')[0]
        
        for char in code:
            if char == '{':
                brace_level += 1
            elif char == '}':
                brace_level -= 1
                if brace_level == 0:
                    print(f"Brace level dropped to 0 at line {line_num}. Class potentially closed.")
                if brace_level < 0:
                    print(f"ERROR: Brace level negative at line {line_num}!")
                    return

    print(f"Final brace level: {brace_level}")

check_braces('shaheen_start_app-main/lib/view/screens/room/room_screen.dart')

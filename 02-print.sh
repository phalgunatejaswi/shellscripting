#!/usr/bin/bash

# There two ways to print on screen
# 1 - echo
# 2 - printf

# printf has more syntax types. However, echo is more descriptive and performs the same actions as printf
# echo is widely used that printf
## Syntax --- echo <MESSAGE>

echo Hello World

# printing in multiple lines\tabs\color
## Syntax --- echo -e "MESSAGE\n\t\e"

echo -e "Hello,\n\tTom"

# Enable Colors
## Syntax -- echo -e "\e[COLOR-CODEmMESSAGE"
# COLOR CODES
# RED     31
# GREEN   32
# YELLOW  33
# BLUE    34
# MAGENTA 35
# CYAN    36

echo -e "\e[31mHello in RED"
echo -e "\e[36mHello in CYAN"

# Once the colors are enabled for a line, the next lines will also be printed with the same.
# So, its best practice to always reset te color to white by providing \e[0m at the end

echo -e "\e[32mColor set to GREEN \t \e[0m Color Reset to White"
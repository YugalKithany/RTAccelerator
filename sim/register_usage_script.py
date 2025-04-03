import re
from collections import Counter

filename = "/home/divyama3/fa24_ece411_The_Chicago_Bears/mp_ooo/sim/bin/coremark_im.dis"
with open(filename, "r") as file:
    lines = file.readlines()

instruction_pattern = re.compile(r"^\s*([0-9a-f]+):\s+[0-9a-f]+\s+(\w+)(?:\s+([^\n]*))?")
register_usage = Counter()

for line in lines:
    instr_match = instruction_pattern.match(line)
    if instr_match:
        operands = instr_match.group(3)
        if operands:
            reg_matches = re.findall(r"x\d+", operands)
            for reg in reg_matches:
                reg_num = int(reg[1:])
                if 0 <= reg_num <= 31:
                    register_usage[reg] += 1

with open("register_usage.txt", "w") as reg_file:
    reg_file.write("Register Usage Analysis\n\n")
    for reg, count in sorted(register_usage.items(), key=lambda x: int(x[0][1:])):
        reg_file.write(f"{reg}: {count} \n")

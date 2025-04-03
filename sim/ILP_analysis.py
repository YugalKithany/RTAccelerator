import re

def analyze_dis(file_path):
    instr = {
        'ADD': (r'^(add)\b', 1),
        'SUB': (r'^(sub)\b', 1),
        'SLL': (r'^(sll)\b', 1),
        'SLLI': (r'^(slli)\b', 1),
        'SLT': (r'^(slt)\b', 1),
        'SLTU': (r'^(sltu)\b', 1),
        'XOR': (r'^(xor)\b', 1),
        'SRL': (r'^(srl)\b', 1),
        'SRLI': (r'^(srli)\b', 1),
        'SRA': (r'^(sra)\b', 1),
        'OR': (r'^(or)\b', 1),
        'AND': (r'^(and)\b', 1),
        'NEG': (r'^(neg)\b', 1),
        'ADDI': (r'^(addi|mv|zext\.b|li)\b', 1),
        'SLTI': (r'^(slti)\b', 1),
        'SLTIU': (r'^(sltiu)\b', 1),
        'XORI': (r'^(xori)\b', 1),
        'ORI': (r'^(ori)\b', 1),
        'ANDI': (r'^(andi)\b', 1),
        'LB': (r'^(lb)\b', 2),
        'LH': (r'^(lh)\b', 2),
        'LW': (r'^(lw)\b', 2),
        'LBU': (r'^(lbu)\b', 2),
        'LHU': (r'^(lhu)\b', 2),
        'SB': (r'^(sb)\b', 2),
        'SH': (r'^(sh)\b', 2),
        'SW': (r'^(sw)\b', 2),
        'BEQ': (r'^(beq)\b', 2),
        'BNE': (r'^(bne)\b', 2),
        'BLT': (r'^(blt)\b', 2),
        'BGE': (r'^(bge)\b', 2),
        'BLTU': (r'^(bltu)\b', 2),
        'BGEU': (r'^(bgeu)\b', 2),
        'BEQZ': (r'^(beqz)\b', 2),
        'BNEZ': (r'^(bnez)\b', 2),
        'LUI': (r'^(lui)\b', 1),
        'AUIPC': (r'^(auipc)\b', 1),
        'NOT': (r'^(not)\b', 1),
        'JAL': (r'^(jal|j)\b', 2),
        'JALR': (r'^(jalr|ret|jr)\b', 2),
        'MUL': (r'^(mul)\b', 5),
        'MULH': (r'^(mulh)\b', 5),
        'MULHSU': (r'^(mulhsu)\b', 5),
        'MULHU': (r'^(mulhu)\b', 5),
        'DIV': (r'^(div)\b', 5),
        'DIVU': (r'^(divu)\b', 5),
        'REM': (r'^(rem)\b', 5),
        'REMU': (r'^(remu)\b', 5),
    }

    instr_array = []
    with open(file_path, 'r') as file:
        start_flag = False
        for line in file:
            if '<_start>' in line:
                start_flag = True
                continue
            if '<_text_vma_end>' in line:
                break
            if start_flag:
                match = re.match(r'\s*[0-9a-f]+:\s+[0-9a-f]+\s+(\w+)(.*)', line)
                if match:
                    instr_match = match.group(1)
                    operands = match.group(2).strip()
                    category = 'OTHER'
                    latency = 1
                    for cat, (pattern, lat) in instr.items():
                        if re.match(pattern, instr_match):
                            category = cat
                            latency = lat
                            break
                    instr_array.append((instr_match, category, operands, latency))

    cycles = 0
    active_registers = {}
    num_instr = len(instr_array)

    for instr_match, category, operands, latency in instr_array:
        dest_reg = None
        src_regs = []
        if operands:
            parts = operands.split(',')
            dest_reg = parts[0].strip() if len(parts) > 1 else None
            src_regs = [r.strip() for r in parts[1:]] if len(parts) > 1 else [parts[0].strip()]

        current_cycle = cycles
        for src in src_regs:
            if src in active_registers:
                current_cycle = max(current_cycle, active_registers[src])

        cycles = max(cycles, current_cycle) + latency

        if dest_reg:
            active_registers[dest_reg] = cycles

    ILP = num_instr / cycles
    print(f"ILP:", ILP)

if __name__ == "__main__":
    import sys

    if len(sys.argv) != 2:
        print("Usage: python3 ILP_analysis.py <disassembly_file>")
        sys.exit(1)

    file_path = sys.argv[1]
    analyze_dis(file_path)

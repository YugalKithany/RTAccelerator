import re
from collections import Counter
import pandas as pd
import sys

def analyze_dis(file_path):
    instr = {
        'ADD': r'^(add)\b',
        'SUB': r'^(sub)\b',
        'SLL': r'^(sll)\b',
        'SLLI': r'^(slli)\b',
        'SLT': r'^(slt)\b',
        'SLTU': r'^(sltu)\b',
        'XOR': r'^(xor)\b',
        'SRL': r'^(srl)\b',
        'SRLI': r'^(srli)\b',
        'SRA': r'^(sra)\b',
        'OR': r'^(or)\b',
        'AND': r'^(and)\b',
        'NEG': r'^(neg)\b',
        'ADDI': r'^(addi|mv|zext\.b|li)\b',
        'SLTI': r'^(slti)\b',
        'SLTIU': r'^(sltiu)\b',
        'XORI': r'^(xori)\b',
        'ORI': r'^(ori)\b',
        'ANDI': r'^(andi)\b',
        'LB': r'^(lb)\b',
        'LH': r'^(lh)\b',
        'LW': r'^(lw)\b',
        'LBU': r'^(lbu)\b',
        'LHU': r'^(lhu)\b',
        'SB': r'^(sb)\b',
        'SH': r'^(sh)\b',
        'SW': r'^(sw)\b',
        'BEQ': r'^(beq)\b',
        'BNE': r'^(bne)\b',
        'BLT': r'^(blt)\b',
        'BGE': r'^(bge)\b',
        'BLTU': r'^(bltu)\b',
        'BGEU': r'^(bgeu)\b',
        'BEQZ': r'^(beqz)\b',
        'BNEZ': r'^(bnez)\b',
        'LUI': r'^(lui)\b',
        'AUIPC': r'^(auipc)\b',
        'NOT': r'^(not)\b',
        'JAL': r'^(jal|j)\b',
        'JALR': r'^(jalr|ret|jr)\b',
        'MUL': r'^(mul)\b',
        'MULH': r'^(mulh)\b',
        'MULHSU': r'^(mulhsu)\b',
        'MULHU': r'^(mulhu)\b',
        'DIV': r'^(div)\b',
        'DIVU': r'^(divu)\b',
        'REM': r'^(rem)\b',
        'REMU': r'^(remu)\b',
    }

    instr_counter = Counter()
    num_instr = 0
    num_cycles = 0

    start_flag = False

    with open(file_path, 'r') as file:
        for line in file:
            if '<_start>' in line:
                start_flag = True
                continue
            if '<_text_vma_end>' in line:
                break
            if start_flag:
                match = re.search(r'\b([a-zA-Z.]+)\b', line)
                if match:
                    instr_match = match.group(1)
                    matched = False
                    for instr_type, pattern in instr.items():
                        if re.match(pattern, instr_match):
                            num_instr += 1
                            instr_counter[instr_type] += 1
                            matched = True
                            break

    instr_match_stats = {
        instr_type: {
            'count': count,
            'percentage (%)': f"{(count / num_instr) * 100:.4f}%"
        }
        for instr_type, count in instr_counter.items()
    }

    for instr in ['ADD', 
                  'SUB', 
                  'AND', 
                  'OR', 
                  'XOR', 
                  'SLL', 
                  'SRL', 
                  'SRA', 
                  'ADDI', 
                  'ANDI', 
                  'ORI', 
                  'XORI', 
                  'SLLI', 
                  'SRLI', 
                  'SRAI', 
                  'LUI', 
                  'AUIPC', 
                  'NOT', 
                  'JALR', 
                  'JAL', 
                  'SLTU', 
                  'SLTI', 
                  'NEG']:
        if instr in instr_match_stats:
            num_cycles += instr_match_stats[instr]['count'] * 1
            instr_match_stats[instr]['cycle_count'] = instr_match_stats[instr]['count'] * 1
    for instr in ['MUL', 
                  'MULH', 
                  'MULHSU', 
                  'MULHU', 
                  'DIV', 
                  'DIVU', 
                  'REM', 
                  'REMU']:
        if instr in instr_match_stats:
            num_cycles += instr_match_stats[instr]['count'] * 5
            instr_match_stats[instr]['cycle_count'] = instr_match_stats[instr]['count'] * 5
    for instr in ['BEQ', 
                  'BEQZ', 
                  'BNEZ', 
                  'BNE', 
                  'BLT', 
                  'BGE', 
                  'BLTU', 
                  'BGEU', 
                  'LB', 
                  'LBU', 
                  'LH', 
                  'LHU', 
                  'LW', 
                  'SB', 
                  'SH', 
                  'SW']:
        if instr in instr_match_stats:
            num_cycles += instr_match_stats[instr]['count'] * 2
            instr_match_stats[instr]['cycle_count'] = instr_match_stats[instr]['count'] * 2

    IPC = num_instr / num_cycles

    df = pd.DataFrame(instr_match_stats).T.sort_values(by='count', ascending=False)
    df = df.drop(columns=['count', 'cycle_count'], errors='ignore')
    return df, IPC


if __name__ == "__main__":
    if len(sys.argv) != 2:
        sys.exit(1)

    file_path = sys.argv[1]
    results_df, ipc_value = analyze_dis(file_path)
    print(results_df)
    print(f"\nSingle cycle CPU IPC: {ipc_value:.4f}")

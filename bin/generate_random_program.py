import random

no_RAW = False

# Define the instruction sets
#lui_auipc_instructions = ['lui', 'auipc']
lui_auipc_instructions = ['lui']
rtype_instructions = ['add', 'sub', 'sll', 'slt', 'sltu', 'xor', 'srl', 'sra', 'or', 'and']
itype_instructions = ['addi', 'slti', 'sltiu', 'xori', 'ori', 'andi', 'slli', 'srli', 'srai']
stype_instructions = ['sb', 'sh', 'sw']
load_instructions = ['lb', 'lh', 'lw', 'lbu', 'lhu']
mtype_instructions = ['mul', 'mulh', 'mulhu', 'mulhsu', 'div', 'divu', 'rem', 'remu']

# Define the registers available for use (excluding x0)
registers = [f'x{i}' for i in range(1, 32)]

used_memory_addresses = []
valid_words =[]
valid_halves = []

last_rd = None

# Generate random immediate value
def random_immediate_11_0():
    return random.randint(-2048, 2047)

def random_immediate_31_12():
    return random.randint(0,1048576)

def random_memory_address():
    return random.randint(126187, 1048576)

def random_immediate_11_0_aligned():
    rand = random.randint(-2048, 2047)
    return rand - (rand % 4)

# Generate random instruction
def generate_instruction():
    global last_rd


    instruction_type = random.choice([
        lui_auipc_instructions, 
        rtype_instructions, 
        itype_instructions, 
        mtype_instructions,
        #stype_instructions, 
        #load_instructions
        ])
    instr = random.choice(instruction_type)
    
    if instr in lui_auipc_instructions:
        # LUI and AUIPC only need a destination register and an immediate
        rd = random.choice(registers)
        imm = random_immediate_31_12()
        return f"{instr} {rd}, {imm}"

    elif instr in rtype_instructions:
        # R-type instructions need rd, rs1, rs2
        rd = random.choice(registers)
        rs1 = random.choice(registers)
        rs2 = random.choice(registers)

        if no_RAW and last_rd:
            while rs1 == last_rd or rs2 == last_rd:
                rs1 = random.choice(registers)
                rs2 = random.choice(registers)

        last_rd = rd

        return f"{instr} {rd}, {rs1}, {rs2}"
    
    elif instr in mtype_instructions:
        # R-type instructions need rd, rs1, rs2
        rd = random.choice(registers)
        rs1 = random.choice(registers)
        rs2 = random.choice(registers)

        if no_RAW and last_rd:
            while rs1 == last_rd:
                rs1 = random.choice(registers)
        
        last_rd = rd

        return f"{instr} {rd}, {rs1}, {rs2}"

    elif instr in itype_instructions:
        # I-type instructions need rd, rs1, imm
        rd = random.choice(registers)
        rs1 = random.choice(registers)
        imm = random_immediate_11_0()
        #avoid improper shift errors
        if instr in ['slli', 'srli', 'srai']: imm = imm & 0b00000001111
        return f"{instr} {rd}, {rs1}, {imm}"

    elif instr in load_instructions and used_memory_addresses:
        rd = random.choice(registers)
        rs1 = random.choice(registers)

        if(instr == 'lh' or instr == 'lhu'): address = random.choice(valid_halves)
        elif(instr == 'lw'): address = random.choice(valid_words)
        else: address = random.choice(used_memory_addresses)

        output_string = f"lui {rs1}, {address} \n\tnop\n\tnop\n\tnop\n\tnop\n\tnop\n\t"

        return output_string + f"{instr} {rd}, 0({rs1})"
    
    elif instr in stype_instructions:

        rs1 = random.choice(registers)
        rs2 = random.choice(registers)

        address = random_memory_address()

        if(instr == 'sh'): 
            address = address & 0xFFFFFFFE
            valid_halves.append(address)
        if(instr == 'sw'): 
            address = address & 0xFFFFFFFC
            valid_words.append(address)
        else:
            used_memory_addresses.append(address)

        output_string = f"lui {rs1}, {address} \n\tnop\n\tnop\n\tnop\n\tnop\n\tnop\n\t"
        return output_string + f"{instr} {rs2}, 0({rs1})"
        
    else: 
        return f"nop"


# Generate the register zeroing instructions
def zero_registers():
    zeroing_instructions = []
    for i in range(1, 32):  # Registers x1 to x31
        zeroing_instructions.append(f"addi x{i}, x0, 0")  # Set x{i} to 0 using addi
        zeroing_instructions.extend(['nop'] * 5)
    return zeroing_instructions

# Generate a sequence of instructions with 5 nops in between
def generate_program(num_instructions):

    program = zero_registers()

    for _ in range(num_instructions):
        instruction = generate_instruction()
        program.append(instruction)
        #program.extend(['nop'] * 5)  # Add 5 nops after every instruction
    
    # Add the terminating instruction
    program.append('slti x0, x0, -256')
    
    return program

# Write to an .asm file
def write_program_to_file(program, filename):
    with open(filename, 'w') as f:
        f.write('.section .text\n')
        f.write('.globl _start\n')
        f.write('_start:\n')

        for line in program:
            f.write('\t' + line + '\n')

# Main function to generate the program
def main():
    num_instructions = 10000 # Adjust the number of random instructions you want
    program = generate_program(num_instructions)
    write_program_to_file(program, '../testcode/random.s')

if __name__ == "__main__":
    main()

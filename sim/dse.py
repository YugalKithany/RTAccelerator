import subprocess
import time
import re

def run_make_command():
    print(f"Simulating...")
    try:
        command = ["make", "run_vcs_top_tb", "PROG=../testcode/coremark_im.elf"]
        make_process = subprocess.Popen(
            command,
            cwd="./",
            universal_newlines=True,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE
        )
        stdout, stderr = make_process.communicate()
        print("STDOUT:", stdout)
        if stderr:
            print("STDERR:", stderr)

        if make_process.returncode != 0:
            print("Makefile execution failed.")
        else:
            print("Makefile executed successfully.")

    except Exception as e:
        print(f"ur surely cooked")

def parse_simulation_log():
    print(f"Parsing simulation.log")
    total_ipc = None

    try:
        with open("vcs/simulation.log", 'r') as log_file:
            log_content = log_file.read()
            match = re.search(r'Monitor: Segment IPC:\s*([\d.]+)', log_content)
            if match:
                total_ipc = match.group(1)
                print(f"Extracted Total IPC: {total_ipc}")
    except FileNotFoundError:
        print(f"ur cooked")
    except Exception as e:
        print(f"ur also cooked: {e}")

    if total_ipc:
        with open("total_ipc.txt", 'a') as file:
            file.write(f"{total_ipc}\n")

def modify_rob_depth(old_rob_value, new_rob_value):
    try:
        old_value = f"ROB_DEPTH = {old_rob_value}"
        new_value = f"ROB_DEPTH = {new_rob_value}"
        with open("../pkg/types.sv", "rt") as fin:
            file_data = fin.read()
        file_data = file_data.replace(old_value, new_value)
        
        with open("../pkg/types.sv", "wt") as fout:
            fout.write(file_data)
        
        print(f"Updated types.sv: Replaced '{old_value}' with '{new_value}'")
    except Exception as e:
        print(f"ur cooked again")

def modify_iqueue_depth(old_iqueue_depth_value, new_iqueue_depth_value):
    try:
        old_value = f"IQUEUE_DEPTH = {old_iqueue_depth_value}"
        new_value = f"IQUEUE_DEPTH = {new_iqueue_depth_value}"
        with open("../pkg/types.sv", "rt") as fin:
            file_data = fin.read()
        file_data = file_data.replace(old_value, new_value)
        
        with open("../pkg/types.sv", "wt") as fout:
            fout.write(file_data)
        
        print(f"Updated types.sv: Replaced '{old_value}' with '{new_value}'")
    except Exception as e:
        print(f"ur cooked again")

def modify_squeue_depth(old_squeue_value, new_squeue_value):
    try:
        old_value = f"SQUEUE_DEPTH = {old_squeue_value}"
        new_value = f"SQUEUE_DEPTH = {new_squeue_value}"
        with open("../pkg/types.sv", "rt") as fin:
            file_data = fin.read()
        file_data = file_data.replace(old_value, new_value)
        
        with open("../pkg/types.sv", "wt") as fout:
            fout.write(file_data)
        
        print(f"Updated types.sv: Replaced '{old_value}' with '{new_value}'")
    except Exception as e:
        print(f"ur cooked again")

def get_ipc_values():
    try:
        with open("total_ipc.txt", 'r') as file:
            lines = file.readlines()
            if len(lines) < 2:
                raise ValueError("time to debug")
            old_IPC = float(lines[-2].strip())
            new_IPC = float(lines[-1].strip())
            return old_IPC, new_IPC
    except Exception as e:
        print(f"ur beyond cooked")

if __name__ == "__main__":
    #   Initial Variables (Do not change)
    old_rob_depth = 8
    new_rob_depth = 4
    rob_depth_done = False
    rob_counter = 0

    old_iqueue_depth = 64
    new_iqueue_depth = 32
    iqueue_depth_done = False
    iqueue_counter = 0

    old_squeue_depth = 8
    new_squeue_depth = 16
    squeue_depth_done = False
    squeue_counter = 0

    with open("vcs/simulation.log", 'w') as file:
        pass
        
    print(f"starting rob_depth optimzation")
    run_make_command()
    parse_simulation_log()

    while not rob_depth_done:
        modify_rob_depth(old_rob_depth, new_rob_depth)
        run_make_command()
        parse_simulation_log()
        old_IPC, new_IPC = get_ipc_values()
        
        if new_IPC > old_IPC:
            if(new_rob_depth > old_rob_depth):
                old_rob_depth = old_rob_depth * 2
                new_rob_depth = new_rob_depth * 2
            else:
                old_rob_depth = old_rob_depth // 2
                new_rob_depth = new_rob_depth // 2
            if(new_rob_depth == 1):
                new_rob_depth = new_rob_depth * 2
                modify_rob_depth(old_rob_depth, new_rob_depth)
                rob_depth_done = True
            elif(new_rob_depth == 32):
                new_rob_depth = new_rob_depth // 2
                modify_rob_depth(old_rob_depth, new_rob_depth)
                rob_depth_done = True
            rob_counter += 1
        elif new_IPC < old_IPC and rob_counter == 0:
            old_rob_depth = old_rob_depth
            new_rob_depth = new_rob_depth * 4
            rob_counter += 1
        elif new_IPC < old_IPC and rob_counter != 0:
            if(old_rob_depth > new_rob_depth):
                new_rob_depth = old_rob_depth
                modify_rob_depth(old_rob_depth, new_rob_depth)
                rob_depth_done = True
            if(old_rob_depth < new_rob_depth):
                new_rob_depth = old_rob_depth
                modify_rob_depth(old_rob_depth, new_rob_depth)
                rob_depth_done = True
            rob_counter += 1
        else:
            if(new_rob_depth > old_rob_depth):
                new_rob_depth = old_rob_depth
                modify_rob_depth(old_rob_depth, new_rob_depth)
            rob_depth_done = True
    with open("vcs/simulation.log", 'w') as file:
        pass
    print(f"done with rob_depth optimzation")

    print(f"starting iqueue_depth optimzation")
    run_make_command()
    parse_simulation_log()

    while not iqueue_depth_done:
        print(f"old: ",old_iqueue_depth)
        print(f"new: ",new_iqueue_depth)
        modify_iqueue_depth(old_iqueue_depth, new_iqueue_depth)
        run_make_command()
        parse_simulation_log()
        old_IPC, new_IPC = get_ipc_values()
        
        if new_IPC > old_IPC:
            if(new_iqueue_depth > old_iqueue_depth):
                old_iqueue_depth = old_iqueue_depth * 2
                new_iqueue_depth = new_iqueue_depth * 2
            else:
                old_iqueue_depth = old_iqueue_depth // 2
                new_iqueue_depth = new_iqueue_depth // 2
            if(new_iqueue_depth == 4):
                new_iqueue_depth = new_iqueue_depth * 2
                modify_iqueue_depth(old_iqueue_depth, new_iqueue_depth)
                iqueue_depth_done = True
            elif(new_iqueue_depth == 256):
                new_iqueue_depth = new_iqueue_depth // 2
                modify_iqueue_depth(old_iqueue_depth, new_iqueue_depth)
                iqueue_depth_done = True
            iqueue_counter += 1
        elif new_IPC < old_IPC and iqueue_counter == 0:
            old_iqueue_depth = old_iqueue_depth
            new_iqueue_depth = new_iqueue_depth * 4
            iqueue_counter += 1
        elif new_IPC < old_IPC and iqueue_counter != 0:
            if(old_iqueue_depth > new_iqueue_depth):
                new_iqueue_depth = old_iqueue_depth
                modify_iqueue_depth(old_iqueue_depth, new_iqueue_depth)
                iqueue_depth_done = True
            if(old_iqueue_depth < new_iqueue_depth):
                new_iqueue_depth = old_iqueue_depth
                modify_iqueue_depth(old_iqueue_depth, new_iqueue_depth)
                iqueue_depth_done = True
            iqueue_counter += 1
        else:
            if(new_iqueue_depth > old_iqueue_depth):
                new_iqueue_depth = old_iqueue_depth
                modify_iqueue_depth(old_iqueue_depth, new_iqueue_depth)
            iqueue_depth_done = True
    with open("vcs/simulation.log", 'w') as file:
        pass
    print(f"done with iqueue_depth optimzation")

    print(f"starting squeue_depth optimzation")
    run_make_command()
    parse_simulation_log()

    while not squeue_depth_done:
        modify_squeue_depth(old_squeue_depth, new_squeue_depth)
        run_make_command()
        parse_simulation_log()
        old_IPC, new_IPC = get_ipc_values()
        
        if new_IPC > old_IPC:
            if(new_squeue_depth > old_squeue_depth):
                old_squeue_depth = old_squeue_depth * 2
                new_squeue_depth = new_squeue_depth * 2
            else:
                old_squeue_depth = old_squeue_depth // 2
                new_squeue_depth = new_squeue_depth // 2
            if(new_squeue_depth == 1):
                new_squeue_depth = new_squeue_depth * 2
                modify_squeue_depth(old_squeue_depth, new_squeue_depth)
                squeue_depth_done = True
            elif(new_squeue_depth == 32):
                new_squeue_depth = new_squeue_depth // 2
                modify_squeue_depth(old_squeue_depth, new_squeue_depth)
                squeue_depth_done = True
            squeue_counter += 1
        elif new_IPC < old_IPC and squeue_counter == 0:
            old_squeue_depth = old_squeue_depth
            new_squeue_depth = new_squeue_depth * 4
            squeue_counter += 1
        elif new_IPC < old_IPC and squeue_counter != 0:
            if(old_squeue_depth > new_squeue_depth):
                new_squeue_depth = old_squeue_depth
                modify_squeue_depth(old_squeue_depth, new_squeue_depth)
                squeue_depth_done = True
            if(old_squeue_depth < new_squeue_depth):
                new_squeue_depth = old_squeue_depth
                modify_squeue_depth(old_squeue_depth, new_squeue_depth)
                squeue_depth_done = True
            squeue_counter += 1
        else:
            if(new_squeue_depth > old_squeue_depth):
                new_squeue_depth = old_squeue_depth
                modify_squeue_depth(old_squeue_depth, new_squeue_depth)
            squeue_depth_done = True
    with open("vcs/simulation.log", 'w') as file:
        pass
    print(f"done with squeue_depth optimzation")

    print(f"Optimized ROB_DEPTH: {new_rob_depth}")
    print(f"Optimized IQUEUE_DEPTH: {new_iqueue_depth}")
    print(f"Optimized SQUEUE_DEPTH: {new_squeue_depth}")
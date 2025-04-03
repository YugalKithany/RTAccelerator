#!/usr/bin/env python3

import json
import subprocess
import os

clock_values = [2500, 2600, 2700]
options_file = "options.json"
synth_dir = "synth"
area_script = "get_area.sh"
slack_script = "get_slack.sh"
results_file = "results.csv"

with open(options_file, 'r') as f:
    original_options = json.load(f)

try:
    if not os.path.exists(results_file):
        with open(results_file, 'w') as rf:
            rf.write("Clock(ps),Total Cell Area,Slack\n")

    for clk in clock_values:
        updated_options = original_options.copy()
        updated_options["clock"] = clk
        with open(options_file, 'w') as f:
            json.dump(updated_options, f, indent=4)

        try:
            subprocess.check_call(["make"], cwd=synth_dir)
            try:
                area_output = subprocess.check_output(["bash", area_script], cwd=synth_dir, universal_newlines=True).strip()

            except subprocess.CalledProcessError as e:
                print("Err")
                area_output = "N/A"

            try:
                slack_output = subprocess.check_output(["bash", slack_script], cwd=synth_dir, universal_newlines=True).strip()

            except subprocess.CalledProcessError as e:
                print("Err")
                slack_output = "N/A"

            with open(results_file, 'a') as rf:
                rf.write(f"{clk},{area_output},{slack_output}\n")

            print(f"Clock: {clk} ps, Total Cell Area: {area_output}, Slack: {slack_output}")
        except subprocess.CalledProcessError as e:
            print("synth failed")

finally:
    with open(options_file, 'w') as f:
        json.dump(original_options, f, indent=4)


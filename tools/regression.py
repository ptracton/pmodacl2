#! /usr/bin/env python3

"""
regression.py

Run all simulations and report results

"""

import argparse
import glob
import json
import os
import re
import shlex
import subprocess
import sys


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description='Run FPGA Regression')
    parser.add_argument("-D", "--debug",
                        help="Debug this script",
                        action="store_true")
    parser.add_argument("--icarus",
                        help="Use Icarus Verilog",
                        action="store_true")
    parser.add_argument("--ncverilog",
                        help="Use NCVerilog",
                        action="store_true")
    parser.add_argument("--xsim",
                        help="Use Xilinx Vivado XSim",
                        action="store_true")
    parser.add_argument("--report_only",
                        help="Generate Results without running tests",
                        action="store_true")

    args = parser.parse_args()
    if args.debug:
        print(os.environ['PATH'])
        print(args)

    simTool = ""
    if args.icarus:
        json_file = "../configurations/simulate_iverilog.json"
        simTool = "--icarus"
    if args.ncverilog:
        json_file = "../configurations/simulate_ncverilog.json"
        simTool = "--ncverilog"
    if args.xsim:
        json_file = "../configurations/simulate_xsim.json"
        simTool = "--xsim"

    try:
        f = open(json_file, "r")
        json_data = json.load(f)
    except:
        print("Failed to open %s" % (json_file))
        sys.exit(-1)        

    test_cases = glob.glob("*.v")
    if args.debug:
        print (test_cases)
    number_of_tests = len(test_cases)

    for test in test_cases:
        print("Running Test %s" % test)
        executable = "../tools/run_sim.py"        
        command = executable + " " + simTool + " --simulation "+ test
        if args.report_only is False:
            if args.debug:
                print (command)
                
            command = shlex.split(command)
            p = subprocess.Popen(command)
            p.communicate()

    log_files = glob.glob("*.log")
    tests_passed_list = []
    tests_failed_list = []
    #print (log_files)
    for log in log_files:
        f = open(log, 'r')
        lines = f.readlines()
        f.close()
        for line in lines:
            test_passed = re.search('TEST PASSED', line)
            if test_passed:
                #print ("%s: %s" % (log, line))
                tests_passed_list.append(log)                
            test_failed = re.search('TEST FAILED', line)
            if test_failed:
                #print ("%s: %s" % (log, line))
                tests_failed_list.append(log)
            
    print ("\n\nTests Failed %d" % len(tests_failed_list))
    for test in tests_failed_list:
        test_str = test.split('.')
        print (test_str[0])
        
    print ("\n\nTests Passed %d" % len(tests_passed_list))
    for test in tests_passed_list:
        test_str = test.split('.')
        print (test_str[0])

    percent_failed = float(len(tests_failed_list)/len(test_cases))*100
    print ("\n\nFAILED %f" % percent_failed)
        
    percent_passed = float(len(tests_passed_list)/len(test_cases))*100
    print ("PASSED %f" % percent_passed)

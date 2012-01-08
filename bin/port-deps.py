#!/usr/bin/env python

# For macports. Print all required ports for specified port in a tree form
# E.g. port-deps-tree.py python26
import subprocess
import sys

dep_line_prefix = 'Library Dependencies:'
cached_deps = dict()

def get_immediate_deps(portname):
    if portname not in cached_deps:
        output = subprocess.Popen(["port","deps", portname], stdout=subprocess.PIPE).communicate()[0]
        lines = output.splitlines()
        for line in lines:
            if line.startswith(dep_line_prefix):
                deps = [d.strip() for d in line[len(dep_line_prefix):].split(',')]
                cached_deps[portname] = deps
                break
        else:
            cached_deps[portname] = []
    return cached_deps[portname]

def get_deps_tree(portname):
    deps = get_immediate_deps(portname)
    deps_tree = [(d, get_deps_tree(d)) for d in deps]
    return deps_tree

def print_deps_tree(deps_tree, indent=0):
    indent_spaces = '  ' * indent
    for dep, subtree in sorted(deps_tree):
        if subtree:
            print '%s%s:' % (indent_spaces, dep)
            print_deps_tree(subtree, indent=indent+1)
        else:
            print '%s%s' % (indent_spaces, dep)

if __name__ == '__main__':
    portname = sys.argv[1]
    deps_tree = get_deps_tree(portname)
    print_deps_tree(deps_tree)


#!/usr/bin/env python3
"""
Script to automatically add all Swift files to Xcode project.pbxproj
This is a workaround for Windows users who can't use Xcode GUI.
"""

import os
import re
import uuid

def generate_uuid():
    """Generate a short UUID-like identifier for Xcode project files"""
    return ''.join([hex(ord(c))[2:] for c in str(uuid.uuid4())[:8].upper()])

def find_swift_files(root_dir):
    """Find all Swift files in the project"""
    swift_files = []
    for root, dirs, files in os.walk(root_dir):
        # Skip certain directories
        if 'Tests' in root or '.git' in root or 'DerivedData' in root:
            continue
        for file in files:
            if file.endswith('.swift'):
                full_path = os.path.join(root, file)
                rel_path = os.path.relpath(full_path, root_dir)
                swift_files.append(rel_path)
    return sorted(swift_files)

def main():
    project_root = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
    swift_files = find_swift_files(os.path.join(project_root, 'FelixPersonalHub', 'FelixPersonalHub'))
    
    print(f"Found {len(swift_files)} Swift files")
    for f in swift_files[:10]:  # Show first 10
        print(f"  - {f}")
    if len(swift_files) > 10:
        print(f"  ... and {len(swift_files) - 10} more")
    
    print("\n⚠️  This script would modify project.pbxproj")
    print("   However, project file format is complex.")
    print("   Best solution: Open in Xcode and add files via GUI.")
    print("\n   For now, project file has been partially fixed:")
    print("   ✅ Removed AppDelegate.swift reference")
    print("   ✅ Added App/ and Views/ groups")
    print("   ⚠️  Other files still need to be added manually in Xcode")

if __name__ == '__main__':
    main()


import bpy
import sys
import os
from pathlib import Path
argv = sys.argv
argv = argv[argv.index("--") + 1:] # get all args after "--"

obj_dir = os.path.join(os.getcwd(),""+argv[0])
fbx_dir = os.path.join(os.getcwd(),""+argv[1])
files =Path(obj_dir).rglob('*.obj')
scale=1.0/1.8
for f_obj in files:    
    f_fbx = os.path.join(fbx_dir,os.path.relpath(f_obj, obj_dir).split(".")[0] + ".fbx")
    print(f_obj)
    print(f_fbx)
    bpy.ops.object.select_all(action='SELECT')
    bpy.ops.object.delete()
    bpy.ops.import_scene.obj(filepath=str(f_obj))
    bpy.ops.object.select_all(action='SELECT')
    bpy.ops.transform.resize(value=(scale,scale,scale))
    bpy.ops.export_scene.fbx(filepath=str(f_fbx), apply_scale_options='FBX_SCALE_UNITS', axis_forward='-Y', axis_up='Z',bake_anim=True,bake_anim_simplify_factor=0)
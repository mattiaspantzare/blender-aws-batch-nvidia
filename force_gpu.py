import bpy

scene = bpy.context.scene
scene.cycles.device = 'GPU'

prefs = bpy.context.preferences
cprefs = prefs.addons['cycles'].preferences

# Attempt to set GPU device types if available
for compute_device_type in ('CUDA', 'OPENCL', 'NONE'):
    try:
        cprefs.compute_device_type = compute_device_type
        break
    except TypeError:
        pass

bpy.context.preferences.addons['cycles'].preferences.get_devices()

# Enable all CPU and GPU devices
for device in cprefs.devices:
    device.use = True


bpy.ops.wm.save_userpref()

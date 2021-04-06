from pyfbsdk import *
import os
###############################################################
# I declare this code is done by myself without help from others.
# YOUR NAME AND CCID
# Name: Cao, Chenlin; CCID: chenlin
# References: 
# 1. Python API for Motion Builder:
# http://help.autodesk.com/view/MOBPRO/2018/ENU/?guid=__py_ref_index_html
# 2. The lab4.py file provided on eclass
###############################################################
# Helper Function(s).                                         #
###############################################################

# Create a spotlight positioned at pTranslation, which will
# shine light on pModel with Intensity=100, ConeAngle=60, FogIntensity = 20
def createSpotlight(pTranslation, pModel):
    light = FBLight('myLight')
    light.LightType = FBLightType.kFBLightTypeSpot
    light.Show = True
    #########################
    #####Your Code Here######
    #########################
    light.Intensity = 500
    light.ConeAngle = 60
    light.FogIntensity = 20

    light.Translation = pTranslation
    light.LookAt = pModel
    return light

# Create a large plane with scaling x=5, y-0, z=5
def createPlane():
    plane = FBModelPlane('myPlane')
    plane.Translation = FBVector3d(0, 1, 0)
    #########################
    #####Your Code Here######
    #########################
    plane.Scaling = FBVector3d(5,0,5)

    plane.Show = True
    return plane

# Create a cylinder.
#########################
#####Your Code Here######
#########################
def createCylinder():
    cylinder = FBCreateObject('Browsing/Templates/Elements/Primitives','Cylinder','Cylinder')
    cylinder.Name = 'myCylinder'
    cylinder.Scaling = FBVector3d(2, 2, 2)
    cylinder.Translation = FBVector3d(0, 30, 100)
    cylinder.Show = True
    return cylinder


# Create a Sphere
def createSphere():
    sphere = FBCreateObject('Browsing/Templates/Elements/Primitives','Sphere','Sphere')
    sphere.Name = 'mySphere'
    sphere.Scaling = FBVector3d(2, 2, 2)
    sphere.Translation = FBVector3d(0,30,0)
    sphere.Show= True
    return sphere

# Create a Cone
#########################
#####Your Code Here######
#########################
def createCone():
    cone = FBCreateObject('Browsing/Templates/Elements/Primitives','Cone','Cone')
    cone.Name = 'myCone'
    cone.Scaling = FBVector3d(2, 2, 2)
    cone.Translation = FBVector3d(100, 30, 0)
    cone.Show = True
    return cone

# Create a Cube
#########################
#####Your Code Here######
#########################
def createCube():
    cube = FBCreateObject('Browsing/Templates/Elements/Primitives','Cube','Cube')
    cube.Name = 'myCube'
    cube.Scaling = FBVector3d(1, 1, 1)
    cube.Translation = FBVector3d(-100, 30, 0)
    cube.Show = True
    return cube

# Create a Torus
#########################
#####Your Code Here######
#########################
def createTorus():
    torus = FBCreateObject('Browsing/Templates/Elements/Primitives','Torus','Torus')
    torus.Name = 'myTorus'
    torus.Scaling = FBVector3d(2, 2, 2)
    torus.Translation = FBVector3d(0, 30, -100)
    torus.Show = True
    return torus

def createMaterial1():
    material = FBMaterial('myMaterial1')
    material.Diffuse = FBColor(34,139,34)
    return material

# Create 4 arbitrary colors material.
def createMaterial2():
#########################
#####Your Code Here######
#########################
    material = FBMaterial('myMaterial2')
    material.Diffuse = FBColor(255,0,0)
    return material

def createMaterial3():
#########################
#####Your Code Here######
#########################
    material = FBMaterial('myMaterial3')
    material.Diffuse = FBColor(0,255,0)
    return material


def createMaterial4():
#########################
#####Your Code Here######
#########################
    material = FBMaterial('myMaterial4')
    material.Diffuse = FBColor(0,0,255)
    return material

def createMaterial5():
#########################
#####Your Code Here######
#########################
    material = FBMaterial('myMaterial5')
    material.Diffuse = FBColor(255,255,0)
    return material

# Create a live shadow shader. This shader projects the shadow of an occluding
# object onto a surface.
def createLiveShadowShader():
    #####Your Code Here######
    shader = FBShaderShadowLive('My Live Shadow Shader')
    return shader

# Create a dynamic lighting shader. This shader projects light dynamically
# onto surfaces.
def createDynamicLightingShader():
    #####Your Code Here######
    shader = FBCreateObject('Browsing/Templates/Shading Elements/Shaders','Dynamic Lighting','Dynamic Lighting')
    print("dy: ", shader)
    return shader

# Create a layered texture, assign it to the diffuse channel
# of a material, and apply the material to the model.
def applyTextureToModel(pTextureFullPath, pModel):
    # Create a texture and set its mapping type.
    texture = FBTexture(pTextureFullPath)
    texture.Mapping = FBTextureMapping.kFBTextureMappingXY

    # Associate the new texture to the diffuse channel of a new material.
    material = FBMaterial('myMaterial')
    material.SetTexture(texture, FBMaterialTextureType.kFBMaterialTextureDiffuse)

    # Append the material to the model's list of materials.
    pModel.Materials.append(material)

#Do not modify
# List of keys to be used later in the applyKeys1()
# and applyKeys2() functions.
keyList = [
    #(time: FBTime  ,  coords: [x,y,z] coordinate list)
    (FBTime(0, 0, 0),  [0, 400, -400]),
    (FBTime(0, 0, 1),  [400, 400, 0]),
    (FBTime(0, 0, 2),  [0, 400, 400]),
    (FBTime(0, 0, 3),  [-400, 400, 0]),
    (FBTime(0, 0, 4),  [0, 400, -400])
]

###############################################################
# Helper Function(s).                                         #
###############################################################

# Create a model to look at.
def createModel():
    model = FBCreateObject( 'Browsing/Templates/Elements/Primitives', 'Torus', 'Torus' )
    model.Name = 'myModel'
    model.Translation = FBVector3d(0, 75, 0)
    model.Scaling = FBVector3d(2, 2, 2)
    model.Rotation = FBVector3d(90, 0, 0)
    model.Show = True
    return model

# Create a camera looking at the model.
def createCamera(pModel):
    camera = FBCamera('myCamera')
    camera.Interest = pModel
    camera.Translation = FBVector3d(0,500,0)
    camera.Show = True

    # Enable motion blurring for the camera.
    camera.PropertyList.Find('UseMotionBlur').Data = True
    camera.PropertyList.Find('UseRealTimeMotionBlur').Data = True
    camera.PropertyList.Find('Motion Blur Intensity').Data = 1

    # Enable camera switching.
    FBSystem().Scene.Renderer.UseCameraSwitcher = True

    # Set our view to the newly created camera.
    cameraSwitcher = FBCameraSwitcher()
    cameraSwitcher.CurrentCamera = camera

    return camera

# First method of applying keys to an animation node.
# Here, we add keys directly to the translation animation node.
def applyKeys1(pTranslationAnimNode):
    # keyList is defined at the top of this file.
    global keyList

    for time, coords in keyList:
        # time format: FBTime(<hour>, <minute>, <second>)
        # coords format: [<x>, <y>, <z>]
        FBPlayerControl().Goto(time)              # set the player control's time.
        pTranslationAnimNode.SetCandidate(coords) # set the candidate at the player control's current time.
        pTranslationAnimNode.KeyCandidate()       # apply the candidate.

# Get the parent's child animation node with the given name.
def getChildNode(pParentNode, pChildName):
    for node in pParentNode.Nodes:
        if node.Name == pChildName:
            return node
    return None

# Second method of applying keys to an animation node.
# Here, we are working with the X, Y, and Z child nodes of the translation node.
def applyKeys2(pTranslationAnimNode):
    # keyList is defined at the top of this file.
    global keyList

    # Obtain the FCurves for each X, Y, Z element of the translation vector.
    # We use the helper function getChildNode() defined above to get the animation
    # nodes for these X, Y, Z elements.
    xAnimNode = getChildNode(pTranslationAnimNode, 'X')
    yAnimNode = getChildNode(pTranslationAnimNode, 'Y')
    zAnimNode = getChildNode(pTranslationAnimNode, 'Z')
    xFCurve = xAnimNode.FCurve
    yFCurve = yAnimNode.FCurve
    zFCurve = zAnimNode.FCurve

    # Apply the keys to each FCurve using cubic interpolation.
    interpolation = FBInterpolation.kFBInterpolationCubic
    for time, coords in keyList:
        # key the x coordinate (coords[0]) at the given time along the X FCurve.
        xKeyIndex = xFCurve.KeyAdd(time, coords[0])
        xKey = xFCurve.Keys[xKeyIndex]
        xKey.Interpolation = interpolation

        # key the y coordinate (coords[1]) at the given time along the Y FCurve.
        yKeyIndex = yFCurve.KeyAdd(time, coords[1])
        yKey = yFCurve.Keys[yKeyIndex]
        yKey.Interpolation = interpolation

        # key the z coordinate (coords[2]) at the given time along the Z FCurve.
        zKeyIndex = zFCurve.KeyAdd(time, coords[2])
        zKey = zFCurve.Keys[zKeyIndex]
        zKey.Interpolation = interpolation

# Create a circling animation for the camera.
def applyAnimationToCamera(pCamera):
    # (!) IMPORTANT: Properties are not animatable by default.
    #     you must explicitly call SetAnimated(True) to initialize
    #     the animation nodes for animatable properties.
    pCamera.Translation.SetAnimated(True)
    translationAnimNode = pCamera.Translation.GetAnimationNode()

    # Set the useApplyKeys1 variable below to False to use a different keying method.
    useApplyKeys1 = True
    #useApplyKeys1 = False

    if useApplyKeys1 == True:
        # Add keys to the translation animation node directly.
        applyKeys1(translationAnimNode)
    else:
        # Add keys to the FCurves of the X, Y, Z elements in the
        # translation animation node.
        applyKeys2(translationAnimNode)


###############################################################
###############################################################
# Main.                                                       #
###############################################################

# Clear the scene.
FBApplication().FileNew()

#############Create a plane and 5 different objects.
plane = createPlane()
#########################
#####Your Code Here######
#########################
cube = createCube()
cylinder = createCylinder()
cone = createCone()
torus = createTorus()
sphere=createSphere()

#############Create color materials to apply to each object.
#########################
#####Your Code Here######
#########################
material1 = createMaterial1()
material2 = createMaterial2()
material3 = createMaterial3()
material4 = createMaterial4()
material5 = createMaterial5()

cube.Materials.append(material3)
cylinder.Materials.append(material5)
cone.Materials.append(material2)
torus.Materials.append(material4)
sphere.Materials.append(material3)

############# Used any texture file ,jpg , .png ######### Optional
myDocuments = os.path.expanduser('~') + '\Documents'
textureFilename = '' ## Add path for any .jpg .png image
textureFullPath = os.path.join(myDocuments, textureFilename)
applyTextureToModel(textureFullPath, plane)

# # Create a spotlight looking at the sphere with translation (-250, 250, -20)
light = createSpotlight(FBVector3d(-250,250,-20), sphere)#####Your Code Here######

# Create the live shadow and dynamic lighting shaders.
#########################
#####Your Code Here######
#########################
liveShadowShader = createLiveShadowShader()
dynamicLightingShader = createDynamicLightingShader()

# Apply the shaders to the plane.
#########################
#####Your Code Here######
#########################
plane.Shaders.append(liveShadowShader)
plane.Shaders.append(dynamicLightingShader)
plane.ShadingMode = FBModelShadingMode.kFBModelShadingDefault

#Apply the dynamic lighting shader to each object.
#########################
#####Your Code Here######
#########################
dynamicLightingShader.Append(cube)
dynamicLightingShader.Append(cylinder)
dynamicLightingShader.Append(cone)
dynamicLightingShader.Append(torus)
dynamicLightingShader.Append(sphere)

# Camera will follow the model object selected
model = sphere
camera = createCamera(model)
applyAnimationToCamera(camera)

# Playback
lPlayer = FBPlayerControl()
lPlayer.LoopStart = FBTime(0,0,0) # Set the start time in the player control.
lPlayer.LoopStop = FBTime(0,0,4)  # Set the end time in the player control.
lPlayer.LoopActive = True         # Enable playback looping.
lPlayer.GotoStart()
lPlayer.Play()

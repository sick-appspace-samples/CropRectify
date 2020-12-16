--[[----------------------------------------------------------------------------

  Application Name:
  CropRectify

  Summary:
  Example of Image.cropRectify

  Description:
  This sample uses a Image.cropRectify to crop and rectify a region of an
  input image. The selected region can be seen overlayed in the original
  image after two seconds the viewer is updated and the resulting image
  is presented. Four test examples are available, and will be show in sequence.

  How to Run:
  Starting this sample is possible either by running the app (F5) or
  debugging (F7+F10). Results can be seen in the viewer on the DevicePage.
  Restarting the Sample may be necessary to show results after loading the webpage.
  To run this Sample a device with SICK Algorithm API and AppEngine >= V2.11.0 is
  required.
  
------------------------------------------------------------------------------]]
--Start of Global Scope---------------------------------------------------------

print('AppEngine Version: ' .. Engine.getVersion())

-- Create a viewer
local v = View.create("viewer2D1")

local shapeDec=View.ShapeDecoration.create()
shapeDec:setLineColor(0, 255, 0, 255)
shapeDec:setLineWidth(6)
--End of Global Scope-----------------------------------------------------------

--Start of Function and Event Scope---------------------------------------------
--@handleOnStarted()
local function handleOnStarted()
  --select the test you want to run
  for test = 1, 4 do
    print("Starting test " .. test)

    --Load images and create crop shapes
    local image
    local shape
    if(test==1) then
      image = Image.load('resources/ivp.bmp')
      shape=Shape.createPolyline({Point.create(1167,793), Point.create(1191,563),
                                  Point.create(1261,567), Point.create(1233,798)}, true)
    elseif(test==2) then
      image = Image.load('resources/ivp.bmp')
      shape=Shape.createRectangle(Point.create(1213.00,680.25), 231, 66, -1.45)
    elseif(test==3) then
      image = Image.load('resources/cards.png')
      shape=Shape.createPolyline({Point.create(878,1060), Point.create(1211,1134),
                                  Point.create(1114,1629), Point.create(768,1553)}, true)
    elseif(test==4) then
      image = Image.load('resources/cards.png')
      shape=Shape.createRectangle(Point.create(994, 1345), 344, 507, 0.205)
    end
    
    -- Perform a crop and rectification
    local croppedAndRectifiedImage, transform = Image.cropRectify(image, shape)
    
    -- Print the transformation
    print(transform:toString())
  
    -- Display the input image
    v:clear()
    v:addImage(image, nil, "imageID")
    v:addShape(shape, shapeDec,"shapeID", "imageID")
    v:present()
    Script.sleep(2000) -- for demonstration purpose only
    
    -- Display the cropped result
    v:clear()
    v:addImage(croppedAndRectifiedImage)
    v:present()
    Script.sleep(2000) -- for demonstration purpose only
  end
  
  print('App finished.')
end
Script.register('Engine.OnStarted', handleOnStarted)

--End of Function and Event Scope--------------------------------------------------

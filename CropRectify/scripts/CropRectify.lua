
--Start of Global Scope---------------------------------------------------------

print('AppEngine Version: ' .. Engine.getVersion())

-- Create a viewer
local v = View.create()

local shapeDec=View.ShapeDecoration.create():setLineColor(0, 255, 0, 255):setLineWidth(6)
--End of Global Scope-----------------------------------------------------------

--Start of Function and Event Scope---------------------------------------------
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
    v:addImage(image)
    v:addShape(shape, shapeDec)
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

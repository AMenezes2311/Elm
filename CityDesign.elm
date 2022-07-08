-- Created by Andre Menezes --
myShapes model =
  [
      background
   
    , rainbow model
        |> move (0, -39)
        |> scale 2
        |> subtract (circle 45 |> ghost |> move (0, -39))
        
    , bottom
    
    , mountain
        |> makeTransparent 0.6
        |> scale 1.5
        
    , balloon
        |> makeTransparent 0.7
        |> move (0, repeatDistance 5 130 -10 model.time)
        |> move (40, 50)
        |> scale 0.7
        
    
    , star
        |> scale 0.1
        |> move (20, 50)
        
    , star
        |> scale 0.1
        |> move (29, 50) 
        
    , star
        |> scale 0.2
        |> move (15, 30)
        
    , star
        |> scale 0.1
        |> move (-28, 50) 
        
        
    , star
        |> scale 0.05
        |> move (-18, 25)
        
    , star
        |> scale 0.05
        |> move (-35, 35) 
        
    , star
        |> scale 0.1
        |> move (-70, 50)
        
    , star
        |> scale 0.1
        |> move (-75, 40) 
       
    , star
        |> scale 0.1
        |> move (25, 30)
        
    , star
        |> scale 0.2
        |> move (-45, 55) 
        
    , star
        |> scale 0.05
        |> move (35, 35)
        
    , star
        |> scale 0.1
        |> move (-70, 20) 
        
    , star
        |> scale 0.1
        |> move (0, 50)
        
    , star
        |> scale 0.1
        |> move (-45, 25) 
        
    , star
        |> scale 0.05
        |> move (10, 70)
        
    , star
        |> scale 0.05
        |> move (20, -25) 
        
    , star
        |> scale 0.1
        |> move (-55, 37)
        
    , star
        |> scale 0.2
        |> move (10, -30) 
        
    , star
        |> scale 0.1
        |> move (40, 55)
        
     , star
        |> scale 0.1
        |> move (15, -10) 
        
    , star
        |> scale 0.1
        |> move (-30, -30)
        
    , star
        |> scale 0.1
        |> move (25, -14) 
        
    , star
        |> scale 0.2
        |> move (-30, -15)
       
    , star
        |> scale 0.05
        |> move (-33, -20)
        
    , buildingRec
        |> move (-75, -40)
        |> scale 0.6
        |> makeTransparent 0.7
        
    , buildingRec
        |> makeTransparent 0.9
        |> scale 0.7
        |> move (0, -22.5)
        
    , buildingCircle
        |> makeTransparent 0.9
        |> scale 0.7
        |> move (25, -22.5)
        
    ,buildingRec
        |> makeTransparent 0.9
        |> scale 0.7
        |> move (55, -22.5)
        
    ,buildingTriangle
        |> makeTransparent 0.9
        |> scale 0.9
        |> move (-35, -16)
        
    ,house
        |> makeTransparent 0.9
        |> scale 0.5
        |> move (78, -31)
    
    , buildingRec
        |> move (-94, -12)
        
    , buildingTriangle
        |> move (60, -12)
        
    , buildingTriangle
        |> move (-55, -12)
       
    , buildingTriangle
        |> move (13, -12)
        
    , buildingRec
        |> move (-40, -12)
        
    , shop
        |> move (35, -35)
        
    , house
        |> scale 0.4
        |> move (-88, -34)
        
    , buildingRec
        |> move (94, -12)
        
    , rainbow model
        |> move (0, -39)
        |> scale 2
        |> subtract (circle 45 |> ghost |> move (0, -39))
        
    , bottom
        
    , buildingRec
        |> move (70, -12)
        
    , moon
        |> move (-75, 45)
        |> subtract (circle 10 |> ghost |> move (-65, 45))
        
        
    , buildingCircle
        |> move (-17, -12)
        
    , ringPlanet
        |> scale 0.3
        |> move (75, 50)
        
    , star
        |> scale 0.1
        |> move (20, 50), star
        |> scale 0.1
        |> move (20, 50)        
           
    , light 
        |> rotate (degrees 195)
        |> move (55, 10)
        |> makeTransparent (0.9)
        
    , buildingRec
        |> move (75, -32)
        |> scale 0.7
        
    , buildingRec
        |> move (-75, -32)
        |> scale 0.7
        
        
    , buildingCircle
        |> move (-70, -12)
        
    , light
         |> makeTransparent 0.9
         |> rotate (degrees -30)
         |> move (-97, 50)
         
    , light
         |> makeTransparent 0.7
         |> rotate (degrees -65)
         |> move (-40, 87)
        
    , lettering
       
    , pacman model
    
    , alien 
         |>  scale 0.5
         --move(x, y)
         --model.time -> increase speed (*), decrease (/)
         -- move(repeasteDistance speed finishPos startingPos time, y)
         |> move (repeatDistance 10 130 -10 (model.time), -55)
         
    , food model
        |> move (repeatDistance 15 130 10 model.time, -55)
          
    , ufo
        |> move (10 * tan(model.time), 0)
        |> scale 0.3
        |> move (-50, 50)
    
    , alien
        |> scale 0.7
        |> move (0, 10)
        |> move (10 * tan(model.time), 0)
        |> scale 0.3
        |> move (-50, 50)
        
    , glass
        |> move (10 * tan(model.time), 0)
        |> scale 0.3
        |> move (-50, 50)
        
    , human
        |> move (-50, 0)
        |> move (3 * cos(model.time), repeatDistance 10 30 5 model.time)

      
  ]
  
food model = group
  [
     circle 2
       |> filled yellow
      
   , circle 2
       |> filled yellow
       |> move (10, 0)
       
   , circle 2
       |> filled yellow
       |> move (20, 0)
       
   , circle 2
       |> filled yellow
       |> move (30, 0)
  ]
  
pacman model = group
  [
    wedge 10 0.75
      |> filled yellow
      |> rotate (degrees -180)
      |> scale 0.7
      |> move (repeatDistance 15 130 -30 model.time, -55)
      
      
  ]
  
shop = group
  [
     square 25
      |> outlined (solid 0.5) white
      
   , square 25
      |> filled black
      
   , triangle 14
      |> filled black
      |> rotate (degrees -30)
      |> move (0, 19.5)
      
   , triangle 14
      |> outlined (solid 0.5) white
      |> rotate (degrees -30)
      |> move (0, 19.5)
      
   , rect 8 8
      |> filled grey
      |> move (0, -8.5)
        
   , rect 14 11
      |> filled grey
      |> move (0, 4)
        
    ,text "|"
      |> filled black
      |> scale 0.5
      |> scaleY 1.9
      |> move (-0.5, -12)
       
  ]
  
lettering = group
  [
    rect 5 25
      |> filled white
      |> move (-87, -40)
      
   ,rect 5 25
      |> filled white
      |> move (-43, -40)
      
   ,rect 50 20
      |> outlined (solid 2) purple
      |> move (-65, -30)
      
   ,rect 50 20
      |> filled white
      |> move (-65, -30)
      
   ,text "|DEKA|"
      |> filled darkPurple    
      |> move (-84, -34)
  ]
  
mountain = group
  [
    triangle 50
      |> filled black
      |> rotate (degrees -30)
      |> move (0, -22)
  ]
  
background = group
  [
   rect 200 200
    |> filled
       (gradient
           [stop (rgba 130 14 231 1) 0
           , stop(rgba 130 14 231 0.9) 10
           , stop(rgba 130 14 231 0.8) 20
           , stop(rgba 130 14 231 0.7) 30
           , stop(rgba 130 14 231 0.6) 40
           , stop(rgba 130 14 231 0.5) 50
           , stop(rgba 130 14 231 0.4) 60
           , stop(rgba 130 14 231 0.3) 70
           , stop(rgba 130 14 231 0.2) 80
           , stop(rgba 130 14 231 0.1) 90
           , stop black 100])
             
     |> rotate (degrees -90) 
  ]
  
bottom = group
  [
    rect 20 200
      |> filled black
      |> rotate (degrees 90)
      |> move (0, -57)
  ]
  
buildingCircle = group
  [
     curve (30,0) [Pull (15,26) (0,0) ]
      |> filled black
      |> move (-15, 77.7)
      |> scale 0.45
      
    ,rect 20 100
      |> filled black
      |> scale 0.7
      
    , circle 2
        |> filled (rgba 252 255 102 1)
        |> move (3, 30)
     
    , circle 2
        |> filled (rgba 252 255 102 1)
        |> move (-3, 25)
      
    , circle 2
        |> filled (rgba 252 255 102 1)
        |> move (3, 20)
     
    , circle 2
        |> filled (rgba 252 255 102 1)
        |> move (-3, 20)
     
    , circle 2
        |> filled (rgba 252 255 102 1)
        |> move (-3, 15)
    
    , circle 2
        |> filled (rgba 252 255 102 1)
        |> move (3, 10)
    
    , circle 2
        |> filled (rgba 252 255 102 1)
        |> move (3, 5)
     
    , circle 2
        |> filled (rgba 252 255 102 1)
        |> move (-3, 5)
     
    , circle 2
        |> filled (rgba 252 255 102 1)
        |> move (-3, 0)
        
    , circle 2
        |> filled (rgba 252 255 102 1)
        |> move (3, -5)
        
    , circle 2
        |> filled (rgba 252 255 102 1)
        |> move (3, -10)
     
    , circle 2
        |> filled (rgba 252 255 102 1)
        |> move (-3, -10)
        
    , circle 2
        |> filled (rgba 252 255 102 1)
        |> move (3, -15)
     
    , circle 2
        |> filled (rgba 252 255 102 1)
        |> move (-3, -20)   
       
    , rect 4 8
        |> filled grey
        |> move (0, -31)
        
    ,text "|"
        |> filled black
        |> scale 0.5
        |> scaleY 1.9
        |> move (-0.5, -35)
        
  ]
  
buildingRec = group
  [ 
     rect 20 100
      |> filled black
      |> scale 0.7
      
    ,rect 10 10
      |> filled black
      |> scale 0.8
      |> move (0, 38.8)
      
    ,rect 5 5
      |> filled black
      |> move (0, 45)
      
    ,rect 3 3
      |> filled black
      |> move (0, 49)
      
    , square 3
        |> filled (rgba 252 255 102 1)
        |> move (3, 30)
     
    , square 3
        |> filled (rgba 252 255 102 1)
        |> move (-3, 25)
      
    , square 3
        |> filled (rgba 252 255 102 1)
        |> move (3, 20)
     
    , square 3
        |> filled (rgba 252 255 102 1)
        |> move (-3, 20)
     
    , square 3
        |> filled (rgba 252 255 102 1)
        |> move (-3, 15)
    
    , square 3
        |> filled (rgba 252 255 102 1)
        |> move (3, 10)
    
    , square 3
        |> filled (rgba 252 255 102 1)
        |> move (3, 5)
     
    , square 3
        |> filled (rgba 252 255 102 1)
        |> move (-3, 5)
     
    , square 3
        |> filled (rgba 252 255 102 1)
        |> move (-3, 0)
        
    , square 3
        |> filled (rgba 252 255 102 1)
        |> move (3, -5)
        
    , square 3
        |> filled (rgba 252 255 102 1)
        |> move (3, -10)
     
    , square 3
        |> filled (rgba 252 255 102 1)
        |> move (-3, -10)
        
    , square 3
        |> filled (rgba 252 255 102 1)
        |> move (3, -15)
     
    , square 3
        |> filled (rgba 252 255 102 1)
        |> move (-3, -20)   
       
    , rect 4 8
        |> filled grey
        |> move (0, -31)
        
    ,text "|"
        |> filled black
        |> scale 0.5
        |> scaleY 1.9
        |> move (-0.5, -35)
  ]
  
buildingTriangle = group
  [ 
     rect 20 100
      |> filled black
      |> scale 0.7
      
    , polygon [(0,0),(0,-10),(30,0)]
        |> filled black
        |> rotate (degrees -180)
        |> move (14, 76)
        |> scale 0.45
      
    , triangle 2
        |> filled (rgba 252 255 102 1)
        |> move (3, 30)
     
    , triangle 2
        |> filled (rgba 252 255 102 1)
        |> move (-3, 25)
      
    , triangle 2
        |> filled (rgba 252 255 102 1)
        |> move (3, 20)
     
    , triangle 2
        |> filled (rgba 252 255 102 1)
        |> move (-3, 20)
     
    , triangle 2
        |> filled (rgba 252 255 102 1)
        |> move (-3, 15)
    
    , triangle 2
        |> filled (rgba 252 255 102 1)
        |> move (3, 10)
    
    , triangle 2
        |> filled (rgba 252 255 102 1)
        |> move (3, 5)
     
    , triangle 2
        |> filled (rgba 252 255 102 1)
        |> move (-3, 5)
     
    , triangle 2
        |> filled (rgba 252 255 102 1)
        |> move (-3, 0)
        
    , triangle 2
        |> filled (rgba 252 255 102 1)
        |> move (3, -5)
        
    , triangle 2
        |> filled (rgba 252 255 102 1)
        |> move (3, -10)
     
    , triangle 2
        |> filled (rgba 252 255 102 1)
        |> move (-3, -10)
        
    , triangle 2
        |> filled (rgba 252 255 102 1)
        |> move (3, -15)
     
    , triangle 2
        |> filled (rgba 252 255 102 1)
        |> move (-3, -20)   
       
    , rect 4 8
        |> filled grey
        |> move (0, -31)
        
    , text "|"
        |> filled black
        |> scale 0.5
        |> scaleY 1.9
        |> move (-0.5, -35)
  ]
  
ringPlanet = group
  [
     circle 20
        |> filled
       (gradient
           [ stop (rgb 202 255 0) 0
           , stop (rgb 0 255 165) 20
           , stop (rgb 0 186 255) 50])
       |> rotate (degrees 105)
      
    , oval 10 100
      |> outlined (solid 3) white
      |> rotate (degrees 105)
      
    , wedge 20 0.5
       |> filled
       (gradient
           [ stop (rgb 202 255 0) 0
           , stop (rgb 0 255 165) 20
           , stop (rgb 0 186 255) 50 ])
       |> rotate (degrees 105)
      
  ] 
star = group
  [
    triangle 10
      |> filled white
      |> rotate (degrees 30)
      
  , triangle 10
      |> filled white
      |> rotate (degrees -30)
      |> move(0, 10)
      
   , triangle 10
      |> filled white
      |> rotate (degrees -60)
      |> move(-5, 5)
      
   , triangle 10
      |> filled white
      |> rotate (degrees 0)
      |> move(5, 5)
  ]
  
moon = group
  [
     circle 7
       |> filled (rgba 240 240 240 1)
      
   , circle 1
       |> filled (rgba 230 230 230 0.8)
       |> move (-4, -4)
       
   , circle 1
       |> filled (rgba 230 230 230 0.8)
       |> move (5, -3)
       
   , circle 1
       |> filled (rgba 230 230 230 0.8)
       |> move (-5, 2)
       
   , circle 1
       |> filled (rgba 230 230 230 0.8)
       |> move (5, -3)
       
   , circle 1
       |> filled (rgba 230 230 230 0.8)      
       |> move (2, 2)
  ]

rainbow model = group
  [
     wedge 50 0.5 -- semi-circle
        |> filled 
            (radialGradient
                [ stop (hsla (degrees <| model.time * 50) 1 0.7 0.7) 0
                , stop (hsl (degrees <| model.time * 50 + 60) 1 0.7) 10
                , stop (hsl (degrees <| model.time * 50 + 120) 1 0.7) 20
                , stop (hsl (degrees <| model.time * 50 + 180) 1 0.7) 30
                , stop (hsl (degrees <| model.time * 50 + 240) 1 0.7) 40
                , stop (hsl (degrees <| model.time * 50 + 300) 1 0.7) 50
                ])
       
       |> rotate (degrees 90)
  ]
 
house = group
  [
     rect 40 65
       |> filled black
        
   , triangle 23
       |> filled black
       |> rotate (degrees 90)
       |> move (0, 44)
        
   , rect 7 15
       |> filled white
       |> move (-8, 20)
       
   , rect 7 15
       |> filled white
       |> move (8, 20)
       
   , rect 7 15
       |> filled white
       |> move (-8, 0)
       
   , rect 7 15
       |> filled white
       |> move (8, 0)
       
   , rect 7 15
       |> filled white
       |> move (8, -20)
       
   , rect 7 15
       |> filled white
       |> move (-8, -20)
       
   , triangle 14
       |> filled white
       |> rotate (degrees 90)
       |> move (0, 40)
       
  ]
  
balloon = group
  [
     curve (23, 13) [Pull (0,-96) (81,-71), Pull (142,0) (0,0) ]
       |> filled white
       |> rotate (degrees 150)
       |> scale 0.4
       |> move (0.2, 0)
        
   , square 9.9
       |> filled white
       |> move (-5, -4.7) 
  ]
  
light = group
  [
    curve (129,-52) [Pull (116,-50) (-9,-27), Pull (29,-66) (0,-119) ]
      |> filled (rgb 255 255 180)
      |> scale 0.5 
  ]
  
ufo = group
  [
      triangle 10
        |> filled white
        |> rotate (degrees -30)
        |> move (0, -10)
        |> scale 21.5
        |> makeTransparent 0.8
        
    , oval 100 25
        |> filled (rgb 24 25 26)
        
    , oval 100 25
        |> outlined (longdash 1) darkGrey
        
    , oval 100 25
        |> outlined (solid 0.5) (rgb 251 72 196)  
        |> scale 0.9
        
    , oval 100 25
        |> outlined (solid 0.5) (rgb 204 255 0)  
        |> scale 0.8
        
    , oval 100 25
        |> outlined (solid 0.5) (rgb 255 173 0)  
        |> scale 0.7
        
    , oval 100 25
        |> outlined (solid 0.5) (rgb 47 249 36)  
        |> scale 0.6
  ]
  
glass = group
  [
      roundedRect 70 95 35
        |> filled (rgba 234 240 240 0.85)
        |> subtract (square 75 |> ghost |> move (-1, -25))
        |> scale 0.75
        |> move (0, -10)
        
    , roundedRect 70 95 35
        |> outlined (solid 0.5) black
        |> subtract (square 75 |> ghost |> move (-1, -25))
        |> scale 0.75
        |> move (0, -10)
        
  ] 
  
alien = group
  [
      circle 15
        |> filled green
        |> subtract (square 30 |> ghost |> move (-28, -8) |> rotate (degrees 50))
        |> subtract (square 30 |> ghost |> move (28, 8) |> rotate (degrees -50))
       
    , oval 10 15
        |> filled black
        |> scale 0.6
        |> move (-5, 3)
        
    , oval 10 15
        |> filled black
        |> scale 0.6
        |> move (5, 3)
        
  ]
  
human = group
  [
    oval 2 8
      |>filled black

      ,circle 2
      |>filled black
      |>move (0,5)

      ,oval 1 5
      |>filled black
      |>move (3,-1)
      |>rotate (degrees 60)

      ,oval 1 5
      |>filled black
      |>move (-3,-1)
      |>rotate (degrees -60)

      ,oval 1 8
      |>filled black
      |>move (-1,-6)
      |>rotate (degrees 20)

      ,oval 1 8
      |>filled black
      |>move (1,-6)
      |>rotate (degrees -20)
  ]

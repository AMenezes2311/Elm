{-
  Created by Andre Menezes, Tung Ho, Margaret Hong, Armaan Nanji --
  
  Contributions :
  
  Wires - Andre / Armaan
  Leaves - Tom / Margaret
  Card Swipe - Andre / Aramaan
  Map - Tom / Margaret
-}

myShapes model =
    [rect 192 128
      |> filled black] ++
    case model.state of
        Cafeteria  ->
            [ 
            -- cafeteria and hallways
            square 60
              |> filled blue
              |> move (60, 0)
            , text "Cafeteria"
              |> centered
              |> filled white
              |> move (60, 0)
            , rect 80 10
              |> filled blue
              |> move (-5, 0)
            , rect 1 30
              |> filled green
              |> move (0, -20)
            -- upper engine transition
            , group
                  [
                   polygon [(30, 20), (30, -20), (-20, -30), (-20, 30)]
                            |> filled black
                  ,    polygon [(30, 20), (30, -20), (-20, -30), (-20, 30)]
                            |> outlined (solid 1) green
                  ,    text "Upper Engine"
                            |> centered
                            |> size 8
                            |> filled white
                            |> move(5, 0)
                  ]
                     |> move (-75, 0)
                     |> notifyTap ToUpperEngine
            -- medbay transition
            , group
                  [
                  rect 40 26
                    |> filled black
                  ,    rect 40 26
                            |> outlined (solid 1) green
                            
                  ,    text "Medbay"
                            |> centered
                            |> size 8
                            |> filled white
                            |> move(0, -3)
                  ]
                     |> move (0, -48)
                     |> notifyTap ToMedbay
            -- crewmate model
            , character
              |> scale (0.5)
              |> move (40, -15)
            ]
        Medbay  ->
            [ 
            -- medbay and hallways
            square 50
              |> filled blue
              |> move (0, -30)
            , rect 10 25
              |> filled blue
            , rect 50 1
              |> filled green
              |> move (-20, 12)
            , line (-20,0) (90, 0) 
              |> outlined (dashed 1) green
              |> move (20, 12)
            , text "Medbay"
                  |> size 6
                  |> centered
                  |> filled white
                  |> move (0, -20)
            -- upper engine transition
            , group
                  [ polygon [(30, 20), (30, -20), (-20, -30), (-20, 30)]
                            |> filled black
                  , polygon [(30, 20), (30, -20), (-20, -30), (-20, 30)]
                            |> outlined (solid 1) green
                  ,    text "Upper Engine"
                            |> centered
                            |> size 8
                            |> filled white
                            |> move(5, 0)
                  ]
                     |> move (-75, 10)
                     |> notifyTap ToUpperEngine
            -- crewmate model
            , character
              |> scale (0.5)
              |> move (0, -30)
            ]
        UpperEngine  ->
            [ 
            -- upper engine and hallways
            polygon [(0, 0), (20, 20), (50, 20), (50, -20), (0, -20)]
              |> filled blue
              |> move (-25, 40)
            , rect 10 80
              |> filled blue
            , rect 30 1
              |> filled green
              |> move (20, 0)
            , rect 30 1
              |> filled green
              |> move (-20, 0)
            , text "Upper Engine"
                  |> size 6
                  |> centered
                  |> filled white
                  |> move (0, 30)
            -- reactor transition
            , group
                  [
                       rect 40 50 
                            |> filled black
                  ,    rect 40 50 
                            |> outlined (solid 1) green
                  ,    text "Reactor"
                            |> centered
                            |> size 8
                            |> filled white
                            |> move(0, -3)
                  ]
                     |> move (-55, 0)
                     |> notifyTap ToReactor
            -- security transition
            , group
                  [
                  rect 40 50
                            |> filled black
                  ,   rect 40 50
                            |> outlined (solid 1) green
                  ,    text "Security"
                            |> centered
                            |> size 8
                            |> filled white
                            |> move(0, -3)
                  ]
                     |> move (55, 0)
                     |> notifyTap ToSecurity
            -- lower engine transition
            , group
                  [
                  rect 50 20 
                            |> filled black
                  ,    rect 50 20 
                            |> outlined (solid 1) green
                  ,    text "Lower Engine"
                            |> centered
                            |> size 8
                            |> filled white
                            |> move(0, -3)
                  ]
                     |> move (0, -50)
                     |> notifyTap ToLowerEngine
            -- crewmate model
            , character
              |> scale (0.5)
              |> move (0, 45)
            ]
        Reactor  ->
            [ 
            -- reactor room and hallways
            square 60
              |> filled blue
              |> move (-50, 30)
            , rect 30 10
              |> filled blue
              |> move (-10, 30)
            , line (5, 62) (5,35)
              |> outlined (dashed 1) green
            , line (5,35) (5, -50)
              |> outlined (solid 1) green
            , line (5, 30) (40, 30)
              |> outlined (solid 1) green
            , text "Reactor"
                  |> size 6
                  |> centered
                  |> filled white
                  |> move (-50, 10)
            -- security transition
            , group
                  [
                       rect 40 50 
                            |> filled black
                  ,    rect 40 50 
                            |> outlined (solid 1) green
                  ,    text "Security"
                            |> centered
                            |> size 8
                            |> filled white
                            |> move(0, -3)
                  ]
                     |> move (50, 25)
                     |> notifyTap ToSecurity
            -- lower engine transition
            , group
                  [
                       rect 50 20 
                            |> filled black
                  ,    rect 50 20 
                            |> outlined (solid 1) green
                  ,    text "Lower Engine"
                            |> centered
                            |> size 8
                            |> filled white
                            |> move(0, -3)
                  ]
                     |> move (5, -55)
                     |> notifyTap ToLowerEngine
            -- button that will take user to the leaf task state
            , task
               |> move (-40, 30)
               |> notifyTap ToLeaf
            -- crewmate model
            , character
              |> scale (0.5)
              |> move (-60, 45)
            ]
        Security  ->
            [ 
            -- sectuity room and hallways
            square 60
              |> filled blue
              |> move (40, 30)
            , rect 30 10
              |> filled blue
              |> move (0, 30)
            , line (-15, 62) (-15,35)
              |> outlined (dashed 1) green
            , line (-15,35) (-15, -50)
              |> outlined (solid 1) green
            , line (-15, 30) (-50, 30)
              |> outlined (solid 1) green
            , text "Security"
                  |> size 6
                  |> filled white
                  |> move (30, 30)
            -- reactor transition
            , group
                  [
                       rect 40 50 
                            |> filled black
                  ,    rect 40 50 
                            |> outlined (solid 1) green
                  ,    text "Reactor"
                            |> centered
                            |> size 8
                            |> filled white
                            |> move(0, -3)
                  ]
                     |> move (-65, 30)
                     |> notifyTap ToReactor
            -- lower engine transition
            , group
                  [
                       rect 50 20 
                            |> filled black
                  ,    rect 50 20 
                            |> outlined (solid 1) green
                  ,    text "Lower Engine"
                            |> centered
                            |> size 8
                            |> filled white
                            |> move(0, -3)
                  ]
                     |> move (-15, -50)
                     |> notifyTap ToLowerEngine
            -- crewmate model
            , character
              |> scale (0.5)
              |> move (20, 45)
            ]
        LowerEngine  ->
            [ 
            -- lower engine and hallways
            rect 40 50
              |> filled blue
              |> move (-60, 30)
            , rect 30 10
              |> filled blue
              |> move (-25, 40)
            , rect 10 40
              |> filled blue
              |> move (-10, 25)
            , rect 80 10
              |> filled blue
              |> move (25, 0)
              
            , line (25, 5) (25, 30)
              |> outlined (solid 1) green
            , text "Lower Engine"
                  |> size 6
                  |> centered
                  |> filled white
                  |> move (-60, 40)
            -- electrical transition
            , group
                  [
                       rect 40 30 
                            |> filled black
                  ,    rect 40 30 
                            |> outlined (solid 1) green
                  ,    text "Electrical"
                            |> centered
                            |> size 8
                            |> filled white
                            |> move(0, -3)
                  ]
                     |> move (25, 45)
                     |> notifyTap ToElectrical
            -- storage transition
            , group
                  [
                       rect 40 50 
                            |> filled black
                  ,    rect 40 50 
                            |> outlined (solid 1) green
                  ,    text "Storage"
                            |> centered
                            |> size 8
                            |> filled white
                            |> move(0, -3)
                  ]
                     |> move (75, 0)
                     |> notifyTap ToStorage
            -- crewmate model
            , character
              |> scale (0.5)
              |> move (-60, 20)
            ]
        Electrical  ->
            [ 
            -- electrical room and hallways
            rect 65 65
              |> filled blue
              |> move (-40, 20)
            , rect 10 30
              |> filled blue
              |> move (-40, -25)
            , text "Electrical"
                  |> centered
                  |> filled white
                  |> move (-40, 20)
            , line (-90, -40) (40, -40)
              |> outlined (dashed 1) green
            , line (-40, -40) (50, -40)
              |> outlined (solid 1) green 
            -- storage transition
            , group
                  [
                       rect 46 36 
                            |> filled black
                  ,    rect 46 36 
                            |> outlined (solid 1) green
                  ,    text "Storage"
                            |> centered
                            |> size 8
                            |> filled white
                            |> move(0, -3)
                  ]
                     |> move (35, -40)
                     |> notifyTap ToStorage
            -- button that will take user to the wires task state
            , task
              |> move (-40, 0)
              |> notifyTap ToWires
            -- crewmember
            , character
              |> scale (0.5)
              |> move (-20, 40)
            ]
        Storage  ->
            -- storage rooms and hallways
            [ line (-90, -40) (30, -40)
              |> outlined (dashed 1) green
              
            , line (0, 0) (45, 0)
              |> outlined (solid 1) green
            
            , rect 55 35
              |> filled blue
              |> move (0, -40)
            , rect 10 45
              |> filled blue
              |> move (0, 0)
            , text "Storage"
                  |> size 6
                  |> centered
                  |> filled white
                  |> move (0, -43)
            -- cafeteria transition
            , group
                  [
                       rect 46 36 
                            |> filled black
                  ,    rect 46 36 
                            |> outlined (solid 1) green
                  ,    text "Cafeteria"
                            |> centered
                            |> size 8
                            |> filled white
                            |> move(0, -3)
                  ]
                     |> move (-0, 35)
                     |> notifyTap ToCafeteria
            -- admin transition
            , group
                  [
                       rect 46 36 
                            |> filled black
                  ,    rect 46 36 
                            |> outlined (solid 1) green
                  ,    text "Admin"
                            |> centered
                            |> size 8
                            |> filled white
                            |> move(0, -3)
                  ]
                     |> move (65, 0)
                     |> notifyTap ToAdmin
            -- crewmate model
            , character
              |> scale (0.5)
              |> move (20, -45)
            ]
        Admin  ->
            -- admin room and hallways
            [ rect 70 10
              |> filled blue
            
            , line (-35, 40) (-35, -70)
              |> outlined (dashed 1) green
              
            , line (-35, 40) (-35, -5)
              |> outlined (solid 1) green
            
            , rect 65 45
              |> filled blue
              |> move (40, 0)
            
            , text "Admin"
                  |> size 6
                  |> centered
                  |> filled white
                  |> move (40, 0)
            -- cafeteria transition
            , group
                  [
                       rect 46 36 
                            |> filled black
                  ,    rect 46 36 
                            |> outlined (solid 1) green
                  ,    text "Cafeteria"
                            |> centered
                            |> size 8
                            |> filled white
                            |> move(0, -3)
                  ]
                     |> move (-35, 40)
                     |> notifyTap ToCafeteria
            -- button that will take user to the card swipe task state
            , task
              |> notifyTap ToCard
              |> move (60, -9)
            , character
              |> scale (0.5)
              |> move (20, 10)
            ]
        Leaf ->
                  -- if the game is won, then show a winning screen
                   if model.isWin then
                     [
                     rect 192 128
                         |> filled black
                     ,text "SUCCESS"
                       |> size 20
                       |> centered
                       |> filled green
                       |> move (0, 20)
                     ,  successButton ToReactor
                       |> move (0, -20)
                         
                     ]
                   else
                    [
                      -- show the leaf minigame, and update the model using it's tick message and the new time in the main model
                     Nanjia12.Leaf.myShapes (model.leaf)
                         |> group
                         |> GraphicSVG.map LeafMsg
                    ]
               
        Wires ->
              -- if the game is won, then show a winning screen
              if model.isWin then
                     [
                     rect 192 128
                         |> filled black
                     ,text "SUCCESS"
                       |> size 20
                       |> centered
                       |> filled green
                       |> move (0, 20)
                     ,  successButton ToElectrical
                       |> move (0, -20)
                     ]
                   else
                    [
                      -- show the wires minigame, and update the model using it's tick message and the new time in the main model
                      Nanjia12.WiresAndre.myShapes (wiresTicker model.wires (model.time - model.gameTime))
                        |> group
                        |> GraphicSVG.map WiresMsg
                    ]
        Card ->
              -- if the game is won, show a contiunue button in the top right hand corner, and make the game unplayable
              if model.isWin then
                     [
                     Nanjia12.CardSwipe.myShapes (cardTicker model.card (model.time - model.gameTime))
                        |> group
                        |> GraphicSVG.map CardMsg
                     , rect 192 128
                       |> filled white
                       |> makeTransparent 0
                     ,  successButton ToAdmin
                       |> move (70, 50)
                     ]
                   else
                    [
                      -- show the card minigame, and update the model using it's tick message and the new time in the main model
                      Nanjia12.CardSwipe.myShapes (cardTicker model.card (model.time - model.gameTime))
                        |> group
                        |> GraphicSVG.map CardMsg
                    ]

-- tick message for wires task
wiresTicker model t =
  Nanjia12.WiresAndre.update (Nanjia12.WiresAndre.Tick t (artKeyState, (0,0), (0,0))) model

-- tick message for leaf task
leafTicker model t =
  Nanjia12.Leaf.update (Nanjia12.Leaf.Tick t (artKeyState, (0,0), (0,0))) model

-- tick message for card task
cardTicker model t =
  Nanjia12.CardSwipe.update (Nanjia12.CardSwipe.Tick t (artKeyState, (0,0), (0,0))) model

{-
  An artificial key state that is used to emulate a tick in the modules used for the minigames
-}
artKeyState key =
  case key of
    Tab
      ->
        Down
    _
      ->
        Down
        
{-
  Task button, a yellow circle with an exclamation mark 
-}
task = group
  [
    circle 10
      |> filled yellow
    , circle 10
      |> outlined (solid 1) orange
    , text "!"
      |> filled orange
      |> move (-2, -3)
  ]

type Msg = Tick Float GetKeyState
         | ToUpperEngine 
         | ToMedbay 
         | ToReactor 
         | ToSecurity 
         | ToLowerEngine 
         | ToStorage 
         | ToElectrical
         | ToCafeteria 
         | ToAdmin 
         | ToLeaf
         | ToWires
         | ToCard
         -- Task model message wrappers
         | LeafMsg Nanjia12.Leaf.Msg
         | WiresMsg Nanjia12.WiresAndre.Msg
         | CardMsg Nanjia12.CardSwipe.Msg

type State = Cafeteria 
           | Medbay 
           | UpperEngine 
           | Reactor 
           | Security 
           | LowerEngine 
           | Electrical 
           | Storage 
           | Admin 
           -- Task states
           | Leaf
           | Wires
           | Card

update msg model =
                case msg of
                    
                    Tick t _ ->
                        {- 
                          everytime the regular tick goes of, check if the minigames have been won, if so
                          set the state so that the win screen is shown 
                        -}
                        if model.leaf.isWin then
                          { model | time = t, leaf = Nanjia12.Leaf.init, isWin = True }
                        else if model.wires.win then
                          { model | time = t, wires = Nanjia12.WiresAndre.init, isWin = True }
                        else if model.card.isWin then
                          { model | time = t, isWin = True }
                        {-
                          perform a tick in the minigame models
                        -}
                        else
                          { model | time = t, 
                          leaf = leafTicker model.leaf (t - model.gameTime), 
                          wires = wiresTicker model.wires (t - model.gameTime),
                          card = cardTicker model.card (t - model.gameTime)}
                    -- Room state transitions
                    ToUpperEngine  ->
                        case model.state of
                            Cafeteria  ->
                                { model | state = UpperEngine, isWin = False  }

                            Medbay  ->
                                { model | state = UpperEngine, isWin = False  }

                            otherwise ->
                                model
                    ToMedbay  ->
                        case model.state of
                            Cafeteria  ->
                                { model | state = Medbay, isWin = False  }

                            otherwise ->
                                model
                    ToReactor  ->
                        case model.state of
                            UpperEngine  ->
                                { model | state = Reactor, isWin = False  }

                            Security  ->
                                { model | state = Reactor, isWin = False  }
                            Leaf  ->
                                { model | state = Reactor, isWin = False  }
                            otherwise ->
                                model
                    ToSecurity  ->
                        case model.state of
                            UpperEngine  ->
                                { model | state = Security, isWin = False  }

                            Reactor  ->
                                { model | state = Security, isWin = False  }

                            otherwise ->
                                model
                    ToLowerEngine  ->
                        case model.state of
                            UpperEngine  ->
                                { model | state = LowerEngine, isWin = False  }

                            Reactor  ->
                                { model | state = LowerEngine, isWin = False  }

                            Security  ->
                                { model | state = LowerEngine, isWin = False  }

                            otherwise ->
                                model
                    ToElectrical ->
                      case model.state of
                        LowerEngine ->
                          { model | state = Electrical, isWin = False }
                        Wires ->
                          { model | state = Electrical, isWin = False }
                        otherwise ->
                          model
                    ToStorage  ->
                        case model.state of
                            LowerEngine  ->
                                { model | state = Storage, isWin = False  }

                            Electrical  ->
                                { model | state = Storage, isWin = False  }

                            otherwise ->
                                model
                    ToCafeteria  ->
                        case model.state of
                            Storage  ->
                                { model | state = Cafeteria, isWin = False  }

                            Admin  ->
                                { model | state = Cafeteria, isWin = False  }

                            otherwise ->
                                model
                    ToAdmin  ->
                        case model.state of
                            Storage  ->
                                { model | state = Admin, isWin = False  }
                            Card  ->
                                -- Reset the card game
                                { model | state = Admin, isWin = False, card = Nanjia12.CardSwipe.init  }
                            otherwise ->
                                model
                    -- Minigame state transitions
                    ToLeaf ->
                           { model | state = Leaf, gameTime = model.time, leaf = Nanjia12.Leaf.init }
                    ToWires ->
                           { model | state = Wires, gameTime = model.time, wires = Nanjia12.WiresAndre.init }
                    ToCard ->
                           { model | state = Card, gameTime = model.time, card = Nanjia12.CardSwipe.init }
                    -- Minigame message wrappers
                    LeafMsg other ->
                        { model | leaf = Nanjia12.Leaf.update other (leafTicker model.leaf (model.time - model.gameTime)) }
                    WiresMsg other ->
                        { model | wires = Nanjia12.WiresAndre.update other (wiresTicker model.wires (model.time - model.gameTime)) }
                    CardMsg other ->
                        { model | card = Nanjia12.CardSwipe.update other (cardTicker model.card (model.time - model.gameTime)) }

{-
  Crewmember model that moves from room to room
-}
character = 
  group
    [
      roundedRect 5 7 3
        |> filled red
        |> move (5, -18)
      , roundedRect 5 7 3
        |> filled red
        |> move (-5, -18)
      , roundedRect 5 7 3
        |> outlined (solid 1) black
        |> move (5, -18)
      , roundedRect 5 7 3
        |> outlined (solid 1) black
        |> move (-5, -18)
      , roundedRect 20 30 3
        |> filled red
      , roundedRect 20 30 3
        |> outlined (solid 1) black
      , roundedRect 10 20 3
        |> filled red
        |> move (15, 0)
      , roundedRect 10 20 3
        |> outlined (solid 1) black
        |> move (15, 0)
      
      , roundedRect 15 10 5
        |> filled lightBlue
        |> move (-3, 7)
      , roundedRect 15 10 5
        |> outlined (solid 1) black
        |> move (-3, 7)
    ]

{-
  Button that when clicked will return the user to a specified state, that
  will vary depending on the minigame they completed
-}
successButton toState = 
  group 
  [
    roundedRect 40 20 3
      |> filled black
      |> addOutline (solid 1) green
    , text "Continue"
      |> size 8
      |> filled green
      |> move (-15, 0)
  ] |> notifyTap toState

type alias Model =
    { time : Float
    , state : State
    -- keep track of when a game starts
    , gameTime : Float
    -- task models
    , leaf : Nanjia12.Leaf.Model
    , wires : Nanjia12.WiresAndre.Model
    , card : Nanjia12.CardSwipe.Model
    , isWin : Bool
    }

type alias Point = (Float, Float)

init : Model
init = { time = 0 
       , state = Cafeteria 
       , gameTime = -100
       -- task model initialization
       , leaf = Nanjia12.Leaf.init
       , wires = Nanjia12.WiresAndre.init
       , card = Nanjia12.CardSwipe.init
       , isWin = False
       }

main = gameApp Tick { model = init, view = view, update = update, title = "Game Slot" }

view model = collage 192 128 (myShapes model)




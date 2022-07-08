view model =
    collage 192 128 (myShapes model)


myTitle : String
myTitle =
    "Probability Casino"


type alias Model =
    { time : Float
    , state : State

    -- models for respective games
    , dice : Nanjia12.DiceRolling.Model
    , card : Nanjia12.CardPulling.Model
    , loto : Nanjia12.Lottery.Model

    -- net points across all games
    , pts : Int

    -- determines whether a game on the main menu should behighlighted
    , highlight : List Bool

    -- points gained from each game
    , lotoPts : Int
    , dicePts : Int
    , cardPts : Int
    , progress : Nanjia12.Progress.Model
    , tutorial : Nanjia12.Tutorial.Model
    , token : { time : Float }
    }


type Msg
    = Tick Float GetKeyState
    | ToTutorial
    | ToLoto
    | ToDice
    | ToCard
    | ToProgress
    | ToEquation Msg
    | ToMenu
    | Highlight Int
    | CardMsg Nanjia12.CardPulling.Msg
    | LotoMsg Nanjia12.Lottery.Msg
    | DiceMsg Nanjia12.DiceRolling.Msg
    | TutorialMsg Nanjia12.Tutorial.Msg
    | ProgressMsg Nanjia12.Progress.Msg
    | EquationsMsg Nanjia12.Equations.Msg
    | TokenAnimMsg Nanjia12.TokenAnimation.Msg
    | EndScreenMsg Nanjia12.EndScreenProbGame.Msg
    | Restart


type State
    = Loto
    | Tutorial
    | Dice
    | Card
    | Menu
    | Progress
    | Equation Msg
    | EndScreen


init : Model
init =
    { time = 0
    , state = Tutorial
    , dice = Nanjia12.DiceRolling.init
    , loto = Nanjia12.Lottery.init
    , card = Nanjia12.CardPulling.init
    , progress = Nanjia12.Progress.init
    , pts = 0
    , highlight = [ False, False, False ]
    , lotoPts = 0
    , dicePts = 0
    , cardPts = 0
    , tutorial = Nanjia12.Tutorial.init
    , token = { time = 0 }
    }


main : EllieAppWithTick () Model Msg
main =
    ellieAppWithTick Tick
        { init =
            \_ ->
                ( init
                  -- this is the initial state, like you are used to
                , Cmd.none
                )

        -- this requests the first random number
        , update = update
        , view = \model -> { title = myTitle, body = view model }
        , subscriptions = \_ -> Sub.none
        }


myShapes : Model -> List (Shape Msg)
myShapes model =
    case model.state of
        -- tutorial screen
        Tutorial ->
            [ Nanjia12.Tutorial.myShapes model.tutorial
                |> group
                |> GraphicSVG.map TutorialMsg
            ]

        Menu ->
            [ -- main menu background
              group
                ([ rect 200 200
                    |> filled darkRed
                 ]
                    ++ laserGen [ 0, 30, 60, 100, 120, 170 ] [ ( 0, 0 ), ( 0, 0 ), ( -50, 0 ), ( 100, 0 ), ( -70, 0 ) ]
                )
            , -- Title game prompt to select a game
              group
                [ text "Welcome to the probability casino!"
                    |> filled (rgb 255 211 50)
                    |> move ( -80, 40 )
                , text "Please select a game to play."
                    |> filled (rgb 255 211 50)
                    |> scale 0.8
                    |> move ( -50, 30 )
                ]

            -- lights
            , group
                [ lights lightBlue 70
                    |> move ( -60, -40 )
                , lights white 90
                    |> move ( 60, -40 )
                , lights pink 90
                    |> move ( -50, -40 )
                ]

            -- game selection menu
            , group
                -- green reactangle background
                [ rect 40 160
                    |> filled (rgb 71 157 0)
                    |> rotate (degrees 90)
                    |> move ( 0, -5 )
                , highlightedShape dice 0 ( 0, 0 ) model ToDice
                    |> scale 2
                , highlightedShape card 1 ( 55, 0 ) model ToCard
                , highlightedShape ball 2 ( -60, 0 ) model ToLoto
                , progressButton
                    |> move ( -30, -40 )
                , tutorialButton
                    |> move ( 30, -40 )
                ]
            ]

        -- show x% completed circles demonstrating the progress made in each game
        Progress ->
            [ Nanjia12.Progress.myShapes model.progress |> group |> GraphicSVG.map ProgressMsg
            , menuButton
                |> move ( 80, 50 )
            ]

        -- lottery game
        Loto ->
            case model.loto.state of
                -- if the user correctly answers a question, play an animation and hide the menu/equation buttons
                Nanjia12.Lottery.Right ->
                    [ Nanjia12.Lottery.myShapes model.loto |> group |> GraphicSVG.map LotoMsg
                    , Nanjia12.TokenAnimation.myShapes model.token |> group |> GraphicSVG.map TokenAnimMsg
                    ]

                -- otherwise, don't play an annimatiom
                _ ->
                    [ Nanjia12.Lottery.myShapes model.loto |> group |> GraphicSVG.map LotoMsg
                    ]
                        ++ (if model.loto.state == Nanjia12.Lottery.Game then
                                [ -- return to menu screen
                                  menuButton
                                    |> move ( 75, 50 )

                                -- view the equation screen
                                , equationButton ToLoto
                                    |> move ( 75, 25 )
                                ]

                            else
                                []
                           )

        -- dice rolling game
        Dice ->
            case model.dice.state of
                -- if the user correctly answers a question, play an animation and hide the menu/equation buttons
                Nanjia12.DiceRolling.Right ->
                    [ Nanjia12.DiceRolling.myShapes model.dice |> group |> GraphicSVG.map DiceMsg
                    , Nanjia12.TokenAnimation.myShapes model.token |> group |> GraphicSVG.map TokenAnimMsg
                    ]

                -- otherwise, don't play an annimation
                _ ->
                    [ Nanjia12.DiceRolling.myShapes model.dice |> group |> GraphicSVG.map DiceMsg
                    ]
                        ++ (if model.dice.state == Nanjia12.DiceRolling.Game then
                                [ -- return to menu screen
                                  menuButton
                                    |> move ( 75, 50 )

                                -- view the equation screen
                                , equationButton ToLoto
                                    |> move ( 75, 25 )
                                ]

                            else
                                []
                           )

        -- card drawing game
        Card ->
            case model.card.state of
                -- if the user correctly answers a question, play an animation and hide the menu/equation buttons
                Nanjia12.CardPulling.Right ->
                    [ Nanjia12.CardPulling.myShapes model.card |> group |> GraphicSVG.map CardMsg
                    , Nanjia12.TokenAnimation.myShapes model.token |> group |> GraphicSVG.map TokenAnimMsg
                    ]

                -- otherwise, don't play an annimation
                _ ->
                    [ Nanjia12.CardPulling.myShapes model.card |> group |> GraphicSVG.map CardMsg
                    ]
                        ++ (if model.card.state == Nanjia12.CardPulling.Game then
                                [ -- return to menu screen
                                  menuButton
                                    |> move ( 82.5, 50 )

                                -- view the equation screen
                                , equationButton ToLoto
                                    |> move ( 82.5, 25 )
                                ]

                            else
                                []
                           )

        -- screen with various equations
        Equation msg ->
            [ group (Nanjia12.Equations.myShapes model) |> GraphicSVG.map EquationsMsg

            -- return to the previous state
            , backButton msg |> move ( 70, -40 )
            ]

        -- once the user has scored 100 points in every game, the game shows an end screen
        EndScreen ->
            [ Nanjia12.EndScreenProbGame.myShapes model |> group |> GraphicSVG.map EndScreenMsg
            , group
                -- restart game button, sets model to init
                [ roundedRect 40 20 3
                    |> filled green
                , text "Play Again?"
                    |> size 6
                    |> centered
                    |> filled black
                    |> move ( 0, -2 )
                ]
                |> move ( 0, -40 )
                |> notifyTap Restart
            ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Tick t _ ->
            ( { model
                | time = t
                , token = { time = t }
                -- once 100 points have been earned through all three minigames, end the game
                , state =
                    if model.cardPts >= 100 && model.lotoPts >= 100 && model.dicePts >= 100 then
                        EndScreen

                    else
                        model.state
              }
            , Cmd.none
            )

        ToTutorial ->
            ( { model | state = Tutorial, dice = pointSet model.dice model.pts, tutorial = Nanjia12.Tutorial.init }, Cmd.none )

        -- these cases are used to transition through tutorial screens 1 - 5
        TutorialMsg altMsg ->
            case altMsg of
                Nanjia12.Tutorial.ToMenu ->
                    ( { model | state = Menu }, Cmd.none )

                _ ->
                    ( { model | tutorial = Nanjia12.Tutorial.update altMsg model.tutorial }, Cmd.none )

        -- these cases are used to transition from the menu/equation screen to games
        ToLoto ->
            ( { model | state = Loto, loto = pointSet model.loto model.pts }, Cmd.none )

        ToDice ->
            ( { model | state = Dice, dice = pointSet model.dice model.pts }, Cmd.none )

        ToCard ->
            ( { model | state = Card, card = pointSet model.card model.pts }, Cmd.none )

        -- used to transition from games/tutorial screen/progress screen to menu screen
        ToMenu ->
            ( { model | state = Menu, pts = ptsFromLastGame model, highlight = [ False, False, False ] }, Cmd.none )

        -- used to transtion from the menu screen to the progress screen
        ToProgress ->
            ( { model | state = Progress, progress = setProgress model.progress model.lotoPts model.dicePts model.cardPts }, Cmd.none )

        -- transition from games to the equation screen
        ToEquation returnMsg ->
            ( { model | state = Equation returnMsg }, Cmd.none )

        -- handle incoming messages from Nanjia12.CardPulling
        CardMsg altMsg ->
            ( { model
                -- set card to the updated Model produced from cardUpdate
                | card = Tuple.first (cardUpdate altMsg model.card)

                -- every time a question is answered correctly, increment cardPts by 20, otherwise do nothing
                , cardPts =
                    model.cardPts + checkForGains cardUpdate altMsg (Nanjia12.CardPulling.EditEq "✓") model.card Nanjia12.CardPulling.Right
              }
              -- warp incoming Cmd msg from Nanjia12.CardPulling and handle them as Cmd msg
            , cardWrapper (Tuple.second (cardUpdate altMsg model.card))
            )

        -- ignore incoming message from Nanjia12.Progress
        ProgressMsg altMsg ->
            ( model, Cmd.none )

        -- ignore incoming message from Nanjia12.Progress
        EquationsMsg altMsg ->
            ( model, Cmd.none )
        
        -- ignore incoming messages from Nanjia12.EndGameProbScreenMsg
        EndScreenMsg altMsg ->
            ( model, Cmd.none)

        -- handle incoming messages from Nanjia12.Lottery
        LotoMsg altMsg ->
            ( { model
                -- set loto to the updated Model produced from lotoUpdate
                | loto = Tuple.first (lotoUpdate altMsg model.loto)

                -- every time a question is answered correctly, increment lotoPts by 20, otherwise do nothing
                , lotoPts =
                    model.lotoPts + checkForGains lotoUpdate altMsg (Nanjia12.Lottery.EditEq "✓") model.loto Nanjia12.Lottery.Right
              }
              -- warp incoming Cmd msg from Nanjia12.Lottery and handle them as Cmd msg
            , lotoWrapper (Tuple.second (lotoUpdate altMsg model.loto))
            )
        
        -- ignore incoming messages from Nanjia12.TokenAnimation
        TokenAnimMsg altMsg ->
            (model, Cmd.none)
        
        -- handle incoming messages from Nanjia12.DiceRolling
        DiceMsg altMsg ->
            ( { model
                -- set dice to the updated Model produced from diceUpdate
                | dice = Tuple.first (diceUpdate altMsg model.dice)

                -- every time a question is answered correctly, increment dicePts by 20, otherwise do nothing
                , dicePts = model.dicePts + checkForGains diceUpdate altMsg (Nanjia12.DiceRolling.EditEq "✓") model.dice Nanjia12.DiceRolling.Right
              }
              -- warp incoming Cmd msg from Nanjia12.DiceRolling and handle them as Cmd msg
            , diceWrapper (Tuple.second (diceUpdate altMsg model.dice))
            )

        -- highlight a shape at a given idx
        Highlight idx ->
            ( { model | highlight = invBoolAt model.highlight idx }, Cmd.none )

        Restart ->
            ( init, Cmd.none )



-- generate lasers for the background given a list of rotation (Int) and movement (Tuple) values


laserGen : List Float -> List ( Float, Float ) -> List (Shape Msg)
laserGen rotationList movementList =
    case rotationList of
        degs :: xs ->
            case movementList of
                mov :: ys ->
                    [ laser
                        |> rotate (degrees degs)
                        |> move mov
                    ]
                        ++ laserGen xs ys

                _ ->
                    []

        _ ->
            []



{-
   given a function that takes a bool indcating whether there should be a highlight and returns a Shape, a unique Int,
   movement coordinates, Model and Msg, generates a shape that gets highlighted when hovered over
-}


highlightedShape : (Bool -> Shape Msg) -> Int -> ( Float, Float ) -> Model -> Msg -> Shape Msg
highlightedShape shape idx coords model msg =
    shape (atIdx model.highlight idx False)
        |> move coords
        |> notifyTap msg
        |> notifyEnter (Highlight idx)
        |> notifyLeave (Highlight idx)



-- dark red background for the menu screen


menuBackground : Shape Msg
menuBackground =
    rect 192 128
        |> filled darkRed



-- button used to transition to Progress state


progressButton : Shape Msg
progressButton =
    group
        [ rect 30 10
            |> filled purple
        , text "Progress"
            |> size 6
            |> centered
            |> filled black
            |> move ( 0, -2 )
        ]
        |> notifyTap ToProgress



-- button used to transition to the Tutorial1 state


tutorialButton : Shape Msg
tutorialButton =
    group
        [ rect 30 10
            |> filled orange
        , text "Tutorial"
            |> size 6
            |> centered
            |> filled black
            |> move ( 0, -2 )
        ]
        |> notifyTap ToTutorial



-- convert a list of Strings into a list of text Shapes


listToText : List String -> Float -> List (Shape Msg)
listToText list verticalDist =
    case list of
        [] ->
            [ text ""
                |> filled black
            ]

        -- when the list isn't empty, append a laser to the list
        x :: xs ->
            [ text x
                |> size 4
                |> centered
                |> filled yellow
                |> move ( 0, verticalDist )
            ]
                ++ listToText xs (verticalDist - 5)



{-
   get an element from a list at an index, in the case that the index doesn't exist, return
   default
-}


atIdx : List a -> Int -> a -> a
atIdx list idx default =
    case list of
        [] ->
            default

        x :: xs ->
            if idx == 0 then
                x

            else
                atIdx xs (idx - 1) default



-- button that performs msg when clicked. has forward facing arrow


forwardButton : Msg -> Shape Msg
forwardButton msg =
    group
        [ circle 10
            |> filled blue
        , rect 12 3
            |> filled white
        , rect 6.5 3
            |> filled white
            |> rotate (degrees 45)
            |> move ( -2.3, 2.85 )
        , rect 6.5 3
            |> filled white
            |> rotate (degrees -45)
            |> move ( -2.3, -2.85 )
        ]
        |> mirrorX
        |> notifyTap msg



{-
   button with question mark that will take users to the Equation state. Takes a Msg argument to determine
   which state is to be returned to. In most cases, pass a Msg that returns to the current state.
-}


equationButton : Msg -> Shape Msg
equationButton msg =
    group
        [ circle 10
            |> filled yellow
        , text "?"
            |> size 18
            |> centered
            |> filled white
            |> move ( 0, -6 )
        ]
        |> notifyTap (ToEquation msg)



-- button with backwards arrow that returns a user to the menu screen


menuButton : Shape Msg
menuButton =
    backButton ToMenu



-- button that performs msg when clicked. has backward facing arrow


backButton : Msg -> Shape Msg
backButton msg =
    group
        [ circle 10
            |> filled blue
        , rect 12 3
            |> filled white
        , rect 6.5 3
            |> filled white
            |> rotate (degrees 45)
            |> move ( -2.3, 2.85 )
        , rect 6.5 3
            |> filled white
            |> rotate (degrees -45)
            |> move ( -2.3, -2.85 )
        ]
        |> notifyTap msg



{-
   given a progress model, sets the percentage fileds based on p1/p2/p3 over 100, where p1 p2 and p3 indicated the points in
   the dice, lottery and card game respectively
-}


setProgress : Nanjia12.Progress.Model -> Int -> Int -> Int -> Nanjia12.Progress.Model
setProgress model p1 p2 p3 =
    { model | percent1 = toFloat p1 / 100, percent2 = toFloat p2 / 100, percent3 = toFloat p3 / 100 }



{-
   given an update function, Msg, a Msg indicating an answered question, a Model for the respective game, and a state Denoting
   correctly asnwered question, the function returns 20 if the question is answered correctly, otherwise 0 is returned
-}


checkForGains : (msg -> { model | state : a } -> ( { model | state : a }, cmd )) -> msg -> msg -> { model | state : a } -> a -> Int
checkForGains gameUpdate msg eqMsg model rightState =
    if msg == eqMsg then
        if (Tuple.first (gameUpdate msg model)).state == rightState then
            20

        else
            0

    else
        0



-- given a List of Bool, invert the boolean value at a given index, if the index doesn't exit, do nothing


invBoolAt : List Bool -> Int -> List Bool
invBoolAt ys idx =
    case ys of
        [] ->
            []

        x :: xs ->
            if idx == 0 then
                not x :: xs

            else
                x :: invBoolAt xs (idx - 1)



-- returns the amount of points from the game that currently being played given a Model


ptsFromLastGame : Model -> Int
ptsFromLastGame model =
    case model.state of
        Loto ->
            model.loto.pts

        Dice ->
            model.dice.pts

        Card ->
            model.card.pts

        _ ->
            model.pts



-- given a record with the pts field and an Int, will return a record with an updated pts field


pointSet : { model | pts : Int } -> Int -> { model | pts : Int }
pointSet model newPts =
    { model | pts = newPts }



-- given a Msg and Model from Nanjia12.CardPulling, the function will perform the appropriate update


cardUpdate : Nanjia12.CardPulling.Msg -> Nanjia12.CardPulling.Model -> ( Nanjia12.CardPulling.Model, Cmd Nanjia12.CardPulling.Msg )
cardUpdate altMsg cardModel =
    Nanjia12.CardPulling.update altMsg cardModel



-- given a Msg and Model from Nanjia12.Lottery, the function will perform the appropriate update


lotoUpdate : Nanjia12.Lottery.Msg -> Nanjia12.Lottery.Model -> ( Nanjia12.Lottery.Model, Cmd Nanjia12.Lottery.Msg )
lotoUpdate altMsg lotoModel =
    Nanjia12.Lottery.update altMsg lotoModel



-- given a Msg and Model from Nanjia12.DiceRolling, the function will perform the appropriate update


diceUpdate : Nanjia12.DiceRolling.Msg -> Nanjia12.DiceRolling.Model -> ( Nanjia12.DiceRolling.Model, Cmd Nanjia12.DiceRolling.Msg )
diceUpdate altMsg diceModel =
    Nanjia12.DiceRolling.update altMsg diceModel



-- wraps incoming Nanjia12.Lottery.Cmd msg by mapping them to a Cmd msg


lotoWrapper : Cmd Nanjia12.Lottery.Msg -> Cmd Msg
lotoWrapper cmd =
    Cmd.map LotoMsg cmd



-- wraps incoming Nanjia12.CardPulling.Cmd msg by mapping them to a Cmd msg


cardWrapper : Cmd Nanjia12.CardPulling.Msg -> Cmd Msg
cardWrapper cmd =
    Cmd.map CardMsg cmd



-- wraps incoming Nanjia12.DiceRolling.Cmd msg by mapping them to a Cmd msg


diceWrapper : Cmd Nanjia12.DiceRolling.Msg -> Cmd Msg
diceWrapper cmd =
    Cmd.map DiceMsg cmd



-- heart shape used for the card icon


heart : Shape Msg
heart =
    group
        [ triangle 2
            |> filled red
            |> rotate (degrees 90)
        , circle 1
            |> filled red
            |> move ( 0.8, -1.2 )
        , circle 1
            |> filled red
            |> move ( -0.8, -1.2 )
        ]



-- card icon, used to redirect users to the Card state


card : Bool -> Shape Msg
card highlight =
    group
        [ -- main card body
          rectangle 15 20
            |> filled white

        -- heart
        , heart
            |> move ( 4, -6 )
        , heart
            |> rotate (degrees 180)
            |> move ( -4, 6 )

        -- outline
        , rectangle 15 20
            |> outlined (solid 0.5) black

        -- highlight if the card is being hovered over
        , if highlight then
            rectangle 17 22
                |> outlined (solid 1) yellow

          else
            group []
        , text "Cards"
            |> filled (rgb 255 211 50)
            |> move ( -14, -40 )
            |> scale 0.5
        ]



-- dice icon, used to redirect users to the Dice state


dice : Bool -> Shape Msg
dice highlight =
    group
        [ --main dice body with outline
          square 10
            |> filled white
        , square 10
            |> outlined (solid 0.25) black

        -- highlight if the dice is being overed over
        , if highlight then
            square 11
                |> outlined (solid 1) yellow

          else
            group []

        -- pips on dice
        , circle 0.9
            |> filled darkGreen
        , circle 0.9
            |> filled darkGreen
            |> move ( 2.5, -2.5 )
        , circle 0.9
            |> filled darkGreen
            |> move ( -2.5, 2.5 )
        , text "Dice"
            |> filled (rgb 255 211 50)
            |> move ( -10, -35 )
            |> scale 0.3
        ]



-- ball icon used to redirect users to the Ball state


ball : Bool -> Shape Msg
ball highlight =
    group
        [ -- main ball body and outline
          circle 10
            |> filled blue
            |> move ( 10, 0 )
        , circle 10
            |> outlined (solid 0.5) black
            |> move ( 10, 0 )

        -- highlight if hovered over
        , if highlight then
            circle 11
                |> outlined (solid 1) yellow
                |> move ( 10, 0 )

          else
            group []

        -- main ball body and outline
        , circle 10
            |> filled red
        , circle 10
            |> outlined (solid 0.5) black

        -- highlight if hovered over
        , if highlight then
            circle 11
                |> outlined (solid 1) yellow

          else
            group []
        , text "Lottery"
            |> filled (rgb 255 211 50)
            |> move ( -10, -40 )
            |> scale 0.5
        ]



-- laser graphic for the menu screen


laser : Shape Msg
laser =
    group
        [ rect 2 500
            |> filled black
        ]



-- light graphic for the menu screen


lights : Color -> Float -> Shape Msg
lights clr deg =
    group
        [ triangle 30
            |> filled clr
            |> scaleX 5
            |> rotate deg
            |> makeTransparent 0.5
        ]

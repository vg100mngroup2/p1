module View exposing (..)
import Model exposing (..)
import Html exposing (..)
import Html.Attributes exposing (style,src)
import Html.Events exposing (..)
import Http
import Svg exposing (..)
import Svg.Attributes exposing (..)
import String
import Update exposing (..)
import Heros exposing (..)
import Messages exposing (Msg(..))
-- import Debug
ballInit : Ball
ballInit = ballRecUpdate ballConfig
batInit : Bat
batInit =batRecUpdate batConfig
brickListInit : List Brick
brickListInit = generateBricks [] total brickConfig.x brickConfig.y 

initPlayer : Player
initPlayer = Player ballInit batInit brickListInit False False False 0 teachers 0

init : Model 
init = Model initPlayer initPlayer

--type Msg = Increment | Decrement

--update : Msg -> List Model -> List Model

setStyle1 : Html.Attribute msg
setStyle1 =
    Html.Attributes.style "padding" "10%"
setStyle2 : Html.Attribute msg
setStyle2 =
    Html.Attributes.style "top" "0"
setStyle3 : Html.Attribute msg
setStyle3 =
    Html.Attributes.style "postion" "fixed"


view : Model -> Html Msg
view model =
    let
       p1=model.player1
       p1Teachers = p1.teachers
       p1FirstTeacher = getFirstTeacher p1Teachers

       p2=model.player2
       p2Teachers = p2.teachers
       p2FirstTeacher = getFirstTeacher p2Teachers
    in
        div[][
        div[][img [src "./images/Logo.png", width "300", height "300"][]],
        div [id  "wrapper"]
        [   
            -- div[][img [src "Logo.png", width "300", height "300"][]],
            div [id "score1",Html.Attributes.style "width" "50%",Html.Attributes.style "float" "left"][Html.text(String.fromFloat p1.score)],
            div [id "score2",Html.Attributes.style "width" "50%",Html.Attributes.style "float" "right"][Html.text(String.fromFloat p2.score)],            
            div [id "div1",Html.Attributes.style "width" "50%",Html.Attributes.style "float" "left"][playerDemonstrate model.player1],
            div [id "div2",Html.Attributes.style "width" "50%",Html.Attributes.style "float" "right"][playerDemonstrate model.player2],
            div[id "p1",Html.Attributes.style "width" "50%",Html.Attributes.style "float" "left"][
                div [id "but1",Html.Attributes.style "width" "50%",Html.Attributes.style "float" "left"][
                    button[onClick PreviousTeacher1] [Html.text "Previous"],
                    div [] [Html.text p1FirstTeacher.name],
                    div [] [Html.text p1FirstTeacher.description],
                    button[onClick NextTeacher1] [Html.text "Next"]
                ],
                div[id "img1",Html.Attributes.style "width" "50%",Html.Attributes.style "float" "right"][img [src p1FirstTeacher.url, width "300", height "300"][]]
            ],
            div[id "p2",Html.Attributes.style "width" "50%",Html.Attributes.style "float" "right"][
                div [id "but2",Html.Attributes.style "width" "50%",Html.Attributes.style "float" "left"][
                    button[onClick PreviousTeacher2] [Html.text "Previous"],
                    div [] [Html.text p2FirstTeacher.name],
                    div [] [Html.text p2FirstTeacher.description],
                    button[onClick NextTeacher2] [Html.text "Next"]
                ],
                 div[id "img2",Html.Attributes.style "width" "50%",Html.Attributes.style "float" "right"][img [src p2FirstTeacher.url, width "300", height "300"][]]
            ]
        ]
        ]

playerDemonstrate : Player -> Html msg
playerDemonstrate model =
    let
       
        gWidth = "100"
        gHeight = "77"
        screen = rect [fill "#ffffff", x "0", y "0", width gWidth, height gHeight] []
    in

        div [setStyle1,setStyle2,setStyle3]
            [ svg [width "100%", height "100%", viewBox <| "0 0 " ++ gWidth ++ " " ++ gHeight]
              (List.append [screen] <| List.append [ball model.ball, bat model.bat] <| bricks model.bricks )
            ]

bricks : List Brick -> List (Html msg)
bricks bricksInput =
    let
        createBricksFormat model =
          rect [fill "#685bd1", x <| String.fromFloat model.x, y <| String.fromFloat model.y, width <| String.fromFloat model.width, height <| String.fromFloat model.height, stroke <| "#ffffff 0.1"] []
    in
        List.map createBricksFormat bricksInput

ball : Ball -> Html msg 
ball ballInput =
    let 
        createBallFormat model =
          circle [fill "#002c5a", cx <| String.fromFloat model.x, cy <| String.fromFloat model.y, r <| String.fromFloat model.r][]
    in
        createBallFormat ballInput

bat : Bat -> Html msg
bat batInput =
    let 
        createBatFormat model =
          rect [fill "#ffcb0b", x <| String.fromFloat model.x, y <| String.fromFloat model.y, width <| String.fromFloat model.width, height <| String.fromFloat model.height] []
    in
        createBatFormat batInput


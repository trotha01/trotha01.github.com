module Page.Header exposing (Model, Msg, view, init, update, tallness)

import Css exposing (..)
import Html exposing (Html, span, button, div, text, a, img)
import Html.Attributes as Attr
import Html.Events exposing (onClick)
import Route exposing (Route)


-- MODEL


type Model
    = Model InternalModel


type alias InternalModel =
    { selected : String }


init : Model
init =
    Model { selected = "Home" }



-- UPDATE


type Msg
    = Select String


update : Msg -> Model -> Model
update msg (Model model) =
    case msg of
        Select tab ->
            Model { model | selected = tab }



-- VIEW


tallness =
    54


view : Route -> Model -> Html Msg
view route (Model model) =
    let
        _ =
            Debug.log "(route, model)" ( route, model )
    in
        div
            [ styles
                [ overflow hidden
                , backgroundColor (hsla 0 0.0 0.0 0)
                ]
            ]
        <|
            -- We have to revers because we float left
            List.reverse
                [ homeButton route
                , aboutButton route
                , projectsButton route
                , resumeButton route
                , contactButton route
                , profilePic
                ]


homeButton : Route -> Html Msg
homeButton model =
    button model Route.Home "Home"


aboutButton : Route -> Html Msg
aboutButton model =
    button model Route.About "About"


projectsButton : Route -> Html Msg
projectsButton model =
    button model Route.Projects "Projects"


resumeButton : Route -> Html Msg
resumeButton model =
    button model Route.Resume "Resume"


contactButton : Route -> Html Msg
contactButton model =
    button model Route.Contact "Contact"


button : Route -> Route -> String -> Html Msg
button currentRoute page str =
    let
        background =
            if currentRoute == page then
                borderBottom3 (px 1) solid (hsl 0 0 0)
            else
                backgroundColor inherit

        textColor =
            if currentRoute == page then
                color (hsl 0 0 0)
            else
                color (hsl 189 0.55 0.61)
    in
        a
            [ Route.href page
            , styles
                [ float right
                , border (px 0)
                , background
                , cursor pointer
                , padding2 (px 14) (px 16)
                , fontSize (em 1)
                , textDecoration none
                , textColor
                  -- , color (rgb 255 255 255)
                , hover
                    [ backgroundColor (hsl 189 0.55 0.91)
                    ]
                ]
            , onClick (Select str)
            ]
            [ Html.text str ]


profilePic : Html msg
profilePic =
    div
        [ styles
            [ width (pct 15)
            , float left
            ]
        ]
        [ img
            [ styles
                [ width (px 50)
                , height (px 50)
                , borderRadius (px 250)
                , marginLeft (px 12)
                ]
            , Attr.src "imgs/profile.jpg"
            ]
            []
        ]



-- STYLE


styles =
    (Css.asPairs >> Attr.style)

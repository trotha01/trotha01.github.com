module Page.Header exposing (Model, Msg, view, init, update)

import Css exposing (..)
import Html exposing (Html, span, button, div, text, a)
import Html.Attributes
import Html.Events exposing (onClick)
import Route exposing (Route, routeToString)


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
                , borderBottom3 (px 1) solid (rgb 0 0 0)
                ]
            ]
            [ homeButton route
            , aboutButton route
            , projectsButton route
            , resumeButton route
            , contactButton route
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
            -- backgroundColor inherit
            if currentRoute == page then
                backgroundColor (hsl 189 0.55 0.61)
            else
                backgroundColor inherit
    in
        a
            [ Route.href page
            , styles
                [ float left
                , border (px 0)
                , background
                , cursor pointer
                , padding2 (px 14) (px 16)
                , fontSize (px 17)
                , textDecoration none
                , color (rgb 255 255 255)
                , hover
                    [ backgroundColor (hsl 189 0.55 0.91)
                    ]
                ]
            , onClick (Select str)
            ]
            [ Html.text str ]



-- STYLE


styles =
    (Css.asPairs >> Html.Attributes.style)

module Page.Header exposing (Model, Msg, view, init, update)

import Css exposing (..)
import Html exposing (Html, span, button, div, text, a)
import Html.Attributes
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
    case (Debug.log "header msg" msg) of
        Select tab ->
            Model { model | selected = tab }



-- VIEW


view : Model -> Html Msg
view (Model model) =
    div
        [ styles
            [ overflow hidden
            , backgroundColor (hsl 175 0.67 0.39)
            , boxShadow4 (px 0) (px 2) (px 5) (rgb 100 100 100)
            ]
        ]
        [ homeButton model
        , aboutButton model
        ]


homeButton : InternalModel -> Html Msg
homeButton model =
    button model Route.Home "Home"


aboutButton : InternalModel -> Html Msg
aboutButton model =
    button model Route.About "About"


button : InternalModel -> Route -> String -> Html Msg
button model page str =
    let
        background =
            backgroundColor inherit

        {-
           if model.selected == str then
               backgroundColor (hsl 189 0.55 0.61)
           else
               backgroundColor inherit
        -}
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
                ]
            , onClick (Select str)
            ]
            [ Html.text str ]



-- STYLE


styles =
    (Css.asPairs >> Html.Attributes.style)
